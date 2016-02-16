Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aVgvd-0001Hn-DH
 for kexec@lists.infradead.org; Tue, 16 Feb 2016 14:48:39 +0000
Received: by mail-wm0-x231.google.com with SMTP id g62so156165557wme.0
 for <kexec@lists.infradead.org>; Tue, 16 Feb 2016 06:48:15 -0800 (PST)
Date: Tue, 16 Feb 2016 14:48:12 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] x86/efi: skip bgrt init for kexec reboot
Message-ID: <20160216144812.GF2769@codeblueprint.co.uk>
References: <20160127112044.GA2961@dhcp-128-65.nay.redhat.com>
 <20160203214200.GA15110@dhcp-128-65.nay.redhat.com>
 <20160203225333.GA31246@codeblueprint.co.uk>
 <20160204100329.GA2586@codeblueprint.co.uk>
 <20160204110903.GA2977@dhcp-128-65.nay.redhat.com>
 <20160204115656.GB2586@codeblueprint.co.uk>
 <20160205004115.GA3651@dhcp-128-65.nay.redhat.com>
 <20160211160931.GL4134@codeblueprint.co.uk>
 <20160212124542.GA7051@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160212124542.GA7051@dhcp-128-65.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>

On Fri, 12 Feb, at 08:45:42PM, Dave Young wrote:
> 
> Yes, rethink about this issue, how about something like below:

Let's put a pin this idea. I've got another approach that I want to
explore a little first. I'll send the patches out soon.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
