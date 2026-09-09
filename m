Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A142C79FB7
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fF1cEFcgyVPOEPUq/61SXtv1bN/BnUewuuhHxkdbS5w=; b=aJewuu3T64lQ9Pz8r5jK5s52cO
	WJ+5IZX4uvRmqkW2ZsrLGNiBqIx01sg+zKz6lpUXktk50+RGZsHYN0q7sECvxOLoqhBpllgCL/PLa
	oxIeOUY8PaK31uNWz/SmiUlVsqTBkxcF7oPwFn2ZcCkP7u5QBPw4GZIjnoWFv7wBsYctBOCHaA51x
	yDtlhulysAVU00aIICQ5KLVBcMaZv+wfbe1ApEYIFWPghUCpmSqSXBc9hwWV4Bm/s1Wcve3Yf2yTn
	r7Z1yvcAkv0EgKGmz/U0rUCOaTmbaH7LfOSoUW7rdg1FIEInu9T4YgtCgC4df1pUkWbM9Y05/VufE
	1Xe17Wwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4IO6-0000000Bo0G-2QvP;
	Wed, 09 Sep 2026 13:30:54 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4IO2-0000000Bnyk-3uOf
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:30:52 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-c29432715d2so14035166b.2
        for <kexec@lists.infradead.org>; Wed, 09 Sep 2026 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788960649; x=1789565449; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fF1cEFcgyVPOEPUq/61SXtv1bN/BnUewuuhHxkdbS5w=;
        b=CUDv5biyOUYsDbx9S0gbChfpLcMv7E1RUJ+oFKlXB1cmVLW/2cwMhf0UDkAdQzfAgj
         V9w6cHPLq3PFtcj0YSK+cQsXmWv41NeQjePrKPL8Tgf13/uE/XpfUQfDNKIUZ9rzLkrO
         QpnpF95WpwFPNOJtS9ppqVMBhNWXV1WHMTsw7QuMOsE1RFBJylbq6gI5jYL1F0luLrTH
         yavqeEcuMitc9b4qmdjLr1u6Sp9g1TtPEKBqh8ftrlS550qCUCMnT0OhyI1XactQYZ6h
         6QOJbZOz/+6xUh/nJ6vvGTFqiIw7Iiq/DPzgSOASGmemUBdMk+NFfnouUZyen9Ya+RSc
         r/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960649; x=1789565449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fF1cEFcgyVPOEPUq/61SXtv1bN/BnUewuuhHxkdbS5w=;
        b=LqGh94i3Qcgxr21oZrNEh11S+NhCrP90ebDn1xDiA8/PCr008rJNg+kg/QPm5b49Gp
         h4/n50yBR+ThFMOpWi2tBVgW6tGxpbPRHtGenwnxTq3p9KPD3BOgURHdwZIUe0w3jQul
         ruyvCNAGPZCbJiV80qHMTA5AolOAQnp+SpocnmRIJluODRM4fj1eLgmwMJGtcWlyU5cp
         U29fdybqNTQNzNr1Akb8Z0anuZYqiW+73GlqQCQeu+px27pAXzbpxYnsfPduk/JKobyM
         HM4+WS6digp1PdFuzSCyRRJXtMObGhw8oYSJOUeaLH1lO7s1KePURFcGj7h11Af59Ztm
         rSIA==
X-Forwarded-Encrypted: i=1; AKwUvBxPQ4H0TD5gcBqdh/F74iFP/9Ax7dkt4632W3E2zmpnSKvW8q3yiMPUZj2uVeEfnHhs+AJSgg==@lists.infradead.org
X-Gm-Message-State: AFuF++ll6JGVxPMAO786Gd+RnJoifgIH6lpmzDcLiNN6hLzkncoau5C6
	doX8BPxO4sxmPHY0wQoLldx8gYoFAiCULvy8/F7Lioo0hl+bL5bDN/Ga
X-Gm-Gg: AYBFou3BDo2VeKpMYHoWUdm8Qk5oC7GW5ss2pK3JuRsj0s+76FOZnm4meDcb1iwmxi+
	Cks0YpvyX8shKpKWi47ROtxZOcm2+lAr+HFyKUNUcCjrcoG8WIDyTqMwG37yUTW6wni4CwdeheB
	F2DHg+28kekD0yQlTChXbRnTaEDlkn49tZMtU/iIeJf0jeCE8dcYPzsBL0R05nNuQSsgMi4ZSO5
	u1Zvj0fqnihZL2H4GDUXRj2NimBaZdZWmEzGw8eRndioBIEYua1goPO2bYjjR/j7jCNmhF3ZQ2T
	nzKAGIBhjM1u9sUtRDYilGvz38Et1fDWZc0QDzcFq2ZbzCuLz2FXIHCrHAeDNSXHU5ygBWywl0w
	VLZzt2Xd9cV9aQpsODUmr65ckD79/iSiqgsm8vDXpwmDhgsvtY5O8UtzjAcobYVropF2M8cT+iX
	Aqol0+aNKsTnZQ+PDT98c3iFoAF+vr9dL0Wdx6JCtXuM6L31h35jt0Tos3ww6wsAi+tXiiiV9KS
	3eR
X-Received: by 2002:a17:906:4789:b0:c24:e0dc:8b66 with SMTP id a640c23a62f3a-c260c8dc700mr1541952166b.6.1788960648727;
        Wed, 09 Sep 2026 06:30:48 -0700 (PDT)
