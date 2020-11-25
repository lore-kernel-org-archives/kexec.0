Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn8nam08on2122.outbound.protection.outlook.com
 ([40.107.100.122] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki4Ns-0002Xu-9g
 for kexec@lists.infradead.org; Wed, 25 Nov 2020 23:39:37 +0000
From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 1/2] x86/kexec: Use up-to-dated screen_info copy to fill
 boot params
Date: Wed, 25 Nov 2020 23:39:30 +0000
Message-ID: <MW2PR2101MB1801B19B018FE42150449D49BFFA1@MW2PR2101MB1801.namprd21.prod.outlook.com>
References: <20201014092429.1415040-1-kasong@redhat.com>
 <20201014092429.1415040-2-kasong@redhat.com>
 <MWHPR21MB0861EA2C8322A7C27404258CBFE20@MWHPR21MB0861.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB0861EA2C8322A7C27404258CBFE20@MWHPR21MB0861.namprd21.prod.outlook.com>
Content-Language: en-US
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
To: 'Kairui Song' <kasong@redhat.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: 'Wei Liu' <wei.liu@kernel.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, Haiyang Zhang <haiyangz@microsoft.com>, "'x86@kernel.org'" <x86@kernel.org>, "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>, "'linux-hyperv@vger.kernel.org'" <linux-hyperv@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>, 'Ingo Molnar' <mingo@redhat.com>, 'Borislav Petkov' <bp@alien8.de>, 'Thomas Gleixner' <tglx@linutronix.de>, KY Srinivasan <kys@microsoft.com>, 'Dave Young' <dyoung@redhat.com>, 'Ard Biesheuvel' <ardb@kernel.org>

> From: Dexuan Cui
> Sent: Monday, November 16, 2020 7:40 PM
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c
> > b/arch/x86/kernel/kexec-bzimage64.c
> > index 57c2ecf43134..ce831f9448e7 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -200,8 +200,7 @@ setup_boot_parameters(struct kimage *image, struct
> > boot_params *params,
> >  	params->hdr.hardware_subarch = boot_params.hdr.hardware_subarch;
> >
> >  	/* Copying screen_info will do? */
> > -	memcpy(&params->screen_info, &boot_params.screen_info,
> > -				sizeof(struct screen_info));
> > +	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));
> >
> >  	/* Fill in memsize later */
> >  	params->screen_info.ext_mem_k = 0;
> > --
> 
> Hi Kairui,
> According to "man kexec", kdump/kexec can use 2 different syscalls to set up
> the
> kdump kernel:
> 
> -s (--kexec-file-syscall)
>        Specify that the new KEXEC_FILE_LOAD syscall should be used
> exclusively.
> 
> -c (--kexec-syscall)
>        Specify that the old KEXEC_LOAD syscall should be used exclusively
> (the default).
> 
> It looks I can only reproduce the call-trace
> (https://bugzilla.redhat.com/show_bug.cgi?id=1867887#c5) with
> KEXEC_FILE_LOAD:
> I did kdump tests in Ubuntu 20.04 VM and by default the VM used the
> KEXEC_LOAD
> syscall and I couldn't reproduce the call-trace; after I added the "-s" parameter
> to use
> the KEXEC_FILE_LOAD syscall, I could reproduce the call-trace and I can confirm
> your
> patch can eliminate the call-trace because the "efifb" driver doesn't even load
> with
> your patch.
> 
> Your patch is only for the KEXEC_FILE_LOAD syscall, and I'm sure it's not used in
> the code path of the KEXEC_LOAD syscall.
> 
> So, in the case of the KEXEC_LOAD syscall, do you know how the *kexec*
> kernel's boot_params.screen_info.lfb_base is intialized? I haven't figured it 
> out yet.

FYI: in the case of the KEXEC_LOAD syscall, I think the lfb_base of the kexec
kernel is pre-setup by the kexec tool (see the function setup_linux_vesafb()):

https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/kexec/arch/i386/x86-linux-setup.c#n126
static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
{
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

When a Ubuntu 20.10 VM (kexec-tools-2.0.20) runs on Hyper-V, we should
fall into the last condition, i.e. setting
"real_mode->orig_video_isVGA = 0;", so the "efifb" driver does not load
in the kdump kernel.

Ubuntu 20.04 (kexec-tools-2.0.18) is a little old in that it does not have
Kairui's patch
https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=fb5a8792e6e4ee7de7ae3e06d193ea5beaaececc
, so it re-uses the VRAM location set up by the hyperv_fb driver, which
is undesirable because the "efifb" driver doesn't know it's accessing
an "incompatible" framebuffer -- IMO this may be just a small issue,
but anyay I hope Ubuntu 20.04's kexec-tools will pick up your patch.

So, now we should cover all the combinations if we use the latest kernel
and the latest kexec-tools, and the "efifb" driver in the kdump kernel
doesn't load.

Thanks,
-- Dexuan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
