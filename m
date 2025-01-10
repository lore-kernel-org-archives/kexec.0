Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65C3E77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XjnAZo6ruk1OKuFWATcJolJe2qu441fKWg1k8R351yw=; b=xkjbPqf80PvPd7dkUOG3JorhKX
	IKdicdvG/9HWFflGcbWEq8cfR38hHmYgSllq9MkWtLUb768KpGWsc3oQDFPSzPCnxwqmGgDbbTV71
	SBNzXa+b4Fy+xnnj/ewYkps+rXZHtl8g2FVhmHSLBFKFkEl/LYc7VB3dfxWbxGcrERokFG+6OWujD
	iJqOUv1n6Z5FJh+rTFkoUscaxObzHNHbhTlgCZmNXl9ShFNJ3zJari67mkoilNySWcWnt7/ruYEYt
	z1L2Pvrgtm0gCbbIKi8tQVeZCVoLOypOvwvMbbBVQ6uFgjxgrPYiZd8RomhUQdx6fzlUzw5rUSlRQ
	nT6AJ0vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWG2l-0000000FdaL-34r5;
	Fri, 10 Jan 2025 14:31:23 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWG2f-0000000FdZc-2Trf
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 14:31:18 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-43618283dedso21145505e9.3
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 06:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736519476; x=1737124276; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjnAZo6ruk1OKuFWATcJolJe2qu441fKWg1k8R351yw=;
        b=QgyjexeQax+rW58j47QqJgpLrqfHibQ5mD1HNJM1FZP6FvuhGFksYXkwC1GmeBHbga
         CGvFgGY9NF9KFYsMq469TNd1nlOV3inbiHDqBKSgTDzX2810o+O1tVL1hNfgAs4Uqvz1
         3RX33+h4nWZ5QaSA7steH0ZrkxqPLF1lNnBuOId+9wrOaipjU7zUm3sy5+X904qbyGgT
         5tAdy8AaAgQFi9cTdgkJ24FBt5AfLu5NkzUBV2t2Renrwpx9+vqIRBUbOx5/AHuqMuk4
         4q07kOEi9YxY1Egj+L6CuepM4kFM5kK3fzjPRUo7/EZ+XqIRkXJ5dM6TrY3ESlnIO2Wm
         0jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519476; x=1737124276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjnAZo6ruk1OKuFWATcJolJe2qu441fKWg1k8R351yw=;
        b=JypgT/mxndCIouONDpCyDB4nCo0bbq+vbr9YH9EQNwX3wLn67ESIrj29ggEU+VfKwv
         Zhtp4+3PpLLJlNGeyROIj8MDauYnutV0N3bZBwpI5fhb5sYTfBw0ddG/2ZImKSrX1Hem
         MNAQEC9+305yHtiLD0VSjDLcZapxP6LMsH8idGbAEV1BZ2QCrrLPSbl5HgCsXTaVvuTb
         gV2/qUf4GlLGA1stU/t+v3DJcfUHq2Esv1pQxLGQLBXofcgdBGSA+BOrBSL0+692fDpZ
         PjzOF0ksZevMd9FFec/Uyog1buhwsUVUyeLdRtgiqZyz9OG3S9vsNw5pWCdfzovn1QvA
         uCoA==
X-Forwarded-Encrypted: i=1; AJvYcCWy7o7jwi7CgUFU5ElGkhNM+45Mcn5ZsrJS76eGXyQwRMtzsJCCfTGYSGjxn5kBsCspgsGGbQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzylhDrLxnRqfA/B9gU+hoUPrLPhRiQDxd8q9MQrAaUhf0LfmQ1
	FXW+Ya7HKKR6dIKNvVV9FIKCMM4CqjZNnRopNz6igfwcgqUNtly9
X-Gm-Gg: ASbGncsShUXEnrNhDT/4uSidAcrKU1nivlAz4vinTGKljDLEltSVkfrjKCpVuTujbGW
	m1cCHm/ZE6u7bExJrtuNaS1VATFoQ4nx5vVdL0xGU3JkS5HiEyUrjkVMElPz9FbiUnw82HAIbRn
	6KkXGTh3JitwAzoMNWygSLN/gUUsSBOifzSjFADeMi5qKLuSYGStiHqgK8KjL9u+LExL8+vqGWX
	acbWnmv2UKRMPZpNOxyvW7dU7mnzlFzl0wwfM1Z9HRiu/0Fl0sAlwP7l5v3Bdtx+Kyxvw19Bba8
	bx4sAlaib1Y7Ow/4HNLUt3BGET/wkxTz3O9XKk7yFqnXI+U3ew==
X-Google-Smtp-Source: AGHT+IGq00rhLc0Ylg2NuJdsWT9ahGisN7BbjecTv7ITNG64U9Bb1M/Ufx7fRwM6+4l70m96C3vDSA==
X-Received: by 2002:a05:600c:3551:b0:434:a781:f5e2 with SMTP id 5b1f17b1804b1-436e26c3c34mr99055335e9.8.1736519475604;
        Fri, 10 Jan 2025 06:31:15 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc860bsm54386535e9.9.2025.01.10.06.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 06:31:15 -0800 (PST)
