Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040C5C48286
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 03:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VML3OKow99nyKkI7DDa99g7dCPH8xj2D4xYQlDOGWSg=; b=oOKvoo9hR5DSm/
	5i72ilAvQriz4trJb7AHhaNzrcWbanlIsY8FerlHAnleWOr1o+d0+hqwgUBSfeRjZjoF+XhTBQilN
	8xdAHKx4x9N/ZVlKKhMuElfAY2CUyLs1cu051yW33sCDW6XJghSZqF5mP2wJ3A267l+iQbUzLhW56
	zxGkwF0I+zdW8l4Msj3q/T35aTSpHQHe8rFiiAIYrtMzgeJTCAmT2CwKxKRS+OkGn89u0QpK6RjrW
	B1Yq/IGKrA0s5ByXuroixHG1fb6cT3OEqXNix7VnpHyp5IBSng9YwuhWo66iQUoF85wIaNzhNHuIh
	cG1YX6cyExAgzQTzBAZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWpOs-00000001tSI-2FxW;
	Mon, 05 Feb 2024 03:12:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWpOp-00000001tRn-1Ueo
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 03:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707102718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kPlQn8QRfP3g8CtVKZqx50P9JlBCXuNtPZrwY21Ifzk=;
	b=hh09krahDDstss0jvLxUfjhSM1YG7aTjXKM1Dp0IYcWlO+yZ/2RAqGdnfKuVEcVxsaaunn
	cPslm6lCP1MVWe7nzrxRScJ+0Pa2UsFJ93OaN6lxtQgxI5Z8xT19Y6Z85Yzy/5y4KLQiO2
	1Wjv/aO5AkZj7Lc1SftENOzPiVciAXY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-zIxkvvPQNnahi-68DSb0bg-1; Sun,
 04 Feb 2024 22:11:52 -0500
X-MC-Unique: zIxkvvPQNnahi-68DSb0bg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC5C51C05AD1;
	Mon,  5 Feb 2024 03:11:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E17B32026D66;
	Mon,  5 Feb 2024 03:11:48 +0000 (UTC)
Date: Mon, 5 Feb 2024 11:11:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Young <dyoung@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v15 1/5] crash: forward memory_notify arg to arch crash
 hotplug handler
Message-ID: <ZcBR8Q+/WL3luZnP@MiWiFi-R3L-srv>
References: <20240111105138.251366-1-sourabhjain@linux.ibm.com>
 <20240111105138.251366-2-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20240111105138.251366-2-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240204_191159_498838_F9A79B47 
X-CRM114-Status: GOOD (  23.52  )
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

On 01/11/24 at 04:21pm, Sourabh Jain wrote:
> In the event of memory hotplug or online/offline events, the crash
> memory hotplug notifier `crash_memhp_notifier()` receives a
> `memory_notify` object but doesn't forward that object to the
> generic and architecture-specific crash hotplug handler.
> 
> The `memory_notify` object contains the starting PFN (Page Frame Number)
> and the number of pages in the hot-removed memory. This information is
> necessary for architectures like PowerPC to update/recreate the kdump
> image, specifically `elfcorehdr`.
> 
> So update the function signature of `crash_handle_hotplug_event()` and
> `arch_crash_handle_hotplug_event()` to accept the `memory_notify` object
> as an argument from crash memory hotplug notifier.
> 
> Since no such object is available in the case of CPU hotplug event, the
> crash CPU hotplug notifier `crash_cpuhp_online()` passes NULL to the
> crash hotplug handler.
> 
......
> ---
>  arch/x86/include/asm/kexec.h |  2 +-
>  arch/x86/kernel/crash.c      |  3 ++-
>  include/linux/kexec.h        |  2 +-
>  kernel/crash_core.c          | 14 +++++++-------
>  4 files changed, 11 insertions(+), 10 deletions(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index c9f6a6c5de3c..9bb6607e864e 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -208,7 +208,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
>  extern void kdump_nmi_shootdown_cpus(void);
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
> -void arch_crash_handle_hotplug_event(struct kimage *image);
> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
>  #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index b6b044356f1b..44744e9c68ec 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -428,10 +428,11 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>  /**
>   * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>   * @image: a pointer to kexec_crash_image
> + * @arg: struct memory_notify handler for memory hotplug case and NULL for CPU hotplug case.
>   *
>   * Prepare the new elfcorehdr and replace the existing elfcorehdr.
>   */
> -void arch_crash_handle_hotplug_event(struct kimage *image)
> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  {
>  	void *elfbuf = NULL, *old_elfcorehdr;
>  	unsigned long nr_mem_ranges;
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 400cb6c02176..802052d9c64b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -483,7 +483,7 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>  #endif
>  
>  #ifndef arch_crash_handle_hotplug_event
> -static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
> +static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>  #endif
>  
>  int crash_check_update_elfcorehdr(void);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d48315667752..ab1c8e79759d 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -914,7 +914,7 @@ int crash_check_update_elfcorehdr(void)
>   * list of segments it checks (since the elfcorehdr changes and thus
>   * would require an update to purgatory itself to update the digest).
>   */
> -static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>  {
>  	struct kimage *image;
>  
> @@ -976,7 +976,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>  	image->hp_action = hp_action;
>  
>  	/* Now invoke arch-specific update handler */
> -	arch_crash_handle_hotplug_event(image);
> +	arch_crash_handle_hotplug_event(image, arg);
>  
>  	/* No longer handling a hotplug event */
>  	image->hp_action = KEXEC_CRASH_HP_NONE;
> @@ -992,17 +992,17 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>  	crash_hotplug_unlock();
>  }
>  
> -static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *arg)
>  {
>  	switch (val) {
>  	case MEM_ONLINE:
>  		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
> -			KEXEC_CRASH_HP_INVALID_CPU);
> +			KEXEC_CRASH_HP_INVALID_CPU, arg);
>  		break;
>  
>  	case MEM_OFFLINE:
>  		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
> -			KEXEC_CRASH_HP_INVALID_CPU);
> +			KEXEC_CRASH_HP_INVALID_CPU, arg);
>  		break;
>  	}
>  	return NOTIFY_OK;
> @@ -1015,13 +1015,13 @@ static struct notifier_block crash_memhp_nb = {
>  
>  static int crash_cpuhp_online(unsigned int cpu)
>  {
> -	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu, NULL);
>  	return 0;
>  }
>  
>  static int crash_cpuhp_offline(unsigned int cpu)
>  {
> -	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu, NULL);
>  	return 0;
>  }
>  
> -- 
> 2.41.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
