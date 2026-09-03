Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F09C624A4
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d+0Di3qj5r5ZLKVg7VMQtnJsK/2I+OQNTE5J5ZZ279A=; b=URkPteb/rY+JkBjb1jqRUl7hGB
	XArrYqiOAELkKCCnpYL6K9Fc22FD6IM+4qKlC4+bJO1gmQuuxSURPnYMxDyHhYK6Pr/uTDapVKquo
	Z2uP095wKQQX2sCGrA49VQEwZVMIgJIgd1MlpJQ3wI495/afjvIHsFsEBDMkCLawx3PCnBQv/yeyq
	o0Xsaia5tdy0CCACksEedUyN1yaamDXo5ipJuI3TNEuWL+5t8SnkAqOA+6PvSihUkp1m7tXtE8Jzl
	0fYdgKKhqRcTAOkEuUIL88kpE/zg9lOKj4u09whXlzjUJNBhyDbnNT0U84d88/t4PJx+bxXBQvLp7
	s0aFvghQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x27XS-0000000HPaX-03Op;
	Thu, 03 Sep 2026 13:31:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x27XO-0000000HPZY-05TI
	for kexec@lists.infradead.org;
	Thu, 03 Sep 2026 13:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788442289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+0Di3qj5r5ZLKVg7VMQtnJsK/2I+OQNTE5J5ZZ279A=;
	b=QU7kUOA0uRV02xiJC7f+1He9/CVN2bLxJ1FoeshQccVvTFbo+S68I9HI19TTx/R6brRMfS
	EYYwjwvbP///VUy8ynMvgBdbcomMCtlcxO10uFDnAgx+ssD0vWlUE6+g7VuJ3hhuUM8l8s
	TkR23NZ2FhvE8UQGR4L5o/quD8pU99I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-atZV6ayHN7yHriB-2Y6sQQ-1; Thu, 03 Sep 2026 09:31:22 -0400
X-MC-Unique: atZV6ayHN7yHriB-2Y6sQQ-1
X-Mimecast-MFC-AGG-ID: atZV6ayHN7yHriB-2Y6sQQ_1788442281
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-395543dc382so3239226a91.0
        for <kexec@lists.infradead.org>; Thu, 03 Sep 2026 06:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442281; x=1789047081;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d+0Di3qj5r5ZLKVg7VMQtnJsK/2I+OQNTE5J5ZZ279A=;
        b=si9VRx3Zo8PI7LOjBL4Wcj6ODBA1X9nu0qaJ5PMqmSi9UTJo3sm7Vo6svqnjqDAKsp
         dw+bfg1A+jjcIKZRH5i/aV36ipBxhuARxKRCV39sKb9HXMcp3S61X6PtLN93iQR4gGb7
         TSEwbTbrueiGwfnj8naqZE9g9R6mGpgrFD+AtFKlWBObiEtjPo4GgJyT6tCDYU6tTKLq
         0ncyYOfjMHOT/3nbr0RQpZwZYO94QJve0N370b7fU6Mgi1H2Klv07lkTR1oFYQh//qSg
         YernDRRTCdF8/ZlZ+MeBqvFwCmyjcF3tnEfIvtrt1Br8KJvGJnPpGDLn1DXx4GYSJ4Tm
         eUuw==
X-Forwarded-Encrypted: i=1; AKwUvBzN/YXlG2yf3CwGPS1jTSo+9lAd2HhgwF+aqEVpVQykgdy06yNutE8Zdu134rGXUpcC+9a40A==@lists.infradead.org
X-Gm-Message-State: AFuF++kjhWz4s3ZQ0rCXLIlC3k/axrA0xl0VGl+bD40xJnSkY0UCLMmA
	FV5XmY7Rqu+y42PBk9a2Vpx7Gb4zGs5RlVMMTAW1lvXel9aHQaVO4X0rKj3QYKxDpv3s92D4e/v
	zmgrHwgj4xUan0yKsqDAE+8IT9TxQtclOxWrzL4DEjWQ7AEshYZ/qdvYwQWo36Q==
X-Gm-Gg: AYBFou1iwFIzYUD/QLkJ11+ZwuJNiZl87iUbXnenlSFcZK9rh2a/TCr8JwJ53e3gXV0
	Gm54ZKptECtbUrMogbUQZJGRBJNtkFtbc9e1+EBeVMQtaA3/OvwRu0NbkYwjCrl9EnEaPKGIoq0
	HVR4ynY7+JYXn7FocqTxboiBSYP91T4hKIaYCmdN6emZ17CBpMCLZLyzscFJd6WwUWnzxmpK8wY
	9tnOGtdK4nsoNzxJkZG0K2J4KX8G+2Jrw7Z7twja6uQUfk1X4E8OuXaWd5jccXnmvgIAJGXLEhU
	T+kSuV2pNsqNCPnVbaRKCX7NdfbBjoQf1mj6BMfls07cRikycaIEoXX0DzMw/gdWyHv/C2D/eJa
	77gHF0VSA6/0ZUmqX
X-Received: by 2002:a17:90b:5102:b0:398:9be6:f998 with SMTP id 98e67ed59e1d1-39aee16a180mr19981106a91.23.1788442281215;
        Thu, 03 Sep 2026 06:31:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5102:b0:398:9be6:f998 with SMTP id 98e67ed59e1d1-39aee16a180mr19980948a91.23.1788442280416;
        Thu, 03 Sep 2026 06:31:20 -0700 (PDT)
