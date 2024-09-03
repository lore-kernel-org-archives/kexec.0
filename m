Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2649CD37AC
	for <kexec@archiver.kernel.org>; Tue,  3 Sep 2024 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AsT3hQRLKsuziUOfhRYHaOvX5258KzoVHF9CuR12i50=; b=rao4j1Hb8RAuDlXLTp8Jjm9mRF
	0YSzdbCByfDYj+IqWbvjJD8+KK4sd/36vFXI5/eU8bV3A+Tg6nraTMnih+MauOTNwE787M92V+NmE
	qD0lKa2/exRp9fwk5blKeuxLXsTa9SlNmY52gMchWIDGfhbM+x1j/qYKJUps/fCEaKHGYtGMyEO20
	e9I2VJmfqNuIR6dpNU53S+RH49d6VAjIVH6g4Uv8GQ6kINhU4DgpkQvz2TWlnADxDO+WN686FDV6e
	tOeRDqgMQE3XxKWoFt40vzb7rBRA+Gn23Onfr4VvQAAJfb0+zlk7uPrRVNRc9L7zC71Prhv7vYAEU
	ZGlhIQIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slZaA-00000001fgs-3uEL;
	Tue, 03 Sep 2024 19:52:54 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slZa6-00000001fe0-3jfL
	for kexec@lists.infradead.org;
	Tue, 03 Sep 2024 19:52:52 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-6d5235d1bcaso72511397b3.2
        for <kexec@lists.infradead.org>; Tue, 03 Sep 2024 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725393169; x=1725997969; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fI+madg2F5jxzMgESVkIyHR0MmAEDyO6S+oxlQFxTfw=;
        b=PnO786m7I+eM1dCYhYSVPKeV+oLtF844LDAzD84Wi+nZs7eadmv9yiZBWC5kWE8+PT
         cfCaPk7Uaa0C2SqwfHLrg5aWfUNnKMQKkqpfcjgkjWHET8XxHw5PPrBqm2ATT8RZnWLZ
         IFapdHODy58ABqbGKSFNzCWu7kygJzialiU4NpSeLLfaDsQqBd4PqbOmGP9fIl0Upafr
         4dgwMcg0KFlp9Uw1RpH7L+KYedHW7sDXz23TejTOcxvK7qHQIjZCbNLiGpqWiGHiMmIR
         7YkUhROJDPIiax6WxuYghC81XxiVkYsd75s7OaexiF8d6BdS0RoLxq5NaED5XzZrSIKk
         UNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725393169; x=1725997969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fI+madg2F5jxzMgESVkIyHR0MmAEDyO6S+oxlQFxTfw=;
        b=PW+jSsvY8oKfayxADmKto/cPdZYugZGNiV5C+hGJ3DzVrj9Fw32cYv9P4g12z8fFLT
         JTyPN1OOx6cJGjEETPga5J9MdAe6F6RBENFa50spQ6UrWwTbhDWrA4cT3KQ3jf6knh9N
         R4DRQjJ0+1UE/JA/xCZW7gRe2d0FMnSfFtNw3HJOCHBbo32n32LV9OJAfOUVGHov9M5k
         /S9YLvjtGQOw794/RK04sofOIXSZ+Z/FaHKaNhCkBmp0J4p4tEDU6gdORXPZWEhWk9Vv
         ZODJ58+afN8C/mibYhe+iOzz2Qm6XVdxiXlCsDFt+kx5+i/RBfz4HthqporKd3HmYQUF
         qJkg==
X-Forwarded-Encrypted: i=1; AJvYcCViBUcAXuhIwTNo37A+W6vld0fT9XvE4IZGjvZzrvuye2sZMNiYiDOIx0pMmLYzpcYltE9NLw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyYwsxevpY/ePVvHiBMnntfYbPEPQZW2dclzYvaLIewhaphR+bB
	uGEOJJ7fB4VeTLoq1U83zpvH1MpDJ4H5VKDiqGsVdvtJAzda+y0MJPnN6u6OJhSbW3xDAtZmjpN
	rLg==
