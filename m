Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A7ED116F3
	for <kexec@archiver.kernel.org>; Mon,  1 Dec 2025 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5S7rehuYscd/hErv8J5+olzkbmCgkfxJ3MreqUx/Zmo=; b=4H0ZKP3gbCdAOX1v3kcGN9AYPu
	xJcuVTOSnPQzzGGSLoGlYGvvpA39SnsHWOjbs25qEBkqqgECuUgRTFq+dtEsRyMPcseQL+gxYLjUO
	rq56h+Hjs6WZCxj17OOAcadJKW3a1JIgWv931Ev7lZuwCsAAkNwxOZl55CIt11+kh0G/9M2oIuXnl
	dYf/MW5VzkizxymX2nxWsAUXnkyVvVuxhU7AXvJDFhNxGU9qlNOV6Nh9Jbgf8eP7erKUI41OWyqk/
	pihOaaoSkWXBtupaGVGL+N1VvPSFU1AvPg81WA6uhNlbLwrq1ZbJ0lVz4RuSVLzFXIJILnZGSyyum
	mWnq0BtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ42Z-000000040s3-3AQy;
	Mon, 01 Dec 2025 13:34:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ3s1-00000003rx8-3wT0
	for kexec@lists.infradead.org;
	Mon, 01 Dec 2025 13:23:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E9B296001D;
	Mon,  1 Dec 2025 13:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37675C4CEF1;
	Mon,  1 Dec 2025 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764595392;
	bh=/5hgmbNcBuxVVJJcYDy7YeTK1UEsFT0pKtlTdyuekFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cqxUaKnE+6gErEu/ml7xQrLCDayT1lGoVeW+FyRqEBgt4BU85HzSBSkUzkCD/+jEF
	 ho5xpl3kOJ958YyyK/XrrbdbajYrOBAqLuR7wft337hLePDckCAlatmd6MOQ4r9Am/
	 XJ7sxb1WcR5HGlxtU7X9u0xuB7gmYo1Ivb+qmndiJgIJws3GobRae5/vxPXLRS0faf
	 MWVSL0+2tP06OZYoPc9xN2Jk5Ubw5jfd0ACuqDgSxcMyM1BZAOsYziU8FSTr/liGU4
	 wtdMN+XanBsT4Fg/MwzvHjsE+46k2nOOa4hrgRxW8dcNxi6Iqw1+E0C4odvn6t+ofA
	 aq3YfXg/D7NbQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kho: fix restoring of contiguous ranges of order-0
 pages
In-Reply-To: <aS07racwRsh4ep_L@kernel.org> (Mike Rapoport's message of "Mon, 1
	Dec 2025 08:54:37 +0200")
References: <20251125110917.843744-1-rppt@kernel.org>
	<20251125110917.843744-3-rppt@kernel.org> <mafs0pl96w7hk.fsf@kernel.org>
	<aS07racwRsh4ep_L@kernel.org>
Date: Mon, 01 Dec 2025 14:23:07 +0100
Message-ID: <86ms42mj44.fsf@kernel.org>
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

On Mon, Dec 01 2025, Mike Rapoport wrote:

> Hi Pratyush,
>
> On Tue, Nov 25, 2025 at 02:45:59PM +0100, Pratyush Yadav wrote:
>> On Tue, Nov 25 2025, Mike Rapoport wrote:
>
> ...
>
>> > @@ -243,11 +243,16 @@ static struct page *kho_restore_page(phys_addr_t phys)
>> >  	/* Head page gets refcount of 1. */
>> >  	set_page_count(page, 1);
>> >  
>> > -	/* For higher order folios, tail pages get a page count of zero. */
>> > +	/*
>> > +	 * For higher order folios, tail pages get a page count of zero.
>> > +	 * For physically contiguous order-0 pages every pages gets a page
>> > +	 * count of 1
>> > +	 */
>> > +	ref_cnt = is_folio ? 0 : 1;
>> >  	for (unsigned int i = 1; i < nr_pages; i++)
>> > -		set_page_count(page + i, 0);
>> > +		set_page_count(page + i, ref_cnt);
>> >  
>> > -	if (info.order > 0)
>> > +	if (is_folio && info.order)
>> 
>> This is getting a bit difficult to parse. Let's separate out folio and
>> page initialization to separate helpers:
>  
> Sorry, I've missed this earlier and now the patches are in akpm's -stable
> branch.
> Let's postpone these changes for the next cycle, maybe along with support
> for deferred initialization of struct page.

Sure, no problem.

[...]

-- 
Regards,
Pratyush Yadav

