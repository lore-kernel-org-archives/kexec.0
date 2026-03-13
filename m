Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD13105F782
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 09:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t6/pkRkl23fjQY+qMNoaMSLlSZdDHQPz1zBNUh/l5QA=; b=ZRcQuqTGRsf3Oh2WgRDpIS62fm
	HsxE98KBKSAExQrNobZQCua9OTJT47SaoP46tM/b5dA9ayyA8aebUDetlk35eNvaajnxKk/6mD8Nt
	DSaCmn0ZTg8acjN19BO7DmREUqgQH35h/I6QJxs4dOd9jw2laKX70Tq+dRqzn9bSAU3SZqf39XMfE
	Wp92wYINKDbKLiEu3hDC6i7klI6cEmrm4ZM1/m+48ODfZ+n4zHgfgCwuRryLR2BnlgWf8IU2kF47N
	JAyznvkRjS1aT6Us147uqNetFPZpydlFzPS7ENVEuUQxvVzSPGgf2w/x9XL/dGH3NzT13fjrZh6hH
	+4cyjE7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ytV-0000000HOrK-3SRM;
	Fri, 13 Mar 2026 09:33:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ytU-0000000HOqg-14KK
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 09:33:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BADA42A30;
	Fri, 13 Mar 2026 09:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD42FC19421;
	Fri, 13 Mar 2026 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773394399;
	bh=02CGLe3Iuw7tQ2MF0lGQAkby+oCpClPybOzJjiCjfSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YpMae/MK0rYwx0zZwabFC4echKf0Z9M5PMBQ4avwLOVVmNKhTDUVh9FX1mnhz33oK
	 OlY7yEfsMqG7odRfEGphFjwQOHWe+fLOaZyY8SZeHafvImrJA+l8ZZF7kGGqUK8pM+
	 wBL6GPYaonjvYqKIeqT0+24T3UyOLyuMKCqEzoINyvn7uDK67sDdvDyRhaA2ebz+uK
	 gtKa3o2ngKx41pL2F6qLdTcSX0kO2p0LWNOhtfYGveZKaSn1fWmzi6bZAUn72/J2Re
	 v1rRqdS5v3eC263HVobnt5GcIRtEXaEBuNjrWhnEdIcklwVatAOH0Fn+z8vHfkOojm
	 kWfREm20kXxeg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v8 5/6] kho: kexec-metadata: track previous kernel chain
In-Reply-To: <20260309-kho-v8-5-c3abcf4ac750@debian.org> (Breno Leitao's
	message of "Mon, 09 Mar 2026 06:41:48 -0700")
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
	<20260309-kho-v8-5-c3abcf4ac750@debian.org>
Date: Fri, 13 Mar 2026 09:33:14 +0000
Message-ID: <2vxz3424gjl1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_023320_348259_6BA3BBFE 
X-CRM114-Status: GOOD (  40.45  )
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

On Mon, Mar 09 2026, Breno Leitao wrote:

