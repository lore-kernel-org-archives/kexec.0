Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wt1DZ-0005Or-JS
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 20:58:30 +0000
Received: by mail-qg0-f54.google.com with SMTP id q108so5644225qgd.13
 for <kexec@lists.infradead.org>; Fri, 06 Jun 2014 13:58:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53922686.6010301@zytor.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140603131203.GA23395@redhat.com>
 <20140605083134.GE3506@darkstar.nay.redhat.com>
 <20140605150159.GA14083@redhat.com>
 <20140606073748.GC3343@darkstar.nay.redhat.com>
 <53922686.6010301@zytor.com>
Date: Fri, 6 Jun 2014 21:58:07 +0100
Message-ID: <CAL01qpsf_-Ae_P-mfmqfu6DYavcb866YUnE4XM_7vdhfcAvMGg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in kernel
 loading
From: Matt Fleming <matt.fleming@intel.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, ebiederm@xmission.com, "jkosina@suse.cz" <jkosina@suse.cz>, chaowang@redhat.com, Dave Young <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On 6 June 2014 21:37, H. Peter Anvin <hpa@zytor.com> wrote:
>
> OK... this is seriously problematic.
>
> #if defined(CONFIG_RELOCATABLE) && defined(CONFIG_X86_64) && \
>         !defined(CONFIG_EFI_MIXED)
>    /* kernel/boot_param/ramdisk could be loaded above 4g */
> # define XLF1 XLF_CAN_BE_LOADED_ABOVE_4G
> #else
> # define XLF1 0
> #endif
>
> The fact that even compiling with CONFIG_EFI_MIXED disables
> XLF_CAN_BE_LOADED_ABOVE_4G is really not going to fly.  We should expect
> CONFIG_EFI_MIXED to be the norm, but *also* should expect that there is
> a legitimate need to load above 4G.
>
> Matt, could you explain why this is necessary?  We need to figure out a
> way around this.
>
> My thinking is that disabling this flag is unnecessary, since a 32-bit
> EFI loader should not load above the 4G mark anyway, but if I'm confused
> and there is a more fundamental requirement, then we need to consider
> that more carefully.

No, your comments are absolutely correct. I was the one who was
confused. I found this in the git history,

commit 7d453eee36ae
Author: Matt Fleming <matt.fleming@intel.com>
Date:   Fri Jan 10 18:52:06 2014 +0000

    x86/efi: Wire up CONFIG_EFI_MIXED

    Add the Kconfig option and bump the kernel header version so that boot
    loaders can check whether the handover code is available if they want.

    The xloadflags field in the bzImage header is also updated to reflect
    that the kernel supports both entry points by setting both of
    XLF_EFI_HANDOVER_32 and XLF_EFI_HANDOVER_64 when CONFIG_EFI_MIXED=y.
    XLF_CAN_BE_LOADED_ABOVE_4G is disabled so that the kernel text is
    guaranteed to be addressable with 32-bits.

As you've pointed out above, a 32-bit loader is never going to load
the kernel above 4G, so we don't need to disable it.

What's the best way to fix this up? Just undo the change from the above commit?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
