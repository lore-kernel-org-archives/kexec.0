Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE17C982D6
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TAR8zhCOEVqWXPt6vBsjOMeeQmFuBz9UsZFbgyML5lo=; b=DH6j+z9gmtQdNXJ3Hh1GemNiNj
	kzGBfXIEM/cqUWkKG1Fm3M+nTs5EGfXkB76Xo3+68c3JO0gWZCGlcpZNX14EmKv2ANneW7tvYP2fB
	f8k2J7/G2MDzYLIL1/cUsdHyH6XPiKNAQv6bUIqi9DCPFG5V43M1WjykDnLoKRk0UDkSYKoUNZxA2
	QLvUKNra7RnVwJ9+cBJt3rWkAELNlfHgmqa+oynBjn2+meHjsjEr35P+690ZaIBxUrgGFThoq2pxi
	RJKTToz62+P64i8FoFpShatxjItmb2cjA2OlMe5uQ+AK3ZkxZcI1IUchQp+2rZZqR46hzEsLydNNI
	C5ImPaNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7WE3-0000000E9jv-3rFm;
	Fri, 18 Sep 2026 10:53:51 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7WDy-0000000E9j5-1E23
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 10:53:47 +0000
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so3986675ad.1
        for <kexec@lists.infradead.org>; Fri, 18 Sep 2026 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789728825; x=1790333625; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAR8zhCOEVqWXPt6vBsjOMeeQmFuBz9UsZFbgyML5lo=;
        b=NP/AXqZEBj4qh+4CQoloMtTZi3ddfXJFlqPMZ0oDBg7PkRd+q6vW4a50xIMU9kbhmX
         BNr9EX5qrPfvt0AeaeVCKF2xI+kog61j0KQy1ZSq9RtEbunjGBnfJpQ8zc6SoicDKZpj
         cjcDaez3qtzhqDD3cKBKerPbK6KbDqNXNoF8sN4R1Wq7L3A2GEuWD+QnYDAR4V+/5t3s
         m76eNR5thSI4VkiH22Ki2teykprAAAX5Fb/CsNNJLimbdgLgTNtB/giTaIg9GWan+ISr
         ua+RlZU6+F6gImvNbMEzI2JNWJY51dRLkTvq+VUJpgFGm1e9MSXZhVfm9+sMIWGaltOK
         K9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789728825; x=1790333625;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAR8zhCOEVqWXPt6vBsjOMeeQmFuBz9UsZFbgyML5lo=;
        b=l/9I7avArlvcgIBoDQfvIyMM9/7okrpd1oCzx6vq1pDh1MqDAqthmv9DBvQ6pHsawS
         7Nwjmcvd8ByRfKLfI7zfoV3+SpWHH1EfFtbLW07DN7zLAbvd47fqDOIqzciLWIythWxZ
         8SQ8pl0UCUsZNGaPSoS58+80iJZtRxj3EvPK+wPQMuI2XSXt0pzLAjCfdAw7H5EHUhap
         swowoP88KteM1BT3HMjv/shAquFi1HQejPuikHZAVsKJ3dnmtACH53w1AK7Vsc3yfJmV
         wE3SSbmXcF/I5myh1iTozuirwC4uBHHR9JVNAXwggsA3GJAmXrLFe1McA3Pm50PxtY6p
         kEMA==
X-Forwarded-Encrypted: i=1; AKwUvBzD6PwNLkCZV9llsNbUst8PsmSmDro0b8sCoF6YO/9P2zNV4DxLq/2lBsg5ky0NYLEv+7xSeg==@lists.infradead.org
X-Gm-Message-State: AFuF++mwQaF/BQAwqjw4AHKGkzJV36u+KEHp70bzJ+7vRAHt9xkwqAK3
	TppF+VSsG4NtgHak+wRgELFu5se4a+yTU/qhlmlUf3Jqp/G0NiR9muLP
