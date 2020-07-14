Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUgF-0008D2-NA
 for kexec@lists.infradead.org; Tue, 14 Jul 2020 23:49:49 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466087136.24747.16494497863685481495.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 03/12] powerpc/kexec_file: add helper functions for
 getting memory ranges
In-reply-to: <159466087136.24747.16494497863685481495.stgit@hbathini.in.ibm.com>
Date: Tue, 14 Jul 2020 20:49:31 -0300
Message-ID: <874kq98xo4.fsf@morokweng.localdomain>
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


Hello Hari,

Hari Bathini <hbathini@linux.ibm.com> writes:

> In kexec case, the kernel to be loaded uses the same memory layout as
> the running kernel. So, passing on the DT of the running kernel would
> be good enough.
>
> But in case of kdump, different memory ranges are needed to manage
> loading the kdump kernel, booting into it and exporting the elfcore
> of the crashing kernel. The ranges are exlude memory ranges, usable

s/exlude/exclude/

> memory ranges, reserved memory ranges and crash memory ranges.
>
> Exclude memory ranges specify the list of memory ranges to avoid while
> loading kdump segments. Usable memory ranges list the memory ranges
> that could be used for booting kdump kernel. Reserved memory ranges
> list the memory regions for the loading kernel's reserve map. Crash
> memory ranges list the memory ranges to be exported as the crashing
> kernel's elfcore.
>
> Add helper functions for setting up the above mentioned memory ranges.
> This helpers facilitate in understanding the subsequent changes better
> and make it easy to setup the different memory ranges listed above, as
> and when appropriate.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>

<snip>

> +/**
> + * get_mem_rngs_size - Get the allocated size of mrngs based on
> + *                     max_nr_ranges and chunk size.
> + * @mrngs:             Memory ranges.
> + *
> + * Returns the maximum no. of ranges.

This isn't correct. It returns the maximum size of @mrngs.

> + */
> +static inline size_t get_mem_rngs_size(struct crash_mem *mrngs)
> +{
> +	size_t size;
> +
> +	if (!mrngs)
> +		return 0;
> +
> +	size = (sizeof(struct crash_mem) +
> +		(mrngs->max_nr_ranges * sizeof(struct crash_mem_range)));
> +
> +	/*
> +	 * Memory is allocated in size multiple of MEM_RANGE_CHUNK_SZ.
> +	 * So, align to get the actual length.
> +	 */
> +	return ALIGN(size, MEM_RANGE_CHUNK_SZ);
> +}

<snip>

