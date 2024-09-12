Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32826EED613
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qgha7QimDNT9IWqhCDlK8a5nwnc+LMY7ciMB5JS5D2U=; b=ZzvKD6kkFwPHjN
	bXaxaip6J2xvj9ZPNvrccCN/RLolUjxRJ7vRnCxkOo8iQ+CrGCkQs67GTSrlgdI3XGprFJl6Pf/Mr
	OON/OnJYzGk3zlIPuefSIh1h8JjLdkiI8+rcwhRuIzNFXGesAf9MOGsYNUqScFHFbNySD0q66xZ3a
	iOqAFBAsDcCblkuCVNZG2upAgsFYfwROFcNvR1irOHT7HtcD2oSjOVN7fxxWa1VoHDj20ait9vtgv
	G0Gcy8anw2BLFdyvSfc2rFhg1hON3T1QT9Jc5THluhAcv78r/5gUUAhJHC+39VhENc7Hu15USEujO
	pgTOGL9g3pa6gCve9Ixg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1solqk-0000000DZxM-2ES2;
	Thu, 12 Sep 2024 15:35:14 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1solqh-0000000DZwd-07Jq
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 15:35:12 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so1160572f8f.0
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726155309; x=1726760109; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0RYORsO9RSRQ8Ioex3F7hf3hojejMNnxlRBDN5pkaA=;
        b=d5ZliqSzI762mPzP81/u4IfwZw9EHmmKim71/F+6XZo0Q60V2FCTbqM8mbWQN4ah6e
         ycqp9I62ENq8plmQe9mDsHkeSD95VAVFEJHH4bH5xRvMzy334wA4FP9OBlqKmiDG+vNk
         1QHyjnn+s1jiKGGaSdvANq8m3msXz2AwPLhlpSdP02wBMoIyNEIcjND/rhLjHUbYLy9G
         yFPEL8l+O31+PBs0mC99Tx8YRDjOAYrQPnUKt1yjnM9qJAvIBpSsUr7qGVumjXH+PzNT
         2XHAgrd5CgzQKW26GqQVxNRFINtGNyg3RXRJxTkZmi84Q349mkLxP8IhfGqJmxl5NtNg
         DjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726155309; x=1726760109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0RYORsO9RSRQ8Ioex3F7hf3hojejMNnxlRBDN5pkaA=;
        b=RjyirhvNHJfRAJ6sYhTsKd2/I7vLXP21ZxRh6FbxJn0g58v3mZBWkjsLmf4Od8BYrv
         pjDrHNOdxqYCUYeG1blqTMUSH/PqwLddDr0GidnIFGpVUnjsv348yukt/Fpi5AOPGGSA
         w8XIUGjURdFBYZMRYdcj5V2iWJ4m5uS99xKzEiP//K37UsiVgbcOlTCbFPCTCFb/8trV
         ABc9aKp0F0Jn3Bhn5CIfJXfaW21n5jyIPZOGdZ3/CDDmREL4YVtSvDXGeHjpfxlM+RyQ
         S7Se/SvXnJrYacpubuG5jomM0nXyDsksMKASUQoaHpsovYxhCrmjhrR1wixZ9qteU/ua
         OjHA==
X-Forwarded-Encrypted: i=1; AJvYcCVP3e+VvXwwSAgaRq1mhy8R+T0/sI22bW0CQoLJk6AWhusJjCZKQAGFFe5kKQyoewifmOrgNA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKmZHyHBl5bMEOYby/CTiI93PuIIKTTpuplDqS1LhLD7shqOlF
	QKsA+VyWjc35FHTjI6urS4BbtFXKBmxHJTS1fU/roh3ecGLOfLDM
X-Google-Smtp-Source: AGHT+IFXuaRB4REQ196i6uJBPCKixLywzCDFF6ZO0mWYedPQxpp3dIPVKUmizW8iLHQMtjHNotnZeA==
X-Received: by 2002:a5d:67d0:0:b0:374:d29e:6db8 with SMTP id ffacd0b85a97d-378c2cf4ad4mr2768741f8f.16.1726155307755;
        Thu, 12 Sep 2024 08:35:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:5725])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a27a9fsm756906866b.91.2024.09.12.08.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:35:07 -0700 (PDT)
