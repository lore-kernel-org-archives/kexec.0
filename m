Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4867CA0FED
	for <kexec@archiver.kernel.org>; Wed, 10 Sep 2025 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TisYwmvR90ER1jazweHvbvoeDDNC29k3gBI9kEQjEok=; b=fqHOPnpLO1XtfSU6kKreNvYXTG
	1guDRL2GFX8dIYkTFIfPmAJf8BN4TG7gD/PBhQTIVMaw/JXHbpe+j4bz7gb2fSt+DzQVkHTQj6tU7
	FkincdAsd+zODmaSUTmID4/hU+3hwFcsHZVFKvW/D+ECp4G5GYolCkOBjTOXwDiryPKO40ZfDi2og
	T5bXKC/2JoFG4+m7+5Sx25vozsvjPzCLCyQt//pjL7DmWwz/O1OpqgZwu0eqTYWcK6TxdRFe9vW+T
	BMejsSYFSUuxzNfhiHRGUPcRkQDYbKOQTUqFPq59+MSD1WgWPZzvPIJReyj7QyM2CQPVVWZovLqli
	n6rhOLCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwN7F-0000000FGRI-2YQI;
	Wed, 10 Sep 2025 15:52:13 +0000
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwN7C-0000000FGNU-49UW
	for kexec@lists.infradead.org;
	Wed, 10 Sep 2025 15:52:12 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 71AE6EC0456;
	Wed, 10 Sep 2025 11:52:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Sep 2025 11:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	yadavpratyush.com; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1757519527;
	 x=1757605927; bh=TisYwmvR90ER1jazweHvbvoeDDNC29k3gBI9kEQjEok=; b=
	MQ1jVJwOLKEK4TRtKuCZUWuuAQageX7JSvcKV/AAQjDLP1FOkBUGIxQeArtXOyvw
	RiCJOOQLE8dwH2yBZAmJUOZUH2cS8m0H8hQ0tq8RmBLEJ98dlLW+VO5WzwfTEiEp
	ZcHcL0j4TRgHRbzBPMVoXIN/TgUBSUkl0EwJIqNRU7bOY8hHPzRUQp5tomfYSYM4
	aaRy1m76V6CftjP7Er2hbHpueVeKDrzxiDB6gIEceqSRYYK3MlhkOMyHKszxkfLi
	RUbQ8ocKfpbnjZs4bPUh+x0Cqc6aVNmdHryM8Awp3jeJeLtIUlbZWLsONvCvHPyW
	mZCD/zorvOHIoYCH40mnnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757519527; x=1757605927; bh=TisYwmvR90ER1jazweHvbvoeDDNC29k3gBI
	9kEQjEok=; b=biG+FHOsup8r5uP8IEey1OrJpI5629ob7gPzDpQqOAtxnhL3Zr0
	lAYHLmLmOnkk/ZFWAy4flV1Zywb3xJ/C9lu8b58qrFjRd1jGE0FnuxDKv1eLqzEC
	LdNQpk67UX6aieSLbuXzA1Vg/QFxHGWYD0Ncs9fWOg5ffSWPr+e2foIt7hOvmQzy
	iLlzxsge5Wr1zuVQhZZPD8cgQf80LhnC8Hn+wf2wU+wIA3OsFlc8DTwywa9Wv8MO
	sEfliZTWg+RaFEbiBvoEfwFRHJ48CPhT4kQMt6cZzi73U66cwxwe/KmU+RdG2VXD
	ivj6MGO/UgwX/gij06eXHRG+djGwjM9eu7A==
X-ME-Sender: <xms:pp7BaKOFqY52w3lZOybWzINO3ENFBHOBl4cBomOTthhrWe4PrdUqzQ>
    <xme:pp7BaHfg7LePI0HEfWmF70EegQxkrN3FIH16nDhz1Qs3U6sgN8W0Qp7GkMEZZEBcj
    yWK80xxSLGCsqAdFlU>