X-Gm-Gg: AYBFou21a1/JTE7sg1OFCgHoy3iC6jCZOeXVRXiCPwto/XcszNtvKEZSMXtSvNZcm+N
	TBTjzXp7QVzLoQiBpG9cwUI4eNGEl8mNY23TRIAr4L/Dkmq3q/EC8rmppHLCaIa8vFtTIu+TZ6C
	wfbtUPSt/9RQvMWZl8FtK2wwQYynpp35q+UzMJGP3O4djppEDMtovXfWr963wZ03EWQxeWGGThx
	H/vRp3Gj7tAjee7PksclN+YrxvmR+skUujXCu803XLleFeybkmMLzztASMg92IxVOaxnvYrB10X
	oJPCXbvEB5dV7lgqzstkSrqHLl3ikNMWD0ruMlZdwhbBbmxXUu5KFYrCXvXkJJhmaOP8xaNA9zQ
	evlOSncgcKzoxgSUdAV/iaQauTqFQQwahlAMLUHgI9wNv4AEby/hGImm41DF+KL/U3WYoOqc4Np
	2nyYg94uCG5Y3UjbtJLNmYFFuZxn0NmRW1dUh/JqKJULqoXywfV/Q3lOIA1zD+grjfoLbass0oV
	/aiJA==
X-Received: by 2002:a17:902:cecc:b0:2d8:d4d2:d139 with SMTP id d9443c01a7336-2dd9ca3f088mr93269015ad.21.1789728825328;
        Fri, 18 Sep 2026 03:53:45 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb7525b2asm5835555ad.19.2026.09.18.03.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 03:53:44 -0700 (PDT)
Message-ID: <1a47d5de-fb68-4c10-a199-f0d274689cdc@gmail.com>
Date: Fri, 18 Sep 2026 18:53:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
To: Baoquan He <baoquan.he@linux.dev>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
 alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <aqzznOgILX2pZg7b@fedora>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <aqzznOgILX2pZg7b@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_035346_324791_CEAC93B1 
X-CRM114-Status: GOOD (  12.11  )
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



On 9/18/26 16:17, Baoquan He wrote:
> On 09/02/26 at 03:31pm, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
> ...snip... 
>> ACPI systems already filter reserved memory out of the vmcore through
>> their existing path; only DT-based systems currently fail to filter these
>> regions, which is what this series addresses. The flag lives in memblock
>> itself rather than in a DT-only structure, so the mechanism is generic and
>                                                                  ~~~
> The patchset itself looks goot to me, while I am concerned if it's
> really generic. I raised that in sub-thread talking with Wandun. Imagine
> I tried to exclude many driver regions and split memblock regions into
> hundreds, cma could yell out: cma_declare_contiguous_multi()?

Are you concerned that setting the MEMBLOCK_NODUMP flag could split a memblock
region into many smaller regions, which might then prevent
cma_declare_contiguous_multi() from satisfying a multi-range allocation?
If so, IICU I don’t think that applies here.

MEMBLOCK_NODUMP is currently only set on memory that has already been reserved.
These regions are excluded when iterating over free memory, so marking them NODUMP
does not increase the number of free regions seen by CMA.


Before marking NODUMP:

  memblock.memory:    [ free ] [ reserved ] [ free ]
  memblock.reserved:           [ reserved ]

Now, for memblock.memory, it is one region that contains free and reserved memory.


After marking the reserved region NODUMP:

  memblock.memory:    [ free ] [  NODUMP  ] [ free ]
  memblock.reserved:           [ reserved ]

for memblock.memory, it splits into 3 regions, 2 free regions, 1 nodump region.

Although the memblock.memory array may be split internally, it does not create additional
free ranges for cma_declare_contiguous_multi() to process.


> 
> IMHO, withdrawing the claim can fix the nit concern. If I am wrong,
> please help point it out to let me learn more.

I will revise this description to avoid any misunderstanding.

Best regards,
Wandun


> 
> Thanks
> Baoquan
> 
>> both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
>>
>> Since the reserved memory regions are filtered out, the vmcore is
>> smaller in size and faster to produce. 
>>
> ...snip...


