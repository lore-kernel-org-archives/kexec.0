Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3965DCAC58F
	for <kexec@archiver.kernel.org>; Thu, 11 Sep 2025 16:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bfboHB9qu5xk51JT6CFCORwu42mssq00krwKtD4BSs0=; b=rd5J1rKh3TbuaoHsqsltgA2rG2
	SrP5jyoGp5lEIij0Yv5YsTjslywrYYP0WHAhgg90nEINVt6gmmbAPohIppoKfLfMHcACxZz+14/eu
	T17uOmRxw99Thd0K1EoEGsZCKYhhopppiogX7dZjvPycLl50Bb52FlKzzxDGsmxoCEL1DOSVJg5su
	YyDA/Gym7B8oZbyu3ky1FMNHu5sbrn8cf7NooWoDbEtbjho1BKPSx9zvslg6z55n3ETfPVKn2IMy8
	5W889iMn4hmUfkHYhTgCE8spuhvEohhe6fVP3GnkvoUcKAL864aYhMDc1y2lK4Yypl/2xksaQJTUP
	7ADCrEgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwkZT-00000004Joe-3kFS;
	Thu, 11 Sep 2025 16:54:55 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwkZQ-00000004Jnu-0VoV
	for kexec@lists.infradead.org;
	Thu, 11 Sep 2025 16:54:53 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-56bde9c6543so114336e87.1
        for <kexec@lists.infradead.org>; Thu, 11 Sep 2025 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757609690; x=1758214490; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfboHB9qu5xk51JT6CFCORwu42mssq00krwKtD4BSs0=;
        b=QD6WuIgWYpObSqK9GBBfjZLkLX6gfBsrq9MjNZ4f9OB6GXjTXdtKTZBjql1sHhh5mX
         ibOrp0v6cK4plRo0W9YVjvMpgBp4Cqpvr3tdCHij9HLuwp/aKNOgG6KJpnYk/V0nFjT0
         99u5ZhAaW6gbxVafUfljKva7nNQhQvP8yXIn2eyNYprnS+QuK6F8kq7nacXzhufY4ObM
         END/9QS4C8TDU/qRTIWj5X4misGiV3raE9hqKNoUjLec6OVdGvh/Gc+wGmsdfInhjNwg
         TlK05jbIprM9lYsZyaaZuxagVDfg7yxCi7dsAlo3KFl1ZrZnTiyhVSaWGtTfKtlwdqZm
         gg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609690; x=1758214490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfboHB9qu5xk51JT6CFCORwu42mssq00krwKtD4BSs0=;
        b=Ollpb4F1gklXzQrJjqYXEJO+WV6sqRxA73hJULPpGGDFV3KpFP55kREd9ufrnNQzOp
         x4rljYt9B7c3Tu86TWzEoH84RHJv/kZcDRvMKynQkC83+7GlcZLEBD6a7SF08iMHeLWp
         nMt6fvjxua3at4ClWkP45d1sBqvcNcKyelmcrDJOWPUjKrt8mkMf9zTLa/gPKtETa++6
         1TsSGMMlbymZ5de0/XjQHu5bhotKEs40u6LdDCrpeKxzzyBNJP/4t6yBrXwmxdBm9Fl7
         QExa1LCHmasrsaGH3f7FaPdCmzFZGIrPHoFuNfsBOIDiOlbUC64I3/LpyEl+FOo8cHGJ
         G9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjv1TDRAKobuFrjQ65MYK5Ye6ZLgSAVYSDEf3mpfFPZZuFhoZGRd3pIpoX9clLbPe+FYG2AA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyoLwelzRRYkvFZ2BjDl0MCWVHFWFobOMv192I3lb8j7L0323w7
	FJ06ijwxGZxm5k3yREUc6l2EqrCfUfD7niofFmzcy6TMT2ZnyzHCiwar
