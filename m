Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D504105F783
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 09:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hP6VB/kh4caosJ7JSFrTVR87i2GC1lPoiQyiYwHx/ts=; b=Na9Gih86cqulaDMGLNqQt02/oL
	0PSFTSCTRyVi+1jr8b4uSNH5lg0o1iZfihf94c6Ls7KQdzrxEsMa+URKG0VBNh011InDSLKgRG0rz
	spIt2UCARCWjiSo7b89LuTGCQKbD219rBKIZXXyIETD7fFWftUS82NNDLqSzDDez6coNCH/o+HO2S
	kVLiA7SQ8ICfMo35f7Tf8YmkjwwFw5OPcG3VMHpwmymIYdRz0yEmuxx8cyLXA/WbEu7p8Y41fKTaF
	8r+R+GeyL3sG2HSo3eabjEmQvrC78T4buzG5ae93C08ZCb2m0jmcxOoB8fLRkqcPG4dwmOOeMmh1P
	ybySNOcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0yiT-0000000HN5s-0DJf;
	Fri, 13 Mar 2026 09:21:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0yiR-0000000HN5b-2k4f
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 09:21:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A0C856012B;
	Fri, 13 Mar 2026 09:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A260C19421;
	Fri, 13 Mar 2026 09:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773393714;
	bh=tQJKdL58Q4S6pgdJ9PWWjtqzjJ6qyibzg9gNvLmbvNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uHDzvVxWqEjeUrRDkZCSRp/7kEUJDWK7mW76FM+GvRlYeECWZC05DVI7QbMSuB+LR
	 ob/sftdL89q0W29TpL0ancfU4zZd98enqGB2NmTbZ9DShiQUHRS7zul5tT4wsFNLW2
	 OcRkn3ydcRA2ZJ+SOiedL9N2n0D9FQQe8lIs+GuGq2zyC9YRzLqtIdMaQwM8h5A5II
	 uvIPcJO215CL9giQF2gsvkZGoNhYSKJEKv2UGlxkaNaN36wVTKkONuKN2OZtOzjixc
	 1lYnLNuWaMJKYnlZrFgkCSUhvsLPEkER/Bl6s5omfDF8SjvzNC1fmngKAH29eh2Owu
	 nPdSACfYjsfTw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v8 3/6] kho: persist blob size in KHO FDT
In-Reply-To: <20260309-kho-v8-3-c3abcf4ac750@debian.org> (Breno Leitao's
	message of "Mon, 09 Mar 2026 06:41:46 -0700")
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
	<20260309-kho-v8-3-c3abcf4ac750@debian.org>
Date: Fri, 13 Mar 2026 09:21:50 +0000
Message-ID: <2vxzbjgsgk41.fsf@kernel.org>
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

On Mon, Mar 09 2026, Breno Leitao wrote:

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
[...]
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

I noticed that the error handling here is a bit broken. We open the
subnode for the subtree, but then if we fail to add the "preserved-data"
property, we don't remove the subnode. So the next kernel gets an
invalid FDT (per KHO ABI) and might as well refuse to parse it.

Similarly here, the FDT might also be missing the size and then the next
kernel might reject the FDT.

Also, we directly return the FDT error code to the caller, which
wouldn't make sense since it probably expects -errno.

Not something this patchset has to fix, but I am pointing this out in
case someone (possibly also future me) is interested in fixing this up.

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

If the size property is invalid, is it a good idea to ignore it? Should
we instead consider the subnode to be broken and reject it entirely with
an error message? Because if a caller expects a blob of 16 bytes but
gets one with 0 bytes, it will likely error out anyway.

> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
[...]

-- 
Regards,
Pratyush Yadav

