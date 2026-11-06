Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F1606A334
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ShJsN5uc;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASq4PFVk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gRVAhGeZWCNMiNHPmygg3aA49aMAiMWPBcpElZA7SC0=; b=ShJsN5uc5yYbo9
	jg7GRMMfokmmdvHDnXVCdXZHYNblj6bArYYGvn3NbAddPNZstE+0ly1UCya4rqon+B/oMzmF/euci
	SJKXcbrup/HxM38v7Ny0Iqr6VuS6CaypmI+zsT51tJ8QokpA6tjersMPXUKcmOyR4fF/b98XEjeF7
	9slPGUK+zkW6R8GWuGWpHW8IWLFRNKhElH5duvZ/3vk3Ux1z32N8E7Kc4vMb6NFJ7w5YOm2+DXWpJ
	erH0lgxZD0g/URAwwiOSpjmVrpENtwDFJ5V4zRX4mMDo1UjBfbCTOrGBYkd/eilipZHh+lnzihqII
	Fox3VY4ovhtC2e7lPGcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPFM3-0000000BagT-3O58;
	Fri, 06 Nov 2026 08:31:23 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPFLt-0000000BaWT-0XlP
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 08:31:22 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so3044795e9.0
        for <kexec@lists.infradead.org>; Fri, 06 Nov 2026 00:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793953871; x=1794558671; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRVAhGeZWCNMiNHPmygg3aA49aMAiMWPBcpElZA7SC0=;
        b=ASq4PFVkHqECXZphvd0vgJV3vkuWvVk09G7r2N+JwRb5YL9chpphaIitVZyV4W+1IR
         l4KQal9pGPxqT6FufNLxusA2NgecS+e6o/NYMTEolIZnBD684IT/+XdT5MUpsZAunUAf
         lGDSY+2I2063hrVu7hpIipisIvmdkPv9eeQApHfnjI2FQdZ51oo2n4nsAoc6As8SO1I0
         yesnK2VD1xBZjKkRJEMkj2cN2bPdWBHntsUmPyHSS99g3CrUe+650UZmNKETtkkw+bnL
         BMGh9js+MPnJ8BFnqVqqSAzSSs8F+dO40YQNirBXlCe4Hn6XobNGK5ExDEAlRZLtVvxo
         1+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793953871; x=1794558671;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRVAhGeZWCNMiNHPmygg3aA49aMAiMWPBcpElZA7SC0=;
        b=y5JJgKNTuwUMygURJv/Q56e7y/2U0cWQupN4N7tPUaJNUcFI3c2i4G5HTk2stYOg1+
         hC/Y9fWzLydGr2DFgMD58NlUkdeO0ErruWK41070DOB79EKetlgqblPPv3XyPGBGiz76
         oYdNbE2RwRF89nxkFhzOybR3HTN0Zly4DY3gYuGz2UFS7/IiU8/IaaFbd6K0y0H8MQNR
         sCPsstnbCTuJ60XuhBU2Uku2e8SvcDP/sCL/5xJuW5zZ5Nun/vaFkVVLeeJCFdF4EPFE
         oFeymi7Cpubzp7M0yMOiX2qYrNDD6mjNdrByzcbXbp4bl3qDD4cZGv/6CiKgv/PbLDAX
         sMzg==
X-Forwarded-Encrypted: i=1; AKwUvBz9GK1xBCM/G4cbCKbUnxj5+dLWnb47S3eM5FZrzq4C/J+6h34D5OHudU2d/kXFCbGlsoL9Dg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+O39/UE8otAhQW4cne1Udhy2A/+bfGI1wD71X7f4J35oCoy6C/
	5n9Hx2whZ6SVoqPeFI2GsMg/z0YPdTTGLkVUXraBEnHF3sv9x61sDaIR
