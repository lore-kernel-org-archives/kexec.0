Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0262DEF3706
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 08:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/DedzbJXFkm+MnAWX4BWPu/pUgf61QHYa8tMfAvMV2Q=; b=muwSkNXy0it0w6Pc7UgfttPbLy
	XSp8b/ettASOSsddi8advtQzn5w6MXhIUhIaao36m7MCcnLK1SViIVi/Y7UeVM3GikTx8F7R1ajzA
	B42FMH76Hm3OgMrEcFSWgiKnXtgovct1bXcLauONN8cTbQMmW6BznC31z7XTvMJsiijk2/hcik4tt
	QeccdRlJSsfa5QujhWtbjxPJSb19W5GVN0gs786itOVNx5jyc/hL7J8z8oLwC2mWQRb1+RF2DB5Dp
	XeKUe1Msnq81gA24uI2RoKsQf5aBUK4arfpJJPwj1axHwWGrDzzBhyU23iYvBmWToRdh0uft1vvFM
	KwJT2gzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVbJ-00000006rQc-0gq0;
	Mon, 09 Mar 2026 08:04:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVbH-00000006rQU-2RdF
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 08:04:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6E5E860131;
	Mon,  9 Mar 2026 08:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1612AC4CEF7;
	Mon,  9 Mar 2026 08:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043466;
	bh=LJdvDDnxeuJeBG4MmNELZoIasBg4c8elab3fV1YLp5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKiYJOH8KTAZsit44TEX+3pQbHKBOHI8z1ReVGwJCBUwNpNL5xGXpBLXvt/1pOClx
	 4lVPuiu44AdJrFafUZwy2w5iMPRzFJ4wuO9pbFG2oxsiRhGwOYIV4+jdyoP25X56nP
	 yy+PDrVJ4t9JXJZ5kOh5wPz0Yv5lN4lGMx6uceyKycQ2znfjPV3ardiV8UAOJTw4b2
	 cmw8/OOLC/BIW0xicLzyFLhbAArhg7P3vaxs6qmajOzcD8eOjmxUVeIyEON1JsL6c1
	 kqRMWc94i8b70ZoUmbGL3LPgEdME6JNO5ijuZUUOpMa7o3ms27SJnpPqvaoEYbH9MI
	 Gs/fY12XebBTA==
Date: Mon, 9 Mar 2026 10:04:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v7 3/6] kho: persist blob size in KHO FDT
Message-ID: <aa5_A42wdcKuCLlE@kernel.org>
References: <20260306-kho-v7-0-404d14c188bb@debian.org>
 <20260306-kho-v7-3-404d14c188bb@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-kho-v7-3-404d14c188bb@debian.org>
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

Hi Breno,

On Fri, Mar 06, 2026 at 04:39:22AM -0800, Breno Leitao wrote:
> kho_add_subtree() accepts a size parameter but only forwards it to
> debugfs. The size is not persisted in the KHO FDT, so it is lost across
> kexec. This makes it impossible for the incoming kernel to determine the
> blob size without understanding the blob format.
> 
> Store the blob size as a "blob-size" property in the KHO FDT alongside
> the "preserved-data" physical address. This allows the receiving kernel
> to recover the size for any blob regardless of format.
> 
> Also extend kho_retrieve_subtree() with an optional size output
> parameter so callers can learn the blob size without needing to
> understand the blob format. Update all callers to pass NULL for the
> new parameter.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/kexec_handover.h         |  5 +++--
>  include/linux/kho/abi/kexec_handover.h | 12 ++++++++++++
>  kernel/liveupdate/kexec_handover.c     | 28 ++++++++++++++++++++++------
>  kernel/liveupdate/luo_core.c           |  2 +-
>  lib/test_kho.c                         |  2 +-
>  mm/memblock.c                          |  2 +-
>  6 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 0666cf298c7f4..8968c56d2d73e 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -34,7 +34,7 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
>  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
>  int kho_add_subtree(const char *name, void *blob, size_t size);
>  void kho_remove_subtree(void *blob);
> -int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
> +int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
>  
>  void kho_memory_init(void);
>  
> @@ -104,7 +104,8 @@ static inline int kho_add_subtree(const char *name, void *blob, size_t size)
>  
>  static inline void kho_remove_subtree(void *blob) { }
>  
> -static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
> +static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys,
> +				       size_t *size)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index 6b7d8ef550f98..15bf7a5be8cf1 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -47,14 +47,17 @@
>   *
>   *         <subnode-name-1> {
>   *             preserved-data = <0x...>;
> + *             blob-size = <0x...>;

Please bump the compatible version

>   *         };
>   *
>   *         <subnode-name-2> {
>   *             preserved-data = <0x...>;
> + *             blob-size = <0x...>;
>   *         };
>   *               ... ...
>   *         <subnode-name-N> {
>   *             preserved-data = <0x...>;
> + *             blob-size = <0x...>;
>   *         };
>   *     };
>   *
> @@ -78,6 +81,12 @@
>   *
>   *       Physical address pointing to a subnode data blob that is also
>   *       being preserved.
> + *
> + *     - blob-size: u64
> + *
> + *       Size in bytes of the preserved data blob. This is needed because
> + *       blobs may use arbitrary formats (not just FDT), so the size
> + *       cannot be determined from the blob content alone.
>   */
>  
>  /* The compatible string for the KHO FDT root node. */
> @@ -89,6 +98,9 @@
>  /* The FDT property for preserved data blobs. */
>  #define KHO_FDT_SUB_TREE_PROP_NAME "preserved-data"
>  
> +/* The FDT property for the size of preserved data blobs. */
> +#define KHO_FDT_SUB_TREE_SIZE_PROP_NAME "blob-size"
> +

