Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRIXI-0007L6-IR
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 11:57:21 +0000
Received: by mail-wm0-x22b.google.com with SMTP id 128so23431670wmz.1
 for <kexec@lists.infradead.org>; Thu, 04 Feb 2016 03:56:59 -0800 (PST)
Date: Thu, 4 Feb 2016 11:56:56 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] x86/efi: skip bgrt init for kexec reboot
Message-ID: <20160204115656.GB2586@codeblueprint.co.uk>
References: <20160127112044.GA2961@dhcp-128-65.nay.redhat.com>
 <20160203214200.GA15110@dhcp-128-65.nay.redhat.com>
 <20160203225333.GA31246@codeblueprint.co.uk>
 <20160204100329.GA2586@codeblueprint.co.uk>
 <20160204110903.GA2977@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160204110903.GA2977@dhcp-128-65.nay.redhat.com>
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

On Thu, 04 Feb, at 07:09:03PM, Dave Young wrote:
> 
> Consider the original code path, maybe change it to efi_kexec_setup will
> be better to remind people? Or something else like a wraper function with
> similar name..
 
Possibly. I had considered adding a new efi_enabled() bit for
KEXEC_BOOT, but I'm worried that'll just encourage more uses.

The best approach is going to be to see whether we can reduce the uses
of efi_setup and the associated special code. Once we've completed
that exercise, we can think about the best name for this variable.

> For building ACPI tables we need do it in kernel instead of kexec-tools
> because of kexec_file_load for secure boot case so we still need a conditional
> code path for kexec..

Note that it may not be necessary to build any ACPI tables at all,
provided that things like acpi_get_table() fail gracefully for kexec.
I'm assuming that's the problem that you discovered when writing this
patch.

And yes, I don't expect you can build the ACPI table from userspace,
but it should at least be possible to do it in setup_boot_parameters()
or so when you setup the EFI table pointers (efi.config_tables), etc.
I think that would be a natural home for this feature.

> Also I'm not sure how to rebuild ACPI tables, it is easy or hard. Let me
> checking the detail and think more about it.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
