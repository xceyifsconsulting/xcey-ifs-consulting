# Formspree Integration - XCEY IFS Consulting

## Overview
The contact form on the XCEY IFS Consulting website is integrated with Formspree for reliable form handling and email delivery.

## Configuration
- **Form Endpoint**: `https://formspree.io/f/xovabrqe`
- **Submission Method**: POST
- **Email Delivery**: xceyifsconsulting@gmail.com
- **Redirect URL**: https://xceyifsconsulting.com/thank-you.html

## Features Implemented
1. **Form Handling**: All form submissions are processed by Formspree
2. **Email Notifications**: Automatic email delivery to xceyifsconsulting@gmail.com
3. **Custom Redirect**: Users are redirected to thank-you.html after submission
4. **Spam Protection**: Honeypot field (_gotcha) prevents bot submissions
5. **File Uploads**: Supports attachments up to 10MB per file
6. **Custom Subject**: Email subject line: "New IFS Support Ticket Submitted"

## Form Fields Collected
- Priority Level (required)
- Name (required)
- Company Name (required)  
- Email Address (required)
- Phone Number (optional)
- IFS Version (required)
- Service Category (required)
- Problem Description (required)
- Expected Outcome (optional)
- Timeline (optional)
- Attachments (optional)
- Preferred Contact Method (required)
- Consent Checkbox (required)

## Technical Details
- Form uses `enctype="multipart/form-data"` for file uploads
- Includes CSRF protection via Formspree
- Client-side validation for required fields
- Progressive enhancement with JavaScript form validation (can be added later)

## Testing

### Production Testing (Recommended)
- Test form submissions at: https://xceyifsconsulting.com/contact-us.html
- Monitor form submissions in Formspree dashboard
- Verify email delivery to xceyifsconsulting@gmail.com

### Local Development Testing
**⚠️ Important:** The main contact form will NOT work on localhost due to CORS and server limitations.

**Error you'll see on localhost:**
```
Error code: 501 - Unsupported method ('POST')
Server does not support this operation
```

**Solutions for local testing:**
1. **Use the test version:** Open `contact-us-test.html` on localhost - shows form data without sending
2. **Test on live site:** Use the production URL for real form testing
3. **Mock testing:** Use browser dev tools to inspect form data

**Why this happens:**
- Formspree expects requests from xceyifsconsulting.com domain
- Local servers don't handle external POST requests the same way
- CORS restrictions prevent cross-origin form submissions

## Next Steps (Optional Enhancements)
1. Add JavaScript form validation for better UX
2. Implement Google reCAPTCHA for additional spam protection
3. Set up email autoresponders in Formspree dashboard
4. Add form analytics tracking
5. Create custom email templates in Formspree

## Support
- Formspree Documentation: https://formspree.io/forms/xovabrqe
- Account Access: Contact xcey for Formspree dashboard access