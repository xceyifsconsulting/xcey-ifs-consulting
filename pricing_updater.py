#!/usr/bin/env python3
"""
Pricing Page Update Function for IFS Consulting
This script updates the pricing page to reflect "we only charge once the work is complete"
"""

import os
import re
import sys

def update_pricing_page(file_path):
    """
    Update pricing page content to reflect new billing policy
    """
    # Read the existing file
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
        
        # Create updated content that matches IFS consulting themes
        updated_content = content
        
        # Replace general billing text with completion-based policy
        replacements = [
            (r'(we charge|we bill|payment for|pricing is|cost is|fee for).*?(complete|finished|done|delivered)', 
             'we only charge once the work is complete and to your satisfaction'),
            (r'(Billing|Payment|Cost|Fee).*?(terms|policy|plan)', 
             'Completion-Based Billing Policy'),
            (r'Payment is due.*?(completion|project)', 
             'Payment is due upon project completion and acceptance of deliverables'),
            (r'(once the project|after completion|when finished) (is|has been) (complete|finished)', 
             'once the work is complete and to your satisfaction'),
        ]
        
        for pattern, replacement in replacements:
            updated_content = re.sub(pattern, replacement, updated_content, flags=re.IGNORECASE)
        
        # Add comprehensive completion-based policy section if not found
        if '<h2.*?Pricing.*?</h2>' not in updated_content:
            # Look for existing content structure to preserve layout
            policy_section = """
    <div class="section">
        <h2>Completion-Based Billing Policy</h2>
        <p>Our pricing is based on successful completion of the project. We only charge once the work is complete and to your satisfaction.</p>
        
        <div class="highlight">
            <h3>Why This Approach?</h3>
            <p>We believe in delivering measurable results. Our completion-based pricing model ensures:</p>
            <ul>
                <li>Quality outcomes that meet your business objectives</li>
                <li>Transparency in our delivery process</li>
                <li>Maximum value for your investment</li>
                <li>Reduced risk for your organization</li>
            </ul>
        </div>
        
        <h3>What's Included in Our Completion-Based Pricing</h3>
        <ul>
            <li>Full IFS implementation support</li>
            <li>Post-go-live system stabilization</li>
            <li>Staff training and knowledge transfer</li>
            <li>Performance optimization services</li>
            <li>Ongoing support and maintenance</li>
        </ul>
        
        <p>Payment is due upon project completion and acceptance of deliverables. This approach ensures we're focused on delivering real business value, not just completing tasks.</p>
    </div>
            """
            # Insert this section after the first section or at the end
            if '<div class="section">' in updated_content:
                # Insert after first section
                sections = updated_content.split('<div class="section">', 1)
                if len(sections) > 1:
                    updated_content = '<div class="section">' + sections[0] + policy_section + '<div class="section">' + sections[1]
            else:
                # If no sections found, append at end
                updated_content = updated_content + policy_section
        
        # Write the updated content back to file
        with open(file_path, 'w', encoding='utf-8') as file:
            file.write(updated_content)
            
        print(f"Pricing page updated successfully in {file_path}")
        return True
        
    except FileNotFoundError:
        print(f"Error: File {file_path} not found")
        return False
    except Exception as e:
        print(f"Error updating pricing page: {e}")
        return False

def update_all_pricing_files():
    """
    Update all HTML files in current directory that may contain pricing information
    """
    try:
        for filename in os.listdir('.'):
            if filename.endswith('.html') or filename.endswith('.htm'):
                print(f"Processing {filename}...")
                update_pricing_page(filename)
        print("All pricing files processed")
        return True
    except Exception as e:
        print(f"Error processing files: {e}")
        return False

if __name__ == "__main__":
    print("Pricing page updater loaded successfully")
    
    if len(sys.argv) > 1:
        # Update specific file
        update_pricing_page(sys.argv[1])
    else:
        # Update all pricing files in current directory
        update_all_pricing_files()