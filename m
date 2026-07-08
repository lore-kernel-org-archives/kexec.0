Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F97C43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 17:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5fSGtkNEGdJxANrrlZw1luedfmF/LGhVw9H890AiSnE=; b=K5x75izFG1K2p1JkM3tC6ZOPt4
	oaSZRRxfYfnWJOsEEZ7sbzwbLWl2TEwwoM5iyrEdzJdQdeptJoWXXjMMn8Zm4BAPaYnmDlXLPAwND
	li2N8SIYqEbzFYI3WMQsFsEBCRfMx5tBKJR2EIgv2H5SYbQcg+ApnOdAe6DT9weEdsb6Wfx3r4JhG
	+gJojxnfliKi2h+ZiD4FcHhWejaQfWEfqzRKGAA2t4HJYgvOoItYBlTtIu5ufsPyEbKJdHeUgsi2l
	ZnAUfjp675ulXPfDbB+jrmfLl1sP26uY6SGg96OzJFH8FC6x4OQfILsFWqN0Yf9zovio5n0+POhFR
	FCDjxhMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWCf-000000007eG-1CjM;
	Wed, 08 Jul 2026 17:36:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWCe-000000007e8-0Ufr
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 17:36:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C517043E0C;
	Wed,  8 Jul 2026 17:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EDD1F000E9;
	Wed,  8 Jul 2026 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532215;
	bh=5fSGtkNEGdJxANrrlZw1luedfmF/LGhVw9H890AiSnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Gohq4OmT54oQiAuRoLb3+AblPONF5BBrRakh7lEgmSJpw7I2O2cLzUsk1lM78uViP
	 r6t6AAns0U/YDRxnaXlZ3nD1aLEo8mNSLBW01efYwPVLbv9+1LdHOLEWXY5f3c2BRh
	 YRL8BnFIk0/4ULGjgz0nRJsZm186Zx3sk0gFWLEJtOE2RdHUFGgQ7KKFtUYltyp/Zu
	 WqLwKT/a2IGKwhB25jKKzmx34d/38fB4oIewM1/EOdumMklrLSrUYAr2RDpwRBPnGi
	 E6jYb0IRAPMvUVfL28Bn3y3y+dbWX3Hbr6Ka+Ws7YdJs+PAGnrTdcB8lS5qctfYo/2
	 4mpAZ+C9oXvEQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Alexander Graf
 <graf@amazon.com>,  Samiullah Khawaja <skhawaja@google.com>,  David
 Matlack <dmatlack@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
In-Reply-To: <ak6CxVty3O5Ib7q4@google.com> (Pranjal Shrivastava's message of
	"Wed, 8 Jul 2026 17:03:01 +0000")
References: <20260703020832.1731864-1-praan@google.com>
	<2vxz7bn5mv0n.fsf@kernel.org> <ak6CxVty3O5Ib7q4@google.com>
Date: Wed, 08 Jul 2026 19:36:52 +0200
Message-ID: <2vxztsq9l6x7.fsf@kernel.org>
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

On Wed, Jul 08 2026, Pranjal Shrivastava wrote:

> On Wed, Jul 08, 2026 at 04:11:04PM +0200, Pratyush Yadav wrote:
>> On Fri, Jul 03 2026, Pranjal Shrivastava wrote:
>> 
>> > This series is required for the ongoing effort to preserve DMA allocations
>> > across KHO [1]. It addresses a fundamental mismatch between the current KHO
>> > restoration logic and adds support for high-order buddy allocations.
>> >
>> > The Problem
>> > ===========
>> > The current KHO restore implementation treats all multi-page blocks as 
>> > split pages during restoration, i.e. kho_restore_pages() initializes 
>> > every 4KB page with a refcount of 1.
>> >
>> > However, many kernel subsystems, most notably the DMA allocator (via
>> > dma_alloc_coherent), frequently return high-order non-compound pages. 
>> > In this unsplit state, only the head page carries a refcount of 1, 
>> > while all tail pages have a reference count of 0.
>> >
>> > Consequently, when these contiguous but unsplit blocks are restored by 
>> > KHO in the new kernel, the forced refcount of 1 on tail pages causes some 
>> > trouble with the buddy allocator. Downstream of the eventual free path
>> > the __free_pages_prepare() [2] ends up calling page_expected_state() [3] 
>> > when is_check_pages_enabled() returns true (only when CONFIG_DEBUG_VM or
>> > debug_pagealloc=on).
>> >
>> > This detects the non-zero refcounts on tail pages [4] and incorrectly
>> > taints the kernel while leaking the pages in question.
[...]
>> >
>> > 4. A new helper, kho_split_preserved_pages(), is provided for subsystems
>> >    that may need to split memory after it has already been preserved.
>> 
>> Umm, that sounds scary... Why do you need to do that? What's the use
>> case? Why is the driver reconfiguring its memory after preservation? I
>> assume these are DMA buffers, so why do they suddenly look different?
>> 
>> And in either case, why does KHO need to do the split? Why can't the
>> driver unpreserve old preservation, then split the pages, and then
>> preserve the new ones?
>
> Ack. I was trying to cover up an edge-case I guess but if we're simply
> moving to an explicit restore API none on this would be needed.

Even with an explicit restore API, I'd say it would be a bad idea to
preserve using one API and restore using another. The driver really
should be unpreserving and represerving. And even that if it really has
to.

-- 
Regards,
Pratyush Yadav

