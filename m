Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535BAC25B0C
	for <kexec@archiver.kernel.org>; Mon,  8 Aug 2022 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vsW1PafoCH9DAHIj9XLb1Aaj7Z0Tet8rer602azUol0=; b=B9Depf0AHl1nqM
	m5gI5hAlaQZ4jhaFPXQIKjnXZ2/jzZCWXNUKvW3OWcAUuXsZW4PdUOC+aCv+sk0iIQMkiu72k2XuT
	aC811aPyy4o2+ggtd0S4a48qf8gG4P9722jSXfOm7rDiU3OmII4aaayMUxsUqgnal769xseJbStxp
	4AhpEzFfEMBeWl3MgOEuY4SrfYBP8b5Pgbtwgh3pr2LRe5n1U417RzjmcJoUvuagOoyiI+2WfhyUT
	Qti4fMvlN16MsZnopDOnwVOqyNNeYQ4j7+CEHFF9kR4fOzt7rTv4Fm15ImojPMHzJsVPssRpg6WqY
	60pmzrVOx32Ky1cnt3aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKz5S-00Cf8v-R2; Mon, 08 Aug 2022 09:30:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKz5Q-00Cf6r-OI
	for kexec@lists.infradead.org; Mon, 08 Aug 2022 09:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659951011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yt7NR2eGA5LoFPxjX/rSv4RMe6uZ/HTujjGSsAea94s=;
	b=EKxocsdYuteaDtXIqgcwahFiO0vOEWoimqCAMJpjKY2qX3DMAytvdfjlZNLTPjmrqdYE1T
	nsd5vNT5H8rQvsgB2FqsWGmJxFofpAhCk5kSKJkTvAq4LatUVD3Oh/+mHPZTk+VUL/k2oT
	3h3hpXgtbuupGLrg1L7hZzJNvvxp+to=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-u9Xr8zsjPUqQ1b4Pvi8qOg-1; Mon, 08 Aug 2022 05:30:07 -0400
X-MC-Unique: u9Xr8zsjPUqQ1b4Pvi8qOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3ED01C006A8;
	Mon,  8 Aug 2022 09:30:06 +0000 (UTC)
Received: from localhost (ovpn-12-221.pek2.redhat.com [10.72.12.221])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B9EDA1121314;
	Mon,  8 Aug 2022 09:30:05 +0000 (UTC)
Date: Mon, 8 Aug 2022 17:30:02 +0800
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
Subject: Re: [PATCH v10 4/8] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <YvDXmmCBXWAFkehc@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-5-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220721181747.1640-5-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220808_023012_889142_A1BC6C23 
X-CRM114-Status: GOOD (  34.99  )
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

