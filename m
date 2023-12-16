Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5356C4332F
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 03:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nc5dtXO82TppyeVttpIq35W5xbY1AqDaxrGLoQ9RBBU=; b=gG7gx2kZCXufK6
	VmXC57cTQ+QjJjedJ7QiO7ap6DXu33ry3A6Vl1MaxWPLEjg504ryutXTXGHMcRzMWtiqhAknUt7yn
	Hh7Fi9XbMCcn4nAvKyA5A+DMh+rdkZkeDsfzypY8Ql6swhsoFDx0vSCaBY/2DwFtA4jJuy23IHwUg
	xI+2EIVwhBLXZzb1N3mKXtWKek9gihBEsVLrMEgJN4RK5M32PkMfrD989au7R42l8uHZc4aSzWNVp
	Ia4+jAYfLNSfftCZ09N7X3e4tSRdBbU0rHlfZ76d7qGgivwCO+ytlIFXzc3vtr0OqxN+4D+p1wtmC
	321krM14Jm62mtbLzpmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEL6B-005Doa-0S;
	Sat, 16 Dec 2023 03:12:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEL65-005Dnm-1Z
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 03:12:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702696324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jgBjk3xZUUlp8fedyMoM3i7Fer0zgmBfT7RMsCfLFXg=;
	b=eg9jGpDjiaJN68PBVzJsSSxR0wXb1cv6HBxmRC5rHDIAlNeCOP3pPUsbVVeSFWoM/KNOev
	xmfCrduiqgbPYq+MYWLgwM5xUsCzvEYyfLEG0VQJ7J4TFW1kzUE6IwI0TJxvt+V69SKfXg
	JXV8wIVCDPpSt0y0KPOAjo0CTgECiQA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-eUTe-m-8Mme1JA-7rLOXVQ-1; Fri, 15 Dec 2023 22:12:02 -0500
X-MC-Unique: eUTe-m-8Mme1JA-7rLOXVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF549832D1A;
	Sat, 16 Dec 2023 03:12:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2867851D5;
	Sat, 16 Dec 2023 03:12:00 +0000 (UTC)
Date: Sat, 16 Dec 2023 11:11:57 +0800
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
	Eric DeVolder <eric.devolder@oracle.com>,
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
Subject: Re: [PATCH v14 6/6] powerpc: add crash memory hotplug support
Message-ID: <ZX0VfVwgxvLSlXFD@MiWiFi-R3L-srv>
References: <20231211083056.340404-1-sourabhjain@linux.ibm.com>
 <20231211083056.340404-7-sourabhjain@linux.ibm.com>
 <ZXuqjAsRlKP152YG@MiWiFi-R3L-srv>
 <c8f5893a-0f15-47a2-b8ee-90cbb77c24d8@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <c8f5893a-0f15-47a2-b8ee-90cbb77c24d8@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_191213_593127_60E50F80 
X-CRM114-Status: GOOD (  47.89  )
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