X-ME-Received: <xmr:pp7BaMy7WN_9-GXpOn0pRXi8Q9lVHX5GEN0I4gRAYoByjs7OssS_3SPKgmZPxv2wyT4IYbQ_d0nVYjLqZuQ-oN4ZEFZM_2LMeoJyu6JvhNyhs7e0IjPCTdEhtDBDylClO-gMWbLx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefrrhgrthihuhhs
    hhcujggruggrvhcuoehmvgeshigruggrvhhprhgrthihuhhshhdrtghomheqnecuggftrf
    grthhtvghrnhepleejgfdufeffuefhiefghfdugeegieejudelgedthfeuudffheeugfel
    hfevvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgvseihrggurghvphhrrghthihushhhrdgtohhmpdhnsggprhgtphhtthhopedugedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrd
    horhhgpdhrtghpthhtohepkhgvgigvtgeslhhishhtshdrihhnfhhrrgguvggrugdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjrghsohhnmhhiuhesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheptghhrhhishhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjghhgsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehprghshhgrrdhtrghtrghshhhinhesshholhgvvghn
    rdgtohhmpdhrtghpthhtohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprg
    hkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:pp7BaE3RDLytsa2QtWwRt9RRI1nVOsBEmidFKrSV6h3zaLVCSt-7Iw>
    <xmx:pp7BaLfLXI8An1b0AqP9N5_8fMLlNdqhMGYiu_I6fX6GdOZu6vb0Cw>
    <xmx:pp7BaBW4-CrB3M9I16AqpIjPSXOniBsClKfdNAAulDJcszXWj21hbA>
    <xmx:pp7BaL9T2jEtjmUP7XxYzydsA-Me-77SLflDvRcsv8WP84tmxnRDrw>
    <xmx:p57BaIxU2zpoDgcYwn06gdAIZWSihVls11YMgzeC1z3eF4bswK9AsSHl>
Feedback-ID: i93f149c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:52:05 -0400 (EDT)
From: Pratyush Yadav <me@yadavpratyush.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Mike Rapoport <rppt@kernel.org>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Chris Li <chrisl@kernel.org>,  Jason Miu
 <jasonmiu@google.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
In-Reply-To: <aMGc-ExhkqwAyY_C@casper.infradead.org>
References: <20250910153443.95049-1-pratyush@kernel.org>
	<aMGc-ExhkqwAyY_C@casper.infradead.org>
Date: Wed, 10 Sep 2025 17:52:04 +0200
Message-ID: <mafs08qimjoez.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_085211_437298_9F344C2E 
X-CRM114-Status: GOOD (  17.68  )
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

On Wed, Sep 10 2025, Matthew Wilcox wrote:

> On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
>> +#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>> +
>> +/*
>> + * KHO uses page->private, which is an unsigned long, to store page metadata.
>> + * Use it to store both the magic and the order.
>> + */
>> +union kho_page_info {
>> +	unsigned long page_private;
>> +	struct {
>> +		unsigned int order;
>> +		unsigned int magic;
>> +	};
>
> KHO is only supported on 64-bit?

Yes. Currently only x86_64 and ARM64. It is mainly for hypervisor live
update so there isn't much reason to support it on 32-bit platforms.

>
>> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
>>  struct folio *kho_restore_folio(phys_addr_t phys)
>>  {
>>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
>> -	unsigned long order;
>> +	union kho_page_info info;
>>  
>>  	if (!page)
>>  		return NULL;
>>  
>> -	order = page->private;
>> -	if (order > MAX_PAGE_ORDER)
>> +	info.page_private = page->private;
>> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
>>  		return NULL;
>>  
>> -	kho_restore_page(page, order);
>> +	kho_restore_page(page, info.order);
>>  	return page_folio(page);
>
> This all looks very confused.  Before your patch as well as after it.
> I don't see anything in the current KHO code that requires the
> phys_addr_t to be order-aligned.

Right, good point. I can send that as a follow up patch. But I think
this patch stands on its own without that fix too.

-- 
Regards,
Pratyush Yadav

