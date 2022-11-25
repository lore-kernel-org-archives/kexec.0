Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE38AC4332F
	for <kexec@archiver.kernel.org>; Fri, 25 Nov 2022 03:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fUz2wMqdI9ejRNRPnMQiBXukM8ydMKQgf3+fU6kU+/g=; b=K+7BkLN1UcBpbo
	p52rfR2bVpkjkY1I5+OE8x3a2LObSLAMSwAdD1RPE+kBSvSKFcox4OK0eQHmzoH8c02Sd3k91PywL
	HmV6zkBdZY1sg20s/E7JbGO8RNX14cc1ytBs3nd/83lNPgr5DLUiqi8PNvZ62BIJM2AnAZ4y4hDIc
	L+9h8q7DS4QBVU7I/2kqEyVp7e+HgtvernT2w0Z0xa2lO8dvytcMYcGRbKgCMlDmPNdbWByg6wPWR
	XCuT7qE4hyndGSgyRXtUb33lsMq5bFmFukV/QNZeodNQxwMJbRnRZbiqANi8w5WKUIzi1Tgx8M5AL
	9HEwR60FReGwPE4ra0QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyPMq-00CLzZ-Ub; Fri, 25 Nov 2022 03:27:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyPMo-00CLy5-7l
	for kexec@lists.infradead.org; Fri, 25 Nov 2022 03:27:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669346824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JwS+i6RHG4xio2GVK1XiM/i9nFbjB+wVt/xavPQmn3c=;
	b=OzSloXY0dPSrpbOnXEPgh0zSdhRpKLAGAKQe95DDY/XctkTcf9wo9O89mKqu68WwZ42ZHS
	5+HtFKdvRb3oy22v5Isb2wIGNFp0nDNZyXcONI47gtpxvR9zbJJ1o1iYfcaJLJ/fdsbL4v
	Tn9Pn8kd5P8g4hNisFlKOMCDp5p6zq8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-BDApgZi3M5KZkQ13ZWGYHQ-1; Thu, 24 Nov 2022 22:27:00 -0500
X-MC-Unique: BDApgZi3M5KZkQ13ZWGYHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 521AC3804507;
	Fri, 25 Nov 2022 03:26:59 +0000 (UTC)
Received: from localhost (ovpn-12-208.pek2.redhat.com [10.72.12.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C5DF540C6DC7;
	Fri, 25 Nov 2022 03:26:57 +0000 (UTC)
Date: Fri, 25 Nov 2022 11:26:53 +0800
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
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116214643.6384-4-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_192706_374148_BBF123B5 
X-CRM114-Status: GOOD (  37.18  )
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

On 11/16/22 at 04:46pm, Eric DeVolder wrote:
......
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ebf46c3b8f8b..b4dbc21f9081 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -32,6 +32,7 @@ extern note_buf_t __percpu *crash_notes;
>  #include <linux/compat.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> +#include <linux/highmem.h>
>  #include <asm/kexec.h>
>  
>  /* Verify architecture specific macros are defined */
> @@ -374,6 +375,13 @@ struct kimage {
>  	struct purgatory_info purgatory_info;
>  #endif
>  
> +#ifdef CONFIG_CRASH_HOTPLUG

This kernel config CRASH_HOTPLUG is added in patch 7, but we have used
it in the previous patch, not sure if this is acceptable.

> +	bool hotplug_event;
> +	unsigned int offlinecpu;
> +	bool elfcorehdr_index_valid;
> +	int elfcorehdr_index;
> +#endif
> +
>  #ifdef CONFIG_IMA_KEXEC
>  	/* Virtual address of IMA measurement buffer for kexec syscall */
>  	void *ima_buffer;
> @@ -503,6 +511,34 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>  static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>  #endif
>  
> +#ifndef arch_map_crash_pages
> +/*
> + * NOTE: The addresses and sizes passed to this routine have
> + * already been fully aligned on page boundaries. There is no
> + * need for massaging the address or size.
> + */
> +static inline void *arch_map_crash_pages(unsigned long paddr,
> +					unsigned long size)
> +{
> +	if (size > 0)
> +		return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
> +	else
> +		return NULL;
> +}
> +#endif
> +
> +#ifndef arch_unmap_crash_pages
> +static inline void arch_unmap_crash_pages(void *ptr)
> +{
> +	if (ptr)
> +		kunmap_local(ptr);
> +}
> +#endif
> +
> +#ifndef arch_crash_handle_hotplug_event
> +static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
> +#endif
> +
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
>  struct task_struct;
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 8c648fd5897a..4e7221226976 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -11,6 +11,8 @@
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
>  #include <linux/kexec.h>
> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -18,6 +20,7 @@
>  #include <crypto/sha1.h>
>  
>  #include "kallsyms_internal.h"
> +#include "kexec_internal.h"
>  
>  /* vmcoreinfo stuff */
>  unsigned char *vmcoreinfo_data;
> @@ -612,3 +615,139 @@ static int __init crash_save_vmcoreinfo_init(void)
>  }
>  
>  subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +#undef pr_fmt
> +#define pr_fmt(fmt) "crash hp: " fmt
> +/*
> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
> + * is passed to the crash kernel via the elfcorehdr= parameter)
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
> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (kexec_trylock()) {
> +
> +		/* Check kdump is loaded */
> +		if (kexec_crash_image) {
> +			struct kimage *image = kexec_crash_image;
> +
> +			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> +				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> +			else
> +				pr_debug("hp_action %u\n", hp_action);
> +
> +			/*
> +			 * When the struct kimage is allocated, it is wiped to zero, so
> +			 * the elfcorehdr_index_valid defaults to false. Find the
> +			 * segment containing the elfcorehdr, if not already found.
> +			 * This works for both the kexec_load and kexec_file_load paths.
> +			 */
> +			if (!image->elfcorehdr_index_valid) {
> +				unsigned long mem, memsz;
> +				unsigned char *ptr;
> +				unsigned int n;
> +
> +				for (n = 0; n < image->nr_segments; n++) {
> +					mem = image->segment[n].mem;
> +					memsz = image->segment[n].memsz;
> +					ptr = arch_map_crash_pages(mem, memsz);
> +					if (ptr) {
> +						/* The segment containing elfcorehdr */
> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +							image->elfcorehdr_index = (int)n;
> +							image->elfcorehdr_index_valid = true;
> +						}
> +					}
> +					arch_unmap_crash_pages((void *)ptr);
> +				}
> +			}
> +
> +			if (!image->elfcorehdr_index_valid) {
> +				pr_err("unable to locate elfcorehdr segment");
> +				goto out;
> +			}
> +
> +			/* Needed in order for the segments to be updated */
> +			arch_kexec_unprotect_crashkres();
> +
> +			/* Flag to differentiate between normal load and hotplug */
> +			image->hotplug_event = true;
> +
> +			/* Now invoke arch-specific update handler */
> +			arch_crash_handle_hotplug_event(image);
> +
> +			/* No longer handling a hotplug event */
> +			image->hotplug_event = false;
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
> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
> +			KEXEC_CRASH_HP_INVALID_CPU);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
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
> +static int crash_cpuhp_online(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
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
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +						   "crash/cpuhp",
> +						   crash_cpuhp_online,
> +						   crash_cpuhp_offline);
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif
> -- 
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
