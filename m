Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B78EC79F9F
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kNyABl3CZEW2VceQ9RPkhr81c66ogdLDFwy8ZLemQBA=; b=ZZz4VI+G1mEv7Of48sMUiZhblR
	nKUtIHHZmzkq2UEEr1N33efq0xGflJCpNXav+d9URD4xIrtjPf/6WCeAhFgtGtoq9eAagWryiYrDw
	KmJi/dqiOCUKS1xlbfttqQ6CUiGkFar02zUmRuG7EBSTY9mbYYu7U8nJjY1iBpTc+PBYb0p5SIPMc
	+lj0YbysoIAbVFvgFeIjM3e4W+yoJBBX/lCbteZ2QcIosmKOH8BSxKvGRVORqbUT8TVYV96krEHvK
	3kDMaUNlbLDZQmUWxqVG7Mxmg2hNJPy2P55y5xqWMqYIe7kB2SXKk2aEuMOmOp5/4q5OY82FFGuhy
	ZrzFhNUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4eZp-0000000ERfq-3DlJ;
	Thu, 10 Sep 2026 13:12:29 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4eZn-0000000ERfG-1D8f
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 13:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kNyABl3CZEW2VceQ9RPkhr81c66ogdLDFwy8ZLemQBA=; b=AuqZrEh/loPwu80xoo+6bFKkEq
	D6bmTxKs6ubIzvlQLl6ThDG3wDMZZmUNKuNnHTkItBlmAFUBBN/Pnk5cX8FViRxsGwizxtujk1/mO
	/BqoKI/sTi5zF2MRq9wUXR2K3bqUKC3ujAzlrBvPnMwhmV6Isz7sUSBU0qULx1hOzj2ZpTuQ+qqR6
	taU/sjiiLY39JDGLcN5Q6Ux6mxw6A0JgJu/H456kgzTzNX1r26Ogi4u7JfELMyAGRKufRQD9eXZlJ
	JFXG0fLOR1FwHdLSDNtwKtVbMd4i04PUi2uO0SFy/nP7GRIsXioBCLJJuABTsbQJWIwb3P8J1D1pZ
	q2iks6CA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4eZN-000XBL-1U;
	Thu, 10 Sep 2026 13:12:02 +0000
Date: Thu, 10 Sep 2026 06:11:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, harry@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 2/5] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
Message-ID: <aqKhgPKzRf0e22s3@gmail.com>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
 <2c9a7bef-3189-4f78-a6cb-61d2f7afd643@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c9a7bef-3189-4f78-a6cb-61d2f7afd643@app.fastmail.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_061227_334454_FBE62348 
X-CRM114-Status: GOOD (  23.61  )
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

Hello Ard,

Thanks for the feedback!

On Wed, Sep 09, 2026 at 04:47:27PM +0200, Ard Biesheuvel wrote:
> On Wed, 9 Sep 2026, at 15:05, Breno Leitao wrote:
> > A EFI config table can only be installed while boot services are still
> > up, so the stub has to create it; the running kernel can only flip bits
> > in a table that already exists.
>
> This is true, but that also means a config table could have a 'next' field
> pointing to an allocation that was added later.
>
> There is a EFI memreserve table based on this principle: this is a hack
> that we added for the arm64 GICv3 LPI table handling, which is a braindead
> piece of kit that must use the same physical allocation as the previous
> kernel. It is not currently enabled on x86.
>
> Please consider whether or not that is more suitable, and can be repurposed
> or shared. (Feel free to make changes to the current format if needed).

That's actually what I tried in the RFC. I passed an almost-empty EFI
table, then built a linked list of poisoned pages on top of it.

It looked like this:

	struct linux_efi_poisoned_memory {
		int		size;			// allocated size of the array
		atomic_t	count;			// number of entries used
		phys_addr_t	next;			// pa of next struct instance
		struct {
			phys_addr_t	base;
			phys_addr_t	size;
		} entry[];
	};


The allocation walks that list the same way; see
efi_hwpoison_record_pfn() in patch "[PATCH RFC 2/3] efi: record hardware-poisoned frames into the poisoned-memory table"

This is the RFC patchset:
https://lore.kernel.org/all/20260717-hwpoison-kho-v1-1-9c5eda551998@debian.org/#t

> I don't have a strong preference either way, but I feel the 2M granularity
> may be a bit wasteful, no?

Maybe. It's the same trade-off as unaccepted memory: reducing the
granularity means growing the bitmap.

We can reduce the granularity, but I don't think we should reduce the
granularity if we're going to KEEP using a bitmap.

So I'd say we have two options:

1) Keep it similar to unaccepted memory, with 2M granularity.
   - Pro : Similar mental model as unnacepted memory
   - Cons: 2 MB might be a bit wasteful 

2) Move to a linked list like the RFC, keeping it outside of the EFI
   table.
   - Pro: Reduce the memory granularities to page instead of 2M blocs.
   - Cons: Another way of passing memory information between kexec
     kernels.

Any any other option or strong preference?
--breno

