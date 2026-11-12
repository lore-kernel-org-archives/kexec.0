Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AF606B730
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3TPvLBuf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blR2ZZkc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OGChezwGEAs5VmxdKN/i88B/dah14lbYLutkEhF0lOY=; b=3TPvLBufgoTAntdjzhlUVmwMPn
	oQ6Xa0C781gb7X36JvgktD2Ax229fmXTr3jzldPN/op7xy0safgCebbrNGhl5a3LrjrMaIq3c9iiC
	VUq/d0vds6c8CvudlWnu4k0YhEBdg8VRcnndXQIbAwrHAmOeJNe7rHVVMxaEOwNgdDC3JIc4kQZHl
	v4Bbu5C28ljFTBHz174YthesftkjVsK8n6TcyHykaDtOUXazkvCMn9KZ5kOuqC8FbpnG4JXh7mCIQ
	Vj/Gw6+pQq6qt8xJ9KCqDROIUbPd7RAAx9nEf9tTQ8/Yo3HnEWKmT0ja5OjYt4zWjZ6mE8qA6H4+T
	l2z31CdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQVI-00000009Ef6-2iDl;
	Thu, 12 Nov 2026 08:49:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQVG-00000009Ee2-02u1
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 08:49:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AE97D43645;
	Thu, 12 Nov 2026 08:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7AE1F00A05;
	Thu, 12 Nov 2026 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473393;
	bh=OGChezwGEAs5VmxdKN/i88B/dah14lbYLutkEhF0lOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=blR2ZZkcc/vDDO96F1pNxo2m29Sm1eEE58wpJKJVkHYo/oXT8bnVVxwZZly5gZt9q
	 WjKhsecawJUo7hwiLqoB1tVNvATaSKrnCQij9ms9i4j046DyigYLVgzKpPVW/Tm32u
	 DFsGgSAhvGZFpD7jZe6hMTEs8q6xFGpoAsvodr12hfkgt1d+rnYLrT4Zo91RMnmygO
	 0yruuXkzYrHRiuER+joOHfZNGA23QqvNVf/8ozCvJuVQ3b+UfYkf9kKtv/5ozkNjEA
	 SJWrIn3UVe4emvFMOq5MsjJhsAU82JyD7Ikm8arKDsaA71v1lyHUIdzvm0qEtUhFC4
	 NtcmR0wFZxi0g==
Date: Thu, 12 Nov 2026 10:49:46 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>,
	Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] kho: walk bootmem areas in address order
Message-ID: <avV9qoaPMBLCNOXD@kernel.org>
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
 <990cc079-70ab-4fcf-9974-679aaf07849e@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <990cc079-70ab-4fcf-9974-679aaf07849e@redhat.com>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:02:05PM +0530, Mukesh Pilaniya wrote:
> Hi Mike,
> 
> On 04/11/26 10:20 pm, Mike Rapoport (Microsoft) wrote:
> > kexec_add_buffer() users may depend on the order in which memory holes are
> > searched. For instance, arm64 places the kernel bottom-up and then
> > requires the DTB to be above the kernel.
> > 
> > kho_walk_bootmem() walks the bootmem areas in the order they were
> > reserved, so if the kernel lands in a small area at the top of the memory
> > there is no room left for the DTB and kexec fails. For example, on an
> > arm64 VM with 2G of RAM and kho_bootmem=8M,64M,64M, the lowmem area is
> > reserved first at the top of the memory, the kernel image takes most of
> > it and kexec fails with
> > 
> >   kexec_file(Image): Could not find any suitable kernel location!
> > 
> > Sort the bootmem areas by address and walk them in ascending order, or in
> > descending order for top-down searches, like kexec_walk_resources() does.
> > 
> > Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 57 ++++++++++++++++++++++++++++++--------
> >  1 file changed, 46 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 6f1f55fe31819..2ac5d94f33fd4 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/list.h>
> >  #include <linux/memblock.h>
> >  #include <linux/page-isolation.h>
> > +#include <linux/sort.h>
> >  #include <linux/unaligned.h>
> >  #include <linux/vmalloc.h>
> >  
> > @@ -820,6 +821,14 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
> >  	return false;
> >  }
> >  
> > +static int __init kho_bootmem_cmp(const void *_a, const void *_b)
> > +{
> > +	const struct kho_bootmem *a = _a;
> > +	const struct kho_bootmem *b = _b;
> > +
> > +	return cmp_int(a->addr, b->addr);
> > +}
> > +
> >  /**
> >   * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
> >   *
> > @@ -904,6 +913,9 @@ static void __init kho_reserve_bootmem(void)
> >  	 */
> >  	kho_bootmem_cnt = i;
> >  
> > +	sort(kho_bootmem, kho_bootmem_cnt, sizeof(*kho_bootmem),
> > +	     kho_bootmem_cmp, NULL);
> This only covers the case where this kernel allocated the areas itself.
> On a KHO boot the array comes from the previous kernel. A kernel with
> this series that is handed over from one without it therefore keeps
> walking the areas in reservation order for every following
> kexec_file_load, and the arm64 failure you describe comes back until the
> next cold boot and vise versa because the ABI string is still
> "kho-v4".

If we were able to kexec from a kernel with no reservation ordering, the
issue is not there, isn't it?

And after a cycle of KHO boots to newer kernels we anyway can get to the
point when bootmem is not large enough.
 
> > +static int kho_bootmem_walk_top_down(struct kexec_buf *kbuf,
> > +				     int (*func)(struct resource *, void *))
> >  {
> >  	int ret = 0;
> > -	int i;
> >  
> > -	for (i = 0; i < kho_bootmem_cnt; i++) {
> > -		struct resource res = {
> > -			.start = kho_bootmem[i].addr,
> > -			.end = kho_bootmem[i].addr + kho_bootmem[i].size - 1,
> > -		};
> > +	for (int i = kho_bootmem_cnt - 1; i >= 0; i--) {
>
> kho_bootmem_cnt is unsigned, but the reverse loops in
> kho_reserve_bootmem() and kho_bootmem_walk_top_down() start an int
> counter at kho_bootmem_cnt - 1, which for a zero count is UINT_MAX
> converted to int.  That conversion is implementation-defined; with the
> current compilers it yields -1 and the loop body is skipped.

We never get here with kho_bootmem_cnt == 0.
 
> How about using this one.
> 	for (unsigned int i = kho_bootmem_cnt; i-- > 0;)
> 
> Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>

Thanks!
 
> -- 
> Regards,
> Mukesh Pilaniya
> 

-- 
Sincerely yours,
Mike.

