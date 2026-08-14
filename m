Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCB2C5B572
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8O34Xc16ur4O9EtunTdCdf0boIbkU6LPLycJBfuzuA=; b=1DkIWEB8hcifpHyQTqZe+zpcw6
	OgSg8V1KddNCQY/Q2EPJWaljCpwKoB1m/Pr99jZwuvIp4+mSmKkqxHzu1FOmNj75Llv2Mg2QopcUc
	aiGn/orEXXfMZ5om59xGBFIgNqH3XCattbHbJboaR0QSpsSduciqxfvrY0nk0DDijlqJbWwhTkZtW
	wkITWDsX20wjaS3MbFxWMSUFr8CKL96fiWEOUfgI3qIyz281Dh772pc+dwy6PthZcB1roUXdmltDL
	O++RUwkiWUkhuGMprHVv5Jpc1Tl0weHPNSDbpvKbfBSra/G/cBV7eAggxDeIni27xkqxriuFs/p9Z
	vya61nxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wumpN-00000002EeP-02Vh;
	Fri, 14 Aug 2026 07:59:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wumpK-00000002EdP-0c6c
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 07:59:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8O34Xc16ur4O9EtunTdCdf0boIbkU6LPLycJBfuzuA=;
	b=KYdH2HFJ0Shi2CfnI9jve/f8gBwg2KBsLCGl4JKrjEgmMXzhfc5d3WZ/AWOWJfchPHjNBO
	keKIjI6a1f6qGaKtl7zrTPZHaJjKL58uKWY/GqG06Kt0wc6bw/qbnB54JbzbJQ9JeNhp4w
	dqSDl30JO9HelhSAwS7ify9ZwGnG7L8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-zofVLlF0NNG91seOyAqLhg-1; Fri, 14 Aug 2026 03:59:24 -0400
X-MC-Unique: zofVLlF0NNG91seOyAqLhg-1
X-Mimecast-MFC-AGG-ID: zofVLlF0NNG91seOyAqLhg_1786694363
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so1585158b3a.2
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 00:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694363; x=1787299163;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8O34Xc16ur4O9EtunTdCdf0boIbkU6LPLycJBfuzuA=;
        b=YzyUQHdnLtO1wMSXxPpuNyNHFdz6o9kP9YssHekfLIhjeo2j9HIaK9rvq9sdIoKMVM
         uaQ2d1lWL9EblB8hC0rq+VrsEe+bHNz+FzWgbdH7wgenCpJiDxV4iVdoY5MD+WfijyZs
         ehzUFjikNhKlRHGtBThjbohvdAh1mCf0u2pHP2ssGTkgJfF80NHPKUehE131waeUQga7
         +bKVZmICX9BK5lVhVS6eIsrfg3P9tZ192BAk12CDepu+xsB1bsovaEPk8ckptftxxaoU
         qk/f8zXoGXmM9SQPkZGGLdxWhDQ6Qyked3Sbv9jlcf6Iuey73YGtn9tzzBu0zjrvJ/Ed
         yDcA==
X-Forwarded-Encrypted: i=1; AHgh+RpdNoZMMWUnpAPGwhwwSW/mElJQQb8KUNfcbYHbho3n000YYMgq9NR1CkYip89LWbUFY/QFGQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6kfceMduh9GQ4JnYUvm3jt2ED6Do0gWJhh3HlBK22JKpL8jTs
	rpL7YMx4V4cNSdx+R0UHZyGc6E3LP62NalVb6uDtoPwFSdhz4QEmEx6Phm/irJ5ILEbLi3hMbTV
	zBHQxl+XvrG57yxeEWqVtFjgpKJlKoJPoGYwExPBmcAdIFn2Dms+wkwtKuAzgNQ==
X-Gm-Gg: AR+sD125o8O4i611X3fHDWpIpaIIyEAp2LFaolRFh2zbMAH21fSFRLnOxtzlxaZ6OH3
	4aCz1WsBOuYJu7rK70rZX9Jp1/8MFp5/HOODA9P7qdNJPG42WRrW5JMVrwlG8NWS9dj6YDmKI0M
	ybbd2A5YloJO9H+Iawm8mkbyk9yK9MM2q+7iO2O20ComYBAitkH99FAUy2fxlBUcbzmGPyNf+sD
	T10YUck5dJ3LMdysf2tIBnqnDKiZxdIO6Nva+A5riJTQVQR3D1mtwrsTnDY9UAmHy3HwKg+V5zq
	n6+tGRMBOMdd6KfeKF5eSIw5RSsc0AUrm4O+h99Og3Kgb0DM4voSoBFuH81mYMLXGQ7cZLPXOKf
	IdEh0+dBn/5WBOHTM1g==
X-Received: by 2002:a05:6a00:2d98:b0:84a:646f:193 with SMTP id d2e1a72fcca58-84fdde42b9bmr3951015b3a.0.1786694363303;
        Fri, 14 Aug 2026 00:59:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d98:b0:84a:646f:193 with SMTP id d2e1a72fcca58-84fdde42b9bmr3950974b3a.0.1786694362810;
        Fri, 14 Aug 2026 00:59:22 -0700 (PDT)
