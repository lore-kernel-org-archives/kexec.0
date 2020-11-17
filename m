Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam12on2136.outbound.protection.outlook.com
 ([40.107.244.136] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kerqN-0006gc-1V
 for kexec@lists.infradead.org; Tue, 17 Nov 2020 03:39:48 +0000
From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 1/2] x86/kexec: Use up-to-dated screen_info copy to fill
 boot params
Date: Tue, 17 Nov 2020 03:39:44 +0000
Message-ID: <MWHPR21MB0861EA2C8322A7C27404258CBFE20@MWHPR21MB0861.namprd21.prod.outlook.com>
References: <20201014092429.1415040-1-kasong@redhat.com>
 <20201014092429.1415040-2-kasong@redhat.com>
In-Reply-To: <20201014092429.1415040-2-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haiyang Zhang <haiyangz@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>

> From: Kairui Song <kasong@redhat.com>
> Sent: Wednesday, October 14, 2020 2:24 AM
> To: linux-kernel@vger.kernel.org
> 
> kexec_file_load now just reuse the old boot_params.screen_info.
> But if drivers have change the hardware state, boot_param.screen_info
> could contain invalid info.
> 
> For example, the video type might be no longer VGA, or frame buffer
> address changed. If kexec kernel keep using the old screen_info,
> kexec'ed kernel may attempt to write to an invalid framebuffer
> memory region.
> 
> There are two screen_info globally available, boot_params.screen_info
> and screen_info. Later one is a copy, and could be updated by drivers.
> 
> So let kexec_file_load use the updated copy.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c
> b/arch/x86/kernel/kexec-bzimage64.c
> index 57c2ecf43134..ce831f9448e7 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -200,8 +200,7 @@ setup_boot_parameters(struct kimage *image, struct
> boot_params *params,
>  	params->hdr.hardware_subarch = boot_params.hdr.hardware_subarch;
> 
>  	/* Copying screen_info will do? */
> -	memcpy(&params->screen_info, &boot_params.screen_info,
> -				sizeof(struct screen_info));
> +	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));
> 
>  	/* Fill in memsize later */
>  	params->screen_info.ext_mem_k = 0;
> --

Hi Kairui,
According to "man kexec", kdump/kexec can use 2 different syscalls to set up the
kdump kernel:

-s (--kexec-file-syscall)
       Specify that the new KEXEC_FILE_LOAD syscall should be used exclusively.

-c (--kexec-syscall)
       Specify that the old KEXEC_LOAD syscall should be used exclusively (the default).

It looks I can only reproduce the call-trace 
(https://bugzilla.redhat.com/show_bug.cgi?id=1867887#c5) with KEXEC_FILE_LOAD:
I did kdump tests in Ubuntu 20.04 VM and by default the VM used the KEXEC_LOAD
syscall and I couldn't reproduce the call-trace; after I added the "-s" parameter to use
the KEXEC_FILE_LOAD syscall, I could reproduce the call-trace and I can confirm your
patch can eliminate the call-trace because the "efifb" driver doesn't even load with 
your patch.

Your patch is only for the KEXEC_FILE_LOAD syscall, and I'm sure it's not used in the
code path of the KEXEC_LOAD syscall.

So, in the case of the KEXEC_LOAD syscall, do you know how the *kexec* kernel's
boot_params.screen_info.lfb_base is intialized? I haven't figured it out yet.

Thanks,
-- Dexuan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
