Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE829606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FwrJsw12;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lvc9GtSK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mB3eENfizdE+Qzu1PBvi0g33xGADuQZYMgUzzyBgSEs=; b=FwrJsw12II+NzJ
	R3S/jbcLHYIuLyI1mriIbyiwA/jdVIt+3mFDiu7ZH1qL1lqHgOcAzK01cFYf22bTxZ98rHxtNdmZu
	bvoymmxJWwbh+dmMe1gq+JdW+tPjXwCg1z7P5uSEIsjupDOIcNY+yr63upr8Ih/ydcahHykOLQFM+
	TLOIevT1VxWj+dmZ4+Y6r7edLcCtbzH35BRIW2kOsfUFodFzMaFNC5YzH3UiSwk7BR9QNDzxYn6Hk
	zKGrcIRpC90QqRL7LO6I2fVTny/XhhIeWsQVNVHYGvhPApwCpvKI0stZuLTjgK6SqcFOLccoQJmca
	sdlInr0Lbg/BQHLk2yCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHqh-00000002G4W-1xpX;
	Mon, 26 Oct 2026 10:22:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHqe-00000002G3m-1iCG
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:22:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793010154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mB3eENfizdE+Qzu1PBvi0g33xGADuQZYMgUzzyBgSEs=;
	b=Lvc9GtSK7EkjsloKxMFPLpwnDwAyhKbTCoIwFgdtVFZTfS1xqqOJ9hiz59RSYMzcZWmggo
	0WnmL3kVrBXgwhlWUPo5UX4VKw4GvZAbG1gsBdHgjNEc6STrDSBYQL4Za3xSSb161iWdTw
	+XZBSS9GG2ANFYwRMnBsKmoXg8bPWLI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-h_Ue92IgNNayOaXM6e3CPg-1; Mon, 26 Oct 2026 06:22:32 -0400
X-MC-Unique: h_Ue92IgNNayOaXM6e3CPg-1
X-Mimecast-MFC-AGG-ID: h_Ue92IgNNayOaXM6e3CPg_1793010151
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd67e98f68fso3983425a12.3
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 03:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010151; x=1793614951;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mB3eENfizdE+Qzu1PBvi0g33xGADuQZYMgUzzyBgSEs=;
        b=UQIV6As8eV/+DsQRrpbgJA20ENUfaWUVJUzxqeO7DA1dJnvnLv6+2FbmAXytGHxXkf
         TyNpi8gjCVFvzK5M0RWDLOh35rD4+jj+Qhzywfqav6gwWcLUwhntMSS3RvJyHmc2nLPK
         rU7bHfn31+xrqw8QBD+jVBAgM3dvfn2SCLQbM2pBB/EV3GYqcRKW9fuzl7iQU+rpXTGX
         ykUM7wFw5k2csut4B65ofblBJpExanzBeomoen7xhyEjQ7zDOI/WNjv2HgKag7Yribur
         VOjedfhZiyQZ7W6WHkbW0oMo6Zd0M/eVVkzzsMW5nXWQDnLOZWsJMtOhPFP1cotObjFg
         Rgig==
X-Gm-Message-State: AFq9FYJd5291rgDprbReRt2jFk0iZJY68gFivaM7KWuA04Y6oCXfIgrq
	2x7rDbEttSDB5NubRJxjpuivNv5qIT0doCHc4R+Izi8W7b1a3tMCQZv5HwYnDmbcTr/IlnhYWxS
	JjkBldQ6E4VfBYjPu7xVVoO9Cx3EjJo8vcI4195C9v/boVpxh2eoF0aLBVf6ygDjI5+7RTEqkoo
	KG5gX/CFAR0HNw3TAWVljbW7fFKDPuEmdBi6Dag9s4CnZvrQ==
X-Gm-Gg: AYBFou0rWY0HUPjqYHGCOvx1tVvn48ZveqL6FKnKHTjCNvLTMey1sG6ndRpCQv1Se25
	hsfwm2iT6Jtamp7fN9eQY6/u0qUa3L2KDHSDKCRgaV/xpKecg8h2jNfcW0/D0fpun+PAmx0sarr
	HqzrvrgGcDFQcKpcbzV1Th5894mmi3hzaEVTnx1srf2BNiQDF+J4fN12hrPgf1wHm0ZSZcXWhby
	9anTifTyx+5Yw8kuZBaQJwl6UhfD08I6on1vPM6s2XElwf9BdZTD+0+KoEQ2k3r7dIbxvWOLNQy
	39a0tt2DlDhlkObC5xlkJwZJXotYaoe0uyslCUb7iSlmbMaPc3qmX0O7lEOWt/mVVFlhyj5BlFr
	UhUpbLaF23OHLxM84z9w=
