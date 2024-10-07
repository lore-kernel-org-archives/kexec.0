Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B17CFB43F
	for <kexec@archiver.kernel.org>; Mon,  7 Oct 2024 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IVHt80NndmslJHdftUtpTcPIM6AcuY2js0SgdvREzB8=; b=JG/ZhrcIyHY4WI
	mxuKleYRpsvj5V0goAUpAnhdYp0lDXd/dnFXokTnJJDuTYZejr0wo3k7aIxprZR0WsPVf6VEJZf1R
	zxDP8/Jq/wWKv5PHTYTSdv8rFQ4rEsy/I6B371LNv0Oh4faB+8r1wk4qWDmbnp/4+rT6XdVMp92Xo
	G67xgQDHm8+H3TCUKC3CMj5mAsTKnCZVJnktKo0eGjjfIZi/Isl3h0sIgUSMDlo26U5JmU4iPAvJ6
	xxVL/bPtm5VV3KicDgQa/cUQMjS82tdvj41c2uvfWeeYYEf+rMyP/8DQGXyioX8WKPO77hSDmzoj1
	FWlDuPSm/hDnAuEp1y8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoU4-00000002esm-1dBa;
	Mon, 07 Oct 2024 14:13:12 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoNr-00000002d3w-2pRi;
	Mon, 07 Oct 2024 14:06:48 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a994cd82a3bso202074766b.2;
        Mon, 07 Oct 2024 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310005; x=1728914805; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdQ4yGHqhJQxjQ94zkFj9YscA03Tg1UyYYIoS94UNGE=;
        b=iRziJ7kQbtHIks7pyvYAnfs6BUjCJdF8/OCZAPe3ci0f9JhfJUD/6PtEKEUUSPMShC
         mUsADEoB014b5zl2K5ZMaEqJHY1YHyjfXoW0EDYHNEKU+Z29SOAo2HuMfOsAWhHDd5ps
         kTOzmjPGcHz8S01HuD20Vuccg0JiCC3BEoOSKYf44dC1shvt7vhQ3tRjWT7dgaccwNkH
         pSkaeWIL4qZ4AjcoVCR3MkgjiDJm3qw5xeR/OS1baz2zKF1psFI3DMVQsffs0knmzhCa
         jV5iIi+J3GWwPV16Fl2vURf1vhrmW6tQdi3Gmm6KBtCmUC05idK0leWh8g23+gyF5hqh
         ZeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310005; x=1728914805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdQ4yGHqhJQxjQ94zkFj9YscA03Tg1UyYYIoS94UNGE=;
        b=IX/RGichbgqMtNx6w2vUef0Z6rWnUaJ3uI1cxEn5BJEpDTMoWqnUv98Z2aBqOGjv6I
         Qq3Eik8yj5KH/wz2GwoTw1zFagYoV2dsl/RpS2p5wNnLKDBIXKBIq9Hmze3op0waPWr7
         NScE6eIpROw0y0SV0a327NWVN2iCH4Kf7lw6gHu0cf8YTGk4A92f8vs0XwZxi5KVDkgu
         QjDeUrCPhS32RbIJ8ZnMCJZzCr70oS/RkOQkpa0BxtSK/j1dhUMAEKfUL/yIH3+NbuKf
         wKJWJ4bmgyi134ogUSsTqNVPGvAQCgYjSvuSizpvNEOs0m5BD2r0f65EFY6GFBKsXPTa
         jGrA==
X-Forwarded-Encrypted: i=1; AJvYcCWT5N3j6BEGn2gSaExzCkzDx5HgI5VCO5Ve06XfyqZfd1mazBxX5poHerwBw2prr8mOU6HQXQ==@lists.infradead.org, AJvYcCXITekRuiekoVFYbvs6iqvHqSGxBpBl8wFs1fRxj0MPl6vcRWykWWS0UpMFntPT1JYFH+f3p2fxSFcfSeWScdctwg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyK2h7qJd/3FdxueZvCDAryLQj8CyeCTKMVI8m1ety3fN/0fymp
	t4M/etOBKF/ehhYvo9oOFd5nE8eNI1SwYNSPhMZEAU4kwhYyr8DY
X-Google-Smtp-Source: AGHT+IHzTf9/mOydaRIHtAD1WG+qTiC3dn2gaVfrhGsXeLY2d2YXJzxhT6uT0jaK87guDPp/jNDboQ==
X-Received: by 2002:a17:907:972a:b0:a8d:555f:eeda with SMTP id a640c23a62f3a-a991bce5aecmr1377640066b.8.1728310005084;
        Mon, 07 Oct 2024 07:06:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:3232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f74e13csm187218766b.164.2024.10.07.07.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:06:44 -0700 (PDT)
Message-ID: <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
Date: Mon, 7 Oct 2024 15:06:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org,
 catalin.marinas@arm.com, saravanak@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241004000316.GA1910499-robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_070647_752104_EBC49500 
X-CRM114-Status: GOOD (  19.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 04/10/2024 01:03, Rob Herring wrote:
> On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
>>  __pa() is only intended to be used for linear map addresses and using
>> it for initial_boot_params which is in fixmap for arm64 will give an
>> incorrect value. Hence stash the physical address when it is known at
>> boot time and use it at kexec time instead of converting the virtual
>> address using __pa().
>>
>> Reported-by: Breno Leitao <leitao@debian.org>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
>> ---
>>  arch/arm64/kernel/setup.c | 8 ++++++++
>>  drivers/of/fdt.c          | 6 ++++++
>>  drivers/of/kexec.c        | 8 ++++++--
>>  include/linux/of_fdt.h    | 2 ++
>>  4 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index b22d28ec8028..a4d96f5e2e05 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>  	/* Early fixups are done, map the FDT as read-only now */
>>  	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>>  
>> +	/*
>> +	 * Save dt_phys address so that it can be used later for kexec. This
>> +	 * is done as __pa() is only intended to be used for linear map addresses
>> +	 * and using it for initial_boot_params which is in fixmap will give an
>> +	 * incorrect value.
>> +	 */
>> +	set_initial_boot_params_pa(dt_phys);
> 
> No new arch->dt functions please. If we need to save off the PA, then do 
> that when we set initial_boot_params.
> 
> Rob


initial_boot_params is set in early_init_dt_verify, called by early_init_dt_scan.
This is done in setup_machine_fdt in arm64 where the PA is available,
but in other functions in other architectures, where the PA is not available.
So it makes it quite messy to set it in the same place as initial_boot_params.
Its only needed for arm64 and making a change in all archs probably isnt a good idea?

Any reason to not add a new function to make arch -> of/fdt call?

Thanks,
Usama




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
