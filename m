Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la1la-00EfV0-81
 for kexec@lists.infradead.org; Fri, 23 Apr 2021 19:47:07 +0000
Received: by mail-qk1-x72b.google.com with SMTP id e13so40939798qkl.6
 for <kexec@lists.infradead.org>; Fri, 23 Apr 2021 12:47:04 -0700 (PDT)
Received: from localhost (c-73-119-27-70.hsd1.ma.comcast.net. [73.119.27.70])
 by smtp.gmail.com with ESMTPSA id
 d204sm5049036qke.3.2021.04.23.12.47.03
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 12:47:03 -0700 (PDT)
Date: Fri, 23 Apr 2021 15:46:57 -0400
From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Setting "orig_video_isVGA" when handing off Linux framebuffer
Message-ID: <20210423154657.40324d86@gmail.com>
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
To: kexec@lists.infradead.org

Dear kexec developers,

(Please let me know if there is a better place to discuss this issue.)

In setup_linux_vesafb (arch/i386/x86-linux-setup.c), we find the
following:

	struct fb_fix_screeninfo fix;
	struct fb_var_screeninfo var;
	int fd;

	fd = open("/dev/fb0", O_RDONLY);
	if (-1 == fd)
		return -1;

	if (-1 == ioctl(fd, FBIOGET_FSCREENINFO, &fix))
		goto out;
	if (-1 == ioctl(fd, FBIOGET_VSCREENINFO, &var))
		goto out;
	if (0 == strcmp(fix.id, "VESA VGA")) {
		/* VIDEO_TYPE_VLFB */
		real_mode->orig_video_isVGA = 0x23;
	} else if (0 == strcmp(fix.id, "EFI VGA")) {
		/* VIDEO_TYPE_EFI */
		real_mode->orig_video_isVGA = 0x70;
	} else if (arch_options.reuse_video_type) {
		int err;
		off_t offset = offsetof(typeof(*real_mode), orig_video_isVGA);

		/* blindly try old boot time video type */
		err = get_bootparam(&real_mode->orig_video_isVGA, offset, 1);
		if (err)
			goto out;
	} else {
		real_mode->orig_video_isVGA = 0;
		close(fd);
		return 0;
	}

What is the rationale for this logic?  What does the
'orig_video_isVGA' parameter actually mean, what is the difference
between VIDEO_TYPE_EFI and VIDEO_TYPE_VLFB, and why does the kernel
care about it?

I'm asking because in the context of Heads
(https://github.com/osresearch/heads), the framebuffer has been
configured by Linux (not by BIOS or UEFI), and indeed there *is* no
BIOS or UEFI, only coreboot.  Thus, 'fix.id' is not "VESA VGA" or "EFI
VGA", but rather "inteldrmfb" or "i915drmfb" or something like that,
and 'get_bootparam' provides nothing useful.  As a result,
'orig_video_isVGA' ends up being set to zero, and consequently the
booted kernel either displays nothing or displays garbage.

I realize that not all possible framebuffer formats can be described
by 'struct x86_linux_param_header', and I assume that's the reason for
checking 'fix.id'.  However, in this case, the framebuffer *is* a
standard linear format, and if we set 'orig_video_isVGA' to either
0x23 or 0x70, it appears to work correctly.

From my naive perspective, it seems that, rather than checking the
value of 'fix.id', kexec ought to be looking at 'fix.type',
'fix.visual', and perhaps other fields, to determine whether the
framebuffer format is compatible.  However, it's not apparent whether
'orig_video_isVGA' should be set to 0x23 or 0x70, since the two seem
to behave identically.

I'm a little unsure about the purpose of the "blindly try old boot
time video type" option but it seems like that's not really relevant
here in any case; the original bootloader has nothing to do with the
current framebuffer.

Benjamin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
