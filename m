Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764D606A32C
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Bind5DCl;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=oLmkxrFn;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgLrNkta
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RAC3JyCcPbrtGRCcu9CD6bbgq1BaxglIl3X5ZCQ3VwI=; b=Bind5DCl2y5eefBeHpvn0ZD036
	AK8cJgYWxJt8/3K+bmYNQ5OQMd9F0bp7taLR/jYrR9SGUpMOyB7MkRgmsSzG8xw4JuF9M64fRABlO
	bjVjauweAoMaPYW8OiSg252RyJTqcxir+rCp88PP8X0yaIwVaI25N0ch2qL0bAaIChyLf5ow+aN8W
	+cOeSAiHeZ2TQ6X67dQ/ZPV6sFGAVlUDAy7kUJDBG7PTwCCVa0W06qpzTqLy3cErqySPTFUXllzjj
	QnE/TqY/C8sBK3pIaYqfMJqdQMNDkaHEfFn1/LM1ZP+2hrUo78QTNsSGUWQ519HuhuDEJyZN4ZI4e
	mKGfZ/lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOw52-00000008n3q-3hUg;
	Thu, 05 Nov 2026 11:56:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOw51-00000008n2e-2sZ7
	for kexec@bombadil.infradead.org;
	Thu, 05 Nov 2026 11:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RAC3JyCcPbrtGRCcu9CD6bbgq1BaxglIl3X5ZCQ3VwI=; b=oLmkxrFnJGXK3w6m/eIKyh9AQP
	lKcUxMvP1uQxrH/gZqB7pfGOgEfwhWdZabpyU/2Rz/YCAplhMOl5RXRDHKF7KOezC9peomc4bbudp
	VHEgNCZsgu1kmGcM5t8v9Z5pUm4UDsSm7QMkvlAwL76xlzLENeRF9MZtrRuYoZQo3xrcKHFf3QFQR
	NbVSeBklhmlzhVpjqf5123b3JltgDVoa4K0T6ZSmZY/IvMtXN/vVfrj1nN881BIIjJ2nWwPEVu2dt
	Xtj8ZNwakqMpe3YegSkwg5BKZNa3ieCWX83FLVW/fF+VFhNInav6w5juT3mDbyuiDfSiBTIvRwVAv
	4vozne4Q==;
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOw4y-00000002vRs-3Yeu
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 11:56:30 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso13904755e9.0
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 03:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793879787; x=1794484587; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAC3JyCcPbrtGRCcu9CD6bbgq1BaxglIl3X5ZCQ3VwI=;
        b=dgLrNktayybW0UNiTZ7t2Al0fzTMZNwoPRPE1FuGjv/bhALzp4/lbQeXBPySSmdmn5
         8B+WLGkwURHjsoS0U3FzulPGdxEub0z7vykUawdhbAsSUZUFK2skDmqB4sDtrlNGEEX4
         iK3H0/Za789ry2NcCixFUuBZkFrvvemhUzHtNVg5pMx82RBhUDkclDlaLGR4HKaSVlCE
         xSns1xfYL421nEo04CIuk16tCLZox6gvozjf6h1yFtJz01RYoECZKvg2K6L/OOPXDyoq
         usdcNyH2+loinXrZ4taUyW3taGGQ2JCGHgSiW+rTFe4mfvvinNVWu6C6hW5SMaCcdeDb
         qcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879787; x=1794484587;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RAC3JyCcPbrtGRCcu9CD6bbgq1BaxglIl3X5ZCQ3VwI=;
        b=QWq1CXLJp3YoMEGNig4ApdoK5ZRWv7zf7MJvmOxrZP9IY4AisbeuqESoF7CmECKiM3
         TbV5d1UlXHq41X3ir54zyzObCWcFQMXV8OedNjBjIYlHUe6+TGBSkNld5EyVnWmxbZYt
         pNIcE+8S8atPsbXrPWYIbe1wZWe+EBk5JDWuC8Czo+Aa7c5N3m5oICax1t1n4hmNUe/q
         wMNcLucC5xhL4GYyvQg77WxC/M6Putp2EGlmLGSAu2xmHNX3sB+hmXT2fPEDQn2OJYtH
         riBG0weVt531lvhq0oxt074pG71/LDagVQfLiMf3K7EUD+2iy0BWtWGpZmb8OfASH/TT
         xeuw==
X-Forwarded-Encrypted: i=1; AKwUvBxV9gpL7u7yEoACH09r56H/Y1YsPBwRlwnsp7tx+3K3uaEaJzbUhhcKQoGPpvt6+33z7JMu4w==@lists.infradead.org
X-Gm-Message-State: APuU4Z+/O/Wqz8Mzkub0yZyWOAhR0WpajTFjRWji2IPCKoJ2k4YBX/JH
	kKbOXA3/PqgL35HWEQ7kvvXNja8GZYy2GUt9JLHuS+Yxfq6/TsOVHk1K
