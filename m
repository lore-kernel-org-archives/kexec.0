Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB5DCD98CC
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OontUb7qE56W5Wue/M2LU8FmpW0BHV0EyXoJjTMFI3Y=; b=W9wEmVxRGRyXxgEYiZS1jP3839
	f8csNIfwZmt7j9YXhltcBgcOFhNHh2kHZraH9zfYYk8Rl3z+F+HOdSlswH2ZwghTMah2y+2dl6Xfb
	PDlLRjUkxIee9NsZJaNS2w6Q4IzkSyT1Lq9gB4KUpKQRLVESARg6ObsXt8QrrorvZDB94SQnUI2qP
	rnTJCYEi2NmGBCBw+TYXX9mbOGnLYv9yXSez7Ec/emyXGTWVjKaAH1pl1V52eCopS4ZB9yaDCxDNq
	cvpq5nIOoMl5g2N8b39RvPF/A9UHT2pB3pWLbOZgknk2Rhr8Uadvh8qZQxOnUPm822v4XSlYIDZxA
	RhOzgk6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXfaw-00000009X0k-0tZi;
	Thu, 11 Jun 2026 13:37:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXfau-00000009X0Y-3IvV
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 13:37:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DBAC9600AA;
	Thu, 11 Jun 2026 13:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463FB1F00893;
	Thu, 11 Jun 2026 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781185035;
	bh=OontUb7qE56W5Wue/M2LU8FmpW0BHV0EyXoJjTMFI3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UmAJp2HGw6a1cxu8Z7qUN33jlTIG2j+zWU8WRaBYMPD0e82ko/eZ36AgAOa43kY/h
	 lxlrudp9simk7JoBMca54NyZEiKzJWI3xHq2I1kMIbJ1GduGALBQqbCBcYKGWYTFml
	 5vfTpJMEs/Ewmp3fN/cMWDpJaVYBCErmVSoa/nVd3BNHzL1DSVVHXG8CYdXTe5g+EE
	 xDYke9gzTLyp1NWBse1zzjPaNGj6xpmesgfWQ6pdUmfK2zOnhfdz4GuStr5vUNRqfT
	 EAl2lV0KWC1COJwOyO0SXjG50HaGTpdkfNeGrd4M9vMiPC4pKJCOBSsVBpQaOqYjgK
	 0CNto2tHZMgOA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Tarun Sahu <tarunsahu@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH] mm/memfd_luo: validate serialized_data before conversion
In-Reply-To: <aiqso7rkpX6oMer7@kernel.org> (Mike Rapoport's message of "Thu,
	11 Jun 2026 15:40:03 +0300")
References: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
	<aiqso7rkpX6oMer7@kernel.org>
Date: Thu, 11 Jun 2026 15:37:12 +0200
Message-ID: <2vxzmrx1qjuf.fsf@kernel.org>
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

On Thu, Jun 11 2026, Mike Rapoport wrote:

> On Thu, Jun 11, 2026 at 10:30:03AM +0000, Tarun Sahu wrote:
>> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
>> on args->serialized_data before checking if the physical address is valid.
>> Since physical address 0 does not map to virtual NULL (due to direct
>> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
>> catching a missing serialized_data, leading to unsafe dereferences later.
>> 
>> Validate that args->serialized_data is non-zero before calling
>> phys_to_virt().
>> 
>> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  mm/memfd_luo.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
>> index 59de210bee5f..10f3983b0060 100644
>> --- a/mm/memfd_luo.c
>> +++ b/mm/memfd_luo.c
>> @@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
>>  	if (args->retrieve_status)
>>  		return;
>>  
>> -	ser = phys_to_virt(args->serialized_data);
>> -	if (!ser)
>> +	if (!args->serialized_data)
>
> We really should make args->serialized_data a KHOSER_PTR

Hmm, that would also be a good idea. I suppose then it would be a better
to directly convert to using KHOSER_PTR() instead of this patch?

>
>>  		return;
>>  
>> +	ser = phys_to_virt(args->serialized_data);
>> +
>>  	if (ser->nr_folios) {
>>  		folios_ser = kho_restore_vmalloc(&ser->folios);
>>  		if (!folios_ser)
>> @@ -522,10 +523,11 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
>>  	struct file *file;
>>  	int err;
>>  
>> -	ser = phys_to_virt(args->serialized_data);
>> -	if (!ser)
>> +	if (!args->serialized_data)
>>  		return -EINVAL;
>>  
>> +	ser = phys_to_virt(args->serialized_data);
>> +
>>  	/* Make sure the file only has seals supported by this version. */
>>  	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
>>  		err = -EOPNOTSUPP;
>> 
>> base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
>> -- 
>> 2.54.0.1099.g489fc7bff1-goog
>> 

-- 
Regards,
Pratyush Yadav