On 12/15/23 at 11:29am, Sourabh Jain wrote:
......
> > > +static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *mn)
> > > +{
> > > +	int ret;
> > > +	struct crash_mem *cmem = NULL;
> > > +	struct kexec_segment *ksegment;
> > > +	void *ptr, *mem, *elfbuf = NULL;
> > > +	unsigned long elfsz, memsz, base_addr, size;
> > > +
> > > +	ksegment = &image->segment[image->elfcorehdr_index];
> > > +	mem = (void *) ksegment->mem;
> > > +	memsz = ksegment->memsz;
> > > +
> > > +	ret = get_crash_memory_ranges(&cmem);
> > > +	if (ret) {
> > > +		pr_err("Failed to get crash mem range\n");
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * The hot unplugged memory is part of crash memory ranges,
> > > +	 * remove it here.
> > > +	 */
> > > +	if (image->hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY) {
> > > +		base_addr = PFN_PHYS(mn->start_pfn);
> > > +		size = mn->nr_pages * PAGE_SIZE;
> > > +		ret = remove_mem_range(&cmem, base_addr, size);
> > Althouth this is ppc specific, I don't understand. Why don't you
> > recreate the elfcorehdr, but take removing the removed region. Comparing the
> > remove_mem_range() implementation with recreating, I don't see too much
> > benefit from that, and it makes your code more complicated. Just
> > curious, surely ppc people can decide what should be taken.
> 
> I am recreating `elfcorehdr` by calling `crash_prepare_elf64_headers()`
> below.
> 
> This complexity is necessary to avoid adding hot-removed memory to the
> new `elfcorehdr`.
> 
> On powerpc, the memblock list is utilized to prepare the `elfcorehdr`. In
> the
> case of memory hot removal, the memblock list is updated after the arch
> crash hotplug handler is triggered. Thus, the hot-removed memory is
> explicitly
> removed from the crash memory ranges to ensure that the memory ranges
> added to `elfcorehdr` do not include the hot-removed memory.

Ah, I see. Thanks for the explanation. Then please ignore this one.

> 
> 
> > 
> > > +		if (ret) {
> > > +			pr_err("Failed to remove hot-unplugged from crash memory ranges.\n");
> > > +			return;
> > > +		}
> > > +	}
> > > +
> > > +	ret = crash_prepare_elf64_headers(cmem, false, &elfbuf, &elfsz);
> > > +	if (ret) {
> > > +		pr_err("Failed to prepare elf header\n");
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * It is unlikely that kernel hit this because elfcorehdr kexec
> > > +	 * segment (memsz) is built with addition space to accommodate growing
> > > +	 * number of crash memory ranges while loading the kdump kernel. It is
> > > +	 * Just to avoid any unforeseen case.
> > > +	 */
> > > +	if (elfsz > memsz) {
> > > +		pr_err("Updated crash elfcorehdr elfsz %lu > memsz %lu", elfsz, memsz);
> > > +		goto out;
> > > +	}
> > > +
> > > +	ptr = __va(mem);
> > > +	if (ptr) {
> > > +		/* Temporarily invalidate the crash image while it is replaced */
> > > +		xchg(&kexec_crash_image, NULL);
> > > +
> > > +		/* Replace the old elfcorehdr with newly prepared elfcorehdr */
> > > +		memcpy((void *)ptr, elfbuf, elfsz);
> > > +
> > > +		/* The crash image is now valid once again */
> > > +		xchg(&kexec_crash_image, image);
> > > +	}
> > > +out:
> > > +	vfree(elfbuf);
> > > +}
> > > +
> > >   /**
> > >    * arch_crash_handle_hotplug_event - Handle crash CPU/Memory hotplug events to update the
> > >    *				     necessary kexec segments based on the hotplug event.
> > > @@ -572,7 +683,7 @@ int arch_crash_hotplug_cpu_support(struct kimage *image)
> > >    * CPU addition: Update the FDT segment to include the newly added CPU.
> > >    * CPU removal: No action is needed, with the assumption that it's okay to have offline CPUs
> > >    *		as part of the FDT.
> > > - * Memory addition/removal: No action is taken as this is not yet supported.
> > > + * Memory addition/removal: Recreate the elfcorehdr segment
> > >    */
> > >   void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
> > >   {
> > > @@ -593,7 +704,6 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
> > >   		return;
> > >   	} else if (hp_action == KEXEC_CRASH_HP_ADD_CPU) {
> > > -
> > >   		void *fdt, *ptr;
> > >   		unsigned long mem;
> > >   		int i, fdt_index = -1;
> > > @@ -628,8 +738,10 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
> > >   	} else if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY ||
> > >   		   hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
> > > -		pr_info_once("Crash update is not supported for memory hotplug\n");
> > > -		return;
> > > +		struct memory_notify *mn;
> > > +
> > > +		mn = (struct memory_notify *)arg;
> > > +		update_crash_elfcorehdr(image, mn);
> > >   	}
> > >   }
> > >   #endif
> > > diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> > > index e2148a009701..2457d7ec2075 100644
> > > --- a/arch/powerpc/kexec/file_load_64.c
> > > +++ b/arch/powerpc/kexec/file_load_64.c
> > > @@ -21,6 +21,8 @@
> > >   #include <linux/memblock.h>
> > >   #include <linux/slab.h>
> > >   #include <linux/vmalloc.h>
> > > +#include <linux/elf.h>
> > > +
> > >   #include <asm/setup.h>
> > >   #include <asm/cputhreads.h>
> > >   #include <asm/drmem.h>
> > > @@ -740,7 +742,35 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
> > >   	kbuf->buffer = headers;
> > >   	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
> > > -	kbuf->bufsz = kbuf->memsz = headers_sz;
> > > +	kbuf->bufsz = headers_sz;
> > > +#if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
> > > +	/* Adjust the elfcorehdr segment size to accommodate
> > > +	 * future crash memory ranges.
> > > +	 */
> > > +	int max_lmb;
> > > +	unsigned long pnum;
> > > +
> > > +	/* In the worst case, a Phdr is needed for every other LMB to be
> > > +	 * represented as an individual crash range.
> > > +	 */
> > > +	max_lmb = memory_hotplug_max() / (2 * drmem_lmb_size());
> > > +
> > > +	/* Do not cross the Phdr max limit of the elf header.
> > > +	 * Avoid counting Phdr for crash ranges (cmem->nr_ranges)
> > > +	 * which are already part of elfcorehdr.
> > > +	 */
> > > +	if (max_lmb > PN_XNUM)
> > > +		pnum = PN_XNUM - cmem->nr_ranges;
> > > +	else
> > > +		pnum = max_lmb - cmem->nr_ranges;
> > > +
> > > +	/* Additional buffer space for elfcorehdr to accommodate
> > > +	 * future memory ranges.
> > > +	 */
> > > +	kbuf->memsz = headers_sz + pnum * sizeof(Elf64_Phdr);
> > > +#else
> > > +	kbuf->memsz = headers_sz;
> > > +#endif
> > >   	kbuf->top_down = false;
> > >   	ret = kexec_add_buffer(kbuf);
> > > @@ -750,7 +780,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
> > >   	}
> > >   	image->elf_load_addr = kbuf->mem;
> > > -	image->elf_headers_sz = headers_sz;
> > > +	image->elf_headers_sz = kbuf->memsz;
> > >   	image->elf_headers = headers;
> > >   out:
> > >   	kfree(cmem);
> > > diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
> > > index fb3e12f15214..4fd0c5d5607b 100644
> > > --- a/arch/powerpc/kexec/ranges.c
> > > +++ b/arch/powerpc/kexec/ranges.c
> > > @@ -234,6 +234,91 @@ int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
> > >   	return __add_mem_range(mem_ranges, base, size);
> > >   }
> > > +/**
> > > + * remove_mem_range - Removes the given memory range from the range list.
> > > + * @mem_ranges:    Range list to remove the memory range to.
> > > + * @base:          Base address of the range to remove.
> > > + * @size:          Size of the memory range to remove.
> > > + *
> > > + * (Re)allocates memory, if needed.
> > > + *
> > > + * Returns 0 on success, negative errno on error.
> > > + */
> > > +int remove_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
> > > +{
> > > +	u64 end;
> > > +	int ret = 0;
> > > +	unsigned int i;
> > > +	u64 mstart, mend;
> > > +	struct crash_mem *mem_rngs = *mem_ranges;
> > > +
> > > +	if (!size)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * Memory range are stored as start and end address, use
> > > +	 * the same format to do remove operation.
> > > +	 */
> > > +	end = base + size - 1;
> > > +
> > > +	for (i = 0; i < mem_rngs->nr_ranges; i++) {
> > > +		mstart = mem_rngs->ranges[i].start;
> > > +		mend = mem_rngs->ranges[i].end;
> > > +
> > > +		/*
> > > +		 * Memory range to remove is not part of this range entry
> > > +		 * in the memory range list
> > > +		 */
> > > +		if (!(base >= mstart && end <= mend))
> > > +			continue;
> > > +
> > > +		/*
> > > +		 * Memory range to remove is equivalent to this entry in the
> > > +		 * memory range list. Remove the range entry from the list.
> > > +		 */
> > > +		if (base == mstart && end == mend) {
> > > +			for (; i < mem_rngs->nr_ranges - 1; i++) {
> > > +				mem_rngs->ranges[i].start = mem_rngs->ranges[i+1].start;
> > > +				mem_rngs->ranges[i].end = mem_rngs->ranges[i+1].end;
> > > +			}
> > > +			mem_rngs->nr_ranges--;
> > > +			goto out;
> > > +		}
> > > +		/*
> > > +		 * Start address of the memory range to remove and the
> > > +		 * current memory range entry in the list is same. Just
> > > +		 * move the start address of the current memory range
> > > +		 * entry in the list to end + 1.
> > > +		 */
> > > +		else if (base == mstart) {
> > > +			mem_rngs->ranges[i].start = end + 1;
> > > +			goto out;
> > > +		}
> > > +		/*
> > > +		 * End address of the memory range to remove and the
> > > +		 * current memory range entry in the list is same.
> > > +		 * Just move the end address of the current memory
> > > +		 * range entry in the list to base - 1.
> > > +		 */
> > > +		else if (end == mend)  {
> > > +			mem_rngs->ranges[i].end = base - 1;
> > > +			goto out;
> > > +		}
> > > +		/*
> > > +		 * Memory range to remove is not at the edge of current
> > > +		 * memory range entry. Split the current memory entry into
> > > +		 * two half.
> > > +		 */
> > > +		else {
> > > +			mem_rngs->ranges[i].end = base - 1;
> > > +			size = mem_rngs->ranges[i].end - end;
> > > +			ret = add_mem_range(mem_ranges, end + 1, size);
> > > +		}
> > > +	}
> > > +out:
> > > +	return ret;
> > > +}
> > > +
> > >   /**
> > >    * add_tce_mem_ranges - Adds tce-table range to the given memory ranges list.
> > >    * @mem_ranges:         Range list to add the memory range(s) to.
> > > -- 
> > > 2.41.0
> > > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