X-Gm-Gg: ASbGncv7L8NKPXTEfSp3HzDi+ehgsdpqPkcItNtxrukukle21gLr30gf93f9KQFjBs7
	bmP44tsUh2Gug611Lx5iAlAuvwEdvVmhTXEK/cW+iR/bppCrXk12jGffukzsPabVs8+jPNSVb22
	pcethckPsmqaS0xcRouLvLXAWVLzQqCxihaGWW1TGIMVzitbnfJK6Nf2gT8y/NPAlhZFtkJxk4d
	cXaMMVA/teJW+KF+QIvx9+yzVJDXUTpyFoLzzg0hukXRESDeJapx01byuMQs0juuTmMQwF8HJdo
	Omxo8iW8H0WqPFkRuniszCoUf+1F2O8uOUi0PDQKOYb1AT8Ii/fqbbGP8HVDMykWuejkt5VWMfj
	iWPWzUAws1AK8l81Sr0yRuI0fEuf/ae5uIdYgac0ZW9uNcocs5A==
X-Google-Smtp-Source: AGHT+IGXwBdnwsXC7werXS6c6WUS/jEPrEOGwp0IA8NfmoP+ydSr3eKuUztbpRmkqaooT6lTRRravA==
X-Received: by 2002:a05:651c:19a3:b0:336:527a:5b45 with SMTP id 38308e7fff4ca-33b52b71534mr29335971fa.5.1757609689465;
        Thu, 11 Sep 2025 09:54:49 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8211d6sm3931581fa.43.2025.09.11.09.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:54:48 -0700 (PDT)
Message-ID: <6673f66b-e854-4502-bfb5-4b46b16fa457@gmail.com>
Date: Thu, 11 Sep 2025 18:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] kho: replace KHO FDT with kstate metadata
To: Rob Herring <robh@kernel.org>, Andrey Ryabinin <arbn@yandex-team.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mike Rapoport <rppt@kernel.org>, James Gowans <jgowans@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 Ashish.Kalra@amd.com, William Tu <witu@nvidia.com>,
 David Matlack <dmatlack@google.com>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-5-arbn@yandex-team.com>
 <20250910165010.GA223810-robh@kernel.org>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250910165010.GA223810-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_095452_185068_EA6068CF 
X-CRM114-Status: GOOD (  19.44  )
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



On 9/10/25 6:50 PM, Rob Herring wrote:
> On Tue, Sep 09, 2025 at 10:14:39PM +0200, Andrey Ryabinin wrote:
>> Store KSTATE physical address & size instead of FDT in kho_data.
>> and initialize KSTATE from kho_populate().
>> To be able to use FDT in parallel with KSTATE place FDT
>> address&size into 'struct kho_fdt' and save/restore it using KSTATE.
>>
>> This finishes wiring KSTATE with KHO, making it fully functional.
>>
>> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>> ---
>>  arch/x86/include/uapi/asm/setup_data.h |  4 +-
>>  arch/x86/kernel/kexec-bzimage64.c      |  6 +--
>>  arch/x86/kernel/setup.c                |  3 +-
>>  drivers/of/fdt.c                       |  6 +--
>>  include/linux/kexec.h                  |  2 +-
>>  include/linux/kstate.h                 |  1 +
>>  kernel/liveupdate/kexec_handover.c     | 60 +++++++++++++++++++++-----
>>  7 files changed, 61 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
>> index 2671c4e1b3a0..844f5b93473f 100644
>> --- a/arch/x86/include/uapi/asm/setup_data.h
>> +++ b/arch/x86/include/uapi/asm/setup_data.h
>> @@ -83,8 +83,8 @@ struct ima_setup_data {
>>   * Locations of kexec handover metadata
>>   */
>>  struct kho_data {
>> -	__u64 fdt_addr;
>> -	__u64 fdt_size;
>> +	__u64 kstate_addr;
>> +	__u64 kstate_size;
>>  	__u64 scratch_addr;
>>  	__u64 scratch_size;
>>  } __attribute__((packed));
> 
> Isn't this part of the ABI which you can't just change.
> 
> Rob

Yes, it is part of the ABI and layout of this struct can't be changed.
But this change only affects semantics of fields, layout stays the same,
so this should be ok.

If we kexec from an old kernel and kho_data contains FDT address,
the initialization of KSTATE will just fail and boot should continue as
if there was no kho_data at all. At current stage of KHO development,
without real users, change like this should be fine.


