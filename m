Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59025F4644F
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JZL2bgode2vAt2OHP2/8t7Ara1fNH4s4w9EznBHpivw=; b=q9DmfVWTgZyTzwD63tkAUVXSrs
	p0HacmmqaAXHf0jMzfFwXaOvmlg0sorzspFoBiyb1BT6Fodfak2MAVfi5+0yc7SoprePAq5/YXQcu
	IsH5lqAxMpcMeqEh/pmS6p84S8dlPX9dDAhR94iQaaY4dDOu+e/CRP7S4/bStpinGlR4gEwpfrdOK
	QOdhhKa9lTNXLEvx0j6wQZADaZuVLfnnriSPR5scZBE0PEP+q9GvTvnyhqmXjrGCnWwTzDLWfxemB
	ynX74FxjvD2aAsOMBE9OqwQ7cnEE/d4zXrpV8X7vYF/IORbHQjfhumnC/tAOeeTVS0uas9sJUQPsN
	ikVh4qIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w25ph-00000003nMN-110i;
	Mon, 16 Mar 2026 11:10:01 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w25pf-00000003nL7-0nPg
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 11:10:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JZL2bgode2vAt2OHP2/8t7Ara1fNH4s4w9EznBHpivw=; b=FyiTwwV+9NvW3WHPFOYHEDVBcW
	3mj3heMZibE7ObGWZHDyqshfsIZq3czXuoBSKMR1bW4Gk3mLHzsNByOIVsw8+F+HfrdQYsny/NhfL
	MUMVuXyrWmHZdZsOZE3lhpwYK9Gdqf12CLZ6yg83sNWCaME+d1gWOFWgTdmyYk+PUnOSIrBaqnU+K
	wZl3IJseSbq+xllzRYWzZOc6IO1+xhkLWqd9cs8WVT70vGBOwpmmdP2rUW3QUlUnWMDzthejTvbmu
	3LwO4LHeFCYx5Sohkn2sE5Yx+lauTchJpbKjZltDmylLJbTAqm1/5FRcD15EbP/WhPCnaZlsPg8Nf
	woSHgZVw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w25pV-0024X3-H2; Mon, 16 Mar 2026 11:09:48 +0000
Date: Mon, 16 Mar 2026 04:09:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>, 
	kernel-team@meta.com
Subject: Re: [PATCH v8 3/6] kho: persist blob size in KHO FDT
Message-ID: <abfkVOjq1ngZb-Nm@gmail.com>
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
 <20260309-kho-v8-3-c3abcf4ac750@debian.org>
 <2vxzbjgsgk41.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzbjgsgk41.fsf@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_040959_449228_5C2B9741 
X-CRM114-Status: GOOD (  40.68  )
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

On Fri, Mar 13, 2026 at 09:21:50AM +0000, Pratyush Yadav wrote:
> On Mon, Mar 09 2026, Breno Leitao wrote:
> 
> > kho_add_subtree() accepts a size parameter but only forwards it to
> > debugfs. The size is not persisted in the KHO FDT, so it is lost across
> > kexec. This makes it impossible for the incoming kernel to determine the
> > blob size without understanding the blob format.
> >
> > Store the blob size as a "blob-size" property in the KHO FDT alongside
> > the "preserved-data" physical address. This allows the receiving kernel
> > to recover the size for any blob regardless of format.
> >
> > Also extend kho_retrieve_subtree() with an optional size output
> > parameter so callers can learn the blob size without needing to
> > understand the blob format. Update all callers to pass NULL for the
> > new parameter.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> [...]
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 54fe59fe43acd..1f22705d5d246 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -768,6 +768,7 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
> >  {
> >  	phys_addr_t phys = virt_to_phys(blob);
> >  	void *root_fdt = kho_out.fdt;
> > +	u64 size_u64 = size;
> >  	int err = -ENOMEM;
> >  	int off, fdt_err;
> >  
> > @@ -784,11 +785,16 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
> >  		goto out_pack;
> >  	}
> >  
> > -	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
> > +	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
> >  			  &phys, sizeof(phys));
> >  	if (err < 0)
> >  		goto out_pack;
> >  
> > +	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
> > +			  &size_u64, sizeof(size_u64));
> > +	if (err < 0)
> > +		goto out_pack;
> > +
> 
> I noticed that the error handling here is a bit broken. We open the
> subnode for the subtree, but then if we fail to add the "preserved-data"
> property, we don't remove the subnode. So the next kernel gets an
> invalid FDT (per KHO ABI) and might as well refuse to parse it.
> 
> Similarly here, the FDT might also be missing the size and then the next
> kernel might reject the FDT.
> 
> Also, we directly return the FDT error code to the caller, which
> wouldn't make sense since it probably expects -errno.
> 
> Not something this patchset has to fix, but I am pointing this out in
> case someone (possibly also future me) is interested in fixing this up.

