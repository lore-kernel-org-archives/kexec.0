Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvtXW-0003rC-O2
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 02:22:27 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466098739.24747.5860501703617893464.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 10/12] ppc64/kexec_file: prepare elfcore header for
 crashing kernel
In-reply-to: <159466098739.24747.5860501703617893464.stgit@hbathini.in.ibm.com>
Date: Wed, 15 Jul 2020 23:22:08 -0300
Message-ID: <87tuy88ai7.fsf@morokweng.localdomain>
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

>  /**
> + * get_crash_memory_ranges - Get crash memory ranges. This list includes
> + *                           first/crashing kernel's memory regions that
> + *                           would be exported via an elfcore.
> + * @mem_ranges:              Range list to add the memory ranges to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int get_crash_memory_ranges(struct crash_mem **mem_ranges)
> +{
> +	struct memblock_region *reg;
> +	struct crash_mem *tmem;
> +	int ret;
> +
> +	for_each_memblock(memory, reg) {
> +		u64 base, size;
> +
> +		base = (u64)reg->base;
> +		size = (u64)reg->size;
> +
> +		/* Skip backup memory region, which needs a separate entry */
> +		if (base == BACKUP_SRC_START) {
> +			if (size > BACKUP_SRC_SIZE) {
> +				base = BACKUP_SRC_END + 1;
> +				size -= BACKUP_SRC_SIZE;
> +			} else
> +				continue;
> +		}
> +
> +		ret = add_mem_range(mem_ranges, base, size);
> +		if (ret)
> +			goto out;
> +
> +		/* Try merging adjacent ranges before reallocation attempt */
> +		if ((*mem_ranges)->nr_ranges == (*mem_ranges)->max_nr_ranges)
> +			sort_memory_ranges(*mem_ranges, true);
> +	}
> +
> +	/* Reallocate memory ranges if there is no space to split ranges */
> +	tmem = *mem_ranges;
> +	if (tmem && (tmem->nr_ranges == tmem->max_nr_ranges)) {
> +		tmem = realloc_mem_ranges(mem_ranges);
> +		if (!tmem)
> +			goto out;
> +	}
> +
> +	/* Exclude crashkernel region */
> +	ret = crash_exclude_mem_range(tmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_rtas_mem_range(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_opal_mem_range(mem_ranges);
> +	if (ret)
> +		goto out;

Maybe I'm confused, but don't you add the RTAS and OPAL regions as
usable memory for the crashkernel? In that case they shouldn't show up
in the core file.

> +
> +	/* create a separate program header for the backup region */
> +	ret = add_mem_range(mem_ranges, BACKUP_SRC_START, BACKUP_SRC_SIZE);
> +	if (ret)
> +		goto out;
> +
> +	sort_memory_ranges(*mem_ranges, false);
> +out:
> +	if (ret)
> +		pr_err("Failed to setup crash memory ranges\n");
> +	return ret;
> +}

<snip>

> +/**
> + * prepare_elf_headers - Prepare headers for the elfcore to be exported as
> + *                       /proc/vmcore by the kdump kernel.
> + * @image:               Kexec image.
> + * @cmem:                Crash memory ranges to be exported via elfcore.
> + * @addr:                Vmalloc'd memory allocated by crash_prepare_elf64_headers
> + *                       to prepare the elf headers.
> + * @sz:                  Size of the vmalloc'd memory allocated.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int prepare_elf_headers(struct kimage *image, struct crash_mem *cmem,
> +			       void **addr, unsigned long *sz)
> +{
> +	int ret;
> +
> +	ret = crash_prepare_elf64_headers(cmem, false, addr, sz);
> +
> +	/* Fix the offset for backup region in the ELF header */
> +	if (!ret)
> +		update_backup_region_phdr(image, *addr);
> +
> +	return ret;
> +}

The code above can be inlined into its caller, I don't see a need to
have a separate function.

> +
> +/**
> + * load_elfcorehdr_segment - Setup crash memory ranges and initialize elfcorehdr
> + *                           segment needed to load kdump kernel.
> + * @image:                   Kexec image.
> + * @kbuf:                    Buffer contents and memory parameters.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
> +{
> +	struct crash_mem *cmem = NULL;
> +	unsigned long headers_sz;
> +	void *headers = NULL;
> +	int ret;
> +
> +	ret = get_crash_memory_ranges(&cmem);
> +	if (ret)
> +		goto out;
> +
> +	/* Setup elfcorehdr segment */
> +	ret = prepare_elf_headers(image, cmem, &headers, &headers_sz);
> +	if (ret) {
> +		pr_err("Failed to prepare elf headers for the core\n");
> +		goto out;
> +	}
> +
> +	kbuf->buffer = headers;
> +	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
> +	kbuf->bufsz = kbuf->memsz = headers_sz;
> +	kbuf->top_down = false;
> +
> +	ret = kexec_add_buffer(kbuf);
> +	if (ret) {
> +		vfree(headers);
> +		goto out;
> +	}
> +
> +	image->arch.elfcorehdr_addr = kbuf->mem;
> +	image->arch.elf_headers_sz = headers_sz;
> +	image->arch.elf_headers = headers;
> +out:
> +	kfree(cmem);
> +	return ret;
> +}

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
