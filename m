Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6786EEA866
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 22:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eMu5gM+7OCyBS0hUDhGp2mJQZR4sgj4kzgGvyMhqUdU=; b=ttHf9CPztA+ynvekfOvtIriuAq
	+bJLs3yMluIyUsoXhLWrrMVokcwHW++Alqh29GvzL36rNrBkUueawhY4EMuzkwUFZ9vidfbeh/hkK
	Znu76/Sqw6zY/p1jf7klaooSplfXcRccfHdSdhwI7clt3KTvJQ4c1rykjtaa8yg6EQnoPJ4BfVrpM
	9tmk2dGw1VeVZ1QY3fyICK+ppA6gfdWM/arqJK+ENheU3zCsbkBP2kkjLjxjoQ4D1Glh2vzCULLip
	Hj4APupgurC9eIXTII6LHAs9xxS4GUymEQfciR8YHLYcKT6kXIHkBfjtVHJW1hPbXRU7zk7XErNWX
	sUQAyKHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqevJ-00000002gp2-3HpQ;
	Thu, 12 Feb 2026 22:12:33 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqevH-00000002go6-0ct8
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 22:12:32 +0000
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id DCE0220B7167;
	Thu, 12 Feb 2026 14:12:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCE0220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770934350;
	bh=eMu5gM+7OCyBS0hUDhGp2mJQZR4sgj4kzgGvyMhqUdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gq8WHvem2vqIRkO6kZVc5+1qQngR2Hp8hsLZVZh0cl2ETgiI+xBKN/TRhkay36ttB
	 basHTkzMfJAYVGt71D5PGwmh4BStk+ZG70JTPBpa735L5I82AU+ydJQ/T9ZjrNsc97
	 pTmlCtk/nOBsGDNI/0wuTdc352GZfFhPoVDJRSBQ=
Message-ID: <fb651abf-0546-3bef-bf8f-597f35ddc0d6@linux.microsoft.com>
Date: Thu, 12 Feb 2026 14:12:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] kexec: Add permission notifier chain for kexec
 operations
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176962212169.85424.4683391728440118017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <176962212169.85424.4683391728440118017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_141231_219820_2D67510A 
X-CRM114-Status: GOOD (  22.03  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 1/28/26 09:42, Stanislav Kinsburskii wrote:
> Add a blocking notifier chain to allow subsystems to be notified
> before kexec execution. This enables modules to perform necessary
> cleanup or validation before the system transitions to a new kernel or
> block kexec if not possible under current conditions.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   include/linux/kexec.h |    6 ++++++
>   kernel/kexec_core.c   |   24 ++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ff7e231b0485..311037d30f9e 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -35,6 +35,7 @@ extern note_buf_t __percpu *crash_notes;
>   #include <linux/ioport.h>
>   #include <linux/module.h>
>   #include <linux/highmem.h>
> +#include <linux/notifier.h>
>   #include <asm/kexec.h>
>   #include <linux/crash_core.h>
>   
> @@ -532,10 +533,13 @@ extern bool kexec_file_dbg_print;
>   
>   extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
>   extern void kimage_unmap_segment(void *buffer);
> +extern int kexec_block_notifier_register(struct notifier_block *nb);
> +extern int kexec_block_notifier_unregister(struct notifier_block *nb);
>   #else /* !CONFIG_KEXEC_CORE */
>   struct pt_regs;
>   struct task_struct;
>   struct kimage;
> +struct notifier_block;
>   static inline void __crash_kexec(struct pt_regs *regs) { }
>   static inline void crash_kexec(struct pt_regs *regs) { }
>   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
> @@ -543,6 +547,8 @@ static inline int kexec_crash_loaded(void) { return 0; }
>   static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
>   { return NULL; }
>   static inline void kimage_unmap_segment(void *buffer) { }
> +static inline int kexec_block_notifier_register(struct notifier_block *nb) { }
> +static inline int kexec_block_notifier_unregister(struct notifier_block *nb) { }
>   #define kexec_in_progress false
>   #endif /* CONFIG_KEXEC_CORE */
>   
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 0f92acdd354d..1e86a6f175f0 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -57,6 +57,20 @@ bool kexec_in_progress = false;
>   
>   bool kexec_file_dbg_print;
>   
> +static BLOCKING_NOTIFIER_HEAD(kexec_block_list);
> +
> +int kexec_block_notifier_register(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&kexec_block_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(kexec_block_notifier_register);
> +
> +int kexec_block_notifier_unregister(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&kexec_block_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(kexec_block_notifier_unregister);
> +
>   /*
>    * When kexec transitions to the new kernel there is a one-to-one
>    * mapping between physical and virtual addresses.  On processors
> @@ -1124,6 +1138,12 @@ bool kexec_load_permitted(int kexec_image_type)
>   	return true;
>   }
>   
> +static int kexec_check_blockers(void)
> +{
> +	/* Notify subsystems of impending kexec */
> +	return blocking_notifier_call_chain(&kexec_block_list, 0, NULL);
> +}
> +
>   /*
>    * Move into place and start executing a preloaded standalone
>    * executable.  If nothing was preloaded return an error.
> @@ -1139,6 +1159,10 @@ int kernel_kexec(void)
>   		goto Unlock;
>   	}
>   
> +	error = kexec_check_blockers();

This could take a long time, and I am not sure if it's a good idea
to stall kexec with such dependencies.

Thanks,
-Mukesh


> +	if (error)
> +		goto Unlock;
> +
>   	error = liveupdate_reboot();
>   	if (error)
>   		goto Unlock;
> 
> 


