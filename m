Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A393EB1049
	for <kexec@archiver.kernel.org>; Tue, 10 Mar 2026 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zgaOmcJcty82p3DVvT02+Cs5PdsEAKFTj12yk/tgr2I=; b=qG6JNxgy4zNc9cAtxXIDrWXd0K
	30EaLaZJPkvZHtPyKRsr9yqmd5AE3TTzAXYaK/gasBu0Ij1lNu+8scJ1vO1UdHzLSRHQg6uL59ZpE
	3P7DrsaAO56T7l7nvoUglVGBSmjsHKc7cg0vLtrbNKfynhiLkrwcLsneqkc1MR6E/FHJk5PG2nNBi
	Rba8m/09AYwcAjoWpjr1wTODrgtC5t8UPkNCaab5Qkf4TAQHzxQVBCU/WoO8Iy6DI/mv2YOjFHRsW
	LymowFwMNT4vrZR0cSE4FaUT1V5ZcoiI8aGp6IwZLo93ZC9eESu3OP2xpv6PzR7ygx0x8Ul9nG45K
	/aQqksJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzuRa-00000009DCc-3gfE;
	Tue, 10 Mar 2026 10:36:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzuRY-00000009DCG-1ZU3
	for kexec@lists.infradead.org;
	Tue, 10 Mar 2026 10:36:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9781D441DA;
	Tue, 10 Mar 2026 10:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09129C19423;
	Tue, 10 Mar 2026 10:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773138963;
	bh=HeYcMENlsoZTkvCoxRtHhelNbtBE9HLVmhk6RimuAPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saiCNpwA1VdG8HIY8XU75j7J1RBMy6PRRnD5UagsoLV/Q0WXrrCi14S+EqKMoELzn
	 1C9gTfoNApqpYPB8NS+b/v/RM580SIZCpgopHsRrqvw1c7A30wVP7wy7TA6ugfJJKH
	 1WCrshnI+5SmYL/HLisNtk5yoYQ3xPwXuOCSFT54noDpHsMiKraEkbLBVwqzgfz2Ll
	 qC19xpj/wPea7YofMJAy1/LeV+Iw4DhBe9yWiK7NXzTcUZt2ECqlfuGOvHlXoNSrgj
	 u+139+E7Td2ix5LTSH3cON5Mtm1mGM8Lpmwsm+Rr8BjyypQF4zl4C6E8iHom2GOGLi
	 RPntKG7n2GcJg==
Date: Tue, 10 Mar 2026 12:35:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v8 3/6] kho: persist blob size in KHO FDT
Message-ID: <aa_0DPN8aCZ_FJ_b@kernel.org>
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
 <20260309-kho-v8-3-c3abcf4ac750@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-kho-v8-3-c3abcf4ac750@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_033604_475719_5ECADCDF 
X-CRM114-Status: GOOD (  34.47  )
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

On Mon, Mar 09, 2026 at 06:41:46AM -0700, Breno Leitao wrote:
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

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kexec_handover.h         |  5 +++--
>  include/linux/kho/abi/kexec_handover.h | 20 ++++++++++++++++----
>  kernel/liveupdate/kexec_handover.c     | 26 +++++++++++++++++++++-----
>  kernel/liveupdate/luo_core.c           |  2 +-
>  lib/test_kho.c                         |  2 +-
>  mm/memblock.c                          |  2 +-
>  6 files changed, 43 insertions(+), 14 deletions(-)
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
> index 6b7d8ef550f98..7e847a2339b09 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -41,25 +41,28 @@
>   *   restore the preserved data.::
>   *
>   *     / {
> - *         compatible = "kho-v2";
> + *         compatible = "kho-v3";
>   *
>   *         preserved-memory-map = <0x...>;
>   *
>   *         <subnode-name-1> {
>   *             preserved-data = <0x...>;
> + *             blob-size = <0x...>;
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
>   *   Root KHO Node (/):
> - *     - compatible: "kho-v2"
> + *     - compatible: "kho-v3"
>   *
>   *       Indentifies the overall KHO ABI version.
>   *
> @@ -78,16 +81,25 @@
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
> -#define KHO_FDT_COMPATIBLE "kho-v2"
> +#define KHO_FDT_COMPATIBLE "kho-v3"
>  
>  /* The FDT property for the preserved memory map. */
>  #define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
>  
>  /* The FDT property for preserved data blobs. */
> -#define KHO_FDT_SUB_TREE_PROP_NAME "preserved-data"
> +#define KHO_SUB_TREE_PROP_NAME "preserved-data"
> +
> +/* The FDT property for the size of preserved data blobs. */
> +#define KHO_SUB_TREE_SIZE_PROP_NAME "blob-size"
>  
>  /**
>   * DOC: Kexec Handover ABI for vmalloc Preservation
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 54fe59fe43acd..1f22705d5d246 100644
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
> @@ -784,11 +785,16 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
>  		goto out_pack;
>  	}
>  
> -	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
> +	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
>  			  &phys, sizeof(phys));
>  	if (err < 0)
>  		goto out_pack;
>  
> +	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
> +			  &size_u64, sizeof(size_u64));
> +	if (err < 0)
> +		goto out_pack;
> +
>  	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
>  					  size, false));
>  
> @@ -817,7 +823,7 @@ void kho_remove_subtree(void *blob)
>  		const u64 *val;
>  		int len;
>  
> -		val = fdt_getprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME, &len);
> +		val = fdt_getprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME, &len);
>  		if (!val || len != sizeof(phys_addr_t))
>  			continue;
>  
> @@ -1314,13 +1320,14 @@ EXPORT_SYMBOL_GPL(is_kho_boot);
>   * kho_retrieve_subtree - retrieve a preserved sub blob by its name.
>   * @name: the name of the sub blob passed to kho_add_subtree().
>   * @phys: if found, the physical address of the sub blob is stored in @phys.
> + * @size: if not NULL and found, the size of the sub blob is stored in @size.
>   *
>   * Retrieve a preserved sub blob named @name and store its physical
> - * address in @phys.
> + * address in @phys and optionally its size in @size.
>   *
>   * Return: 0 on success, error code on failure
>   */
> -int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
> +int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
>  {
>  	const void *fdt = kho_get_fdt();
>  	const u64 *val;
> @@ -1336,12 +1343,21 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
>  	if (offset < 0)
>  		return -ENOENT;
>  
> -	val = fdt_getprop(fdt, offset, KHO_FDT_SUB_TREE_PROP_NAME, &len);
> +	val = fdt_getprop(fdt, offset, KHO_SUB_TREE_PROP_NAME, &len);
>  	if (!val || len != sizeof(*val))
>  		return -EINVAL;
>  
>  	*phys = (phys_addr_t)*val;
>  
> +	if (size) {
> +		val = fdt_getprop(fdt, offset, KHO_SUB_TREE_SIZE_PROP_NAME,
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

-- 
Sincerely yours,
Mike.

