package com.GymInfo.OxyGym.controller;

import com.GymInfo.OxyGym.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.validation.Valid;
import com.GymInfo.OxyGym.bean.GymUser;
import com.GymInfo.OxyGym.service.GymUserService;
import java.util.logging.Logger;
import java.util.UUID;

@Controller
public class LoginController {
  @Autowired
  private BCryptPasswordEncoder bcrypt;
  @Autowired 
  private GymUserService service;
  @Autowired
  private EmailService emailService; // Inject Email Service
  private static final Logger logger = Logger.getLogger(LoginController.class.getName());


  @GetMapping("/register")
  public ModelAndView showUserRegistrationPage() {
    GymUser user=new GymUser();
    ModelAndView mv=new ModelAndView("newUserRegistration");
    mv.addObject("userRecord",user);
    return mv;
  }

    @PostMapping("/register")
    public ModelAndView saveUserRegisterPage(@Valid @ModelAttribute("userRecord") GymUser user, BindingResult result) {
        if (result.hasErrors()) {
            return new ModelAndView("newUserRegistration", "formErrors", result.getAllErrors());
        }

        String encodedPassword = bcrypt.encode(user.getPassword());
        user.setPassword(encodedPassword);
        user.setType("Member");

        // Generate a random verification token
        String token = UUID.randomUUID().toString();
        user.setVerificationToken(token);
        user.setVerified(false);

        service.save(user);

        // Send verification email
        emailService.sendVerificationEmail(user.getEmail(), token);

        return new ModelAndView("loginPage", "message", "A verification email has been sent to your email. Please check your inbox.");
    }
  
  @GetMapping("/loginpage")
  public ModelAndView showLoginPage(@RequestParam(name = "error", required = false) String error) {
      ModelAndView mv = new ModelAndView("loginPage");
      if (error != null) {
          mv.addObject("errorMessage", "Wrong credentials, please re-enter.");
      }
      return mv;
  }

    @PostMapping("/login")
    public ModelAndView login(@RequestParam String username, @RequestParam String password) {
        GymUser user = service.findByUsername(username);

        if (user == null || !bcrypt.matches(password, user.getPassword())) {
            ModelAndView mv = new ModelAndView("loginPage");
            mv.addObject("errorMessage", "Invalid username or password");
            return mv;
        }

        // ✅ Prevent login if the user has not verified their email
        if (!user.isVerified()) {
            ModelAndView mv = new ModelAndView("loginPage");
            mv.addObject("errorMessage", "Your email is not verified. Please check your inbox and verify your email.");
            return mv;
        }

        return new ModelAndView("redirect:/index");
    }


  @GetMapping("/loginindex")
  public ModelAndView showLoginIndexPage() {
      return new ModelAndView("index");
  }
  
  @GetMapping("/loginerror")
  public ModelAndView showLoginErrorPage() {
      ModelAndView mv = new ModelAndView("loginPage");
      mv.addObject("errorMessage", "Wrong credentials, please re-enter.");
      return mv;
  }

    @GetMapping("/verify")
    public ModelAndView verifyUser(@RequestParam("token") String token) {
        logger.info("🔎 Starting verification process for token: " + token);

        try {
            GymUser user = service.verifyUserToken(token);
            logger.info("✅ User verified successfully: " + user.getUsername());
            return new ModelAndView("loginPage", "message", "Your account has been verified! You can now log in.");
        } catch (IllegalArgumentException e) {
            logger.warning("🚨 Verification failed: " + e.getMessage());
            return new ModelAndView("loginPage", "errorMessage", e.getMessage());
        }
    }

}