X-Gm-Gg: AYBFou3o9iNhJcR2Q2Buev2E2c5kzMsffmvz25pfQTxvplcdSoC6mn/BTerR5PftY2+
	POHjFP7fz0yEkfF+VSIR34UgdB+VXYgXurh1Vz5CJJVPJCVFz/yIgvHvo00jdJGl9VZwwFE5Bey
	BZn0+U3uBzJqicQbF5W2c8fpEMvUwlszDDrds6ebXJOx4017phnJL2E7VhqMfCz8Tu3eyXw+im0
	wNAFSMvMhx7HVIS3OK/ouIY4ubJkt+vbu+ezO4Yn6IFi5pI78HSqYuQ0gIPAnqRCsbUr0nrNOFu
	JKE1lgL4QI81hxsJhEeurjagl4dij0En9kuy6m7dz3Pt0zwwScJqZqcq2HK3PnWFHcniNiP/Yqi
	BNrTSrKr/LmfcaNoXd+F+LwoHlABUW7YBAxea8moVMEkOb2RXJUQcnbIX/W95aAQqwMYhHuFtCz
	lYsl3sPgNeOiSZlBINGCBUcadcQh9NejCqVKP61tiBtwdcfI8aZJpA9CJlr5QIDMVLrX/Itk9n/
	PDjMdFAQwuMKjQz7ncgiS5JBvys1FP6seN3q0u60D9GcO05NSSeHXX3158naI5+pF/RymVkGkaT
	TBi9fP3ug3jqhNW0Xlk6ag5q/Y3ZWdJG8P62FIDUCNlI
X-Received: by 2002:a05:600c:6212:b0:4a4:de70:2ad4 with SMTP id 5b1f17b1804b1-4ac17ffa395mr398423355e9.22.1793879786986;
        Thu, 05 Nov 2026 03:56:26 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea181085sm9708651f8f.1.2026.11.05.03.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 03:56:26 -0800 (PST)
Message-ID: <d2965cb2-428f-484a-bd81-55b78b770b96@gmail.com>
Date: Thu, 5 Nov 2026 12:56:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memblock: don't allocate new reserve_mem regions on a
 KHO boot
To: Mike Rapoport <rppt@kernel.org>
References: <20261104204235.9066-1-azpijr@gmail.com>
 <auw3dtAMp4CjNwY2@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <auw3dtAMp4CjNwY2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_115628_822053_CBD994E2 
X-CRM114-Status: GOOD (  20.18  )
X-Spam-Score: -0.2 (/)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, Kees Cook <kees@kernel.org>, Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 8:59 AM, Mike Rapoport wrote:
> On Wed, Nov 04, 2026 at 09:42:17PM +0100, Jose A. Perez de Azpillaga wrote:
>> On a KHO boot, a reserve_mem region that can't be revived is allocated
>> from KHO_NOPRSRV memory, which includes the bootmem the next kernel
>> boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
>> then fails:
>>
>>   WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+0x168/0x180
>>   failed to prepare memblock FDT for KHO: -22
>>
>> Without it, the next kernel puts its memmap on top of the region and
>> the ramoops records in it are lost.
>>
>> There is no use case for adding regions across a live update, so fail
>> instead of allocating, and drop the TODO.
>>
>> Fixes: f99230780211 ("memblock: add KHO support for reserve_mem")
>> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>> ---
>> Changes in v2:
>> - fail on a KHO boot instead of allocating outside bootmem, as agreed
>>   with Pratyush [1]. this drops v1's patch 1.
>> - not an RFC anymore.
>> - based on v7.4-rc1.
>>
>> v1: https://lore.kernel.org/all/20261021211058.83483-3-azpijr@gmail.com/
>>
>> [1] https://lore.kernel.org/all/2vxzfqxglrg6.fsf@kernel.org/
>>
>>  mm/memblock.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index a450092a80fb..e325e0542c9a 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -2827,7 +2827,16 @@ static int __init reserve_mem(char *p)
>>  	if (reserve_mem_kho_revive(name, size, align))
>>  		return 1;
>>  
>> -	/* TODO: Allocation must be outside of KHO_NOPRSRV region */
>> +	/*
>> +	 * On a KHO boot memblock only allocates from KHO_NOPRSRV memory here,
>> +	 * which includes the bootmem the next kernel boots out of. Only regions
>> +	 * handed over by the previous kernel are supported.
>> +	 */
>> +	if (is_kho_boot()) {
> 
> This breaks memblock tests, please add a stub there.


oops, sorry. will add it in v3 :)

-- 
cheers,
jose a. p-a

