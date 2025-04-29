Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAA9C3ABA5
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZo61+eEgTcVCv0fnGtdIxIWd9KmIQ33ES/RWrkQ7PY=; b=WwLqXD7bOYfDGeOPMK8FtRtpMz
	o1c4OvVh11j96Pp3fKec2HguY0US44lpGufk1yANpM6g80zc3H+Q01ycRSFGLwkr4bwu/npmR8Dnh
	8o4VZ9oRmBgh4m7DmXSl6vEARj+wvg0ScFrfC1Ke4ZHJSJg0b6pj4QAGf5N0Te3FeOxdjvsQYi0KT
	BPmJ6lcf9k9mW4C5yKdC9QOyzvv+w1Y75i8Zh0ZrXutZwrhp279MmAOwGHv6vY/Rm+4ja+xzaDHBv
	RkMRaIQhrsNQtoq1YwbUVM4OIJh2NbVg57llgQlctxA86mbwi0I0B2dswrlEXsecQcGi2Zp+6d67M
	IxxcFwlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nge-0000000AEgs-2iMx;
	Tue, 29 Apr 2025 16:20:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nTc-0000000ACow-0iV1;
	Tue, 29 Apr 2025 16:06:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eZo61+eEgTcVCv0fnGtdIxIWd9KmIQ33ES/RWrkQ7PY=; b=CCphn17JYcuXSuEnvuvqmWbD7A
	Nq4L509ZFZkXeYJXiUXJClRV91J4+MqMnhYVly8r4qVptl+XUXadxDmlO4U/2tZ7wuYrJfUxWr950
	9KV59vgqtotUmoEAkWI7KOtIFrdIXdcp4q+IVvYe+ROMNI0PQrKkFSmatxHn7DYsVTS2A/HxKDWiF
	+i9pinV55NpliHzCaAg4K3lJYtDpU26q2a+YtrkdneuJ+HE2+mKk0htdDFp7FU9QahgYQGDSm9cWb
	6+hWp12iOzQWq3MU6+pXo7nVr/0QhaAtk/+N+RQswRAldrTpDRncEK5MBWFR49/N0UOKuzgx10rdt
	D0izakww==;
Received: from mgamail.intel.com ([198.175.65.17])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9nTX-0000000DSym-1nHU;
	Tue, 29 Apr 2025 16:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745942787; x=1777478787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2+za/Wd7mqbVhiX4qWwpSAKjWmTdOR4nplZwpcx+ko8=;
  b=G5V5VMx4RxUcXTFcW480DLszm7bQ3I7eRXdX8tcZuEmcowJwZhHegOKW
   JHq+OTFMX3hFsMA5GIzK+HAWhwtWcEALyhepMB7u0PhumVXa+pQzYCOez
   I8oJSUyEVbOEJ7rZxWWRFP4VwwKp+/13dcAtqsWu8eWXR+GwSBw6VyyJl
   IcONKSm4V86b2aWjIeqeFpXP5kQb99gkia2NigvEcoTaIEEXzl4yvvSIw
   XPuTJfz/u0d40jltz2WMAKijJ59nBVmwQTSIyRCJfGCa7TZwIUyCUYT3A
   XCOHMdWS+p1JPdhUcx6YjlVYdHiRnIPmOAbl9JayqhDkmv3x9hrSY7Q0L
   Q==;
X-CSE-ConnectionGUID: jL965zCeRpikrM1oVFGM9Q==
X-CSE-MsgGUID: V6/uyNX2SJyWmq5OM4bggw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47585241"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="47585241"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 09:06:23 -0700
X-CSE-ConnectionGUID: jprk9LZTRiGvaEpFCgNi7g==
X-CSE-MsgGUID: 4izxWN+ZSo2csuyrRFsyNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="139055788"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO [10.124.223.107]) ([10.124.223.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 09:06:21 -0700
Message-ID: <d64a4593-c9bd-42c7-81f6-137a22ff5caa@intel.com>
Date: Tue, 29 Apr 2025 09:06:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/14] x86: add KHO support
To: Mike Rapoport <rppt@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
 ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
 catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
 devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com,
 graf@amazon.com, hpa@zytor.com, jgowans@amazon.com,
 kexec@lists.infradead.org, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org,
 ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org,
 saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de,
 thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
References: <20250411053745.1817356-1-changyuanl@google.com>
 <20250411053745.1817356-12-changyuanl@google.com>
 <35c58191-f774-40cf-8d66-d1e2aaf11a62@intel.com>
 <aBCIhQjKKyaAuvC9@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <aBCIhQjKKyaAuvC9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_170628_147036_5576DB0A 
X-CRM114-Status: GOOD (  17.49  )
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

On 4/29/25 01:06, Mike Rapoport wrote:
> On Mon, Apr 28, 2025 at 03:05:55PM -0700, Dave Hansen wrote:
>> On 4/10/25 22:37, Changyuan Lyu wrote:
>>> From: Alexander Graf <graf@amazon.com>
>>>
>>> +/*
>>> + * If KHO is active, only process its scratch areas to ensure we are not
>>> + * stepping onto preserved memory.
>>> + */
>>
>> Same thing on the imperative voice here.
>>
>> I'm also not fully understanding the comment. Do these "scratch" regions
>> basically represent all the memory that's not being handed over? It's
>> not obvious.
> 
> Scratch memory represents areas created at the boot of the first kernel and
> it's known that scratch areas won't contain any memory that's being handed
> over.
>  
>>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>>> index 57120f0749cc3..c314212a5ecd5 100644
>>> --- a/arch/x86/kernel/e820.c
>>> +++ b/arch/x86/kernel/e820.c
>>> @@ -1300,6 +1300,24 @@ void __init e820__memblock_setup(void)
>>>  		memblock_add(entry->addr, entry->size);
>>>  	}
>>>  
>>> +	/*
>>> +	 * At this point with KHO we only allocate from scratch memory.
>>> +	 * At the same time, we configure memblock to only allow
>>> +	 * allocations from memory below ISA_END_ADDRESS which is not
>>> +	 * a natural scratch region, because Linux ignores memory below
>>> +	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
>>> +	 * allocations, we must allocate real-mode trapoline below
>>
>> 						trampoline ^
>>
>>> +	 * ISA_END_ADDRESS.
>>> +	 *
>>> +	 * To make sure that we can actually perform allocations during
>>> +	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
>>> +	 * so we can allocate from there in a scratch-only world.
>>> +	 *
>>> +	 * After real mode trampoline is allocated, we clear scratch
>>> +	 * marking from the memory below ISA_END_ADDRESS
>>> +	 */
>>> +	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
>>
>> This isn't making a whole ton of sense to me.
>>
>> Is this *only* to facilitate possible users that need <ISA_END_ADDRESS
>> allocations? If so, please say that.
>>
>> I _think_ this is trying to say that KHO kernels are special and are
>> trying to only allocate from scratch areas. But <ISA_END_ADDRESS
>> allocations are both necessary and not marked by KHO _as_ a scratch area
>> which causes a problem.
> 
> Yes :)

So, on both of these, could the submitters please add or revise the
comments to make it more clear?

