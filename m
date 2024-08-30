Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18155CA0EFD
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fqSqUtnd3MnGXExWe13PZTKUfXbvrb4TjFU/xUlB0KY=; b=u0vFfdkg/Jea+r
	YUHCh3/kxU7z/4C+6XCSNu704UwVTROjA4C5mV2407BR6LdmPHE7tAKu8vp6yYPmw1njTrw/eEgmQ
	1LHzNp8Fmv/JdtY9VwWlhtc+d+Fnqj9A3n67PSHP7LVk5j59vNptIVWq4QeyjMLvc3BjjIGvAYZL6
	Dy4yu+zcw2GrydkWKIfKUOSUd6mzMnMxz6l/LUFwAqxuxzZ/lOQCBsTQJNOCgzvNOzLah2Pgrk4k1
	EqHHQoV151phdNbAbFFm+k1jd5zeemEcC3H3DjIE3rWPVYH6fWYmwNcwYiL0hn2jmjrr12gN9ss4E
	2Holihe0FWUQqZ3FVT3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk65y-00000007IdI-39oo;
	Fri, 30 Aug 2024 18:11:38 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk65v-00000007Iah-1Fr1
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 18:11:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=28Z7dlWcO7m9gkU3DOzwuYm7qBeow4XlSUU1VNXqCuM=; b=KCJhDUSZXjqCXyf6ktd33IQgT2
	oAAS/t7P+5fmOFj5q8ftN2N0OIByUsie0WiIxFaKnmOrOmB5sI7zja5AbFIaUFThjBX6e06rnevWj
	1Huq33OngdJz/bAYJTSPwf1328zmWAx/E+Nl8Hk4ffOdfSIC7UKNWEKMxPCF8WbDGNDSgT6J8jrsi
	WlgdVrzqdnrBrJLAgk3Sp/4F792EYW74wRQVr06ZEg/FLfcBqP4FAKAwVLmunNp9oQapsLc6JakIc
	L9zTQgLdcK4BxCSwBfZ3HAoSE2lLbss1059yuc45J4n/3uLvSbK1kKKH164xrpV+ZPZGsJ+LqoVVR
	jAIJOA3g==;
Received: from [177.76.152.96] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sk65l-007FKs-2N; Fri, 30 Aug 2024 20:11:24 +0200
Message-ID: <d1e65436-b49b-76b1-01d4-2be2a0eb0f3a@igalia.com>
Date: Fri, 30 Aug 2024 15:11:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] powerpc/fadump, x86/sev: Inform about unconditionally
 enabling crash_kexec_post_notifiers
Content-Language: en-US
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 hbathini@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ashish.kalra@amd.com,
 michael.roth@amd.com, brijesh.singh@amd.com, thomas.lendacky@amd.com,
 linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
 kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20240830141752.460173-1-gpiccoli@igalia.com>
 <87bk19rj5u.fsf@oracle.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <87bk19rj5u.fsf@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_111135_694806_38D52CF9 
X-CRM114-Status: GOOD (  20.42  )
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

On 30/08/2024 14:54, Stephen Brennan wrote:
> [...]
> Could we maybe go further than this, and delete the public declarations
> of crash_kexec_post_notifiers in "include/linux"? (I see two). We could
> replace the users that set it to true with a function that logs the
> change so that it's impossible for new code to set it directly without
> notifying the user. Something like this? Compile tested only for x86.
> 
> commit da8691a25d7b0c2f914720bc054dd1d9dbe4b373
> Author: Stephen Brennan <stephen.s.brennan@oracle.com>
> Date:   Fri Aug 30 10:49:24 2024 -0700
> 
>     panic: make crash_kexec_post_notifiers private
>     
>     This requires that any in-kernel user setting it directly must log the
>     reason so that users are aware their panic behavior may be different
>     from their configuration.
>     
>     Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> 

Thanks Stephen! I'm totally into that, your approach is very good.
Cheers,


Guilherme


> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index a612e7513a4f8..9966f29409599 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1818,7 +1818,7 @@ int __init setup_fadump(void)
>  	 * lets panic() function take crash friendly path before panic
>  	 * notifiers are invoked.
>  	 */
> -	crash_kexec_post_notifiers = true;
> +	enable_crash_kexec_post_notifiers("PPC/fadump");
>  
>  	return 1;
>  }
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 0ce17766c0e52..6e9f5f8d13cc5 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -256,7 +256,7 @@ static int __init snp_rmptable_init(void)
>  	 * Setting crash_kexec_post_notifiers to 'true' to ensure that SNP panic
>  	 * notifier is invoked to do SNP IOMMU shutdown before kdump.
>  	 */
> -	crash_kexec_post_notifiers = true;
> +	enable_crash_kexec_post_notifiers("AMD/SEV");
>  
>  	return 0;
>  
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 9c452bfbd5719..fa3bbb66235de 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -303,8 +303,7 @@ int __init hv_common_init(void)
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
>  		u64 hyperv_crash_ctl;
>  
> -		crash_kexec_post_notifiers = true;
> -		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
> +		enable_crash_kexec_post_notifiers("Hyper-V");
>  
>  		/*
>  		 * Panic message recording (sysctl_record_panic_msg)
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 54d90b6c5f47b..697184664c6f4 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -31,8 +31,6 @@ extern int sysctl_panic_on_rcu_stall;
>  extern int sysctl_max_rcu_stall_to_panic;
>  extern int sysctl_panic_on_stackoverflow;
>  
> -extern bool crash_kexec_post_notifiers;
> -
>  extern void __stack_chk_fail(void);
>  void abort(void);
>  
> diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> index 41e32483d7a7b..97c31cf5c2fdb 100644
> --- a/include/linux/panic_notifier.h
> +++ b/include/linux/panic_notifier.h
> @@ -7,6 +7,6 @@
>  
>  extern struct atomic_notifier_head panic_notifier_list;
>  
> -extern bool crash_kexec_post_notifiers;
> +void enable_crash_kexec_post_notifiers(const char *reason);
>  
>  #endif	/* _LINUX_PANIC_NOTIFIERS_H */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 63cf89393c6eb..634c6b99717c5 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -33,6 +33,9 @@
>  /* Per cpu memory for storing cpu states in case of system crash. */
>  note_buf_t __percpu *crash_notes;
>  
> +/* Defined in kernel/panic.c and needed here, but not intended to be public. */
> +extern bool crash_kexec_post_notifiers;
> +
>  #ifdef CONFIG_CRASH_DUMP
>  
>  int kimage_crash_copy_vmcoreinfo(struct kimage *image)
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 2a0449144f82e..f4ae3abbea7ed 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -137,6 +137,12 @@ static long no_blink(int state)
>  	return 0;
>  }
>  
> +void enable_crash_kexec_post_notifiers(const char *reason)
> +{
> +	crash_kexec_post_notifiers = true;
> +	pr_info("%s: enabling crash_kexec_post_notifiers\n", reason);
> +}
> +
>  /* Returns how long it waited in ms */
>  long (*panic_blink)(int state);
>  EXPORT_SYMBOL(panic_blink);
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
