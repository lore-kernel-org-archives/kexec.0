Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCD3D2628A
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4X3p1hsMbO1Gjz1e07Um2YapRO5gCA5rv2LgEFafNKo=; b=0zLLY22wv9CGfheYoWvX8P37+h
	ZdY6Y49qtd6keMZjPv6KJ2M8aINh8jwizUXgTH/BusBuXc6rE2Bn0kKg+P8t7rTb+P1aIDf5j0v1/
	qLgNBIecUTbXO0IA2UvZHaKn53mBt2oFbELSyzy+J64r1OKmAaS1TSX6JJhcuZRTWKg/d/NneqDPN
	R1s6QV0I7uolIGZCpHfX/86bh1OKctWM7rwWsmcK+yNaPjTcF62dxOrKxeio2tPmlh+WC1MyZwidD
	EvLFiJRsq0uTvgMT84bz7hRjmFGzAuS1ggywB72j57ch7AXMlQuyGOOzy99vXb4ZkFrLxlt4WWUnj
	D0phlgNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGgx-00000004Jbk-0JFu;
	Tue, 20 Jan 2026 18:43:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGgs-00000004JbF-3LXZ
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 18:43:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E98B3435B4;
	Tue, 20 Jan 2026 18:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABADC16AAE;
	Tue, 20 Jan 2026 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934577;
	bh=9asjItjUuW66QRWbqI3QXT7hKg9DauBgryF6+gZ2LNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjqiEUIQDfHO6Y7G/RKwZ5STzyAI3pmHlAXYrmpO177JUyGX8ZQ2arH5agwQ1mIQF
	 06Q/WGxNJm5wqvx44LsUPycGl7t9/iaBz6ay83UeQystb/yWY8U5aE4cXTa2HhvIId
	 p4g6qBLQjwFsPg9ld8SgZeCG1wtu8ENI6AGo/S1AMjok8WBwK8v+/JCidE2dfZW40v
	 yiKeRoX1WOHyN6rAKE0zpbSZ6yubd6llKtUZQKTOs5NrqUFsfflDd+ffq/YnzWu5bn
	 +ZGUcPE8CUQKafbu7zRgvs4L01dfbNM7AsTbpwQjfSHIFqzE+m6sm4biqw7EOiKZ/d
	 /qsbKT+M1zyrA==
Date: Tue, 20 Jan 2026 20:42:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/6] kho: Relocate vmalloc preservation structure to KHO
 ABI header
Message-ID: <aW_Mqp6HcqLwQImS@kernel.org>
References: <20260105165839.285270-1-rppt@kernel.org>
 <20260105165839.285270-6-rppt@kernel.org>
 <2vxzy0lscks4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzy0lscks4.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_104258_879929_26ECDBA2 
X-CRM114-Status: GOOD (  27.72  )
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

On Tue, Jan 20, 2026 at 04:26:51PM +0000, Pratyush Yadav wrote:
> On Mon, Jan 05 2026, Mike Rapoport wrote:
> 
> > From: Jason Miu <jasonmiu@google.com>
> >
> > The `struct kho_vmalloc` defines the in-memory layout for preserving
> > vmalloc regions across kexec. This layout is a contract between kernels
> > and part of the KHO ABI.
> >
> > To reflect this relationship, the related structs and helper macros are
> > relocated to the ABI header, `include/linux/kho/abi/kexec_handover.h`.
> > This move places the structure's definition under the protection of the
> > KHO_FDT_COMPATIBLE version string.
> >
> > The structure and its components are now also documented within the
> > ABI header to describe the contract and prevent ABI breaks.
> >
> > Signed-off-by: Jason Miu <jasonmiu@google.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> [...]
> > +/* Helper macro to define a union for a serializable pointer. */
> > +#define DECLARE_KHOSER_PTR(name, type)	\
> > +	union {                        \
> > +		u64 phys;              \
> > +		type ptr;              \
> > +	} name
> > +
> > +/* Stores the physical address of a serializable pointer. */
> > +#define KHOSER_STORE_PTR(dest, val)               \
> > +	({                                        \
> > +		typeof(val) v = val;              \
> > +		typecheck(typeof((dest).ptr), v); \
> > +		(dest).phys = virt_to_phys(v);    \
> > +	})
> > +
> > +/* Loads the stored physical address back to a pointer. */
> > +#define KHOSER_LOAD_PTR(src)						\
> > +	({                                                                   \
> > +		typeof(src) s = src;                                         \
> > +		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
> > +	})
> 
> Nit: not a fan of exposing code internals to the ABI header. But without
> this the definition of kho_vmalloc_hdr won't make any sense to someone
> reading the doc without looking at the code. Dunno if we can do anything
> better though...

These might be actually useful for other KHO users. 

> > +/*
> > + * This header is embedded at the beginning of each `kho_vmalloc_chunk`
> > + * and contains a pointer to the next chunk in the linked list,
> > + * stored as a physical address for handover.
> > + */
> > +struct kho_vmalloc_hdr {
> > +	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
> > +};
> > +
> > +#define KHO_VMALLOC_SIZE				\
> > +	((PAGE_SIZE - sizeof(struct kho_vmalloc_hdr)) / \
> > +	 sizeof(u64))
> > +
> > +/*
> > + * Each chunk is a single page and is part of a linked list that describes
> > + * a preserved vmalloc area. It contains the header with the link to the next
> > + * chunk and an array of physical addresses of the pages that make up the
> > + * preserved vmalloc area.
> 
> Perhaps also mention that the array is 0-terminated?

Yeah, sure.

@Andrew, can you please add this as a fixup:

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 285eda8a36e4..2201a0d2c159 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -138,8 +138,8 @@ struct kho_vmalloc_hdr {
 /*
  * Each chunk is a single page and is part of a linked list that describes
  * a preserved vmalloc area. It contains the header with the link to the next
- * chunk and an array of physical addresses of the pages that make up the
- * preserved vmalloc area.
+ * chunk and a zero terminated array of physical addresses of the pages that
+ * make up the preserved vmalloc area.
  */
 struct kho_vmalloc_chunk {
 	struct kho_vmalloc_hdr hdr;


> Looks good otherwise.
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

