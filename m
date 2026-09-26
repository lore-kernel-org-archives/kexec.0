Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FD9C98328
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qPPM7SXCBhuzMJBn4w/Iue6D6iAI4Dgq9juqp97Dizc=; b=sbi4DfQO1yBqKgyerFr7ayiRvT
	JPtIo/yXEkSXN6zcOMNJHo7YO9Tvo90vMEgsJ4Ya4VxlT/F+QCDPJl5ZMU7nMW51n1hdvH2Cc2uEk
	T/cugYqI3i0wzRkehLxHRjhXMD+sXTavQPm46kamO+aS8GVV/jZAxIXOmKW0D2gDfk6JNC+Uq4TMU
	Z+pnWr88u3Ncz7ZwEIiKtRp902aYIUKOzS/74KmlCGSmesdFyxm2JxEsx3joS/PbO1pt7FDNTnMaf
	yPaYQktFHRicKZ970Gi7tawqlF7Y1dj4amIM68l7Q+ItuCXnezsk1twcK5rEEcnddyr8uixdK8CRL
	eE/YHktw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOkG-0000000FD9F-37D8;
	Sat, 26 Sep 2026 09:31:00 +0000
Received: from mail-ej1-x648.google.com ([2a00:1450:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOkE-0000000FD8W-1f3z
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 09:30:59 +0000
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c294442d71dso185339466b.2
        for <kexec@lists.infradead.org>; Sat, 26 Sep 2026 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790415056; x=1791019856; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPPM7SXCBhuzMJBn4w/Iue6D6iAI4Dgq9juqp97Dizc=;
        b=TVt7XNJwV1ZgDW5rnUuXQAm9hJaXnOuxvjCbZ7t0A0KmiI/3RGhqHBRrWLQypV45sb
         Kux7HvDjExp3MqVExGqePM2p4yxhj0vZpoxF5pBs4PBSboeDy2rXezD9+FIqBlnWw2bz
         n+KRuGwop5fOeLdxjWoOpbjG65O0cvvlycZWSmpdMBkP6HfB9Q0cBLOP3yautuR27gfP
         0YbFF2uvdiDqESurpBMzfhsuXHqOlEpYiGt+Ci4MRv6m3eExScWRtT5w180BuEnpvwP1
         7tyK0RdABKWK4mz7EZ0fmOfZ3FbB9H3De1f9iIr2uD8QsdgoFZ4el4Edk9ZDNS/LCnPQ
         lS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790415056; x=1791019856;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPPM7SXCBhuzMJBn4w/Iue6D6iAI4Dgq9juqp97Dizc=;
        b=KVc2n0XSb5M09oqopu4wLRkKu7sJUqIaJx7FlCIPQzubzNTdtvyNQK6h44oRkiYa5x
         W6R5BIIz8/vBBb5xjeSqDdBNDJMirXrtup1IFQmyIoRtigf8R+bYLa155ZyiPDK+jCi6
         7K7CL4zMw0y+WuHADEuEH8JMxJswlt/9ypqv9g3spTYfnhnYggET2oXGHUTlOWb6vAiy
         XV1SQ9uyzG2bRvUFH6pweXiN1YGrEiKtRk7URbzJOvLeNSRJjPUwp33l9Zsp0Ux4+MzP
         U9lajnWHck6O3Zz+geugZJ90rwmK+f4HJyQZGY2Pt5jzMr/8nYpaMUCgRxiOmu6o1Jy3
         p1fQ==
X-Forwarded-Encrypted: i=1; AKwUvBwX5+uh3n+OsBnfFV7z8UY9j88dJmNfEzosxBXmWiTTdmZeu+g43v8xbxpLq2tX0FEHPMdNBA==@lists.infradead.org
X-Gm-Message-State: AFuF++kgu0uxLing7BAHR9XnsSKCI0vRPOrxgiUA1JnEyjQtU+O6F+ac
	tH9uMfXsCT8EN2jXrdNVw9x71OsycdnLO+fTvxLOw6Q0U93nmwPEtfu7EVVeB6s/ZMR3oL5mY8E
	32kufEQI6xSDTqt6/9Q==
X-Received: from ejiv7.prod.google.com ([2002:a17:906:2f07:b0:c2a:bb40:5656])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f19:b0:c29:3c21:ee69 with SMTP id a640c23a62f3a-c2ae9f3157dmr395838166b.23.1790415055784;
 Sat, 26 Sep 2026 02:30:55 -0700 (PDT)
Date: Sat, 26 Sep 2026 09:30:55 +0000
In-Reply-To: <2vxzwlsj5r83.fsf@kernel.org>
Mime-Version: 1.0
References: <20260918002239.4024231-1-tarunsahu@google.com> <2vxzwlsj5r83.fsf@kernel.org>
Message-ID: <9huzh5jcnyuo.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v2 1/2] memblock: drop for_each_memblock_type() and open
 code its users
From: tarunsahu@google.com
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	dmatlack@google.com, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dev.jain@arm.com, 
	Pratyush Yadav <pratyush@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_023058_449422_DD72615F 
X-CRM114-Status: GOOD (  20.80  )
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

Pratyush Yadav <pratyush@kernel.org> writes:

> On Fri, Sep 18 2026, Tarun Sahu wrote:
>
>> for_each_memblock_type() always starts the iteration at index 0 and its
>> body is a trivial 'for' loop, so it hides very little. It also gets in
>> the way of iterating from an arbitrary index, which the next patch
>> needs.
>>
>> Remove the macro and open code its three users: memblock_add_range(),
>> memblock_isolate_range() and memblock_dump(). While at it, move the
>> region pointer into the loop body scope.
>>
>> No functional change.
>>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  mm/memblock.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 9ce86349a29f..5aae75d34dec 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -155,11 +155,6 @@ struct memblock_type physmem = {
>>   */
>>  static __refdata struct memblock_type *memblock_memory = &memblock.memory;
>>  
>> -#define for_each_memblock_type(i, memblock_type, rgn)			\
>> -	for (i = 0, rgn = &memblock_type->regions[0];			\
>> -	     i < memblock_type->cnt;					\
>> -	     i++, rgn = &memblock_type->regions[i])
>> -
>>  #define memblock_dbg(fmt, ...)						\
>>  	do {								\
>>  		if (memblock_debug)					\
>> @@ -651,7 +646,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>  	base = obase;
>>  	nr_new = 0;
>>  
>> -	for_each_memblock_type(idx, type, rgn) {
>> +	for (idx = 0; idx < type->cnt; idx++) {
>> +		rgn = &type->regions[idx];
>
> Nit: this is really odd to read. You assign rgn and then declare rbase
> and rend. Doesn't checkpatch complain?

I kept it there to minimize the changes in the patch as the variable was
already defined there. and unfortunately, checkpatch did not throw any error.

Regrardless, Good idea. I updated in v3 here:
https://lore.kernel.org/all/20260926092448.4090401-1-tarunsahu@google.com/

>
> Regardless, I reckon it would be a lot nicer to read of you move the
> declaration of rgn into the loop. Same for the others below.
>
> LGTM otherwise, so after fixing this up, feel free to add:
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Done! Thanks for reviewing it.

>
>>  		phys_addr_t rbase = rgn->base;
>>  		phys_addr_t rend = rbase + rgn->size;
>>  
>> @@ -827,7 +823,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>  		if (memblock_double_array(type, base, size) < 0)
>>  			return -ENOMEM;
>>  
>> -	for_each_memblock_type(idx, type, rgn) {
>> +	for (idx = 0; idx < type->cnt; idx++) {
>> +		rgn = &type->regions[idx];
>>  		phys_addr_t rbase = rgn->base;
>>  		phys_addr_t rend = rbase + rgn->size;
>>  
>> @@ -2198,7 +2195,8 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
>>  
>>  	pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
>>  
>> -	for_each_memblock_type(idx, type, rgn) {
>> +	for (idx = 0; idx < type->cnt; idx++) {
>> +		rgn = &type->regions[idx];
>>  		char nid_buf[32] = "";
>>  
>>  		base = rgn->base;
>
> -- 
> Regards,
> Pratyush Yadav