Received: from localhost ([45.112.44.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c262ccca940sm616338266b.18.2026.09.09.06.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:30:48 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 9 Sep 2026 21:27:47 +0800
To: sashiko-reviews@lists.linux.dev
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	kexec@lists.infradead.org, Pratyush Yadav <pratyush@kernel.org>, 
	Dave Young <ruirui.yang@linux.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Baoquan He <baoquan.he@linux.dev>, linux-arm-kernel@lists.infradead.org, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/9] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <aqFeOaIxKNMKVOTM@Rk>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-2-coiby.xu@gmail.com>
 <20260909005311.B1E471F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909005311.B1E471F00A3A@smtp.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_063051_004938_464403A1 
X-CRM114-Status: GOOD (  21.22  )
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

On Wed, Sep 09, 2026 at 12:53:11AM +0000, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
>New issues:
>- [High] Prematurely clearing `is_dm_key_reused` breaks the ARM64 kexec_file_load retry loop and defeats hotplug dm-crypt key reuse.

Thanks for catching this issue! I'll send a new version to address this
issue.

>
>Pre-existing issues:
>- [High] Mapping crash-reserved memory with `kmap_local_page()` causes out-of-bounds reads if dm-crypt keys exceed a single page.

x86 is not supported so I think this concern can be dismissed.

>--
>
>commit 9cf0538566bf6406e97a7f29629856abff44a5b0
>Author: Coiby Xu <coiby.xu@gmail.com>
>
>crash_dump: Fix potential double free and UAF of keys_header
>
>This commit addresses a potential double free and UAF of keys_header when
>loading dm-crypt keys for kdump. It establishes an invariant to free
>keys_header at the end of kexec_file_load unless reuse=true.
>
>> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>> index b70f4df15a1ae..1a0ca54adc9a4 100644
>> --- a/arch/arm64/kernel/kexec_image.c
>> +++ b/arch/arm64/kernel/kexec_image.c
>> @@ -110,6 +110,7 @@ static void *image_load(struct kimage *image,
>>  		image->nr_segments -= 1;
>>  		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>>  		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +		crash_dm_crypt_cleanup(image);
>
>[Severity: High]
>Does this call to crash_dm_crypt_cleanup() during a retry loop unintentionally
>free the keys_header buffer?
>
>Since crash_load_dm_crypt_keys() unconditionally clears the is_dm_key_reused
>flag before returning, any mid-retry cleanup performed here when segment
>placement fails will see the flag as false and wrongfully free the valid
>keys_header buffer.
>
>>  	}
>>
>>  	if (ret) {
>
>[ ... ]
>
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index c685497cd470e..f638fb4b8554c 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -84,18 +84,25 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>
>[ ... ]
>
>> -static void get_keys_from_kdump_reserved_memory(void)
>> +static int get_keys_from_kdump_reserved_memory(void)
>>  {
>>  	struct keys_header *keys_header_loaded;
>> +	size_t keys_header_size;
>>
>> -	arch_kexec_unprotect_crashkres();
>> +	keys_header_size = get_keys_header_size(key_count);
>> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>> +	if (!keys_header)
>> +		return -ENOMEM;
>>
>> +	arch_kexec_unprotect_crashkres();
>>  	keys_header_loaded = kmap_local_page(pfn_to_page(
>>  		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
>>
>> -	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
>> +	memcpy(keys_header, keys_header_loaded, keys_header_size);
>
>[Severity: High]
>This is a pre-existing issue, but does this copy read out of bounds?
>
>kmap_local_page() guarantees mapping exactly one physical page frame. If user
>configuration has enough dm-crypt keys (e.g., > 10 keys, where each struct is
>388 bytes), keys_header_size easily exceeds the 4KB page size.
>
>Copying beyond the single-page mapping will cause out-of-bounds reads and
>could trigger a kernel panic on systems with HIGHMEM or when
>CONFIG_DEBUG_KMAP_LOCAL is enabled. Could memremap() be used instead?
>
>>  	kunmap_local(keys_header_loaded);
>>  	arch_kexec_protect_crashkres();
>> +
>> +	return 0;
>>  }
>
>[ ... ]
>
>> @@ -441,18 +458,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	r = kexec_add_buffer(&kbuf);
>>  	if (r) {
>>  		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>> -		kvfree((void *)kbuf.buffer);
>> -		return r;
>> +		goto out;
>>  	}
>> +
>>  	image->dm_crypt_keys_addr = kbuf.mem;
>>  	image->dm_crypt_keys_sz = kbuf.bufsz;
>>  	kexec_dprintk(
>>  		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
>>  		kbuf.bufsz, kbuf.memsz);
>>
>> +out:
>> +	is_dm_key_reused = false;
>
>[Severity: High]
>Does prematurely clearing is_dm_key_reused here destroy the state needed for
>the segment placement retry loop?
>
>On ARM64, if the first attempt at segment placement fails, the kexec load
>code retries the loop. Since the flag is unconditionally cleared here, the
>first iteration will clear it. When the retry cleanup executes in
>image_load(), it will see is_dm_key_reused == false, freeing the keys_header
>buffer and leaving subsequent retries without the required keys.
>
>>  	return r;
>>  }
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260909003657.1570544-1-coiby.xu@gmail.com?part=1

-- 
Best regards,
Coiby

