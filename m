Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A22C9830C
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IW7QWn6JL0RwdL3zwoGz2swVZ83QFuVyY00wIq8n19Q=; b=pBk8dyUkCL9rVLp5XDIWqOvArz
	P6LpMwXSrlC6TOnSlPV3dJ4DdfsHQy8/9vgtobg/LHjQJtQwJsr7w3+l5DIMq17myIDCCI2GvVAsw
	AM53jPnbc+6R45qgdJdS5L/t5bnW6wAdit8AqdiCgWAtgJXOpa1t3D1XhrWKSTsKtanqueejOd15T
	sq3lUGbqpT+r1FoHJamHaBnl039nGfsVoimd0BOgS3qKSa8Ycp7fkcRYkpOpTHd8Hk3HFO40SXQWA
	zz0PGk2wpUBpn/tYvAB6NLrTxizeei/JyUAmXyY83iAunexpDFiDxCJisQM+LmT4mJFNO4v2Zce6Q
	1B3I4MUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDq8-000000045tp-2SGf;
	Tue, 20 Jan 2026 15:40:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDq5-000000045th-08Aq
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 15:40:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0CC7560010;
	Tue, 20 Jan 2026 15:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA06C16AAE;
	Tue, 20 Jan 2026 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768923615;
	bh=XFFzzyZSUruiv8f4AcuaPh9t+1U5dJ6/iPk2wc0hEsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Xakh/0A+63sAKspk3ekVV4qVSQqA4ZkFNTAe6ENLfgNFCrPITL6jO50SQ0pLdgr7F
	 iREgsqYGFnLylulaAbdlY1tMhiYhBVR/515TqsSkik7ZDxPuYbciM1xtY9iqS4A1NF
	 2YmaryZOlTR2HE9eZGtHhyrlp2nR4keSmLx58H8r25723+kvWZgXcObQFr7qGJwsP/
	 RxLxFdkSWANPFCf4199rujL609uHcH1+W4vut3R/FFvWSgBzIb8kAJB1PFMkmJyvHy
	 6dC0UYF2IqbvlmV4iC+YvoxpENKvOzX0nhDWx7Fc0KrhgeG+w7RQS8Vmkdepqu0kLp
	 WS4YJXYbUxMfw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] kho: history: track previous kernel version