Received: from [192.168.1.2] ([122.171.16.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm5659399a91.13.2026.09.03.06.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 06:31:19 -0700 (PDT)
Message-ID: <1b845292-1117-458d-ab58-67c3e643ddc8@redhat.com>
Date: Thu, 3 Sep 2026 19:01:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec_file: remove unused arch_kexec_locate_mem_hole hook
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Paul Walmsley <pjw@kernel.org>,
 Pratyush Yadav <pratyush@kernel.org>, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org
References: <20260827144452.508328-1-sourabhjain@linux.ibm.com>
 <d16164ef-7211-4272-bc74-bc38efd8623e@redhat.com>
 <f1c3c554-8500-45ef-953d-b7bcece988c7@linux.ibm.com>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <f1c3c554-8500-45ef-953d-b7bcece988c7@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s9jEBmkE6BmuxtUglP3uLCYZOGOhmMXwRQaYJ2GNkAo_1788442281
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_063130_121051_A674C60D 
X-CRM114-Status: GOOD (  26.51  )
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

Hi Sourabh,

On 29/08/26 10:28 am, Sourabh Jain wrote:
> Hello Mukesh,
> 
> On 28/08/26 18:50, Mukesh Pilaniya wrote:
>> Hi Sourabh,
>>
>> The patch touches three files across three subsystems so kexec: would be
>> a more accurate prefix than kexec_file, for e.g.:
>>
>> kexec: remove unused arch_kexec_locate_mem_hole hook
> 
> As I understand it, the kexec: prefix is generally used when the changes
> apply to both
> the kexec_load and kexec_file_load syscalls.
> 
> Since these changes are specific to kexec_file_load, I used the
> kexec_file: prefix for the patch title.
> 
> That said, I’m happy to follow the convention if you and others feel the
> patch should use the
> kexec: prefix. Otherwise, I would prefer to keep the kexec_file: prefix.
>

You're right, I hadn't noticed that the hook is entirely within the
CONFIG_KEXEC_FILE block and both callers are in the kexec_file_load
path. kexec_file: is the correct prefix here. Thanks for the clarification.

> 
>>
>> On 27/08/26 8:14 pm, Sourabh Jain wrote:
>>> No architecture provides an implementation of
>>> arch_kexec_locate_mem_hole(). Use kexec_locate_mem_hole() directly
>>> and remove the unused fallback wrapper from the kexec header.
>>>
>>> This simplifies the kexec memory allocation path without changing
>>> its behavior.
>>>
>> Also, it might be worth mentioning in the commit message that this hook
>> was originally introduced by commit f891f19736bd and that the last arch
>> override was removed in commit 6e5250eaa665; making it safe to remove
>> now.
> 
> Sure, I don’t mind including this in v2.
> 
> 
>>
>> Otherwise, the change looks good to me. Feel free to add:
>> Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>
> 
> Thanks for the review.
> 
> - Sourabh Jain
> 
>>
>>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Baoquan He <baoquan.he@linux.dev>
>>> Cc: Mike Rapoport <rppt@kernel.org>
>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> Cc: Paul Walmsley <pjw@kernel.org>
>>> Cc: Pratyush Yadav <pratyush@kernel.org>
>>> Cc: linux-riscv@lists.infradead.org
>>> Cc: kexec@lists.infradead.org
>>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>> ---
>>>   arch/riscv/kernel/kexec_elf.c |  2 +-
>>>   include/linux/kexec.h         | 15 ---------------
>>>   kernel/kexec_file.c           |  2 +-
>>>   3 files changed, 2 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/kexec_elf.c b/arch/riscv/kernel/
>>> kexec_elf.c
>>> index 3e9a32acb8f2..ca5abbad59e5 100644
>>> --- a/arch/riscv/kernel/kexec_elf.c
>>> +++ b/arch/riscv/kernel/kexec_elf.c
>>> @@ -91,7 +91,7 @@ static int elf_find_pbase(struct kimage *image,
>>> unsigned long kernel_len,
>>>       kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
>>>       kbuf.cma = NULL;
>>>       kbuf.top_down = false;
>>> -    ret = arch_kexec_locate_mem_hole(&kbuf);
>>> +    ret = kexec_locate_mem_hole(&kbuf);
>>>       if (!ret) {
>>>           *old_pbase = lowest_paddr;
>>>           *new_pbase = kbuf.mem;
>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>> index 0af8ae4fdd08..e5f1cfc11fef 100644
>>> --- a/include/linux/kexec.h
>>> +++ b/include/linux/kexec.h
>>> @@ -259,21 +259,6 @@ int kexec_kernel_verify_pe_sig(const char
>>> *kernel, unsigned long kernel_len);
>>>   extern int kexec_add_buffer(struct kexec_buf *kbuf);
>>>   int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>>   -#ifndef arch_kexec_locate_mem_hole
>>> -/**
>>> - * arch_kexec_locate_mem_hole - Find free memory to place the segments.
>>> - * @kbuf:                       Parameters for the memory search.
>>> - *
>>> - * On success, kbuf->mem will have the start address of the memory
>>> region found.
>>> - *
>>> - * Return: 0 on success, negative errno on error.
>>> - */
>>> -static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
>>> -{
>>> -    return kexec_locate_mem_hole(kbuf);
>>> -}
>>> -#endif
>>> -
>>>   #ifndef arch_kexec_apply_relocations_add
>>>   /*
>>>    * arch_kexec_apply_relocations_add - apply relocations of type RELA
>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>> index 59fb9d71e9d8..9a981359addd 100644
>>> --- a/kernel/kexec_file.c
>>> +++ b/kernel/kexec_file.c
>>> @@ -784,7 +784,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>>>       kbuf->cma = NULL;
>>>         /* Walk the RAM ranges and allocate a suitable range for the
>>> buffer */
>>> -    ret = arch_kexec_locate_mem_hole(kbuf);
>>> +    ret = kexec_locate_mem_hole(kbuf);
>>>       if (ret)
>>>           return ret;
>>>   
> 

-- 
Regards,
Mukesh Pilaniya