Received: from [192.168.1.2] ([122.171.16.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d249b26sm121142b3a.43.2026.08.14.00.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:59:22 -0700 (PDT)
Message-ID: <81cb568c-e65f-4359-9c6f-f994f910f2f1@redhat.com>
Date: Fri, 14 Aug 2026 13:29:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: return -ENOEXEC from image probe functions on
 mismatch
To: Philipp Rudo <prudo@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Tao Liu <ltao@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org
References: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com>
 <20260813151350.6b511155@rotkaeppchen>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20260813151350.6b511155@rotkaeppchen>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AEqt3dy8xsJ0Rga_VSEdTJq3Sw4hwyb78koheGjiYyQ_1786694363
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_005942_258086_37D904BF 
X-CRM114-Status: GOOD (  22.19  )
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


Hi Philipp,

On 13/08/26 6:43 pm, Philipp Rudo wrote:
> Hi Mukesh,
> 
> the patch looks good to me.
> 
> There is also a corresponding kexec-tools patch, which was accidentally
> opened as a Github PR (https://github.com/horms/kexec-tools/pull/12).
> It will be sent to kexec@lists.infradead.org shortly.
> 
> Thanks
> 
> Reviewed-by: Philipp Rudo <prudo@redhat.com>
> 
The kexec-tools patch has now been posted to the mailing list.
It can be found here:
https://lore.kernel.org/all/20260814075329.30203-1-mpilaniy@redhat.com/

> On Thu, 13 Aug 2026 12:36:29 +0530
> Mukesh Pilaniya <mpilaniy@redhat.com> wrote:
> 
>> Several kexec_file_load() image probe functions return -EINVAL when
>> they do not recognize the image format.  A probe function that rejects
>> an image should return -ENOEXEC to indicate that the image is not a
>> recognized executable format.  -EINVAL implies a problem with the
>> syscall parameters, not with image recognition.
>>
>> kexec_image_probe_default() iterates through registered loaders and
>> returns the last probe's error code to the caller.  That error
>> propagates as the kexec_file_load() return value to userspace.
>> Returning -EINVAL from a probe when no loader matches is semantically
>> incorrect and misleads userspace about the nature of the failure.
>>
>> Return -ENOEXEC from all probe functions and their helpers when the
>> image format is not recognized.
>>
>> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
>> ---
>> branch: next-20260812
>> base commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
>> ---
>>   arch/arm64/kernel/kexec_image.c   | 4 ++--
>>   arch/loongarch/kernel/kexec_efi.c | 4 ++--
>>   arch/riscv/kernel/kexec_image.c   | 4 ++--
>>   kernel/kexec_elf.c                | 4 ++--
>>   4 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>> index b70f4df15a1a..101259874d44 100644
>> --- a/arch/arm64/kernel/kexec_image.c
>> +++ b/arch/arm64/kernel/kexec_image.c
>> @@ -25,10 +25,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>>   		(const struct arm64_image_header *)(kernel_buf);
>>   
>>   	if (!h || (kernel_len < sizeof(*h)))
>> -		return -EINVAL;
>> +		return -ENOEXEC;
>>   
>>   	if (memcmp(&h->magic, ARM64_IMAGE_MAGIC, sizeof(h->magic)))
>> -		return -EINVAL;
>> +		return -ENOEXEC;
>>   
>>   	return 0;
>>   }
>> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
>> index 5ee78ebb1546..28a1d0420ba3 100644
>> --- a/arch/loongarch/kernel/kexec_efi.c
>> +++ b/arch/loongarch/kernel/kexec_efi.c
>> @@ -24,12 +24,12 @@ static int efi_kexec_probe(const char *kernel_buf, unsigned long kernel_len)
>>   
>>   	if (!h || (kernel_len < sizeof(*h))) {
>>   		kexec_dprintk("No LoongArch image header.\n");
>> -		return -EINVAL;
>> +		return -ENOEXEC;
>>   	}
>>   
>>   	if (!loongarch_header_check_dos_sig(h)) {
>>   		kexec_dprintk("No LoongArch PE image header.\n");
>> -		return -EINVAL;
>> +		return -ENOEXEC;
>>   	}
>>   
>>   	return 0;
>> diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
>> index 51dc89259f16..963a25f5b55b 100644
>> --- a/arch/riscv/kernel/kexec_image.c
>> +++ b/arch/riscv/kernel/kexec_image.c
>> @@ -20,7 +20,7 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>>   	const struct riscv_image_header *h = (const struct riscv_image_header *)kernel_buf;
>>   
>>   	if (!h || kernel_len < sizeof(*h))
>> -		return -EINVAL;
>> +		return -ENOEXEC;
>>   
>>   	/* According to Documentation/arch/riscv/boot-image-header.rst,
>>   	 * use "magic2" field to check when version >= 0.2.
>> @@ -28,7 +28,7 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>>   
>>   	if (h->version >= RISCV_HEADER_VERSION &&
>>   	    memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
>> -		return -EINVAL;
>> +		return -ENOEXEC;
>>   
>>   	return 0;
>>   }
>> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
>> index 3a5c25b2adc9..89a444a00693 100644
>> --- a/kernel/kexec_elf.c
>> +++ b/kernel/kexec_elf.c
>> @@ -172,7 +172,7 @@ static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
>>   
>>   	default:
>>   		pr_debug("Unknown ELF class.\n");
>> -		return -EINVAL;
>> +		return -ENOEXEC;
>>   	}
>>   
>>   	return elf_is_ehdr_sane(ehdr, len) ? 0 : -ENOEXEC;
>> @@ -236,7 +236,7 @@ static int elf_read_phdr(const char *buf, size_t len,
>>   
>>   	default:
>>   		pr_debug("Unknown ELF class.\n");
>> -		return -EINVAL;
>> +		return -ENOEXEC;
>>   	}
>>   
>>   	return elf_is_phdr_sane(phdr, len) ? 0 : -ENOEXEC;
>>
>> ---
>> base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
>> change-id: 20260813-mpilaniy-ffb0cc92c313
>>
>> Best regards,
>> --
>> Mukesh Pilaniya <mpilaniy@redhat.com>
>>
> 


