Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF34CD8CAA
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yAwQzCcKV6xIGEtBzqxQ3COTqDOfT90qmmiQBuBzWZU=; b=cCEg3VZdN3gPJ3oZBOiZ6GZJK4
	TdYZuI2Lp16+eJ6uWhu0DtmV4XMlPSLUOjtrGHCgzjuAEF6IuJBddQF6P50Ve/mDcaupH72GWQUcF
	GIdGL9Bm6OOm2gO57x5i4H28w5IVSN0JGoUJFN/vI8aiTr6WHoUhKwUd8A7y033WcUv46Eey/Ba8L
	6EunWH5h+PRLCmqAhNZGTpE497Ej/cvU5Lkxnq5pHeUJf44d7Wfod56nuAzfHW9uxuMG3wv+bMNmY
	bFMJLEKIl33lx7uQc8xCFaHd/5pNZC3wwcRhMAMz8vJCNpjTqAtdMhthpw0pPErRXZLmx0JrMr2MN
	NVg8y3Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxWJ-00000005mve-07l9;
	Tue, 09 Jun 2026 14:33:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxWH-00000005mvQ-0AfN
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 14:33:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B199E435AE;
	Tue,  9 Jun 2026 14:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4439C1F00893;
	Tue,  9 Jun 2026 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015612;
	bh=yAwQzCcKV6xIGEtBzqxQ3COTqDOfT90qmmiQBuBzWZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jR6h5cLRTujiltPSm689nN920+3X6yo5OD4R884+TkTANE/D6veFgcNFK8J9g6K2Z
	 OK4at4p99jOAG8zdRm8aWzewXlItlUeUEUh4JkkNSplo/jRskZZ7h9b8BE80utgoTy
	 bLGqLeqXxHFzP92wW/MtMiSWEXdUaJPdXhHOz2+E+Ay4Hm8rGEzjykfbW2yqIX1ItT
	 DXJ1F54Fyvux8kMJiS9ZauKV9V5vnjHC4ZC7fKP1PnC/Ht0w1fWeGT4xRMewWcwo5e
	 xK4sOtVyJOp8m4bnjyXthx/HCjrBBH6toZ87zTvyau3Fy/kYJFCwBdBOKl2G/rEO9B
	 +BP2y6GDEmaMA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>,  linux-kselftest@vger.kernel.org,
  shuah@kernel.org,  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  jasonmiu@google.com,  linux-kernel@vger.kernel.org,  corbet@lwn.net,
  ran.xiaokai@zte.com.cn,  kexec@lists.infradead.org,  pratyush@kernel.org,
  graf@amazon.com
Subject: Re: [RFC v1 0/9] kho: granular compatibility and header decoupling
In-Reply-To: <aidnjw5pH_z45gJT@plex> (Pasha Tatashin's message of "Tue, 9 Jun
	2026 01:14:53 +0000")
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
	<178083348872.1648214.17778188633648887952.b4-review@b4>
	<aiVp5RlbWRz5VnPB@plex>
	<178091437240.1648214.10761111570005003901.b4-reply@b4>
	<aibYJvzQQnpoN6YW@plex> <aicF5Sa11B4ujfSa@kernel.org>
	<aidnjw5pH_z45gJT@plex>
Date: Tue, 09 Jun 2026 16:33:28 +0200
Message-ID: <2vxzjys7ss07.fsf@kernel.org>
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

On Tue, Jun 09 2026, Pasha Tatashin wrote:

> On 06-08 21:11, Mike Rapoport wrote:
>> On Mon, Jun 08, 2026 at 04:12:56PM +0000, Pasha Tatashin wrote:
>> > On 06-08 13:26, Mike Rapoport wrote:
>> > > On 2026-06-07 13:43:09+00:00, Pasha Tatashin wrote:
>> >
>> > Keeping all of that in a single KHO file is the wrong approach and goes 
>> > against how other logically separated subsystems in Linux are organized 
>> > (e.g., mm/vmap.c, mm/vmalloc.c, etc.). Yes, there are some messier 
>> > places in the kernel as well, but keeping this in its own dedicated 
>> > kho_vmalloc.c file makes complete sense to me.
>> 
>> Either I hallucinated or b4 ate a paragraph from my reply ;)
>> 
>> Regarding the code movement
>> - splitting radix tree makes perfect sense to me, just the documentation
>>   part needs more care than mechanical move

+1, separating radix and KHO block makes sense.

>
> Agreed. I'll also pay closer attention to the documentation.
>
>> - I'm fine with abi/vmalloc.h, presuming KHOSER_PTR() is not part of it
>
> Yes, I will move KHOSER_PTR() to the shared compat.h in v2 so it's not 
> tied to vmalloc.
>
>> - I can live with kho_vmalloc.c although I still consider it unnecessary
>>   churn
>
> Appreciate it.
>
>> - I'm against moving vmalloc APIs from kexec_handover.h because they are
>>   very close in nature to folio and pages. I don't see core KHO as
>>   responsible for preserving physically contiguous ranges but rather as
>>   preserving allocations. Not sure we'll ever support kmalloc(), but still.

FWIW, I agree with Mike here. I also see kho_preserve_vmalloc() as a
memory preservation primitive, same as kho_preserve_folio() or
kho_preserve_pages(). So I think it belongs in the main KHO header.

I also think it would also be nice to have vmalloc in kexec_handover.c,
but I can live with either way.

>
> That is a very reasonable compromise. I am fine with keeping the 
> consumer-facing function declarations in kexec_handover.h so they remain 
> grouped  with folios and pages.
>
>> > However, overall enforcing the use of KHOSER is unrelated to this work. 
>> > I have my own thoughts on this, and perhaps with proper versioning, 
>> > using KHOSER_PTR everywhere would be appropriate, but let's keep that as 
>> > a separate work.
>> 
>> This is a separate work, indeed. But regardless of the versioning it's
>> already better than plain u64 because it provides type safety.

It would be even nicer to have some sort of type safety for KHO vmalloc.
On preservation and restore, you lose the the type of the array, and it
is very easy to make mistakes. I gave it a try some time ago but
unfortunately couldn't come up with anything good.

-- 
Regards,
Pratyush Yadav

