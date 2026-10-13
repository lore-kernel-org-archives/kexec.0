Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14201CC6B12
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WFCGbaDlX/AVQV6RAFUOj0q1sLZPldXZf8616wSFK2M=; b=YmwAVaBJuRhXd18fq7GIYnsu28
	nGB5P5M6VpIgT2TnaxosRaET1kfykgL6JjqcBBvMifk3fqfCr6Xct9blkzNFYG+aDmUN7OzBfBHT0
	UsjkonzqOeRtRGZSMLZnwL3GSiRG0AzJhP/BmFruarAfz9iI+GcDH+TfbJZeql/Hi9KgdhsKtkpyU
	1CEbLu23FUhjxIYHenSdAr6FIfPF7NH+FKGaw6Pmn7T1PNYaBZpkVVe72HeupH6JeSsZpy7DM6lrQ
	GvLTCV74RG9nVJQpVyWYTHlnruz/9KAMbApEQMgdj/j4O7yvNVExztfVS3n6WRGu+XzgEmxOcTr6e
	MFAqDB6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeHN-0000000DGcm-0fHp;
	Tue, 13 Oct 2026 15:19:01 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeHB-0000000DGPI-0po2
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 15:18:56 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-6b1bc2e62d5so2308217a12.2
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791904727; x=1792509527; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFCGbaDlX/AVQV6RAFUOj0q1sLZPldXZf8616wSFK2M=;
        b=TJr+rvqiFZJWCPB/QwT5HYvmc8eGMtfPkYn0sY2pskOZigKk2Mu1pHNIvbc6nwij62
         EpJORIYKUJp4eGRws+XkeXfBzN9HXAXMiW4I0JmgwKub1mUzWB/Ihm/iw6fZRPqgJNvO
         G2Ef2XQGfYr60rraQuAw14Qj3AvSt9sNwRg+IY2GVx5bLLIW0ktFvG6N0aAUryB8bJyJ
         KyicYYvfnhbO4v1D9nsL3zP2r4WE/zhJ1eJm22g2b3UmelZlIN4GGelPydnhTmyfBDjH
         LoorVWEpaPWpFRKFafuByr9YP7cytFRP1BPT2fBD66PQddDHQKRSNTn43JBAd7Anuw35
         Cbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904727; x=1792509527;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFCGbaDlX/AVQV6RAFUOj0q1sLZPldXZf8616wSFK2M=;
        b=HHT7j9siS6OxoJJJV9R4cW+LjnPwexkalmB9MjalEA6R3b4q8CUuolILnX1GGg6FCP
         LZoB3RaVHZSL2faQtjuGPVu5Qq0EpGSnF6BPvK94PeLfXj6C7w3OXKG4e2BoRAyLn7c5
         nx2akWJ/NSOkiXXbKHdaw2aK3WpWJCUxxUO+zCacqjReId+EYroEJRvW58cGvdsijngg
         85grRsxobstWoRPPsYMo2J+PyA3h5mUwVulkI6S7G3Wb3VAk4n2x7nsZMxFRL7JnlwzZ
         XMxzw/rGU6Jzu5iqxfMU+zZeePpxzzIGoVp3npgSsRpDJLSkIQNhJPZSLaEN5bqJizu5
         3noQ==
X-Forwarded-Encrypted: i=1; AKwUvBxemTVnF4w+MsJVGiHdPr/IsgqDv2a4wAJfy69JU2TOk4w4v75ypWBq/gdJdsVS7Q+MEAcX5A==@lists.infradead.org
X-Gm-Message-State: AFq9FYKJtioOmANe2s2pz0M04w761xVAQIW1UZMMHDaj5yJm0FPU3gae
	gs7uJ0P2Cn4zGMkkFmXjg0gsgOHil5sohDmBMRijL7h/Zs5F5yc3JAWXnT1P3ZxxBI9XlH7YDSF
	tkv+Bu/37oswlDw0WBw==
X-Received: from edwl2.prod.google.com ([2002:a05:6402:1242:b0:6b1:a8d5:117d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ed4:b0:6b1:ba86:5f55 with SMTP id 4fb4d7f45d1cf-6b1ba86636dmr5678473a12.35.1791904726451;
 Tue, 13 Oct 2026 08:18:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:18:45 +0000
In-Reply-To: <as4EcgiBH5jjww42@kernel.org>
Mime-Version: 1.0
References: <20261008190828.3221718-1-tarunsahu@google.com> <as4EcgiBH5jjww42@kernel.org>
Message-ID: <9huzecdt633e.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 1/2] memblock: drop for_each_memblock_type() and open
 code its users
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: dmatlack@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_081849_262971_9E64231A 
X-CRM114-Status: GOOD (  19.41  )
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

> Hi Tarun,
>
> Please for the next time add the cover-letter when sending more than one
> patch.

Thanks Mike for piking up the patches.

Sure, I will take care of adding the cover-letter.

You had some nit change suggestion, Let me know if you want
me send v5 or it is alright.

~Tarun


>
> On Thu, Oct 08, 2026 at 07:08:27PM +0000, Tarun Sahu wrote:
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
>> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  mm/memblock.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>> 
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index f5aaa38cfa31..59dda7d085f3 100644
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
>> @@ -615,7 +610,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>  	phys_addr_t obase = base;
>>  	phys_addr_t end = base + memblock_cap_size(base, &size);
>>  	int idx, nr_new, start_rgn = -1, end_rgn;
>> -	struct memblock_region *rgn;
>>  
>>  	if (!size)
>>  		return 0;
>> @@ -651,7 +645,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>  	base = obase;
>>  	nr_new = 0;
>>  
>> -	for_each_memblock_type(idx, type, rgn) {
>> +	for (idx = 0; idx < type->cnt; idx++) {
>> +		struct memblock_region *rgn = &type->regions[idx];
>>  		phys_addr_t rbase = rgn->base;
>>  		phys_addr_t rend = rbase + rgn->size;
>>  
>> @@ -815,7 +810,6 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>  {
>>  	phys_addr_t end = base + memblock_cap_size(base, &size);
>>  	int idx;
>> -	struct memblock_region *rgn;
>>  
>>  	*start_rgn = *end_rgn = 0;
>>  
>> @@ -827,7 +821,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>  		if (memblock_double_array(type, base, size) < 0)
>>  			return -ENOMEM;
>>  
>> -	for_each_memblock_type(idx, type, rgn) {
>> +	for (idx = 0; idx < type->cnt; idx++) {
>> +		struct memblock_region *rgn = &type->regions[idx];
>>  		phys_addr_t rbase = rgn->base;
>>  		phys_addr_t rend = rbase + rgn->size;
>>  
>> @@ -2194,11 +2189,11 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
>>  	phys_addr_t base, end, size;
>>  	enum memblock_flags flags;
>>  	int idx;
>> -	struct memblock_region *rgn;
>>  
>>  	pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
>>  
>> -	for_each_memblock_type(idx, type, rgn) {
>> +	for (idx = 0; idx < type->cnt; idx++) {
>> +		struct memblock_region *rgn = &type->regions[idx];
>>  		char nid_buf[32] = "";
>>  
>>  		base = rgn->base;
>> -- 
>> 2.56.0.385.gd3acb90ef8-goog
>> 
>
> -- 
> Sincerely yours,
> Mike.

