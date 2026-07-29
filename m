Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BCDC54F51
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ToiJoF4NcsxRlbsxS2U0VQ57R0XjAeQgD4aiE3GQTgU=; b=jHcgPwb5OWNd2igHz3lPM2PZjB
	eYBA4MuPAsAMq9heuJAkrrt77DCp2V/xJS4zRUd29U/rHgB5iV/08FoQkX0bqb7rnO/ytiFDOskpL
	PE9StK7fpAGyxHN1UEh7lfcOV7Z/slp26QZE2eM+kaR+6pvSw9Ca87jMDKA6Js8jefBePqd9t1Rho
	d/CYiRyRhJnK6Bxg14cez7fEaapsZTfLri2odWOO6YdrcE7BCMVHEdHTOVLT60bu3XIe6WLTfDhGs
	j6EcbZK29weUaRwgR1sMW9u5GvnQvOZke/+4TZAMaEgkECoTRmy6e7endtq5y8B9LB5c2Hcj71JDs
	DaP20lsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp58h-00000008FOp-1gBL;
	Wed, 29 Jul 2026 14:20:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp58f-00000008FOi-1PkX
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 14:20:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BD51E4357B;
	Wed, 29 Jul 2026 14:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7484E1F000E9;
	Wed, 29 Jul 2026 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785334804;
	bh=ToiJoF4NcsxRlbsxS2U0VQ57R0XjAeQgD4aiE3GQTgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Qbnf2thCmDftHpU293Cjw8f+lvQqn3HXrlqAxa+6XB7oBenqHteYwSX88ZeqJZJ3x
	 xcOYql4hyNOsX7Go1UZO9BQIFfeyGo9BOyt0M5W8+BiTH2aSK6V5QA41+g1q8SWpLS
	 IOnJJzNYleeMxT5+if5EdiAX38V+rB7wFMtDMZlUcP/aLjrIFqorv/heZaOrbndoif
	 gxtdY6a/n4/fRt2tcEsuf2XuLXQQMyxJnMQgv2O12AUkbzP2mZlhhpJlfQd/8y3xXV
	 t2KDAoIQMcPKqkZi28muGaVdiRqw/V+EF7w406MnK/VV+0a05+iLaTGDX6LWPetjG0
	 iOPMTmp00QMgQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/21] memblock: make HugeTLB bootmem allocation work
 with KHO
In-Reply-To: <amjqwKoF0XrvYw9N@kernel.org> (Mike Rapoport's message of "Tue,
	28 Jul 2026 20:45:36 +0300")
References: <20260725172133.4018491-1-pratyush@kernel.org>
	<20260725172133.4018491-20-pratyush@kernel.org>
	<amjqwKoF0XrvYw9N@kernel.org>
Date: Wed, 29 Jul 2026 16:20:01 +0200
Message-ID: <2vxz33x198tq.fsf@kernel.org>
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

On Tue, Jul 28 2026, Mike Rapoport wrote:

> On Sat, Jul 25, 2026 at 07:21:19PM +0200, Pratyush Yadav wrote:
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 8b2e551435ae..ff470fd0fd10 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -19,11 +19,9 @@
>>  #include <linux/mutex.h>
>>  #include <linux/string_helpers.h>
>>  
>> -#ifdef CONFIG_KEXEC_HANDOVER
>>  #include <linux/libfdt.h>
>>  #include <linux/kexec_handover.h>
>>  #include <linux/kho/abi/memblock.h>
>> -#endif /* CONFIG_KEXEC_HANDOVER */
>
> This breaks memblock tests, can you please add stubs for these in
> tools/testing/memblock?

I swear I tried building memblock tests but somehow still missed this :-(.

I think it is because the very last thing I tested was a boot with KHO
disabled, and that's when I discovered this.

Anyway, will fix in next version.

-- 
Regards,
Pratyush Yadav