I think we can drop _FDT here and in KHO_FDT_SUB_TREE_PROP_NAME

>  /**
>   * DOC: Kexec Handover ABI for vmalloc Preservation
>   *
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index ebaf3104c36ab..e52615fdd5e4b 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -768,6 +768,7 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
>  {
>  	phys_addr_t phys = virt_to_phys(blob);
>  	void *root_fdt = kho_out.fdt;
> +	u64 size_u64 = size;
>  	int err = -ENOMEM;
>  	int off, fdt_err;
>  
> @@ -789,6 +790,11 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
>  	if (err < 0)
>  		goto out_pack;
>  
> +	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_SIZE_PROP_NAME,
> +			  &size_u64, sizeof(size_u64));
> +	if (err < 0)
> +		goto out_pack;
> +
>  	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
>  					  size, false));
>  
> @@ -1311,16 +1317,17 @@ bool is_kho_boot(void)
>  EXPORT_SYMBOL_GPL(is_kho_boot);
>  
>  /**
> - * kho_retrieve_subtree - retrieve a preserved sub FDT by its name.
> - * @name: the name of the sub FDT passed to kho_add_subtree().
> - * @phys: if found, the physical address of the sub FDT is stored in @phys.
> + * kho_retrieve_subtree - retrieve a preserved sub blob by its name.
> + * @name: the name of the sub blob passed to kho_add_subtree().
> + * @phys: if found, the physical address of the sub blob is stored in @phys.

The renaming part better fits the renaming patch :)

> + * @size: if not NULL and found, the size of the sub blob is stored in @size.
>   *
> - * Retrieve a preserved sub FDT named @name and store its physical
> - * address in @phys.
> + * Retrieve a preserved sub blob named @name and store its physical
> + * address in @phys and optionally its size in @size.

Here as well.

>   *
>   * Return: 0 on success, error code on failure
>   */
> -int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
> +int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
>  {
>  	const void *fdt = kho_get_fdt();
>  	const u64 *val;
> @@ -1342,6 +1349,15 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
>  
>  	*phys = (phys_addr_t)*val;
>  
> +	if (size) {
> +		val = fdt_getprop(fdt, offset, KHO_FDT_SUB_TREE_SIZE_PROP_NAME,
> +				  &len);
> +		if (val && len == sizeof(*val))
> +			*size = (size_t)*val;
> +		else
> +			*size = 0;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index 04d06a0906c0e..48b25c9abeda3 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -88,7 +88,7 @@ static int __init luo_early_startup(void)
>  	}
>  
>  	/* Retrieve LUO subtree, and verify its format. */
> -	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys);
> +	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys, NULL);
>  	if (err) {
>  		if (err != -ENOENT) {
>  			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index 2631824373152..aa6a0956bb8b7 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -319,7 +319,7 @@ static int __init kho_test_init(void)
>  	if (!kho_is_enabled())
>  		return 0;
>  
> -	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
> +	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys, NULL);
>  	if (!err) {
>  		err = kho_test_restore(fdt_phys);
>  		if (err)
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 29e12ea2a854c..4f4bf1a9d7900 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2533,7 +2533,7 @@ static void *__init reserve_mem_kho_retrieve_fdt(void)
>  	if (fdt)
>  		return fdt;
>  
> -	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys);
> +	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys, NULL);
>  	if (err) {
>  		if (err != -ENOENT)
>  			pr_warn("failed to retrieve FDT '%s' from KHO: %d\n",
> 
> -- 
> 2.47.3
> 
> 

-- 
Sincerely yours,
Mike.