In-Reply-To: <v7g7nmd3jif6vftvnmucvpluevufcdxmefcgqq3yfpnzyb7mql@ojpotuu4hgxm>
	(Breno Leitao's message of "Fri, 16 Jan 2026 07:50:29 -0800")
References: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
	<20260108-kho-v3-1-b1d6b7a89342@debian.org> <2vxzy0m0gfyo.fsf@kernel.org>
	<v7g7nmd3jif6vftvnmucvpluevufcdxmefcgqq3yfpnzyb7mql@ojpotuu4hgxm>
Date: Tue, 20 Jan 2026 15:40:12 +0000
Message-ID: <2vxzms28e1ib.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Jan 16 2026, Breno Leitao wrote:

> Hello Pratyush,
>
> On Wed, Jan 14, 2026 at 07:19:11PM +0000, Pratyush Yadav wrote:
>> On Thu, Jan 08 2026, Breno Leitao wrote:
>> 
>> > Store and display the kernel version from the previous kexec boot.
>> >
>> > The current kernel's release string is saved to the "previous-release"
>> > property in the KHO FDT before kexec. On the next boot, if this property
>> > exists, the previous kernel version is retrieved and printed during
>> > early boot.
>> >
>> > This helps diagnose bugs that only manifest when kexecing from specific
>> > kernel versions, making it easier to correlate crashes with the kernel
>> > that initiated the kexec.
>> 
>> The KHO FDT is ABI. So you should be bumping the version number when you
>> make changes to it.
>> 
>> But honestly, adding this "optional" stuff to the core KHO ABI makes me
>> uneasy. I say optional since it is not needed for the main functionality
>> of KHO. Making this a part of the ABI increases the surface area we
>> have. The more things we stuff in the ABI, the more inflexible it gets
>> over time.
>> 
>> Any changes to the KHO ABI means all consumers also need a version bump.
>> This includes LUO and all its users for example. So I would really like
>> to avoid adding optional things in core KHO FDT.
>> 
>> The easy fix is to add a separate subtree for the optional metadata. You
>> would still need to create an ABI for the data format, but being
>> independent of core KHO, it will make it more flexible and easier to
>> change in the future. You can keep the code in kexec_handover.c.
>
> Thanks for the feedback and guidance!
>
> I was able to hack this a bit and I came up with something like the
> follow. Is this what you have in mind?

Thanks! Yes, this looks much better. Some comments below.

>
> Author: Breno Leitao <leitao@debian.org>
> Date:   Fri Jan 16 06:42:56 2026 -0800
>
>     kho: history: track previous kernel version and kexec count
>     
>     Use Kexec Handover (KHO) to pass the previous kernel's version string
>     and the number of kexec reboots since the last cold boot to the next
>     kernel, and print it at boot time.
>     
>     Example output:
>         [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107 (count 1)
>     
>     Motivation
>     ==========
>     
>     Bugs that only reproduce when kexecing from specific kernel versions
>     are difficult to diagnose. These issues occur when a buggy kernel
>     kexecs into a new kernel, with the bug manifesting only in the second
>     kernel.
>     
>     Recent examples include:
>     
>      * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
>      * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
>      * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")
>     
>     As kexec-based reboots become more common, these version-dependent bugs
>     are appearing more frequently. At scale, correlating crashes to the
>     previous kernel version is challenging, especially when issues only
>     occur in specific transition scenarios.
>     
>     Implementation
>     ==============
>     
>     The history metadata is stored in a separate FDT subtree registered via
>     kho_add_subtree(), rather than being embedded directly in the root KHO
>     FDT. This design choice:
>     
>      - Keeps the core KHO ABI minimal and stable
>      - Allows the history format to evolve independently
>      - Avoids requiring version bumps for all KHO consumers (LUO, etc.)
>        when the history format changes
>     
>     The history subtree uses its own compatible string "kho-history-v1" and
>     contains two properties:
>      - previous-release: The kernel version that initiated the kexec
>      - kexec-count: Number of kexec boots since last cold boot
>     
>     On cold boot, kexec-count starts at 0 and increments with each kexec.
>     The count helps identify issues that only manifest after multiple
>     consecutive kexec reboots.

Very well written changelog!

>     
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index 285eda8a36e4..da19d6029815 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -84,6 +84,29 @@
>  /* The FDT property for sub-FDTs. */
>  #define KHO_FDT_SUB_TREE_PROP_NAME "fdt"
>  
> +/*
> + * The "history" subtree stores optional metadata about the kexec chain.
> + * It is registered as a separate FDT via kho_add_subtree(), keeping it
> + * independent from the core KHO ABI. This allows the history format to
> + * evolve without affecting other KHO consumers.
> + *
> + * The history FDT structure:

I don't have a strong preference here, but you don't _have_ to use FDT.
For example, with memfd, we moved from FDT to plain C structs during the
evolution of the patchset. Main reason is that FDT programming is a bit
annoying. C structs make many things much easier. For example, you can
always assume a certain property always exists and is of a given size,
and you don't have to validate every single property you read.

Anyway, I don't mind either way.

> + *
> + *   / {
> + *       compatible = "kho-history-v1";
> + *       previous-release = "6.x.y-...";
> + *       kexec-count = <N>;
> + *   };
> + */
> +#define KHO_HISTORY_NODE_NAME "history"

Do we want to call it history? Perhaps "kexec-metadata" instead? So we
could use it for other misc information if needed later.

Mike/Pasha, any thoughts?

> +#define KHO_HISTORY_COMPATIBLE "kho-history-v1"
> +
> +/* The FDT property to track previous kernel (kexec caller) */
> +#define KHO_PROP_PREVIOUS_RELEASE "previous-release"
> +
> +/* The FDT property to track number of kexec counts so far */
> +#define KHO_PROP_KEXEC_COUNT "kexec-count"
> +
>  /**
>   * DOC: Kexec Handover ABI for vmalloc Preservation
>   *
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 3cf2dc6840c9..fd22b0947587 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -15,6 +15,7 @@
>  #include <linux/count_zeros.h>
>  #include <linux/kexec.h>
>  #include <linux/kexec_handover.h>
> +#include <linux/utsname.h>
>  #include <linux/kho/abi/kexec_handover.h>
>  #include <linux/libfdt.h>
>  #include <linux/list.h>
> @@ -1246,6 +1247,8 @@ struct kho_in {
>  	phys_addr_t fdt_phys;
>  	phys_addr_t scratch_phys;
>  	phys_addr_t mem_map_phys;
> +	char previous_release[__NEW_UTS_LEN + 1];
> +	u32 kexec_count;
>  	struct kho_debugfs dbg;
>  };
>  
> @@ -1331,6 +1334,48 @@ static __init int kho_out_fdt_setup(void)
>  	return err;
>  }
>  
> +/*
> + * Create a separate FDT subtree for optional history metadata.
> + * This keeps the core KHO ABI minimal and allows the history format
> + * to evolve independently.
> + */
> +static __init int kho_history_init(void)
> +{
> +	u32 kexec_count;
> +	void *fdt;
> +	int err;
> +
> +	fdt = kho_alloc_preserve(PAGE_SIZE);
> +	if (IS_ERR(fdt))
> +		return PTR_ERR(fdt);
> +
> +	err = fdt_create(fdt, PAGE_SIZE);
> +	err |= fdt_finish_reservemap(fdt);
> +	err |= fdt_begin_node(fdt, "");
> +	err |= fdt_property_string(fdt, "compatible", KHO_HISTORY_COMPATIBLE);
> +	err |= fdt_property_string(fdt, KHO_PROP_PREVIOUS_RELEASE,
> +				   init_uts_ns.name.release);
> +	/* kho_in.kexec_count is set to 0 on cold boot */
> +	kexec_count = kho_in.kexec_count + 1;
> +	err |= fdt_property(fdt, KHO_PROP_KEXEC_COUNT, &kexec_count,
> +			    sizeof(kexec_count));
> +	err |= fdt_end_node(fdt);
> +	err |= fdt_finish(fdt);
> +
> +	if (err) {
> +		kho_unpreserve_free(fdt);
> +		return err;
> +	}
> +
> +	err = kho_add_subtree(KHO_HISTORY_NODE_NAME, fdt);
> +	if (err) {
> +		kho_unpreserve_free(fdt);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static __init int kho_init(void)
>  {
>  	const void *fdt = kho_get_fdt();
> @@ -1357,6 +1402,10 @@ static __init int kho_init(void)
>  	if (err)
>  		goto err_free_fdt;
>  
> +	err = kho_history_init();
> +	if (err)
> +		pr_warn("failed to initialize history subtree: %d\n", err);
> +
>  	if (fdt) {
>  		kho_in_debugfs_init(&kho_in.dbg, fdt);
>  		return 0;
> @@ -1425,6 +1474,61 @@ static void __init kho_release_scratch(void)
>  	}
>  }
>  
> +static int __init kho_print_previous_kernel(const void *fdt)
> +{
> +	const char *prev_release;
> +	const u64 *history_phys;
> +	const u32 *count_ptr;
> +	void *history_fdt;
> +	int history_node;
> +	int len;
> +	int ret;
> +
> +	/* Find the history subtree reference in root FDT */
> +	history_node = fdt_subnode_offset(fdt, 0, KHO_HISTORY_NODE_NAME);
> +	if (history_node < 0)
> +		/* This is fine, previous kernel didn't export history */
> +		return -ENOENT;
> +
> +	/* Get the physical address of the history FDT */
> +	history_phys = fdt_getprop(fdt, history_node, KHO_FDT_SUB_TREE_PROP_NAME, &len);
> +	if (!history_phys || len != sizeof(*history_phys))
> +		return -ENOENT;
> +
> +	/* Map the history FDT */
> +	history_fdt = early_memremap(*history_phys, PAGE_SIZE);
> +	if (!history_fdt)
> +		return -ENOMEM;

There is no real reason to call this so early in boot. You can call it
from an initcall or from kho_init(). Then you won't need the
early_memremap(). And you should also not poke into the KHO FDT
directly. Use kho_retrieve_subtree() instead.

> +
> +	prev_release = fdt_getprop(history_fdt, 0, KHO_PROP_PREVIOUS_RELEASE, &len);
> +	if (!prev_release || len <= 0) {
> +		ret = -ENOENT;
> +		goto exit;
> +	}
> +
> +	/* Read the kexec count from the previous kernel */
> +	count_ptr = fdt_getprop(history_fdt, 0, KHO_PROP_KEXEC_COUNT, &len);
> +	if (WARN_ON(!count_ptr || len != sizeof(u32))) {
> +		ret = -ENOENT;
> +		goto exit;
> +	}
> +	/*
> +	 * This populate the kernel structure that will be persisted during
> +	 * kernel life time, and the fdt will be unmapped
> +	 */
> +	kho_in.kexec_count = *count_ptr;

This is another annoying thing about FDT. Alignment is only guaranteed
at 32 bits. So you should use get_unaligned() AFAIK.

> +
> +	strscpy(kho_in.previous_release, prev_release,
> +		sizeof(kho_in.previous_release));
> +	pr_info("exec from: %s (count %u)\n", kho_in.previous_release,
> +					      kho_in.kexec_count);
> +
> +	ret = 0;
> +exit:
> +	early_memunmap(history_fdt, PAGE_SIZE);
> +	return ret;
> +}
> +
>  void __init kho_memory_init(void)
>  {
>  	if (kho_in.mem_map_phys) {
> @@ -1513,7 +1617,10 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	kho_in.scratch_phys = scratch_phys;
>  	kho_in.mem_map_phys = mem_map_phys;
>  	kho_scratch_cnt = scratch_cnt;
> -	pr_info("found kexec handover data.\n");
> +
> +	if (kho_print_previous_kernel(fdt))
> +		/* Fallback message when previous kernel info unavailable */
> +		pr_info("found kexec handover data.\n");
>  
>  out:
>  	if (fdt)

-- 
Regards,
Pratyush Yadav