X-Gm-Gg: AYBFou3E2AKQZnh7e/46k8BSkhjmxMZticZ2QN1VyrzvUXLcuImFxJsjXuDdqiDZJwz
	urLCvewREsC67qCbZPWjrROaTlBKNSrJWXC9/8K94wtXrm8SRT/FRZrjAZZAhztP3vVhbd+y/2z
	5etWvbYNAHajKF1/14Uz1V0QZrLWEkbhta8IhPlyv04TAyPsYfFX98yp4Ys+VF8scWmi8M+x8Ef
	R7CJGzpuSeAdlaVe9VtL1tH/rhBX7S+ozXPIdoy7ZawuW6rciu3SPtJC+o3kozBaNWG2Ac7CXjR
	UUcVRN3VYycuAXv9tOldRVVlrL3dNcf3TezNNQEzbGkv+PXDfcpucsE3RlrJ9Rypx+4xvM2b7Ef
	IkGbzsgvmGwJ7EH5C5N0jOTR6x8hQr6XraaM6aMCGKQLNNKz1vpxhU/UctO3rm/o0h7yjx64Pnr
	00l2YhiyIxT955DAHFaUuWZJVYWGqNpgpguZ1s3rxvjckPZVMqmLXmeVfrEMMPO9DX64U2d0M95
	r37pa1rJ8G6TXuFG0e3YSF7QmHhcN0t35r80O+A/B+0SIvgikAGPEneYFY6o6VhCtpwQwG54V6y
	jEoAVL4xFkyjgxD5VzUONsKw
X-Received: by 2002:a05:600c:4f42:b0:4b2:4b5e:8141 with SMTP id 5b1f17b1804b1-4b6df4f2304mr29162125e9.9.1793953870825;
        Fri, 06 Nov 2026 00:31:10 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6dc6e0cfbsm44553765e9.0.2026.11.06.00.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 00:31:10 -0800 (PST)
Message-ID: <40bdc057-7e5a-4904-9f1a-1a36e639e0e7@gmail.com>
Date: Fri, 6 Nov 2026 09:31:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memblock: don't allocate new reserve_mem regions on a
 KHO boot
To: Mukesh Pilaniya <mpilaniy@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Alexander Graf <graf@amazon.com>
Cc: Tony Luck <tony.luck@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>
References: <20261105213153.9572-1-azpijr@gmail.com>
 <d928099c-4e43-4af8-a929-b510819967ce@redhat.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <d928099c-4e43-4af8-a929-b510819967ce@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_003113_248381_626581D8 
X-CRM114-Status: GOOD (  25.81  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 4:57 AM, Mukesh Pilaniya wrote:
> Hi Jose, Thanks for the patch!
> 
> On 06/11/26 3:01 am, Jose A. Perez de Azpillaga wrote:
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
>> Add an is_kho_boot() stub so the memblock tests still build.
>>
>> Fixes: f99230780211 ("memblock: add KHO support for reserve_mem")
>> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>> ---
>> Changes in v3:
>> - add an is_kho_boot() stub to the memblock tests (Mike).
>> - add Pasha's Reviewed-by.
>>
>> Changes in v2:
>> - fail on a KHO boot instead of allocating outside bootmem, as agreed
>>   with Pratyush [1]. this drops v1's patch 1.
>> - not an RFC anymore.
>> - based on v7.4-rc1.
>>
>> v2: https://lore.kernel.org/all/20261104204235.9066-1-azpijr@gmail.com/
>> v1: https://lore.kernel.org/all/20261021211058.83483-3-azpijr@gmail.com/
>>
>> [1] https://lore.kernel.org/all/2vxzfqxglrg6.fsf@kernel.org/
>>
>>  mm/memblock.c                     | 11 ++++++++++-
>>  tools/testing/memblock/internal.h |  5 +++++
>>  2 files changed, 15 insertions(+), 1 deletion(-)
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
>> +		pr_err("reserve_mem: can't allocate \"%s\" on a KHO boot\n", name);
>> +		return -EOPNOTSUPP;
>> +	}
> I think this over-restricts when KHO is explicitly disabled. kho= is an
> early_param parsed before reserve_mem=, but kho_populate records the
> incoming FDT without checking kho_enable. So a KHO payload booted with
> kho=off ends up with is_kho_boot() == true and kho_is_enabled() ==false.
> 
> In that config nothing can be handed over again; reserve_mem_init
> returns early on !kho_is_enabled(), and kho_fill_kimage bails on
> !kho_enable. Allocating the region from KHO_NOPRSRV is therefore
> harmless, and the documented best-effort reserve_mem= behaviour is
> preserved.
> That said, a new reserve_mem= line is rejected and its ramoops/ftrace
> boot-instance consumers lose their region.
> 
> So, Would
> 
> 	if (kho_is_enabled() && is_kho_boot())
> 
> be better here? If so, the memblock tests will also need a
> kho_is_enabled() stub, since
> tools/testing/memblock/linux/kexec_handover.h is empty and reserve_mem()
> sits outside the CONFIG_KEXEC_HANDOVER ifdef.

good catch, will do it in v4 :)

-- 
cheers,
jose a. p-a

