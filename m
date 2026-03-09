Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1ADEF36F8
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 07:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKOGQSccnOLIOvszIRzBg7Fo7IwCwzoMUoz3ymuPxCY=; b=CtlwTGQ6ferqcsA4QSlM1numoN
	u2TL5v20thEsSmTfeWJ44DuISsUVJBG8bA8IIdIqVb2OQDP/yz2FODNAtxqwkslbnSvzgnbAKjoei
	nRxqUgOj0d/lXyR6Te3bKyf+BArWxXOsd4sQ2Xljk6/K/+m1qlEHGb+ymD5mm2IBLgJa/IW1EvWkm
	1oiIzybovqlXVTL129e+cewYC6U3p8QoTjQcXFNEMdVPZVWRSmSVnvfRqn7AvIYB0oAhLSsnVcYcR
	/d33t4yxL+pnilo1IPb2jVIe4kOiMAfApwLB2bAbzH2oRVEdbHKFdQqCPGFi8dhfW+Ud6UM6OCrLi
	qrCMeg+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVVG-00000006qra-0wEJ;
	Mon, 09 Mar 2026 07:58:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVVE-00000006qr8-0Vsn
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 07:58:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BC441429CD;
	Mon,  9 Mar 2026 07:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC603C4CEF7;
	Mon,  9 Mar 2026 07:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043090;
	bh=hUC6isBD58pUbu3zVQBoLKKC8yyRHkrLeQRdXS+SnP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sClTN7LRV3iwwY9qz66NghmzMC8SpFSJbToxuVy4BVF5uIomByFWf3jOe0N052pJb
	 uGYnS+e2Nl7h6qc/xPnGiuWuT6Lx2UqprA0i4ePdVTT0EqQKE/XFW4qBzKuwGFG/PR
	 EMIjY7nVuZ+omD39r4Fcjg796/5SL6xhmpQxmrNDwi71hiDNxioYYIcNHhzvwRLIkP
	 GQgPKYtajX8JfO3HNU2AdGOb1aV6pNNz0z/7ASY1/kllgQEU/XBIqqsedf7Tux28uE
	 LwbmzHcnOak0ZNfG+o/1MA//Vl9PJZZzXyauDhQHAqkLr884ErpdVNyyU4yxM/XU9N
	 XHRftrpNAG3nQ==
Date: Mon, 9 Mar 2026 09:58:02 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v7 2/6] kho: rename fdt parameter to blob in
 kho_add/remove_subtree()
Message-ID: <aa59irg2P-sejKO5@kernel.org>
References: <20260306-kho-v7-0-404d14c188bb@debian.org>
 <20260306-kho-v7-2-404d14c188bb@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-kho-v7-2-404d14c188bb@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_005812_290905_DD89714C 
X-CRM114-Status: GOOD (  28.76  )
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