Message-ID: <9d3962f1-96b6-44a3-a7d3-10fbfbe06164@gmail.com>
Date: Thu, 12 Sep 2024 16:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
 tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <20240912-sapphire-koala-of-focus-918cff@leitao>
 <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_083511_113243_09B24BFB 
X-CRM114-Status: GOOD (  32.39  )
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



On 12/09/2024 16:21, Ard Biesheuvel wrote:
> On Thu, 12 Sept 2024 at 16:29, Breno Leitao <leitao@debian.org> wrote:
>>
>> On Thu, Sep 12, 2024 at 03:10:43PM +0200, Ard Biesheuvel wrote:
>>> On Thu, 12 Sept 2024 at 15:03, Breno Leitao <leitao@debian.org> wrote:
>>>> On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
>>>>> I don't see how this could be an EFI bug, given that it does not deal
>>>>> with E820 tables at all.
>>>>
>>>> I want to back up a little bit and make sure I am following the
>>>> discussion.
>>>>
>>>> From what I understand from previous discussion, we have an EFI bug as
>>>> the root cause of this issue.
>>>>
>>>> This happens because the EFI does NOT mark the EFI TPM event log memory
>>>> region as reserved (EFI_RESERVED_TYPE).
>>>
>>> Why do you think EFI should use EFI_RESERVED_TYPE in this case?
>>>
>>> The EFI spec is very clear that EFI_RESERVED_TYPE really shouldn't be
>>> used for anything by EFI itself. It is quite common for EFI
>>> configuration tables to be passed as EfiRuntimeServicesData (SMBIOS),
>>> EfiBootServicesData (ESRT) or EFiAcpiReclaim (ACPI tables).
>>>
>>> Reserved memory is mostly for memory that even the firmware does not
>>> know what it is for, i.e., particular platform specific uses.
>>>
>>> In general, it is up to the OS to ensure that EFI configuration tables
>>> that it cares about should be reserved in the correct way.
>>
>> Thanks for the explanation.
>>
>> So, if I understand what you meant here, the TPM event log memory range
>> shouldn't be listed as a memory region in EFI memory map (as passed by
>> the firmware to the OS).
>>
>> Hence, this is not a EFI firmware bug, but a OS/Kernel bug.
>>
>> Am I correct with the statements above?
>>
> 
> No, not entirely. But I also missed the face that this table is
> actually created by the EFI stub in Linux, not the firmware. It is
> *not* the same memory region that the TPM2 ACPI table describes, and
> so what the various specs say about that is entirely irrelevant.
> 
> The TPM event log configuration table is created by the EFI stub,
> which uses the TCG2::GetEventLog () protocol method to obtain it. This
> must be done by the EFI stub because these protocols will no longer be
> available once the OS boots. But the data is not used by the EFI stub,
> only by the OS, which is why it is passed in memory like this.
> 
> The memory in question is allocated as EFI_LOADER_DATA, and so we are
> relying on the OS to know that this memory is special, and needs to be
> preserved.
> 
> I think the solution here is to use a different memory type:
> 
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version,
> efi_physical_addr_t log_loca
>         }
> 
>         /* Allocate space for the logs and copy them. */
> -       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> +       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>                              sizeof(*log_tbl) + log_size, (void **)&log_tbl);
> 
>         if (status != EFI_SUCCESS) {
> 
> which will be treated appropriately by the existing EFI-to-E820
> conversion logic.

I have tested above diff, and it works! No memory corruption.

The region comes up as ACPI data:
[    0.000000] BIOS-e820: [mem 0x000000007fb6d000-0x000000007fb7efff] ACPI data                                                                                                                               

and kexec doesnt interfere with it.

Thanks,
Usama


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
