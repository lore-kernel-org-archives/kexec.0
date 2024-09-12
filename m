Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09195EED606
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MrUOtp7Gbcmyyjx4j73d9qA9hO0Y+QJE/nhErGLcKmQ=; b=UX/aJKe/JmpYKU
	NMqsy7lTfYUf/YNRljxSPZPPPX191CABpCf86SYvHsS6BZO75bSYVMsW/AHoLJIE4UhWidQ/7kaUO
	4Iai9R5ie0CreqAv7PZl/NgFAkASnn4MSGQ2NXGLpfbQjbZsODbFJmrHA/d2Y1pyH4AXKE7RXCgpL
	CWvM0QRNT69HQhrp2Fe4Mcd67H8pK07PvubjxuVJGGHAAZ+7/bg5duysEoliMNny3C3MWFji74h5M
	sP4ZEhManvqszq3OEvNUgksgr0Y6+UslMlOC0ZzFJpF1614o+MbbDIAf+2Z+2CtzBvXOctoqZGoU0
	6aR7nW72NjKdEJriMwbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokHn-0000000DGvO-018u;
	Thu, 12 Sep 2024 13:55:03 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokHj-0000000DGtr-43fk
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 13:55:01 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so155744266b.1
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726149298; x=1726754098; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1G5qVhSpJn+iV45COy44bHVmW0jeUlHnhOjcc2IqBg=;
        b=PGInxH9bSMa3QDBiMpO9vloeE7zekpdHNbME9vfQfEC6LG6Iy9xfhcz1pEwFEf6tUd
         WFvG6hySLqIK2FSc0Jue3w7yP4IspMhpKLBcjNMxNKGwVxLaEM/teHYBgwYcrubyTYhS
         Sh1vgbsjFpBVdirInvMAy1Wg9Ot9+HOSruKpfk2RksKSgSRUK8nPufJwcEzAuaSHx3QY
         7mV+pKLwAnkpkpdPzdPokxsa0JlCDf+U618Z+Uzjfrb7AXvrpYtP6vePu8GWMinmn92o
         Sm3f5xVcwwpRN6RH7xl1jR1kPU1o/O6At9adiZtEEaQfR6UiAlUpglYPNIW5E9kfOF9G
         rpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726149298; x=1726754098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1G5qVhSpJn+iV45COy44bHVmW0jeUlHnhOjcc2IqBg=;
        b=Fw1naAKtHVNhL7KgkRcEl67gAsMUc8Dr+zYNDY1kxI1wVX2y/IpAkz8U8TSOvH5YDS
         u5jA2Q70fmylw5e/FAGJJ51KUzNzAkF59BGvTuhR6ucV8XPlIZ4LfSOUGJ3udpOAbe+q
         8vILxRWxbjGbispEUSEmd49ycYHG03FW61T2NTVoF0TXlTiED4joVS35RpEB5eKBlKy9
         aUf/pxyCpAgolGOOM+woZzpyLnZ6c6wKg1tMpmgyFaH7PjPz+SLA4JoMo46zAJZeN/fp
         PNnRRT4rdFgg5+yuZVHeENo57AaBc1gUWYLyVkbDdOJbs2aYX9MaUV+Dyqdr2EeH6EDo
         62sg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ01+Xr6uOMv22wbZti1bnOzT8k9p1Bm6lt3HlNUoCjOvHkM+GT2vd4HQUX+8CJfu8uHj8lQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YypJFn/hG+YcfX0/EbnC+pbeOBPbu1hVVqmPPRCSudnR9bfWxq4
	b5SyqwZ3l+ArnmHkk3XZiJNwkSMcLq2TEZKURUt/ZCw1u7NaaL37NgoeBw==
X-Google-Smtp-Source: AGHT+IGHyggpXdC19jbQjmV+z/3GczJJNtHI7cEPIGNXAzJMFOl3VDvtIn7uWtgy0U0A/cj483cK+Q==
X-Received: by 2002:a17:906:c151:b0:a8d:5d28:8e0d with SMTP id a640c23a62f3a-a90296175a4mr320642766b.45.1726149297648;
        Thu, 12 Sep 2024 06:54:57 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:5725])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5dda8sm744523866b.211.2024.09.12.06.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:54:57 -0700 (PDT)
Message-ID: <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com>
Date: Thu, 12 Sep 2024 14:54:56 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_065500_040699_F652566F 
X-CRM114-Status: GOOD (  10.05  )
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



On 12/09/2024 14:10, Ard Biesheuvel wrote:
> Does the below help at all?
> 
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
>         }
> 
>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> -       memblock_reserve(efi.tpm_log, tbl_size);
> +       efi_mem_reserve(efi.tpm_log, tbl_size);
> 
>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>                 pr_info("TPM Final Events table not present\n");

Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
which is e820_table_firmware.

arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
its end, just with e820_table_firmware instead of e820_table.
i.e. efi_mem_reserve does:
	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
	e820__update_table(e820_table);

while arch_update_firmware_area does:
	e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
	e820__update_table(e820_table_firmware);

Thanks,
Usama

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
