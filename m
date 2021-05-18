Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj30e-00Eoxl-Nm
 for kexec@lists.infradead.org; Tue, 18 May 2021 16:55:58 +0000
Received: by mail-yb1-f198.google.com with SMTP id
 j4-20020a2523040000b029050d0d623dccso9269197ybj.15
 for <kexec@lists.infradead.org>; Tue, 18 May 2021 09:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210423154657.40324d86@gmail.com>
 <20210504190954.46edf191@gmail.com>
In-Reply-To: <20210504190954.46edf191@gmail.com>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 19 May 2021 00:55:37 +0800
Message-ID: <CACPcB9encLUW+Xf0Ce+S7dpBv6_C-Y5ynnX6pxHintzQfCyy8w@mail.gmail.com>
Subject: Re: Setting "orig_video_isVGA" when handing off Linux framebuffer
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
To: Benjamin Moody <benjamin.moody@gmail.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>

 Hi Benjamin,

Sorry for the late reply, I missed your email in my inbox.

On Wed, May 5, 2021 at 7:10 AM Benjamin Moody <benjamin.moody@gmail.com> wrote:
>
> Hi,
>
> In regard to how kexec hands off the framebuffer to the newly-booted
> kernel:
>
> Commit 060eee589dd1 (2018-01-28) added the "blindly try old boot time
> video type" behavior, without doing any checking to see if the
> framebuffer is compatible with the stated format.
>
> Commit fb5a8792e6e4 (2019-03-05) made this behavior conditional on the
> --reuse-video-type option.  The commit message observes that:
>
>     Currently kernel hanging is inspected on some hyper-v VMs after this
>     commit, because hyperv_fb will mimic EFI (or VESA) VGA on first boot
>     up, but after the real driver is loaded, it will switch to new mode
>     and no longer compatible with EFI/VESA VGA. Keep setting
>     orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded
>     and try to manipulate the framebuffer in a wrong way.
>
> It's clear to me that various bad things *might* happen if kexec
> pretends that the framebuffer is "VESA-compatible" or "EFI-compatible"
> when in fact it isn't.
>
> Yet, in many cases, the Linux framebuffer is VESA/EFI-compatible, at
> least to the extent that blindly setting orig_video_isVGA = 0x23 or
> 0x70 results in a usable display.  So I have to wonder, in the
> situation mentioned above:
>
>  - was the framebuffer not in a compatible format to begin with?
>
>  - was the framebuffer address not correctly reported by the existing
>    kernel driver?
>
>  - did the original bootloader give wrong information and somehow that
>    broke the newly booted kernel?
>
> Kairui, can you please clarify what sort of kernel hangs you were
> seeing and what specific hardware and drivers you were using?
>

For the commit fb5a8792e6e4, the problem is only observed with
hyperv_fb, and it's a HyperV VM.
The framebuffer was VESA compatible when the machine just booted, but
after hyperv_fb driver is loaded, it will ask the hypervisor to
relocate the framebuffer in a new location and in a new format.

In a later kernel commit 3cb73bc3fa2a3cb80b88aa63b48409939e0d996b, it
fixed the kernel side issue that after the relocation, the framebuffer
address is not updated in boot_params. It was not updated before this
kernel commit. Before that, the old boot_params will contain an
invalid address and cause failures in the new booted kernel.

And I also remember blindly setting orig_video_isVGA will cause
strange errors on some random graphic cards. If we can't make sure
it's really VGA, this field better left zero, so kernel won't use it
as a VGA framebuffer.

For your case, you mentioned "'fix.id' is not "VESA VGA" or "EFI VGA",
but rather "inteldrmfb" or "i915drmfb"",  'fix.id' can change after
boot, I'm not familiar with heads or coreboot, but I guess the first
kernel you booted have intel drm drivers loaded? Maybe you can try
either don't load intel drm driver in first kernel (so the framebuffer
is always being used in a VESA/EFI compatible way), or ensure same
driver is loaded in the new booted kernel (this way the driver will
reinitialize the framebuffer anyway, even if it's not set in
boot_params).

> Benjamin Moody
>


-- 
Best Regards,
Kairui Song


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
