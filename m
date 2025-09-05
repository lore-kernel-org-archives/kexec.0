Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A50ACA1017
	for <kexec@archiver.kernel.org>; Sat,  6 Sep 2025 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b1MnDfvzkRjUKqLvn44SR8WojgXCXrb2im/5uhar/UE=; b=wQL3p/14FpaZY2zNtJAThEQ3rY
	C9ayAZnPctOhaEcv3khCV5Jsy2AfjuzsI6CoA3Lel632rTWEXcv8ygF3ekemUQfRGaPqNJ5YoNrxX
	Zol9vrFkoZGE/oQoFECOFepLTVcqHk3E8lbsfdjMxqIxP1bHAODTQffgN7bVnjnp16YU9huc+d29V
	yi9vMYdPXJpY2KhDbpsnBH6xIS3tkr+IYSvhxogeh6ENJmuE6C4oAtkvuIrXnFVUdoF1qJFRrj9Im
	lyKDpk30qgXQnl1nUAKQQ96xYKOqSTwHFLAxslOLJ77DTcV/ccBlHZDvlvrDonalqXMn8Hlo3IjQZ
	ELFPR/BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugXr-00000005Vzm-0Z9v;
	Sat, 06 Sep 2025 00:12:43 +0000
Received: from pegase2.c-s.fr ([93.17.235.10])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uubzB-0000000456J-0tyM
	for kexec@lists.infradead.org;
	Fri, 05 Sep 2025 19:20:38 +0000
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cJQx530RBz9sS7;
	Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8FPsSrEXf2k; Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cJQx51qPmz9sRy;
	Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C7B98B77A;
	Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 570O8DO0c8e4; Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6312E8B773;
	Fri,  5 Sep 2025 21:13:28 +0200 (CEST)
Message-ID: <c0bd173c-c84f-41d5-8532-2afb8eca9313@csgroup.eu>
Date: Fri, 5 Sep 2025 21:13:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
To: Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, snovitoll@gmail.com, glider@google.com,
 dvyukov@google.com, elver@google.com, linux-mm@kvack.org,
 vincenzo.frascino@arm.com, akpm@linux-foundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZdWxWD99t9yhmB90VPefi3Gohn8Peo6=cxrvw8Zdz+3qQ@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <CA+fCnZdWxWD99t9yhmB90VPefi3Gohn8Peo6=cxrvw8Zdz+3qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_122037_417895_C1A99F7D 
X-CRM114-Status: GOOD (  11.94  )
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



Le 05/09/2025 à 20:08, Andrey Konovalov a écrit :
> On Fri, Sep 5, 2025 at 7:12 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>> But have you tried running kasan=off + CONFIG_KASAN_STACK=y +
>>> CONFIG_VMAP_STACK=y (+ CONFIG_KASAN_VMALLOC=y)? I would expect this
>>> should causes crashes, as the early shadow is mapped as read-only and
>>> the inline stack instrumentation will try writing into it (or do the
>>> writes into the early shadow somehow get ignored?..).
>>>
>>
>> It's not read-only, otherwise we would crash very early before full shadow
>> setup and won't be able to boot at all. So writes still happen, and shadow
>> checked, but reports are disabled.
> 
> Hm, I thought it worked like that, but then what threw me off just now
> was seeing that zero_pte_populate()->pte_wrprotect() (on arm64) resets
> the PTE_WRITE bit and sets the PTE_RDONLY bit. So I thought the
> kasan_early_shadow_page is marked as read-only and then the
> instrumentation is disabled for all early code that might write into
> the page before the proper shadow is set up. Or am I reading this
> bit-setting code wrong?

But that zero_pte_populate() is called by kasan_init() when everything 
is ready.

kasan_init()->kasan_init_shadow()->kasan_populate_early_shadow()->zero_p4d_populate()->zero_pud_populate()->zero_pmd_populate()->zero_pte_populate()

Here we are talking about the shadow set at startup kasan_early_init(), 
aren't we ?

Christophe