On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> CPU and memory change notifications are received in order to
> regenerate the elfcorehdr.
> 
> To support cpu hotplug, a callback is registered to capture the
> CPUHP_AP_ONLINE_DYN online and offline events via
> cpuhp_setup_state_nocalls().
> 
> To support memory hotplug, a notifier is registered to capture the
> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
> 
> The cpu callback and memory notifiers call handle_hotplug_event()
> which performs needed tasks and then dispatches the event to the
> architecture specific arch_crash_handle_hotplug_event(). During the
> process, the kexec_mutex is held.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  include/linux/crash_core.h |  24 ++++++++
>  include/linux/kexec.h      |   7 +++
>  kernel/crash_core.c        | 118 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index cb0f1916fbf5..c9705b6872e7 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -86,4 +86,28 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  
> +#define KEXEC_CRASH_HP_REMOVE_CPU		0
> +#define KEXEC_CRASH_HP_ADD_CPU			1
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
> +
> +struct kimage;
> +#ifndef arch_map_crash_pages
> +static inline void *arch_map_crash_pages(unsigned long paddr,
> +		unsigned long size)
> +{
> +	return NULL;
> +}
> +#endif
> +#ifndef arch_unmap_crash_pages
> +static inline void arch_unmap_crash_pages(void **ptr) { }
> +#endif
> +#ifndef arch_crash_handle_hotplug_event
> +static inline void arch_crash_handle_hotplug_event(struct kimage *image,
> +		unsigned int hp_action, unsigned int cpu)
> +{
> +}
> +#endif
> +
>  #endif /* LINUX_CRASH_CORE_H */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 5f4969cf3f4e..7694aa77b92b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -340,6 +340,13 @@ struct kimage {
>  	struct purgatory_info purgatory_info;
>  #endif
>  
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +	bool hotplug_event;
> +	unsigned int offlinecpu;
> +	bool elfcorehdr_index_valid;
> +	int elfcorehdr_index;
> +#endif
> +
>  #ifdef CONFIG_IMA_KEXEC
>  	/* Virtual address of IMA measurement buffer for kexec syscall */
>  	void *ima_buffer;
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 212d4dad0ec7..154ef532d45a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -10,12 +10,16 @@
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
>  
>  #include <crypto/sha1.h>
>  
> +#include "kexec_internal.h"
> +
>  /* vmcoreinfo stuff */
>  unsigned char *vmcoreinfo_data;
>  size_t vmcoreinfo_size;
> @@ -587,3 +591,117 @@ static int __init crash_save_vmcoreinfo_init(void)
>  }
>  
>  subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	mutex_lock(&kexec_mutex);
> +
> +	/* Check kdump is loaded */
> +	if (kexec_crash_image) {
> +		struct kimage *image = kexec_crash_image;
> +
> +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);

We don't need to check if it's cpu hotplug action here? Then for mem
hotplug actions, we also get:
                "crash hp: hp_action 2, cpu 0"
That cpu 0 will be confusing. And you forgot the line break.

Can we do like this:
		pr_debug("crash hp: hp_action %u ", hp_action);
		if (hp_action == KEXEC_CRASH_HP_REMOVE_CPU ||
		    hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
			pr_debug("cpu %u \n", cpu);

Other than this, the patch looks good to me.

> +
> +		/*
> +		 * When the struct kimage is alloced, it is wiped to zero, so
> +		 * the elfcorehdr_index_valid defaults to false. Find the
> +		 * segment containing the elfcorehdr, if not already found.
> +		 * This works for both the kexec_load and kexec_file_load paths.
> +		 */
> +		if (!image->elfcorehdr_index_valid) {
> +			unsigned char *ptr;
> +			unsigned long mem, memsz;
> +			unsigned int n;
> +
> +			for (n = 0; n < image->nr_segments; n++) {
> +				mem = image->segment[n].mem;
> +				memsz = image->segment[n].memsz;
> +				ptr = arch_map_crash_pages(mem, memsz);
> +				if (ptr) {
> +					/* The segment containing elfcorehdr */
> +					if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +						image->elfcorehdr_index = (int)n;
> +						image->elfcorehdr_index_valid = true;
> +					}
> +				}
> +				arch_unmap_crash_pages((void **)&ptr);
> +			}
> +		}
> +
> +		if (!image->elfcorehdr_index_valid) {
> +			pr_err("crash hp: unable to locate elfcorehdr segment");
> +			goto out;
> +		}
> +
> +		/* Needed in order for the segments to be updated */
> +		arch_kexec_unprotect_crashkres();
> +
> +		/* Flag to differentiate between normal load and hotplug */
> +		image->hotplug_event = true;
> +
> +		/* Now invoke arch-specific update handler */
> +		arch_crash_handle_hotplug_event(image, hp_action, cpu);
> +
> +		/* No longer handling a hotplug event */
> +		image->hotplug_event = false;
> +
> +		/* Change back to read-only */
> +		arch_kexec_protect_crashkres();
> +	}
> +
> +out:
> +	/* Release lock now that update complete */
> +	mutex_unlock(&kexec_mutex);
> +}
> +
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +{
> +	switch (val) {
> +	case MEM_ONLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
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
