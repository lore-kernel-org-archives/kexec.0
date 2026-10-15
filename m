Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F53CCA462
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8xIcAcbBHZy1mi8Rb1UegUyeiD956DGbti3HZCArR0=; b=uBSpebWtfNEWqEtp6qz4pLBVl8
	Au9m6hQfRRAXKnfZA0sU6y28/A+uHyYWVImC9Z5mpn7D1mGt5BaIkGM/G3czobeo02RfDeNGi/NYK
	l3LXNR4fvJNoDvhW8l7PVj7VXK4NsWrjZsVrxlsULcLDgnetQVBEBZqRw66idI7nosKHmcdcUa7KA
	qeqskVOBbHeFisgDuIRys0broqmIT6k/G3MblwUDrNkya4bGmtmNOI/0a4lzKAOHXfz6y6gZ8IROR
	H7GXuPk/slgh+eBnAuDZa1chQb0ezF5tEXpCy+wivHOhcjh2qSh6Tqr4ZmQEhK9K0yFqhdR/ya6vM
	b2yNxNaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHUCS-00000001VPs-2A2l;
	Thu, 15 Oct 2026 22:45:24 +0000
Received: from mail-ej1-x645.google.com ([2a00:1450:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHUCQ-00000001VPU-2Pq8
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 22:45:23 +0000
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c25edb54d22so700721266b.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 15:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792104320; x=1792709120; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C8xIcAcbBHZy1mi8Rb1UegUyeiD956DGbti3HZCArR0=;
        b=g5U3/8CUOc5ADCxSxFiPEK7JeGrLDyQobyreiEDxGwmQcj39sp6h3pYMKqJ5LV4hFY
         CtohkjfFfh502t7/k7rAfoaHbZQ80WjUFGUtRyJfO6N/ayIiuRT3j2moGdWko8e8SXQ5
         GrB9SM16E60CGMkkYKVi4rPZ4fEGo3IbY51+MuvSyn+TSPhO8tyNIcGA0msBOzS2uS6x
         o5TPhgH3cdB9OGbBFfXBbDunUkQwh8NcavOqobxDjMLWO98k3s0uj90Mx6Sy9Jhnhjx8
         5TAetdOqltKl82rfIj6DPihTTeBpd5BEyXsKf26e60XXVsVjA6HkFRie3xuFKfMwB1mp
         GmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792104320; x=1792709120;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C8xIcAcbBHZy1mi8Rb1UegUyeiD956DGbti3HZCArR0=;
        b=hQcPPIpLybcSJcuxhgbC27eJx3JotDT0WHepIkXcajxGDIIIVQ1oyWgVfAu8Yi2xZl
         i2AYk0+lATgCprO6p4lbmqsNpK4iMoSF/eBGkG5MJ1fYJF+jKvkx5DecrsfscpfmVSgU
         6iFERarRFNGI9QY/+dBXm4DL2irizwgn8oLshA2181txR5UNym1xExsT8DJrcDvURW/3
         /SNvAfMou3hWk9k5K55dNEkKo40FMAlZcj3MZGgIpfxXb+P5TKmTOm+2Q3hMDhIGajQH
         Dcx04LKVpS/aJb2+C2HZ0GzyBE5CcfNsLCncRORhbo3MDvM2Dghm+F7y3KYXnVP6jAoD
         CqmQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7bwPPU44xLtucqnbMPipJ//CJsR9FyLEXXPTAv/9e8vgco+OYdeNecyjxypXFHGzvE9aEBA==@lists.infradead.org
X-Gm-Message-State: AFq9FYKto2rxVxHU6N+jKpi5wVN6tfDzZAki8HNhUahi7poTyX7Vg2vA
	3s0eg5Ht+YPd04/OnAtACjmoTJm1RtGOLROWfXu8jmWx7dxks9xelVp6qmluJe26PVXLLnPr7cx
	PdJtLN9S/G1LwE6hVuA==
X-Received: from ejyb15.prod.google.com ([2002:a17:906:834f:b0:c39:4b00:1781])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9801:b0:c25:504a:1e25 with SMTP id a640c23a62f3a-c31a9fcf521mr1847005866b.13.1792104319385;
 Thu, 15 Oct 2026 15:45:19 -0700 (PDT)
Date: Thu, 15 Oct 2026 22:45:18 +0000
In-Reply-To: <atB1uG8kLfmZyLIH@kernel.org>
Mime-Version: 1.0
References: <20261008190828.3221718-1-tarunsahu@google.com>
 <as4EcgiBH5jjww42@kernel.org> <9huzecdt633e.fsf@tarunix.c.googlers.com> <atB1uG8kLfmZyLIH@kernel.org>
Message-ID: <9huzo6cuinwh.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 1/2] memblock: drop for_each_memblock_type() and open
 code its users
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: dmatlack@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_154522_633301_66DF00E7 
X-CRM114-Status: GOOD (  23.37  )
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

Mike Rapoport <rppt@kernel.org> writes:

> On Tue, Oct 13, 2026 at 03:18:45PM +0000, tarunsahu@google.com wrote:
>> Mike Rapoport <rppt@kernel.org> writes:
>> 
>> > Hi Tarun,
>> >
>> > Please for the next time add the cover-letter when sending more than one
>> > patch.
>> 
>> Thanks Mike for piking up the patches.
>> 
>> Sure, I will take care of adding the cover-letter.
>> 
>> You had some nit change suggestion, Let me know if you want
>> me send v5 or it is alright.
>
> I fixed some of it when applying and some right now, no need for v5

Thanks Mike!

>  
>> ~Tarun
>> 
>> 
>> >
>> > On Thu, Oct 08, 2026 at 07:08:27PM +0000, Tarun Sahu wrote:
>> >> for_each_memblock_type() always starts the iteration at index 0 and its
>> >> body is a trivial 'for' loop, so it hides very little. It also gets in
>> >> the way of iterating from an arbitrary index, which the next patch
>> >> needs.
>> >> 
>> >> Remove the macro and open code its three users: memblock_add_range(),
>> >> memblock_isolate_range() and memblock_dump(). While at it, move the
>> >> region pointer into the loop body scope.
>> >> 
>> >> No functional change.
>> >> 
>> >> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>> >> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> >> ---
>> >>  mm/memblock.c | 17 ++++++-----------
>> >>  1 file changed, 6 insertions(+), 11 deletions(-)
>> >> 
>> >> diff --git a/mm/memblock.c b/mm/memblock.c
>> >> index f5aaa38cfa31..59dda7d085f3 100644
>> >> --- a/mm/memblock.c
>> >> +++ b/mm/memblock.c
>> >> @@ -155,11 +155,6 @@ struct memblock_type physmem = {
>> >>   */
>> >>  static __refdata struct memblock_type *memblock_memory = &memblock.memory;
>> >>  
>> >> -#define for_each_memblock_type(i, memblock_type, rgn)			\
>> >> -	for (i = 0, rgn = &memblock_type->regions[0];			\
>> >> -	     i < memblock_type->cnt;					\
>> >> -	     i++, rgn = &memblock_type->regions[i])
>> >> -
>> >>  #define memblock_dbg(fmt, ...)						\
>> >>  	do {								\
>> >>  		if (memblock_debug)					\
>> >> @@ -615,7 +610,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>> >>  	phys_addr_t obase = base;
>> >>  	phys_addr_t end = base + memblock_cap_size(base, &size);
>> >>  	int idx, nr_new, start_rgn = -1, end_rgn;
>> >> -	struct memblock_region *rgn;
>> >>  
>> >>  	if (!size)
>> >>  		return 0;
>> >> @@ -651,7 +645,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>> >>  	base = obase;
>> >>  	nr_new = 0;
>> >>  
>> >> -	for_each_memblock_type(idx, type, rgn) {
>> >> +	for (idx = 0; idx < type->cnt; idx++) {
>> >> +		struct memblock_region *rgn = &type->regions[idx];
>> >>  		phys_addr_t rbase = rgn->base;
>> >>  		phys_addr_t rend = rbase + rgn->size;
>> >>  
>> >> @@ -815,7 +810,6 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>> >>  {
>> >>  	phys_addr_t end = base + memblock_cap_size(base, &size);
>> >>  	int idx;
>> >> -	struct memblock_region *rgn;
>> >>  
>> >>  	*start_rgn = *end_rgn = 0;
>> >>  
>> >> @@ -827,7 +821,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>> >>  		if (memblock_double_array(type, base, size) < 0)
>> >>  			return -ENOMEM;
>> >>  
>> >> -	for_each_memblock_type(idx, type, rgn) {
>> >> +	for (idx = 0; idx < type->cnt; idx++) {
>> >> +		struct memblock_region *rgn = &type->regions[idx];
>> >>  		phys_addr_t rbase = rgn->base;
>> >>  		phys_addr_t rend = rbase + rgn->size;
>> >>  
>> >> @@ -2194,11 +2189,11 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
>> >>  	phys_addr_t base, end, size;
>> >>  	enum memblock_flags flags;
>> >>  	int idx;
>> >> -	struct memblock_region *rgn;
>> >>  
>> >>  	pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
>> >>  
>> >> -	for_each_memblock_type(idx, type, rgn) {
>> >> +	for (idx = 0; idx < type->cnt; idx++) {
>> >> +		struct memblock_region *rgn = &type->regions[idx];
>> >>  		char nid_buf[32] = "";
>> >>  
>> >>  		base = rgn->base;
>> >> -- 
>> >> 2.56.0.385.gd3acb90ef8-goog
>> >> 
>> >
>> > -- 
>> > Sincerely yours,
>> > Mike.
>
> -- 
> Sincerely yours,
> Mike.

