Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C46AC6FD1C
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 10:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OM1OYlcmxScjLRU1zQN3MuD451+Vx9A7znitUTp9S6A=; b=0Tck2EWkmRj6Lq
	mNai33mvwHCyPXZA2EHKxastjAEL6YvJrU5cEzULLo1Z0AmlIMU7XY2izrvcKPqheYiNxVvo4NHsA
	LYVOEiugEjQgJK3U7n0hjwXQShT6YUtQCdfCxSTcYI07B3YXUEqT4UYMN1VeWNziNONNTUEo6bL5B
	YwxlYccfTcz4NW4LCCLtzmkxRq7Nh8RgShr06Yto6Jx2WHiTWVYPPikPzRHfHlps7DynxaNX6xsaA
	1C3quQMKrjqZjbecGER3Md+n00sK4GjIPl0D4VyZ6quWaA+nim1M+NzX16LMd/CG2uQhLq3hHZmAT
	Cia5bnj/GTWp70WNYCTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc285-009nOs-1m;
	Tue, 14 Mar 2023 10:43:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc282-009nMC-0l
	for kexec@lists.infradead.org;
	Tue, 14 Mar 2023 10:43:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678790615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2qaqlNY6k4SWQVNT90AfT4Sxk3NbeQfevvHYqeFvtY=;
	b=Oh48xVQWMpkzPUdsjBJVzECPXzg8UQhDCksUhE7DeBJWXgMpuY3lRHtDjFv7AKhSHDn9KV
	wfYCrwGBuoKe1UL1sXzPthteQCqEUyyHssdCiQa+43MTCaij4RQsSGXg9RRawB3D2zC/xE
	swNEFU+jjAiR6mSD0dv5iKJqlxUZgrI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-EAvHKNpsN9CxgMptaQqMfg-1; Tue, 14 Mar 2023 06:43:30 -0400
X-MC-Unique: EAvHKNpsN9CxgMptaQqMfg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2D062810C08;
	Tue, 14 Mar 2023 10:43:28 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AFBE9400F55;
	Tue, 14 Mar 2023 10:43:27 +0000 (UTC)
Date: Tue, 14 Mar 2023 18:43:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZBBPzKBTuzGZe4OC@MiWiFi-R3L-srv>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230306162228.8277-3-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_034338_465430_7DCB2E76 
X-CRM114-Status: GOOD (  32.83  )
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

On 03/06/23 at 11:22am, Eric DeVolder wrote:
......
> +#ifdef CONFIG_CRASH_HOTPLUG
> +#undef pr_fmt
> +#define pr_fmt(fmt) "crash hp: " fmt
> +/*
> + * To accurately reflect hot un/plug changes of cpu and memory resources
> + * (including onling and offlining of those resources), the elfcorehdr
> + * (which is passed to the crash kernel via the elfcorehdr= parameter)
> + * must be updated with the new list of CPUs and memories.
> + *
> + * In order to make changes to elfcorehdr, two conditions are needed:
> + * First, the segment containing the elfcorehdr must be large enough
> + * to permit a growing number of resources; the elfcorehdr memory size
> + * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
> + * Second, purgatory must explicitly exclude the elfcorehdr from the
> + * list of segments it checks (since the elfcorehdr changes and thus
> + * would require an update to purgatory itself to update the digest).
> + */
> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (kexec_trylock()) {
> +
> +		/* Check kdump is loaded */
> +		if (kexec_crash_image) {

If the above check failed, I would directly return or jump out becuase
one indentation can be reduced.

> +			struct kimage *image = kexec_crash_image;
> +
> +			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> +				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> +			else
> +				pr_debug("hp_action %u\n", hp_action);
> +
> +			/*
> +			 * When the struct kimage is allocated, the elfcorehdr_index
> +			 * is set to -1. Find the segment containing the elfcorehdr,
> +			 * if not already found. This works for both the kexec_load
> +			 * and kexec_file_load paths.
> +			 */
> +			if (image->elfcorehdr_index < 0) {
> +				unsigned long mem;
> +				unsigned char *ptr;
> +				unsigned int n;
> +
> +				for (n = 0; n < image->nr_segments; n++) {
> +					mem = image->segment[n].mem;
> +					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> +					if (ptr) {
> +						/* The segment containing elfcorehdr */
> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +							image->elfcorehdr_index = (int)n;
> +						}
> +						kunmap_local(ptr);
> +					}
> +				}
> +			}
> +
> +			if (image->elfcorehdr_index < 0) {
> +				pr_err("unable to locate elfcorehdr segment");
> +				goto out;
> +			}
> +
> +			/* Needed in order for the segments to be updated */
> +			arch_kexec_unprotect_crashkres();
> +
> +			/* Differentiate between normal load and hotplug update */
> +			image->hp_action = hp_action;
> +
> +			/* Now invoke arch-specific update handler */
> +			arch_crash_handle_hotplug_event(image);
> +
> +			/* No longer handling a hotplug event */
> +			image->hp_action = KEXEC_CRASH_HP_NONE;
> +			image->elfcorehdr_updated = true;
> +
> +			/* Change back to read-only */
> +			arch_kexec_protect_crashkres();
> +		}
> +
> +out:
> +		/* Release lock now that update complete */
> +		kexec_unlock();
> +	}
> +}
> +
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +{
> +	switch (val) {
> +	case MEM_ONLINE:
> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
> +			KEXEC_CRASH_HP_INVALID_CPU);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
> +			KEXEC_CRASH_HP_INVALID_CPU);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block crash_memhp_nb = {
> +	.notifier_call = crash_memhp_notifier,
> +	.priority = 0
> +};
> +

Because for_each_possible_cpu() is taken in
crash_prepare_elf64_headers(), x86 doesn't need to respond to cpu
hotplug or doesn't do anything with this patchset. This cpu part in
infrastructure is only for the later powerpc usage, right?

> +static int crash_cpuhp_online(unsigned int cpu)
> +{
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> +	return 0;
> +}
> +
> +static int __init crash_hotplug_init(void)
> +{
> +	int result = 0;
> +
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		register_memory_notifier(&crash_memhp_nb);
> +
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> +		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
> +			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
> +	}
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 969e8f52f7da..f2f9d41ce5df 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -276,6 +276,11 @@ struct kimage *do_kimage_alloc_init(void)
>  	/* Initialize the list of unusable pages */
>  	INIT_LIST_HEAD(&image->unusable_pages);
>  
> +#ifdef CONFIG_CRASH_HOTPLUG
> +    image->elfcorehdr_index = -1;
> +    image->elfcorehdr_updated = false;
> +#endif
> +
>  	return image;
>  }
>  
> -- 
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