> +/**
> + * add_tce_mem_ranges - Adds tce-table range to the given memory ranges list.
> + * @mem_ranges:         Range list to add the memory range(s) to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_tce_mem_ranges(struct crash_mem **mem_ranges)
> +{
> +	struct device_node *dn;
> +	int ret;
> +
> +	for_each_node_by_type(dn, "pci") {
> +		u64 base;
> +		u32 size;
> +
> +		ret = of_property_read_u64(dn, "linux,tce-base", &base);
> +		ret |= of_property_read_u32(dn, "linux,tce-size", &size);
> +		if (!ret)

Shouldn't the condition be `ret` instead of `!ret`?

> +			continue;
> +
> +		ret = add_mem_range(mem_ranges, base, size);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * add_initrd_mem_range - Adds initrd range to the given memory ranges list,
> + *                        if the initrd was retained.
> + * @mem_ranges:           Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_initrd_mem_range(struct crash_mem **mem_ranges)
> +{
> +	u64 base, end;
> +	int ret = 0;
> +	char *str;
> +
> +	/* This range means something only if initrd was retained */
> +	str = strstr(saved_command_line, "retain_initrd");
> +	if (!str)
> +		return 0;
> +
> +	ret = of_property_read_u64(of_chosen, "linux,initrd-start", &base);
> +	ret |= of_property_read_u64(of_chosen, "linux,initrd-end", &end);
> +	if (!ret)
> +		ret = add_mem_range(mem_ranges, base, end - base + 1);
> +	return ret;
> +}
> +
> +/**
> + * add_htab_mem_range - Adds htab range to the given memory ranges list,
> + *                      if it exists
> + * @mem_ranges:         Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_htab_mem_range(struct crash_mem **mem_ranges)
> +{
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	int ret;
> +
> +	if (!htab_address)
> +		return 0;
> +
> +	ret = add_mem_range(mem_ranges, __pa(htab_address), htab_size_bytes);
> +	return ret;
> +#else
> +	return 0;
> +#endif
> +}

If I'm not mistaken, this is not the preferred way of having alternative
implementations of a function. The "Conditional Compilation" section of
the coding style document doesn't mention this directly, but does say
that it's better to put the conditionals in a header file.

In this case, I would do this in <asm/kexec_ranges.h>

#ifdef CONFIG_PPC_BOOK3S_64
int add_htab_mem_range(struct crash_mem **mem_ranges);
#else
static inline int add_htab_mem_range(struct crash_mem **mem_ranges)
{
	return 0;
}
#endif

And in ranges.c just surround the add_htab_mem_range() definition with
#ifdef CONFIG_PPC_BOOK3S_64 and #endif

Also, there's no need for the ret variable. You can just
`return add_mem_range(...)` directly.

> +
> +/**
> + * add_kernel_mem_range - Adds kernel text region to the given
> + *                        memory ranges list.
> + * @mem_ranges:           Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_kernel_mem_range(struct crash_mem **mem_ranges)
> +{
> +	int ret;
> +
> +	ret = add_mem_range(mem_ranges, 0, __pa(_end));
> +	return ret;
> +}

No need for the ret variable here, just `return add_mem_range()`
directly.

> +
> +/**
> + * add_rtas_mem_range - Adds RTAS region to the given memory ranges list.
> + * @mem_ranges:         Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_rtas_mem_range(struct crash_mem **mem_ranges)
> +{
> +	struct device_node *dn;
> +	int ret = 0;
> +
> +	dn = of_find_node_by_path("/rtas");
> +	if (dn) {
> +		u32 base, size;
> +
> +		ret = of_property_read_u32(dn, "linux,rtas-base", &base);
> +		ret |= of_property_read_u32(dn, "rtas-size", &size);
> +		if (ret)
> +			return ret;
> +
> +		ret = add_mem_range(mem_ranges, base, size);

You're missing an of_node_put(dn) here (also in the early return in the
line above).

> +	}
> +	return ret;
> +}
> +
> +/**
> + * add_opal_mem_range - Adds OPAL region to the given memory ranges list.
> + * @mem_ranges:         Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_opal_mem_range(struct crash_mem **mem_ranges)
> +{
> +	struct device_node *dn;
> +	int ret = 0;
> +
> +	dn = of_find_node_by_path("/ibm,opal");
> +	if (dn) {
> +		u64 base, size;
> +
> +		ret = of_property_read_u64(dn, "opal-base-address", &base);
> +		ret |= of_property_read_u64(dn, "opal-runtime-size", &size);
> +		if (ret)
> +			return ret;
> +
> +		ret = add_mem_range(mem_ranges, base, size);

You're missing an of_node_put(dn) here (also in the early return in the
line above).

> +	}
> +	return ret;
> +}
> +
> +/**
> + * add_reserved_ranges - Adds "/reserved-ranges" regions exported by f/w
> + *                       to the given memory ranges list.
> + * @mem_ranges:          Range list to add the memory ranges to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_reserved_ranges(struct crash_mem **mem_ranges)
> +{
> +	int i, len, ret = 0;
> +	const __be32 *prop;
> +
> +	prop = of_get_property(of_root, "reserved-ranges", &len);
> +	if (!prop)
> +		return 0;
> +
> +	/*
> +	 * Each reserved range is an (address,size) pair, 2 cells each,
> +	 * totalling 4 cells per range.

Can you assume that, or do you need to check the #address-cells and
#size-cells properties of the root node?

> +	 */
> +	for (i = 0; i < len / (sizeof(*prop) * 4); i++) {
> +		u64 base, size;
> +
> +		base = of_read_number(prop + (i * 4) + 0, 2);
> +		size = of_read_number(prop + (i * 4) + 2, 2);
> +
> +		ret = add_mem_range(mem_ranges, base, size);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * sort_memory_ranges - Sorts the given memory ranges list.
> + * @mem_ranges:         Range list to sort.
> + * @merge:              If true, merge the list after sorting.
> + *
> + * Returns nothing.
> + */
> +void sort_memory_ranges(struct crash_mem *mrngs, bool merge)
> +{
> +	struct crash_mem_range *rngs;
> +	struct crash_mem_range rng;
> +	int i, j, idx;
> +
> +	if (!mrngs)
> +		return;
> +
> +	/* Sort the ranges in-place */
> +	rngs = &mrngs->ranges[0];
> +	for (i = 0; i < mrngs->nr_ranges; i++) {
> +		idx = i;
> +		for (j = (i + 1); j < mrngs->nr_ranges; j++) {
> +			if (rngs[idx].start > rngs[j].start)
> +				idx = j;
> +		}
> +		if (idx != i) {
> +			rng = rngs[idx];
> +			rngs[idx] = rngs[i];
> +			rngs[i] = rng;
> +		}
> +	}

Would it work using sort() from lib/sort.c here?

> +
> +	if (merge)
> +		__merge_memory_ranges(mrngs);
> +}


--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
