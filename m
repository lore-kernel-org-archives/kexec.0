Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44BBC5CFCF
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 13:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OenMr5nT85sI6+yUZ5su20Q5jfaEjzyJzi9hJtpz57s=; b=qvfouqRGNhoLMEtuia49Bzhiz5
	yXxhB3SFb599NMhF/CFwj5Go/vf8iCZNN04Cv0MdQhY6YYurKAIATen07dNWT9cWFUQwgl6cIPj4y
	T05Ld+ZiH3pUGdpSQjjUxG7aerN0zzoFaiMjlLq5L+U1Bzj/IyX7XiOlPvfjXJ30EwOVh8CuCHkPr
	fYBChFH44aa+5w2FB1PMroUfQ2PyYFciJR1VI3DqlB+F90EDkgBXOHACLlpDhJ+jZe401DgdvbIef
	kvTbQX1Svb4E0gGt/YnwoY9sCjyM07Pfz7OZPzSL/0Tw1oDoEIN3q+ndmq8aNy2RuUCHPBHgDXVbj
	han6p8VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9Kd-0000000GK8m-1FlD;
	Wed, 12 Aug 2026 13:49:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9KX-0000000GK79-02qm
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 13:49:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A0F6360A9E;
	Wed, 12 Aug 2026 13:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9664D1F000E9;
	Wed, 12 Aug 2026 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786542543;
	bh=OenMr5nT85sI6+yUZ5su20Q5jfaEjzyJzi9hJtpz57s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UexFnpIWk2+YiBJrt9VA2Sfiyzo5Isjw4CnK/CaYnaL2+bfwDCWo7W7E1fiiHF6bt
	 NTBmKRKR2t20kh915uCjvT6d2N1ALd3LLMhii3XVXwSAYBYYoyYEukDPCAldIAf4vC
	 sEHEObdblFY4n+akVftR4rtv4qfB3ZSFuSROdY4gQ97JnRWwbMtamPLobUoM9FYUQY
	 SWpAc1UtsLTNSBn/HA5nd92QIvNPIGFU3EdPkhcSwama+ZcyD4fijjoSsJQE3Mt+3n
	 frnZA5FzMSQWct/bezhFsRc1DKWbD8pb6l2s01bXo9zvXWRJMMZpHvWJur6a7N1IPe
	 JFnGvrKJyIeFw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Alexander Graf
 <graf@amazon.com>,  Samiullah Khawaja <skhawaja@google.com>,  David
 Matlack <dmatlack@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] kho: Introduce preserve/restore APIs for
 high-order pages
In-Reply-To: <anxrM6HPKPq74So3@google.com> (Pranjal Shrivastava's message of
	"Wed, 12 Aug 2026 12:46:43 +0000")
References: <20260803113944.3694290-1-praan@google.com>
	<20260803113944.3694290-3-praan@google.com> <2vxzmrur3880.fsf@kernel.org>
	<anxrM6HPKPq74So3@google.com>
Date: Wed, 12 Aug 2026 15:49:00 +0200
Message-ID: <2vxza4qr30vn.fsf@kernel.org>
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

On Wed, Aug 12 2026, Pranjal Shrivastava wrote:

> On Wed, Aug 12, 2026 at 01:10:23PM +0200, Pratyush Yadav wrote:
>> On Mon, Aug 03 2026, Pranjal Shrivastava wrote:
>> 
>> > The current KHO page preservation APIs (e.g. kho_preserve_pages) assume
>> > that multi-page blocks are split into independent 4KB pages during
>> > restoration. This is incompatible with high-order non-compound pages,
>> > such as DMA buffers, which must be restored with tail pages having a
>> > zero reference count.
>> >
>> > Introduce explicit preserve and restore APIs for high-order pages,
>> > which preserve and restore a high-order page block as a single unit,
>> > applying a refcount of 1 to the head page while leaving tail pages at 0.
>> > Rename the existing internal helper to __kho_restore_page() and
>> > consolidate the common restoration code into it.
>> >
>> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
>> 
>> The code here looks very convoluted TBH. I think it will be simpler to
>> make kho_restore_page() only return non-compound pages. That is, it
>> returns 0 or higher order non-compound page.
>> 
>> Then kho_restore_pages() can call kho_restore_page() and then do
>> split_page() on the page it got to turn it into 0-order pages.
>> kho_restore_folio() can call kho_restore_page() and then do
>> prep_compound_page() on the page it got.
>> 
>> And then you expose kho_restore_page() to be used by DMA APIs to get
>> non-compound high order pages directly.
>> 
>> How does that sound?
>> 
>
> I like the suggestion to use a single base primitive and mold it via
> split_page() and prep_compound_page().
>
> However, To implement this, we'll need __kho_restore_page(phys, &order)
> as the internal base primitive because callers (like kho_restore_folio)
> need to retrieve the order from the KHO metadata to pass into 
> prep_compound_page(), and a raw non-compound struct page doesn't store 
> its order.

Oh, right. I didn't think of that.

>
> By having __kho_restore_page() initialize the head_ref = 1 & all_tails
> =0 refcount pattern by default, all three public APIs can just wrap it
> and call the appropriate MM subsystem helpers. I'll spin v5 with this

Makes sense I think.

-- 
Regards,
Pratyush Yadav