X-Received: by 2002:a17:90b:2891:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3adead488d1mr5548421a91.25.1793010150971;
        Mon, 26 Oct 2026 03:22:30 -0700 (PDT)
X-Received: by 2002:a17:90b:2891:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3adead488d1mr5548389a91.25.1793010150124;
        Mon, 26 Oct 2026 03:22:30 -0700 (PDT)
Received: from [10.76.99.237] ([115.110.236.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaca7casm8054796a91.4.2026.10.26.03.22.28
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:22:29 -0700 (PDT)
Message-ID: <a01eea1a-32f6-4445-ba66-5bb48c957876@redhat.com>
Date: Mon, 26 Oct 2026 15:52:27 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] Drivers: hv: Run VMBus kexec cleanup from syscore
 shutdown
To: kexec@lists.infradead.org
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
 <20261009102250.3361076-1-shradhagupta@linux.microsoft.com>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261009102250.3361076-1-shradhagupta@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xR0kCObhB4-tHnnX5sIBGmSoC04va9hwXv9aKtePenw_1793010151
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_032236_526136_377B390B 
X-CRM114-Status: GOOD (  33.36  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 09/10/26 3:52 pm, Shradha Gupta wrote:
> ARM64 Hyper-V guests do not run the VMBus kexec cleanup before
> secondary CPUs are stopped. Consequently, the old VMBus connection
> and SynIC state remain active when the kexec kernel starts.
> 
> Run the VMBus kexec handler from the existing VMBus syscore shutdown
> callback. syscore_shutdown() runs after device shutdown and before
> machine shutdown, while all CPUs needed by the SynIC CPU hotplug
> teardown are still available. Guard the callback with
> kexec_is_in_progress() so normal restart, halt, and poweroff paths are
> unchanged.
> 
> Use the same path on x86 and remove the architecture-specific handler
> pointer and the weak setup/remove interfaces. VMBus teardown now
> precedes hv_stimer_global_cleanup() on x86.
> 
> The new x86 ordering relies on commit be0cfab740e5 ("clocksource:
> hyper-v: Remove support for stimer interrupts in message mode"), which
> removed the synthetic timer's dependency on VMBus message delivery.
> Older kernels that retain message-mode stimer interrupts must preserve
> the existing x86 ordering and therefore require an ARM64-specific
> backport.
> 
> Document the VMBus cleanup path and its position in shutdown ordering.
> 
> Fixes: 9bbb888824e3 ("arm64: hyperv: Initialize hypervisor on boot")
> Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@linux.microsoft.com/
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  Documentation/virt/hyperv/overview.rst | 12 +++++++-----
>  arch/x86/kernel/cpu/mshyperv.c         | 27 ++++++---------------------
>  drivers/hv/hv_common.c                 | 10 ----------
>  drivers/hv/vmbus_drv.c                 | 22 ++++++++++++++--------
>  include/asm-generic/mshyperv.h         |  2 --
>  5 files changed, 27 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/virt/hyperv/overview.rst b/Documentation/virt/hyperv/overview.rst
> index 77408a89d1a4..34a53ba7a122 100644
> --- a/Documentation/virt/hyperv/overview.rst
> +++ b/Documentation/virt/hyperv/overview.rst
> @@ -114,11 +114,13 @@ a shared page or remove an overlay page after the new kernel is
>  using the page for a different purpose, corrupting the new kernel.
>  Hyper-V does not provide a single "set everything" operation to
>  guest VMs, so Linux code must individually revoke all sharing before
> -doing kexec.   See hv_kexec_handler() and hv_crash_handler().  But
> -the crash/panic path still has holes in cleanup because some shared
> -pages are set using per-CPU synthetic registers and there's no
> -mechanism to revoke the shared pages for CPUs other than the CPU
> -running the panic path.
> +doing kexec.  For a normal kexec reboot, the VMBus driver calls
> +hv_kexec_handler() from its syscore shutdown callback, after device
> +shutdown and before the architecture-specific machine shutdown.  The
> +crash/panic path uses hv_crash_handler(), but still has holes in
> +cleanup because some shared pages are set using per-CPU synthetic
> +registers and there is no mechanism to revoke the shared pages for
> +CPUs other than the CPU running the panic path.
>  
>  CPU Management
>  --------------
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index b4af7c0a70ac..fec1c37dafbf 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -148,7 +148,6 @@ EXPORT_SYMBOL_GPL(hv_set_msr);
>  static void (*mshv_handler)(void);
>  static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
> -static void (*hv_kexec_handler)(void);
>  static void (*hv_crash_handler)(struct pt_regs *regs);
>  
>  DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
> @@ -215,16 +214,6 @@ void hv_remove_stimer0_handler(void)
>  	hv_stimer0_handler = NULL;
>  }
>  
> -void hv_setup_kexec_handler(void (*handler)(void))
> -{
> -	hv_kexec_handler = handler;
> -}
> -
> -void hv_remove_kexec_handler(void)
> -{
> -	hv_kexec_handler = NULL;
> -}
> -
>  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
>  {
>  	hv_crash_handler = handler;
> @@ -240,17 +229,13 @@ static void hv_machine_shutdown(void)
>  {
>  	if (kexec_in_progress) {
>  		hv_stimer_global_cleanup();
> -
> -		if (hv_kexec_handler)
> -			hv_kexec_handler();
> -	}
> -
> -	/*
> -	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
> -	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
> -	 */
> -	if (kexec_in_progress)
> +		/*
> +		 * Call hv_cpu_die() on all the CPUs, otherwise later the
> +		 * hypervisor corrupts the old VP Assist Pages and can crash
> +		 * the kexec kernel.
> +		 */
>  		cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
> +	}
>  
After this patch, the x86 kexec path ends up with two
cpuhp_remove_state() calls, one inside hv_kexec_handler() (now fired
from syscore shutdown) on hyperv_cpuhp_online, and one in
hv_machine_shutdown() on CPUHP_AP_HYPERV_ONLINE.

Could you confirm these refer to distinct CPUHP slots? If they resolve
to the same slot, we'd be calling cpuhp_remove_state() twice on it,
which would be a bug.

>  	/* The function calls stop_other_cpus(). */
>  	native_machine_shutdown();
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 31256cb22b39..bb290a5eaf1d 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -681,16 +681,6 @@ void __weak hv_setup_mshv_handler(void (*handler)(void))
>  }
>  EXPORT_SYMBOL_GPL(hv_setup_mshv_handler);
>  
> -void __weak hv_setup_kexec_handler(void (*handler)(void))
> -{
> -}
> -EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
> -
> -void __weak hv_remove_kexec_handler(void)
> -{
> -}
> -EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
> -
>  void __weak hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
>  {
>  }
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 5ebdbe24b5a1..3532ea779d34 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -33,6 +33,7 @@
>  #include <linux/sysfb.h>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
> +#include <linux/kexec.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
> @@ -2904,6 +2905,12 @@ static void hv_kexec_handler(void)
>  	cpuhp_remove_state(hyperv_cpuhp_online);
>  };
>  
> +static void hv_vmbus_syscore_shutdown(void *data)
> +{
> +	if (kexec_is_in_progress())
> +		hv_kexec_handler();
> +}
> +
>  static void hv_crash_handler(struct pt_regs *regs)
>  {
>  	int cpu;
> @@ -2958,14 +2965,15 @@ static void hv_synic_resume(void *data)
>  	 */
>  }
>  
> -/* The callbacks run only on CPU0, with irqs_disabled. */
> -static const struct syscore_ops hv_synic_syscore_ops = {
> +/* The suspend and resume callbacks run only on CPU0, with irqs_disabled. */
> +static const struct syscore_ops hv_vmbus_syscore_ops = {
>  	.suspend = hv_synic_suspend,
>  	.resume = hv_synic_resume,
> +	.shutdown = hv_vmbus_syscore_shutdown,
>  };
>  
> -static struct syscore hv_synic_syscore = {
> -	.ops = &hv_synic_syscore_ops,
> +static struct syscore hv_vmbus_syscore = {
> +	.ops = &hv_vmbus_syscore_ops,
>  };
>  
>  static int __init hv_acpi_init(void)
> @@ -3014,10 +3022,9 @@ static int __init hv_acpi_init(void)
>  	if (ret)
>  		goto cleanup;
>  
> -	hv_setup_kexec_handler(hv_kexec_handler);
>  	hv_setup_crash_handler(hv_crash_handler);
>  
> -	register_syscore(&hv_synic_syscore);
> +	register_syscore(&hv_vmbus_syscore);
>  
>  	return 0;
>  
> @@ -3039,9 +3046,8 @@ static void __exit vmbus_exit(void)
>  		 */
>  		return;
>  
> -	unregister_syscore(&hv_synic_syscore);
> +	unregister_syscore(&hv_vmbus_syscore);
>  
> -	hv_remove_kexec_handler();
>  	hv_remove_crash_handler();
>  	vmbus_connection.conn_state = DISCONNECTED;
>  	hv_stimer_global_cleanup();
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index bf601d67cecb..98fe5c0f54ea 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -183,8 +183,6 @@ void hv_remove_vmbus_handler(void);
>  void hv_setup_stimer0_handler(void (*handler)(void));
>  void hv_remove_stimer0_handler(void);
>  
> -void hv_setup_kexec_handler(void (*handler)(void));
> -void hv_remove_kexec_handler(void);
>  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
>  void hv_remove_crash_handler(void);
>  void hv_setup_mshv_handler(void (*handler)(void));

-- 
Regards,
Mukesh Pilaniya


