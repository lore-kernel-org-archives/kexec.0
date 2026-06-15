Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471C8CD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GWS/64/tkYjcSZn0+hqm9aXVQVkFIYWRXsZULuD0LK4=; b=woj1HpQxxAIJJFv4UoVObyJ+EC
	hF/CPZJKH8gOTMqUynWHBXGs7iocrXSzyAspAKU0kuLDsTdLiOjper/7MCdBUR/NjDl8Nba/NN+CG
	uUlXsD4WTOO+unebXwxZFFexE0buJp/D69nLlhxH8wbm4zJOZ8shUdPPKaiqTjP0z6TSSSWlPrqPu
	KUHTPDOPN0CNwXuWSV5+7RpaiN2wwZgvTVPkMBSn1UV4OQnBGXTl40DY+urzk43OlsoaNi+nDFp3Z
	5UYM4Y9Npx7lZ0DtYvjSZBJ0m3ZSEil/ypotDxVWIBYHvTB8hHCslV1ePWdUz0ZwabdKegJ5ZZIW5
	vTegIT3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7Dl-0000000EHdm-0vj1;
	Mon, 15 Jun 2026 13:19:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7Dh-0000000EHdH-2WZV
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 13:19:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EFBA26008A;
	Mon, 15 Jun 2026 13:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00701F000E9;
	Mon, 15 Jun 2026 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781529556;
	bh=GWS/64/tkYjcSZn0+hqm9aXVQVkFIYWRXsZULuD0LK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Mf/t1n2ddz2qMaxadwsFp4vho15rywK7816pf4mxJrKsZhDJ0TvwIs+YKd4J4Q2u/
	 qvbkqn2IOmk0OKNkeA8coBYRcA2K6hn72O3Tmh9L3O6usnClSS7F5aVuPLCl86nMs2
	 7/MYCDStyI5jPgMsz02xpx0/6Zw1ydzTFK1+6PrPlbuY5NcY1f7Nxw3BuU8vzSQQcK
	 L2svRO0qN2C85ojeMSMlvJ0zhaHTOlBGhE+Z6sH4oViQcE9NO+ZLBb9Gtlla0AFPu/
	 eGkWfxluf1yr2bJ3AE7TtxQI/BI5hJ0j0FpAmmba4mT98cEpzthtGkDbl0Dn5WvI7d
	 Dk7H1D/mh07Dw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] memblock: use kho_scratch_overlap() to decide
 migratetype
In-Reply-To: <178143855115.2123877.12922508735700031761.b4-review@b4> (Mike
	Rapoport's message of "Sun, 14 Jun 2026 15:02:31 +0300")
References: <20260605183501.3884950-1-pratyush@kernel.org>
	<20260605183501.3884950-15-pratyush@kernel.org>
	<178143855115.2123877.12922508735700031761.b4-review@b4>
Date: Mon, 15 Jun 2026 15:19:13 +0200
Message-ID: <2vxzy0ggosa6.fsf@kernel.org>
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

On Sun, Jun 14 2026, Mike Rapoport wrote:

> On Fri, 05 Jun 2026 20:34:47 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 5afcd99aa8c1..546d7ef798b8 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -618,7 +619,7 @@ bool memblock_is_kho_scratch_memory(phys_addr_t addr);
>>  static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
>>  						       enum migratetype mt)
>>  {
>> -	if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
>> +	if (kho_scratch_overlap(PFN_PHYS(pfn), pageblock_nr_pages << PAGE_SHIFT))
>
> I'd move it to kexec_handover.h and kill
> memblock_is_kho_scratch_memory() in the same patch
>
> BTW, please double check that the extended scratch does not require
> updates to efi_init()::reserve_regions().

It does not. efi_init() happens in setup_arch() on both x86 and arm64.
The extended scratch is discovered after setup_arch(), in
mm_core_init_early().

But I do think this is worth a comment since the interaction is not
obvious at all.

-- 
Regards,
Pratyush Yadav

