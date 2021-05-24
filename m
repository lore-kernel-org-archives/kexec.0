Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1llIuy-00263h-Lf
 for kexec@lists.infradead.org; Mon, 24 May 2021 22:19:26 +0000
Received: by mail-qk1-x733.google.com with SMTP id i5so21325752qkf.12
 for <kexec@lists.infradead.org>; Mon, 24 May 2021 15:19:23 -0700 (PDT)
Date: Mon, 24 May 2021 18:19:19 -0400
From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Re: Setting "orig_video_isVGA" when handing off Linux framebuffer
Message-ID: <20210524181919.76d5cbf2@gmail.com>
In-Reply-To: <CACPcB9encLUW+Xf0Ce+S7dpBv6_C-Y5ynnX6pxHintzQfCyy8w@mail.gmail.com>
References: <20210423154657.40324d86@gmail.com>
 <20210504190954.46edf191@gmail.com>
 <CACPcB9encLUW+Xf0Ce+S7dpBv6_C-Y5ynnX6pxHintzQfCyy8w@mail.gmail.com>
MIME-Version: 1.0
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
To: Kairui Song <kasong@redhat.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>

Thanks, this is helpful!

> For the commit fb5a8792e6e4, the problem is only observed with
> hyperv_fb, and it's a HyperV VM.
> The framebuffer was VESA compatible when the machine just booted, but
> after hyperv_fb driver is loaded, it will ask the hypervisor to
> relocate the framebuffer in a new location and in a new format.
> 
> In a later kernel commit 3cb73bc3fa2a3cb80b88aa63b48409939e0d996b, it
> fixed the kernel side issue that after the relocation, the framebuffer
> address is not updated in boot_params. It was not updated before this
> kernel commit. Before that, the old boot_params will contain an
> invalid address and cause failures in the new booted kernel.

This doesn't seem like a HyperV issue, it seems like a general problem
with assuming the boot-time screen parameters are valid after some
driver has reconfigured the display.

> And I also remember blindly setting orig_video_isVGA will cause
> strange errors on some random graphic cards. If we can't make sure
> it's really VGA, this field better left zero, so kernel won't use it
> as a VGA framebuffer.
> 
> For your case, you mentioned "'fix.id' is not "VESA VGA" or "EFI VGA",
> but rather "inteldrmfb" or "i915drmfb"",  'fix.id' can change after
> boot, I'm not familiar with heads or coreboot, but I guess the first
> kernel you booted have intel drm drivers loaded?

Exactly.

> Maybe you can try
> either don't load intel drm driver in first kernel (so the framebuffer
> is always being used in a VESA/EFI compatible way),

Good idea, but in this case there isn't any BIOS or EFI firmware.  If I
didn't load the DRM driver then there would be no display at all.

> or ensure same
> driver is loaded in the new booted kernel (this way the driver will
> reinitialize the framebuffer anyway, even if it's not set in
> boot_params).

Indeed, but this is only possible if you have control over the
kernel/OS being booted.

The example that set this off is the Debian installer: the installer
doesn't include video drivers, it only uses the framebuffer provided by
the bootloader.

But more broadly, when you're booting a new kernel, it is best to have
some way of displaying stuff on screen, if for no other reason than to
tell you why it is unable to load the DRM driver.

From my understanding and brief perusal of the code, if the bootloader
specifies an "EFI framebuffer", then Linux simply treats this as a big
reserved block of memory where pixels can be drawn.  It doesn't support
changing the resolution or format, and doesn't support pseudocolor.  If
I understand correctly, EFI itself doesn't permit changing the
framebuffer configuration "after boot time".

So it seems to me that:

 - if fix.smem_start != 0
 - and fix.smem_len != 0
 - and fix.type == FB_TYPE_PACKED_PIXELS
 - and fix.visual == FB_VISUAL_TRUECOLOR

then it ought to be safe to treat this as an "EFI framebuffer" and
allow the booted kernel to draw on it.  This works, as far as I can
see, with all the drivers I've tested (i915, radeon, cirrus, uvesafb).

Looking at the hyperv_fb driver, however, it appears to be setting
smem_start and smem_len (indicating that the framebuffer is located in
contiguous "physical" memory) even when that is incorrect.  Perhaps
that is the cause of the problems you saw.

I notice that framebuffer_info (kexec/arch/i386/kexec-multiboot-x86.c)
and multiboot2_make_mbi (kexec/arch/i386/kexec-mb2-x86.c) already do
just what I'm suggesting.  So I expect that, if you tried to boot a
Multiboot kernel that supports video handoff, you would see the same
problems as before.

It would be a good sanity check if kexec could somehow test whether
smem_start is actually a valid physical memory address.  Is there any
way to do that in userspace?

Benjamin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