That is a good point, do you mean a fix like the following? 

commit 633d0cb01ed959676b60de8b1851dad1757d8fe5
Author: Breno Leitao <leitao@debian.org>
Date:   Mon Mar 16 04:03:51 2026 -0700

    kho: fix error handling in kho_add_subtree()
    
    Fix two error handling issues in kho_add_subtree():
    
    1. If fdt_setprop() fails after the subnode has been created, the
       subnode is not removed. This leaves an incomplete node in the FDT
       (missing "preserved-data" or "blob-size" properties), which violates
       the KHO ABI and may cause the next kernel to reject the FDT.
    
    2. The fdt_setprop() return value (an FDT error code) is stored
       directly in err and returned to the caller, which expects -errno.
    
    Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
    out_del_node label that removes the subnode on failure, and only setting
    err = 0 on the success path.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Suggested-by: Pratyush Yadav <pratyush@kernel.org>

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 62b1b8a9aa337..8d2d30119f6d4 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -787,19 +787,24 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
 		goto out_pack;
 	}
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
-			  &phys, sizeof(phys));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
+			      &phys, sizeof(phys));
+	if (fdt_err < 0)
+		goto out_del_node;
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
-			  &size_u64, sizeof(size_u64));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
+			      &size_u64, sizeof(size_u64));
+	if (fdt_err < 0)
+		goto out_del_node;
 
 	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
 					  size, false));
 
+	err = 0;
+	goto out_pack;
+
+out_del_node:
+	fdt_del_node(root_fdt, off);
 out_pack:
 	fdt_pack(root_fdt);
 

Given this is not strictly related to this patchset, I am planning to
send this fix separately.

> >  	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
> >  					  size, false));
> >  
> > @@ -817,7 +823,7 @@ void kho_remove_subtree(void *blob)
> >  		const u64 *val;
> >  		int len;
> >  
> > -		val = fdt_getprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME, &len);
> > +		val = fdt_getprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME, &len);
> >  		if (!val || len != sizeof(phys_addr_t))
> >  			continue;
> >  
> > @@ -1314,13 +1320,14 @@ EXPORT_SYMBOL_GPL(is_kho_boot);
> >   * kho_retrieve_subtree - retrieve a preserved sub blob by its name.
> >   * @name: the name of the sub blob passed to kho_add_subtree().
> >   * @phys: if found, the physical address of the sub blob is stored in @phys.
> > + * @size: if not NULL and found, the size of the sub blob is stored in @size.
> >   *
> >   * Retrieve a preserved sub blob named @name and store its physical
> > - * address in @phys.
> > + * address in @phys and optionally its size in @size.
> >   *
> >   * Return: 0 on success, error code on failure
> >   */
> > -int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
> > +int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
> >  {
> >  	const void *fdt = kho_get_fdt();
> >  	const u64 *val;
> > @@ -1336,12 +1343,21 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
> >  	if (offset < 0)
> >  		return -ENOENT;
> >  
> > -	val = fdt_getprop(fdt, offset, KHO_FDT_SUB_TREE_PROP_NAME, &len);
> > +	val = fdt_getprop(fdt, offset, KHO_SUB_TREE_PROP_NAME, &len);
> >  	if (!val || len != sizeof(*val))
> >  		return -EINVAL;
> >  
> >  	*phys = (phys_addr_t)*val;
> >  
> > +	if (size) {
> > +		val = fdt_getprop(fdt, offset, KHO_SUB_TREE_SIZE_PROP_NAME,
> > +				  &len);
> > +		if (val && len == sizeof(*val))
> > +			*size = (size_t)*val;
> > +		else
> > +			*size = 0;
> 
> If the size property is invalid, is it a good idea to ignore it? Should
> we instead consider the subnode to be broken and reject it entirely with
> an error message? Because if a caller expects a blob of 16 bytes but
> gets one with 0 bytes, it will likely error out anyway.

Ack, let me update this, then.

Thanks for the review,
--breno

