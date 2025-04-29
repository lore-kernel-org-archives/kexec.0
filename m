Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832B0C369DC
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+QzDaNGo5NB7iQMYVe4vJtK6G+OOCC2HWSYEH+vC8Ic=; b=TLo06PbIJ1/hRktrjwSGrAV8Vp
	soFkUT0NqC4fsJacwErbbUfwF+vGtRwe30Ww+dm05pp/hPrsSgyURO2fD1xuo8DIT6pbJin8tZu8n
	H9bSCGmVg6LY2cN2vniL5UzbrGOwpJYfgclvkN/qo5LwC/FzXUepIPtTZoBmdlbjF9Y4DNccd0CYW
	OVkuGd0rNaQv7wqRRLgLZIKsywO6/Gs/GoxUdQw/CNDK3I/R1iNIUecWQ8wJd4dZqmSK8PEjhtXmZ
	gawa91XNr0fqDO7SkZTDwL9Quhv6Irnv6/eSeaXApxezKBL+G6HEEGfRzSUNQUTTsLDhwQTPuZjnI
	XxSL9Urw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9ngT-0000000AEeU-42AQ;
	Tue, 29 Apr 2025 16:19:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nST-0000000AChW-40Ji;
	Tue, 29 Apr 2025 16:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+QzDaNGo5NB7iQMYVe4vJtK6G+OOCC2HWSYEH+vC8Ic=; b=mPI3azslQsLlIkrcg9DT2D1ogn
	XlkvdW+phhCaZCj5wV34VJyGpkh+PPn0OPJhk6A0rpafdIhJPiAfUoeeYlGFyJERswPhbN4hktMSC
	yw6v3gX9VnS9ENKP/ddN3TeSt6IdYre4tX9QkCX6QMcJaGeB+/8+F29DWqR7el1tCMbsueo0qSPyT
	CoMqLnkPS6UCuIWgmSZfOuLTsxZTpraBzV+YSs/QXJINXNrwJTbbEQq8YOhhVvCOdc6aMjeYygqk+
	fm2lE1MUvW5h5oRF+5K2dpyOtASy9RIG7RuHCXiCLsHUgWR7VbH0svOlKHZqUINfQ309FLvfPo1Oi
	ua62/h7w==;
Received: from mgamail.intel.com ([198.175.65.17])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9nSO-0000000DSwZ-2CNT;
	Tue, 29 Apr 2025 16:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745942716; x=1777478716;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kc4wP+JTOQYbzdxScoLeIhj26yfCcr1KXX5njmFEzCM=;
  b=TZOdz7mwjLb90W4Uf4nGaSpZTjtmRFD4dBRtH/cGDbjg7rBRQCNODS9U
   BU81LpLTYzuAn2Q88dCszherLXf6/WGSmSNjFfIf1m4A3wQueTBaWShs/
   IAhy0FACRpoiU06i5ND8+J9TVVkH4EgnDhGhWLtQPRYaSnkmOJltQ7RhZ
   Z4NhXYVxTaamGi9174QG6wTz7Ny49LmHdeY3BQOf0FA6l8S5rl5HUcQIa
   6nKAIe6gweozoKHxm8aOU6qMqtkgPDlarHXK5MWtvmxlhMQVAYdV61lFI
   wDflQVtNxzTnJUEDoiAUulH88VoCpX8OHZl2IkVvHyOCEjOgtHx2NZKBq
   Q==;
X-CSE-ConnectionGUID: YvnxJXbVTGejUjD0Q54HDw==
X-CSE-MsgGUID: c41zWuGSS3e5zizGp2wboQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47585026"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="47585026"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 09:05:07 -0700
X-CSE-ConnectionGUID: 4V1xIgNkRNqS84as7fjsbQ==
X-CSE-MsgGUID: qtvKug+WQZ2IK/ghsaacoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="139055434"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO [10.124.223.107]) ([10.124.223.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 09:05:05 -0700
Message-ID: <e90b81a4-a912-4174-b6e9-46a6ddd92ee3@intel.com>
Date: Tue, 29 Apr 2025 09:05:02 -0700
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
 <aBD165pVhOIl3_by@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <aBD165pVhOIl3_by@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_170517_016772_DB129390 
X-CRM114-Status: GOOD (  16.22  )
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

On 4/29/25 08:53, Mike Rapoport wrote:
> On Mon, Apr 28, 2025 at 03:05:55PM -0700, Dave Hansen wrote:
>> On 4/10/25 22:37, Changyuan Lyu wrote:
>>> From: Alexander Graf <graf@amazon.com>
>>>
>>> +#ifdef CONFIG_KEXEC_HANDOVER
>>> +static bool process_kho_entries(unsigned long minimum, unsigned long image_size)
>>> +{
>>> +	struct kho_scratch *kho_scratch;
>>> +	struct setup_data *ptr;
>>> +	int i, nr_areas = 0;
>>
>> Do these really need actual #ifdefs or will a nice IS_ENABLED() check
>> work instead?
>>
>>> +	ptr = (struct setup_data *)(unsigned long)boot_params_ptr->hdr.setup_data;
>>
>> What's with the double cast?
> 
> The double cast is required for this to be compiled on 32 bits (just like
> in mem_avoid_overlap). The setup_data is all u64 and to cast it to a
> pointer on 32 bit it has to go via unsigned long.

Let's just make KHO depend on 64BIT, at least on x86.

>>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>>> index 68530fad05f74..518635cc0876c 100644
>>> --- a/arch/x86/kernel/kexec-bzimage64.c
>>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>>> @@ -233,6 +233,31 @@ setup_ima_state(const struct kimage *image, struct boot_params *params,
>>>  #endif /* CONFIG_IMA_KEXEC */
>>>  }
>>>  
>>> +static void setup_kho(const struct kimage *image, struct boot_params *params,
>>> +		      unsigned long params_load_addr,
>>> +		      unsigned int setup_data_offset)
>>> +{
>>> +#ifdef CONFIG_KEXEC_HANDOVER
>>
>> Can this #ifdef be replaced with IS_ENABLED()?
> 
> The KHO structures in kexec image are under #ifdef, so it won't compile
> with IS_ENABLED().

They shouldn't be. Define them unconditionally, please.

...
>> Please axe the #ifdef in the .c file if at all possible, just like the
>> others.
> 
> This one follows IMA, but it's easy to make it IS_ENABLED(). It's really up
> to x86 folks preference.

Last I checked, I'm listed under the big M: for "X86 ARCHITECTURE". ;)

