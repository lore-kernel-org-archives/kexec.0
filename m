Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvqGM-0004iM-BY
 for kexec@lists.infradead.org; Wed, 15 Jul 2020 22:52:31 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466091925.24747.6840028682768745598.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 06/12] ppc64/kexec_file: restrict memory usage of kdump
 kernel
In-reply-to: <159466091925.24747.6840028682768745598.stgit@hbathini.in.ibm.com>
Date: Wed, 15 Jul 2020 19:52:12 -0300
Message-ID: <87365s9ysj.fsf@morokweng.localdomain>
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
> + * get_usable_memory_ranges - Get usable memory ranges. This list includes
> + *                            regions like crashkernel, opal/rtas & tce-table,
> + *                            that kdump kernel could use.
> + * @mem_ranges:               Range list to add the memory ranges to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int get_usable_memory_ranges(struct crash_mem **mem_ranges)
> +{
> +	int ret;
> +
> +	/* First memory block & crashkernel region */
> +	ret = add_mem_range(mem_ranges, 0, crashk_res.end + 1);

This is a bit surprising. I guess I don't have a complete big picture of
the patch series yet. What prevents the crashkernel from using memory at
the [0, _end] range and overwriting the crashed kernel's memory?

Shouldn't the above range start at crashk_res.start?

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
> +
> +	ret = add_tce_mem_ranges(mem_ranges);
> +out:
> +	if (ret)
> +		pr_err("Failed to setup usable memory ranges\n");
> +	return ret;
> +}
> +
> +/**
>   * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
>   *                              in the memory regions between buf_min & buf_max
>   *                              for the buffer. If found, sets kbuf->mem.
> @@ -261,6 +305,322 @@ static int locate_mem_hole_bottom_up_ppc64(struct kexec_buf *kbuf,
>  }
>
>  /**
> + * check_realloc_usable_mem - Reallocate buffer if it can't accommodate entries
> + * @um_info:                  Usable memory buffer and ranges info.
> + * @cnt:                      No. of entries to accommodate.
> + *
> + * Returns 0 on success, negative errno on error.

It actually returns the buffer on success, and NULL on error.

> + */
> +static uint64_t *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
> +{
> +	void *tbuf;
> +
> +	if (um_info->size >=
> +	    ((um_info->idx + cnt) * sizeof(*(um_info->buf))))
> +		return um_info->buf;
> +
> +	um_info->size += MEM_RANGE_CHUNK_SZ;
> +	tbuf = krealloc(um_info->buf, um_info->size, GFP_KERNEL);
> +	if (!tbuf) {
> +		um_info->size -= MEM_RANGE_CHUNK_SZ;
> +		return NULL;
> +	}
> +
> +	memset(tbuf + um_info->idx, 0, MEM_RANGE_CHUNK_SZ);
> +	return tbuf;
> +}

<snip>

> +/**
> + * get_node_path - Get the full path of the given node.
> + * @dn:            Node.
> + * @path:          Updated with the full path of the node.
> + *
> + * Returns nothing.
> + */
> +static void get_node_path(struct device_node *dn, char *path)
> +{
> +	if (!dn)
> +		return;
> +
> +	get_node_path(dn->parent, path);

Is it ok to do recursion in the kernel? In this case I believe it's not
problematic since the maximum call depth will be the maximum depth of a
device tree node which shouldn't be too much. Also, there are no local
variables in this function. But I thought it was worth mentioning.

> +	sprintf(path, "/%s", dn->full_name);
> +}
> +
> +/**
> + * get_node_pathlen - Get the full path length of the given node.
> + * @dn:               Node.
> + *
> + * Returns the length of the full path of the node.
> + */
> +static int get_node_pathlen(struct device_node *dn)
> +{
> +	int len = 0;
> +
> +	while (dn) {
> +		len += strlen(dn->full_name) + 1;
> +		dn = dn->parent;
> +	}
> +	len++;
> +
> +	return len;
> +}
> +
> +/**
> + * add_usable_mem_property - Add usable memory property for the given
> + *                           memory node.
> + * @fdt:                     Flattened device tree for the kdump kernel.
> + * @dn:                      Memory node.
> + * @um_info:                 Usable memory buffer and ranges info.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int add_usable_mem_property(void *fdt, struct device_node *dn,
> +				   struct umem_info *um_info)
> +{
> +	int n_mem_addr_cells, n_mem_size_cells, node;
> +	int i, len, ranges, cnt, ret;
> +	uint64_t base, end, *buf;
> +	const __be32 *prop;
> +	char *pathname;
> +
> +	/* Allocate memory for node path */
> +	pathname = kzalloc(ALIGN(get_node_pathlen(dn), 8), GFP_KERNEL);
> +	if (!pathname)
> +		return -ENOMEM;
> +
> +	/* Get the full path of the memory node */
> +	get_node_path(dn, pathname);
> +	pr_debug("Memory node path: %s\n", pathname);
> +
> +	/* Now that we know the path, find its offset in kdump kernel's fdt */
> +	node = fdt_path_offset(fdt, pathname);
> +	if (node < 0) {
> +		pr_err("Malformed device tree: error reading %s\n",
> +		       pathname);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Get the address & size cells */
> +	n_mem_addr_cells = of_n_addr_cells(dn);
> +	n_mem_size_cells = of_n_size_cells(dn);
> +	pr_debug("address cells: %d, size cells: %d\n", n_mem_addr_cells,
> +		 n_mem_size_cells);
> +
> +	um_info->idx  = 0;
> +	buf = check_realloc_usable_mem(um_info, 2);
> +	if (!buf) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	um_info->buf = buf;
> +
> +	prop = of_get_property(dn, "reg", &len);
> +	if (!prop || len <= 0) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	/*
> +	 * "reg" property represents sequence of (addr,size) duples

s/duples/tuples/ ?

> +	 * each representing a memory range.
> +	 */
> +	ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
> +
> +	for (i = 0; i < ranges; i++) {
> +		base = of_read_number(prop, n_mem_addr_cells);
> +		prop += n_mem_addr_cells;
> +		end = base + of_read_number(prop, n_mem_size_cells) - 1;

You need to `prop += n_mem_size_cells` here.

> +
> +		ret = add_usable_mem(um_info, base, end, &cnt);
> +		if (ret) {
> +			ret = ret;
> +			goto out;
> +		}
> +	}
> +
> +	/*
> +	 * No kdump kernel usable memory found in this memory node.
> +	 * Write (0,0) duple in linux,usable-memory property for

s/duple/tuple/ ?

> +	 * this region to be ignored.
> +	 */
> +	if (um_info->idx == 0) {
> +		um_info->buf[0] = 0;
> +		um_info->buf[1] = 0;
> +		um_info->idx = 2;
> +	}
> +
> +	ret = fdt_setprop(fdt, node, "linux,usable-memory", um_info->buf,
> +			  (um_info->idx * sizeof(*(um_info->buf))));
> +
> +out:
> +	kfree(pathname);
> +	return ret;
> +}

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