> Use Kexec Handover (KHO) to pass the previous kernel's version string
> and the number of kexec reboots since the last cold boot to the next
> kernel, and print it at boot time.
>
> Example output:
>     [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107 (count 1)
>
> Motivation
> ==========
>
> Bugs that only reproduce when kexecing from specific kernel versions
> are difficult to diagnose. These issues occur when a buggy kernel
> kexecs into a new kernel, with the bug manifesting only in the second
> kernel.
>
> Recent examples include the following commits:
>
>  * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
>  * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
>  * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")
>
> As kexec-based reboots become more common, these version-dependent bugs
> are appearing more frequently. At scale, correlating crashes to the
> previous kernel version is challenging, especially when issues only
> occur in specific transition scenarios.
>
> Implementation
> ==============
>
> The kexec metadata is stored as a plain C struct (struct kho_kexec_metadata)
> rather than FDT format, for simplicity and direct field access. It is
> registered via kho_add_subtree() as a separate subtree, keeping it
> independent from the core KHO ABI. This design choice:
>
>  - Keeps the core KHO ABI minimal and stable
>  - Allows the metadata format to evolve independently
>  - Avoids requiring version bumps for all KHO consumers (LUO, etc.)
>    when the metadata format changes
>
> The struct kho_kexec_metadata contains two fields:
>  - previous_release: The kernel version that initiated the kexec
>  - kexec_count: Number of kexec boots since last cold boot
>
> On cold boot, kexec_count starts at 0 and increments with each kexec.
> The count helps identify issues that only manifest after multiple
> consecutive kexec reboots.
>
> Acked-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/kho/abi/kexec_handover.h | 31 ++++++++++++++
>  kernel/liveupdate/kexec_handover.c     | 75 ++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index 7e847a2339b09..832390f96f49c 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -14,6 +14,7 @@
>  #include <linux/log2.h>
>  #include <linux/math.h>
>  #include <linux/types.h>
> +#include <linux/utsname.h>
>  
>  #include <asm/page.h>
>  
> @@ -101,6 +102,36 @@
>  /* The FDT property for the size of preserved data blobs. */
>  #define KHO_SUB_TREE_SIZE_PROP_NAME "blob-size"
>  
> +/**
> + * DOC: Kexec Metadata ABI
> + *
> + * The "kexec-metadata" subtree stores optional metadata about the kexec chain.
> + * It is registered via kho_add_subtree(), keeping it independent from the core
> + * KHO ABI. This allows the metadata format to evolve without affecting other
> + * KHO consumers.
> + *
> + * The metadata is stored as a plain C struct rather than FDT format for
> + * simplicity and direct field access.
> + */
> +
> +/**
> + * struct kho_kexec_metadata - Kexec metadata passed between kernels
> + * @previous_release: Kernel version string that initiated the kexec
> + * @kexec_count: Number of kexec boots since last cold boot
> + *
> + * This structure is preserved across kexec and allows the new kernel to
> + * identify which kernel it was booted from and how many kexec reboots
> + * have occurred.
> + *
> + * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
> + */
> +struct kho_kexec_metadata {

You need to have a version field here, as the first 4 or 8 bytes. And
you need to check it before parsing anything else in the struct.
Otherwise there will be no way to extend this struct since there won't
be a way to find out if the kernel can read the new format. You probably
should also check the size of the blob on retrieve to make sure it is
large enough to at least contain the version.

Also, since this follows ABI version independent of KHO, please move it
to a separate header, perhaps kexec_metadata.h. Right now we assume that
everything in this file is tied to the base KHO version.

Other than this, LGTM.

> +	char previous_release[__NEW_UTS_LEN + 1];
> +	u32 kexec_count;
> +} __packed;
> +
> +#define KHO_METADATA_NODE_NAME "kexec-metadata"
> +
>  /**
>   * DOC: Kexec Handover ABI for vmalloc Preservation
>   *
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 1f22705d5d246..7bac80e9a29a4 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -18,6 +18,7 @@
>  #include <linux/kexec.h>
>  #include <linux/kexec_handover.h>
>  #include <linux/kho_radix_tree.h>
> +#include <linux/utsname.h>
>  #include <linux/kho/abi/kexec_handover.h>
>  #include <linux/libfdt.h>
>  #include <linux/list.h>
> @@ -1285,6 +1286,8 @@ EXPORT_SYMBOL_GPL(kho_restore_free);
>  struct kho_in {
>  	phys_addr_t fdt_phys;
>  	phys_addr_t scratch_phys;
> +	char previous_release[__NEW_UTS_LEN + 1];
> +	u32 kexec_count;
>  	struct kho_debugfs dbg;
>  };
>  
> @@ -1408,6 +1411,74 @@ static __init int kho_out_fdt_setup(void)
>  	return err;
>  }
>  
> +static void __init kho_in_kexec_metadata(void)
> +{
> +	struct kho_kexec_metadata *metadata;
> +	phys_addr_t metadata_phys;
> +	int err;
> +
> +	err = kho_retrieve_subtree(KHO_METADATA_NODE_NAME, &metadata_phys,
> +				   NULL);
> +	if (err)
> +		/* This is fine, previous kernel didn't export metadata */
> +		return;
> +	metadata = phys_to_virt(metadata_phys);
> +
> +	/*
> +	 * Copy data to the kernel structure that will persist during
> +	 * kernel lifetime.
> +	 */
> +	kho_in.kexec_count = metadata->kexec_count;
> +	strscpy(kho_in.previous_release, metadata->previous_release,
> +		sizeof(kho_in.previous_release));
> +
> +	pr_info("exec from: %s (count %u)\n", kho_in.previous_release,
> +					      kho_in.kexec_count);
> +}
> +
> +/*
> + * Create kexec metadata to pass kernel version and boot count to the
> + * next kernel. This keeps the core KHO ABI minimal and allows the
> + * metadata format to evolve independently.
> + */
> +static __init int kho_out_kexec_metadata(void)
> +{
> +	struct kho_kexec_metadata *metadata;
> +	int err;
> +
> +	metadata = kho_alloc_preserve(sizeof(*metadata));
> +	if (IS_ERR(metadata))
> +		return PTR_ERR(metadata);
> +
> +	strscpy(metadata->previous_release, init_uts_ns.name.release,
> +		sizeof(metadata->previous_release));
> +	/* kho_in.kexec_count is set to 0 on cold boot */
> +	metadata->kexec_count = kho_in.kexec_count + 1;
> +
> +	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata,
> +			      sizeof(*metadata));
> +	if (err)
> +		kho_unpreserve_free(metadata);
> +
> +	return err;
> +}
> +
> +static int __init kho_kexec_metadata_init(const void *fdt)
> +{
> +	int err;
> +
> +	if (fdt)
> +		kho_in_kexec_metadata();
> +
> +	/* Populate kexec metadata for the possible next kexec */
> +	err = kho_out_kexec_metadata();
> +	if (err)
> +		pr_warn("failed to initialize kexec-metadata subtree: %d\n",
> +			err);
> +
> +	return err;
> +}
> +
>  static __init int kho_init(void)
>  {
>  	struct kho_radix_tree *tree = &kho_out.radix_tree;
> @@ -1441,6 +1512,10 @@ static __init int kho_init(void)
>  	if (err)
>  		goto err_free_fdt;
>  
> +	err = kho_kexec_metadata_init(fdt);
> +	if (err)
> +		goto err_free_fdt;
> +
>  	for (int i = 0; i < kho_scratch_cnt; i++) {
>  		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
>  		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;

-- 
Regards,
Pratyush Yadav