Message-ID: <d3ee6521-fae3-41b2-a759-e454681dde6f@gmail.com>
Date: Fri, 10 Jan 2025 14:31:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
 <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_063117_640632_76DDBE99 
X-CRM114-Status: GOOD (  22.18  )
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



On 10/01/2025 07:32, Ard Biesheuvel wrote:
> On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 09/01/2025 16:15, Ard Biesheuvel wrote:

>> I think in the end whoevers' responsibility it is, the easiest path forward
>> seems to be in kernel? (and not firmware or libstub)
>>
> 
> Agreed. But as I pointed out in the other thread, the memory
> attributes table only augments the memory map with permission
> information, and can be disregarded, and given how badly we mangle the
> memory map on x86, maybe this is the right choice here.
> 
>>>
>>>> The next ideal place would be in libstub. However, it looks like
>>>> InstallMemoryAttributesTable [2] is not available as a boot service
>>>> call option [3], [4], and install_configuration_table does not
>>>> seem to work as a valid substitute.
>>>>
>>>
>>> To do what, exactly?
>>>
>>
>> To change the memory type from System RAM to either reserved or
>> something more appropriate, i.e. any type that is not touched by
>> kexec or any other userspace.
>>
>> Basically the example code I attached at the end of the cover letter in
>> https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
>> It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
>> touched by kexec.
>>
> 
> This is a kexec problem (on x86 only) so let's fix it there.


I don't believe we can accurately tell if we are booting from a cold boot or kexec.
There is bootloader_type available for x86, but not sure if we should rely on
that. I think a way forward would be to move it behind a Kconfig option, something like
below, which defaults to n for x86. Anyone who needs it can enable it. What do you think?


diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index aa95f77d7a30..31deb0a5371e 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -83,7 +83,9 @@ static const unsigned long * const efi_tables[] = {
        &efi_config_table,
        &efi.esrt,
        &prop_phys,
+#ifdef CONFIG_EFI_MEMATTR
        &efi_mem_attr_table,
+#endif
 #ifdef CONFIG_EFI_RCI2_TABLE
        &rci2_table_phys,
 #endif
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 72f2537d90ca..b8ecb318768c 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -287,6 +287,13 @@ config EFI_EMBEDDED_FIRMWARE
        bool
        select CRYPTO_LIB_SHA256
 
+config EFI_MEMATTR
+       bool "EFI Memory attributes table"
+       default n if X86_64
+       help
+          EFI Memory Attributes table describes memory protections that may
+          be applied to the EFI Runtime code and data regions by the kernel.
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index a2d0009560d0..c593ec0d9940 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -11,7 +11,9 @@
 KASAN_SANITIZE_runtime-wrappers.o      := n
 
 obj-$(CONFIG_ACPI_BGRT)                += efi-bgrt.o
-obj-$(CONFIG_EFI)                      += efi.o vars.o reboot.o memattr.o tpm.o
+obj-$(CONFIG_EFI)                      += efi.o vars.o reboot.o tpm.o
+obj-$(CONFIG_EFI_MEMATTR)              += memattr.o
+
 obj-$(CONFIG_EFI)                      += memmap.o
 ifneq ($(CONFIG_EFI_CAPSULE_LOADER),)
 obj-$(CONFIG_EFI)                      += capsule.o
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fdf07dd6f459..f359179083d5 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -596,7 +596,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
        {SMBIOS_TABLE_GUID,                     &efi.smbios,            "SMBIOS"        },
        {SMBIOS3_TABLE_GUID,                    &efi.smbios3,           "SMBIOS 3.0"    },
        {EFI_SYSTEM_RESOURCE_TABLE_GUID,        &efi.esrt,              "ESRT"          },
+#ifdef CONFIG_EFI_MEMATTR
        {EFI_MEMORY_ATTRIBUTES_TABLE_GUID,      &efi_mem_attr_table,    "MEMATTR"       },
+#endif
        {LINUX_EFI_RANDOM_SEED_TABLE_GUID,      &efi_rng_seed,          "RNG"           },
        {LINUX_EFI_TPM_EVENT_LOG_GUID,          &efi.tpm_log,           "TPMEventLog"   },
        {EFI_TCG2_FINAL_EVENTS_TABLE_GUID,      &efi.tpm_final_log,     "TPMFinalLog"   },
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9c239cdff771..4cf5ebe014e2 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -783,9 +783,21 @@ extern unsigned long efi_mem_attr_table;
  */
 typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *, bool);
 
+#ifdef CONFIG_EFI_MEMATTR
 extern int efi_memattr_init(void);
 extern int efi_memattr_apply_permissions(struct mm_struct *mm,
                                         efi_memattr_perm_setter fn);
+#else
+static inline int efi_memattr_init(void)
+{
+       return 0;
+}
+static inline int efi_memattr_apply_permissions(struct mm_struct *mm,
+                                        efi_memattr_perm_setter fn)
+{
+       return 0;
+}
+#endif
 
 /*
  * efi_memdesc_ptr - get the n-th EFI memmap descriptor