X-Google-Smtp-Source: AGHT+IGznZGpOHs537cn7xrwAtS55FBRH/lk1IunDfes8pLlRqXE4lN176lmA/xwEcC4P3q0jU1X7lR2lZU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:281:b0:69a:536:afd3 with SMTP id
 00721157ae682-6d4108c6606mr11831257b3.5.1725393168864; Tue, 03 Sep 2024
 12:52:48 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:52:47 -0700
In-Reply-To: <20240903191033.28365-1-Ashish.Kalra@amd.com>
Mime-Version: 1.0
References: <20240903191033.28365-1-Ashish.Kalra@amd.com>
Message-ID: <ZtdpDwT8S_llR9Zn@google.com>
Subject: Re: [PATCH v2] x86/sev: Fix host kdump support for SNP
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	thomas.lendacky@amd.com, michael.roth@amd.com, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_125250_964621_45136EB8 
X-CRM114-Status: GOOD (  40.32  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2024, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> [    1.671804] AMD-Vi: Using global IVHD EFR:0x841f77e022094ace, EFR2:0x0
> [    1.679835] AMD-Vi: Translation is already enabled - trying to copy translation structures
> [    1.689363] AMD-Vi: Copied DEV table from previous kernel.
> [    1.864369] AMD-Vi: Completion-Wait loop timed out
> [    2.038289] AMD-Vi: Completion-Wait loop timed out
> [    2.212215] AMD-Vi: Completion-Wait loop timed out
> [    2.386141] AMD-Vi: Completion-Wait loop timed out
> [    2.560068] AMD-Vi: Completion-Wait loop timed out
> [    2.733997] AMD-Vi: Completion-Wait loop timed out
> [    2.907927] AMD-Vi: Completion-Wait loop timed out
> [    3.081855] AMD-Vi: Completion-Wait loop timed out
> [    3.225500] AMD-Vi: Completion-Wait loop timed out
> [    3.231083] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> d out
> [    3.579592] AMD-Vi: Completion-Wait loop timed out
> [    3.753164] AMD-Vi: Completion-Wait loop timed out
> [    3.815762] Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
> [    3.825347] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc3-next-20240813-snp-host-f2a41ff576cc-dirty #61
> [    3.837188] Hardware name: AMD Corporation ETHANOL_X/ETHANOL_X, BIOS RXM100AB 10/17/2022
> [    3.846215] Call Trace:
> [    3.848939]  <TASK>
> [    3.851277]  dump_stack_lvl+0x2b/0x90
> [    3.855354]  dump_stack+0x14/0x20
> [    3.859050]  panic+0x3b9/0x400
> [    3.862454]  panic_if_irq_remap+0x21/0x30
> [    3.866925]  setup_IO_APIC+0x8aa/0xa50
> [    3.871106]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [    3.877032]  ? __cpuhp_setup_state+0x5e/0xd0
> [    3.881793]  apic_intr_mode_init+0x6a/0xf0
> [    3.886360]  x86_late_time_init+0x28/0x40
> [    3.890832]  start_kernel+0x6a8/0xb50
> [    3.894914]  x86_64_start_reservations+0x1c/0x30
> [    3.900064]  x86_64_start_kernel+0xbf/0x110
> [    3.904729]  ? setup_ghcb+0x12/0x130
> [    3.908716]  common_startup_64+0x13e/0x141
> [    3.913283]  </TASK>
> [    3.915715] in panic
> [    3.918149] in panic_other_cpus_shutdown
> [    3.922523] ---[ end Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC ]---
> 
> This happens as SNP_SHUTDOWN_EX fails

Exactly what happens?  I.e. why does the PSP (sorry, ASP) need to be full shutdown
in order to get a kdump?  The changelogs for the original SNP panic/kdump support
are frustratingly unhelpful.  They all describe what the patch does, but say
nothing about _why_.

> when SNP VMs are active as the firmware checks every encryption-capable ASID
> to verify that it is not in use by a guest and a DF_FLUSH is not required. If
> a DF_FLUSH is required, the firmware returns DFFLUSH_REQUIRED.
> 
> To fix this, added support to do SNP_DECOMMISSION of all active SNP VMs
> in the panic notifier before doing SNP_SHUTDOWN_EX, but then
> SNP_DECOMMISSION tags all CPUs on which guest has been activated to do
> a WBINVD. This causes SNP_DF_FLUSH command failure with the following
> flow: SNP_DECOMMISSION -> SNP_SHUTDOWN_EX -> SNP_DF_FLUSH ->
> failure with WBINVD_REQUIRED.
> 
> When panic notifier is invoked all other CPUs have already been
> shutdown, so it is not possible to do a wbinvd_on_all_cpus() after
> SNP_DECOMMISSION has been executed. This eventually causes SNP_SHUTDOWN_EX
> to fail after SNP_DECOMMISSION.
> 
> Adding fix to do SNP_DECOMMISSION and subsequent WBINVD on all CPUs
> during NMI shutdown of CPUs as part of disabling virtualization on
> all CPUs via cpu_emergency_disable_virtualization ->
> svm_emergency_disable().
> 
> SNP_DECOMMISSION unbinds the ASID from SNP context and marks the ASID
> as unusable and then transitions the SNP guest context page to a
> firmware page and SNP_SHUTDOWN_EX transitions all pages associated
> with the IOMMU to reclaim state which the hypervisor then transitions
> to hypervisor state, all these page state changes are in the RMP
> table, so there is no loss of guest data as such and the complete
> host memory is captured with the crashkernel boot. There are no
> processes which are being killed and host/guest memory is not
> being altered or modified in any way.
> 
> This fixes and enables crashkernel/kdump on SNP host.

...

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 714c517dd4b7..30f286a3afb0 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -16,6 +16,7 @@
>  #include <linux/psp-sev.h>
>  #include <linux/pagemap.h>
>  #include <linux/swap.h>
> +#include <linux/delay.h>
>  #include <linux/misc_cgroup.h>
>  #include <linux/processor.h>
>  #include <linux/trace_events.h>
> @@ -89,6 +90,8 @@ static unsigned int nr_asids;
>  static unsigned long *sev_asid_bitmap;
>  static unsigned long *sev_reclaim_asid_bitmap;
>  
> +static DEFINE_SPINLOCK(snp_decommission_lock);
> +static void **snp_asid_to_gctx_pages_map;
>  static int snp_decommission_context(struct kvm *kvm);
>  
>  struct enc_region {
> @@ -2248,6 +2251,9 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  		goto e_free_context;
>  	}
>  
> +	if (snp_asid_to_gctx_pages_map)
> +		snp_asid_to_gctx_pages_map[sev_get_asid(kvm)] = sev->snp_context;
> +
>  	return 0;
>  
>  e_free_context:
> @@ -2884,9 +2890,126 @@ static int snp_decommission_context(struct kvm *kvm)
>  	snp_free_firmware_page(sev->snp_context);
>  	sev->snp_context = NULL;
>  
> +	if (snp_asid_to_gctx_pages_map)
> +		snp_asid_to_gctx_pages_map[sev_get_asid(kvm)] = NULL;
> +
>  	return 0;
>  }
>  
> +static void __snp_decommission_all(void)
> +{
> +	struct sev_data_snp_addr data = {};
> +	int ret, asid;
> +
> +	if (!snp_asid_to_gctx_pages_map)
> +		return;
> +
> +	for (asid = 1; asid < min_sev_asid; asid++) {
> +		if (snp_asid_to_gctx_pages_map[asid]) {
> +			data.address = __sme_pa(snp_asid_to_gctx_pages_map[asid]);

NULL pointer deref if this races with snp_decommission_context() from task
context.

> +			ret = sev_do_cmd(SEV_CMD_SNP_DECOMMISSION, &data, NULL);
> +			if (!ret) {

And what happens if SEV_CMD_SNP_DECOMMISSION fails?

> +				snp_free_firmware_page(snp_asid_to_gctx_pages_map[asid]);
> +				snp_asid_to_gctx_pages_map[asid] = NULL;
> +			}
> +		}
> +	}
> +}
> +
> +/*
> + * NOTE: called in NMI context from svm_emergency_disable().
> + */
> +void sev_emergency_disable(void)
> +{
> +	static atomic_t waiting_for_cpus_synchronized;
> +	static bool synchronize_cpus_initiated;
> +	static bool snp_decommission_handled;
> +	static atomic_t cpus_synchronized;
> +
> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +		return;
> +
> +	/*
> +	 * SNP_SHUTDOWN_EX fails when SNP VMs are active as the firmware checks

Define "active".

> +	 * every encryption-capable ASID to verify that it is not in use by a
> +	 * guest and a DF_FLUSH is not required. If a DF_FLUSH is required,
> +	 * the firmware returns DFFLUSH_REQUIRED. To address this, SNP_DECOMMISSION
> +	 * is required to shutdown all active SNP VMs, but SNP_DECOMMISSION tags all
> +	 * CPUs that guest was activated on to do a WBINVD. When panic notifier
> +	 * is invoked all other CPUs have already been shutdown, so it is not
> +	 * possible to do a wbinvd_on_all_cpus() after SNP_DECOMMISSION has been
> +	 * executed. This eventually causes SNP_SHUTDOWN_EX to fail after
> +	 * SNP_DECOMMISSION. To fix this, do SNP_DECOMMISSION and subsequent WBINVD
> +	 * on all CPUs during NMI shutdown of CPUs as part of disabling
> +	 * virtualization on all CPUs via cpu_emergency_disable_virtualization().
> +	 */
> +
> +	spin_lock(&snp_decommission_lock);
> +
> +	/*
> +	 * exit early for call from native_machine_crash_shutdown()
> +	 * as SNP_DECOMMISSION has already been done as part of
> +	 * NMI shutdown of the CPUs.
> +	 */
> +	if (snp_decommission_handled) {
> +		spin_unlock(&snp_decommission_lock);
> +		return;
> +	}
> +
> +	/*
> +	 * Synchronize all CPUs handling NMI before issuing
> +	 * SNP_DECOMMISSION.
> +	 */
> +	if (!synchronize_cpus_initiated) {
> +		/*
> +		 * one CPU handling panic, the other CPU is initiator for
> +		 * CPU synchronization.
> +		 */
> +		atomic_set(&waiting_for_cpus_synchronized, num_online_cpus() - 2);

And what happens when num_online_cpus() == 1?

> +		synchronize_cpus_initiated = true;
> +		/*
> +		 * Ensure CPU synchronization parameters are setup before dropping
> +		 * the lock to let other CPUs continue to reach synchronization.
> +		 */
> +		wmb();
> +
> +		spin_unlock(&snp_decommission_lock);
> +
> +		/*
> +		 * This will not cause system to hang forever as the CPU
> +		 * handling panic waits for maximum one second for
> +		 * other CPUs to stop in nmi_shootdown_cpus().
> +		 */
> +		while (atomic_read(&waiting_for_cpus_synchronized) > 0)
> +		       mdelay(1);
> +
> +		/* Reacquire the lock once CPUs are synchronized */
> +		spin_lock(&snp_decommission_lock);
> +
> +		atomic_set(&cpus_synchronized, 1);
> +	} else {
> +		atomic_dec(&waiting_for_cpus_synchronized);
> +		/*
> +		 * drop the lock to let other CPUs contiune to reach
> +		 * synchronization.
> +		 */
> +		spin_unlock(&snp_decommission_lock);
> +
> +		while (atomic_read(&cpus_synchronized) == 0)
> +		       mdelay(1);
> +
> +		/* Try to re-acquire lock after CPUs are synchronized */
> +		spin_lock(&snp_decommission_lock);
> +	}

Yeah, no.  This is horrific.  If the panic path doesn't provide the necessary
infrastructure to ensure the necessary ordering between the initiating CPU and
responding CPUs, then rework the panic path.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