On Fri, Mar 06, 2026 at 04:39:21AM -0800, Breno Leitao wrote:
> Since kho_add_subtree() now accepts arbitrary data blobs (not just
> FDTs), rename the parameter from 'fdt' to 'blob' to better reflect
> its purpose. Apply the same rename to kho_remove_subtree() for
> consistency.
> 
> Also rename kho_debugfs_fdt_add() and kho_debugfs_fdt_remove() to
> kho_debugfs_blob_add() and kho_debugfs_blob_remove() respectively,
> with the same parameter rename from 'fdt' to 'blob'.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kexec_handover.h              |  8 ++++----
>  kernel/liveupdate/kexec_handover.c          | 25 +++++++++++++------------
>  kernel/liveupdate/kexec_handover_debugfs.c  | 25 +++++++++++++------------
>  kernel/liveupdate/kexec_handover_internal.h | 16 ++++++++--------
>  4 files changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index abb1d324f42d0..0666cf298c7f4 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -32,8 +32,8 @@ void kho_restore_free(void *mem);
>  struct folio *kho_restore_folio(phys_addr_t phys);
>  struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
>  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
> -int kho_add_subtree(const char *name, void *fdt, size_t size);
> -void kho_remove_subtree(void *fdt);
> +int kho_add_subtree(const char *name, void *blob, size_t size);
> +void kho_remove_subtree(void *blob);
>  int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
>  
>  void kho_memory_init(void);
> @@ -97,12 +97,12 @@ static inline void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>  	return NULL;
>  }
>  
> -static inline int kho_add_subtree(const char *name, void *fdt, size_t size)
> +static inline int kho_add_subtree(const char *name, void *blob, size_t size)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline void kho_remove_subtree(void *fdt) { }
> +static inline void kho_remove_subtree(void *blob) { }
>  
>  static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
>  {
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 55bdc5d2d1929..ebaf3104c36ab 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -749,13 +749,13 @@ static void __init kho_reserve_scratch(void)
>  }
>  
>  /**
> - * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
> + * kho_add_subtree - record the physical address of a sub blob in KHO root tree.
>   * @name: name of the sub tree.
> - * @fdt: the sub tree blob.
> + * @blob: the sub tree blob.
>   * @size: size of the blob in bytes.
>   *
>   * Creates a new child node named @name in KHO root FDT and records
> - * the physical address of @fdt. The pages of @fdt must also be preserved
> + * the physical address of @blob. The pages of @blob must also be preserved
>   * by KHO for the new kernel to retrieve it after kexec.
>   *
>   * A debugfs blob entry is also created at
> @@ -764,9 +764,9 @@ static void __init kho_reserve_scratch(void)
>   *
>   * Return: 0 on success, error code on failure
>   */
> -int kho_add_subtree(const char *name, void *fdt, size_t size)
> +int kho_add_subtree(const char *name, void *blob, size_t size)
>  {
> -	phys_addr_t phys = virt_to_phys(fdt);
> +	phys_addr_t phys = virt_to_phys(blob);
>  	void *root_fdt = kho_out.fdt;
>  	int err = -ENOMEM;
>  	int off, fdt_err;
> @@ -789,7 +789,8 @@ int kho_add_subtree(const char *name, void *fdt, size_t size)
>  	if (err < 0)
>  		goto out_pack;
>  
> -	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, size, false));
> +	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
> +					  size, false));
>  
>  out_pack:
>  	fdt_pack(root_fdt);
> @@ -798,9 +799,9 @@ int kho_add_subtree(const char *name, void *fdt, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(kho_add_subtree);
>  
> -void kho_remove_subtree(void *fdt)
> +void kho_remove_subtree(void *blob)
>  {
> -	phys_addr_t target_phys = virt_to_phys(fdt);
> +	phys_addr_t target_phys = virt_to_phys(blob);
>  	void *root_fdt = kho_out.fdt;
>  	int off;
>  	int err;
> @@ -822,7 +823,7 @@ void kho_remove_subtree(void *fdt)
>  
>  		if ((phys_addr_t)*val == target_phys) {
>  			fdt_del_node(root_fdt, off);
> -			kho_debugfs_fdt_remove(&kho_out.dbg, fdt);
> +			kho_debugfs_blob_remove(&kho_out.dbg, blob);
>  			break;
>  		}
>  	}
> @@ -1452,9 +1453,9 @@ static __init int kho_init(void)
>  		return 0;
>  	}
>  
> -	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
> -					 kho_out.fdt,
> -					 fdt_totalsize(kho_out.fdt), true));
> +	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, "fdt",
> +					  kho_out.fdt,
> +					  fdt_totalsize(kho_out.fdt), true));
>  
>  	return 0;
>  
> diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
> index b5a1e09ca8f14..7a100f2bf3947 100644
> --- a/kernel/liveupdate/kexec_handover_debugfs.c
> +++ b/kernel/liveupdate/kexec_handover_debugfs.c
> @@ -23,8 +23,9 @@ struct fdt_debugfs {
>  	struct dentry *file;
>  };
>  
> -static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
> -				 const char *name, const void *fdt, size_t size)
> +static int __kho_debugfs_blob_add(struct list_head *list, struct dentry *dir,
> +				  const char *name, const void *blob,
> +				  size_t size)
>  {
>  	struct fdt_debugfs *f;
>  	struct dentry *file;
> @@ -33,7 +34,7 @@ static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
>  	if (!f)
>  		return -ENOMEM;
>  
> -	f->wrapper.data = (void *)fdt;
> +	f->wrapper.data = (void *)blob;
>  	f->wrapper.size = size;
>  
>  	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
> @@ -48,8 +49,8 @@ static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
>  	return 0;
>  }
>  
> -int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
> -			const void *fdt, size_t size, bool root)
> +int kho_debugfs_blob_add(struct kho_debugfs *dbg, const char *name,
> +			 const void *blob, size_t size, bool root)
>  {
>  	struct dentry *dir;
>  
> @@ -58,15 +59,15 @@ int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
>  	else
>  		dir = dbg->sub_fdt_dir;
>  
> -	return __kho_debugfs_fdt_add(&dbg->fdt_list, dir, name, fdt, size);
> +	return __kho_debugfs_blob_add(&dbg->fdt_list, dir, name, blob, size);
>  }
>  
> -void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt)
> +void kho_debugfs_blob_remove(struct kho_debugfs *dbg, void *blob)
>  {
>  	struct fdt_debugfs *ff;
>  
>  	list_for_each_entry(ff, &dbg->fdt_list, list) {
> -		if (ff->wrapper.data == fdt) {
> +		if (ff->wrapper.data == blob) {
>  			debugfs_remove(ff->file);
>  			list_del(&ff->list);
>  			kfree(ff);
> @@ -112,8 +113,8 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
>  		goto err_rmdir;
>  	}
>  
> -	err = __kho_debugfs_fdt_add(&dbg->fdt_list, dir, "fdt", fdt,
> -				    fdt_totalsize(fdt));
> +	err = __kho_debugfs_blob_add(&dbg->fdt_list, dir, "fdt", fdt,
> +				     fdt_totalsize(fdt));
>  	if (err)
>  		goto err_rmdir;
>  
> @@ -132,8 +133,8 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
>  			continue;
>  		}
>  		sub_fdt = phys_to_virt(*fdt_phys);
> -		err = __kho_debugfs_fdt_add(&dbg->fdt_list, sub_fdt_dir, name,
> -					    sub_fdt, fdt_totalsize(sub_fdt));
> +		err = __kho_debugfs_blob_add(&dbg->fdt_list, sub_fdt_dir, name,
> +					     sub_fdt, fdt_totalsize(sub_fdt));
>  		if (err) {
>  			pr_warn("failed to add fdt %s to debugfs: %pe\n", name,
>  				ERR_PTR(err));
> diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
> index 2a28cb8db9b0a..0399ff1077750 100644
> --- a/kernel/liveupdate/kexec_handover_internal.h
> +++ b/kernel/liveupdate/kexec_handover_internal.h
> @@ -26,19 +26,19 @@ extern unsigned int kho_scratch_cnt;
>  int kho_debugfs_init(void);
>  void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
>  int kho_out_debugfs_init(struct kho_debugfs *dbg);
> -int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
> -			const void *fdt, size_t size, bool root);
> -void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt);
> +int kho_debugfs_blob_add(struct kho_debugfs *dbg, const char *name,
> +			 const void *blob, size_t size, bool root);
> +void kho_debugfs_blob_remove(struct kho_debugfs *dbg, void *blob);
>  #else
>  static inline int kho_debugfs_init(void) { return 0; }
>  static inline void kho_in_debugfs_init(struct kho_debugfs *dbg,
>  				       const void *fdt) { }
>  static inline int kho_out_debugfs_init(struct kho_debugfs *dbg) { return 0; }
> -static inline int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
> -				      const void *fdt, size_t size,
> -				      bool root) { return 0; }
> -static inline void kho_debugfs_fdt_remove(struct kho_debugfs *dbg,
> -					  void *fdt) { }
> +static inline int kho_debugfs_blob_add(struct kho_debugfs *dbg,
> +				       const char *name, const void *blob,
> +				       size_t size, bool root) { return 0; }
> +static inline void kho_debugfs_blob_remove(struct kho_debugfs *dbg,
> +					   void *blob) { }
>  #endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
>  
>  #ifdef CONFIG_KEXEC_HANDOVER_DEBUG
> 
> -- 
> 2.47.3
> 
> 

-- 
Sincerely yours,
Mike.

