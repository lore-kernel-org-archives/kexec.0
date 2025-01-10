Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47696E7719D
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/c1zoXGuzll6xGx17OnRXhTktRZuXOkRRbzbli15PE=; b=Nh6a2MGcwkqIY967JBcLfnCKit
	R+p8KVvDUHPAuH3z4thO+OYL1yszVePh2Cwz0M2DszaFmUenAfE2mIwvRJej06hlOlSgmaMwBTQUG
	DhgviJu1xJ8ULeYTmOxmcCaZl/FWU3/A6z8bf6iMdOJ9Y+a0hR0BdaHAWxQuQ1YLM+y/FqJNe18BB
	aoX14qJ8Tvepz4gzhGSAbctTs2RYcOrpEP/wcb/l79fWtxxCPbyoyIo3nyzs844O8foUrU9d2o4+m
	0XjwEMT6Zpa0m6F4AF9+0TtAD0J2K9RVzJY/qiMoqkb4I1ymXXkofOdUTmep4UpUVDkQTjhLy5M91
	IdUdZKnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHev-0000000GBAR-01bT;
	Fri, 10 Jan 2025 16:14:53 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHGv-0000000G5rP-2JUN
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 15:50:06 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso1926942f8f.1
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736524204; x=1737129004; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7/c1zoXGuzll6xGx17OnRXhTktRZuXOkRRbzbli15PE=;
        b=cAAyBkhp6KMabvtYYg/W6pe4BGq/XJ7TgmlfSlePKdUtBIaOA517GCvKyMDrmj4N9l
         MbtupXy3hJCF9lHzW/oWJmQvo6Rn7DgJhHYVqh7GXLwUkNXKTBJblrs6S5aHNh+aZrWh
         AU8Tl4PoMVxbGlVi4YZMZ8p7xEFxeCBYK2AYcPJJIg8nOnES+9WlgzeD8ba+C0qOxK+q
         XK9PT0QEJDoWSRhVC+DIAuoq5Wz+8KwffNadHV55NA56Xm+qI0TTeErMCnzYq3+BCFMH
         JvMYRz7VWIyTBL0VtEHCBSJXG6K81zES8tazYmVuUbNsUW8FwgoMpzm32koH0G25qBEc
         B1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736524204; x=1737129004;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/c1zoXGuzll6xGx17OnRXhTktRZuXOkRRbzbli15PE=;
        b=H88aCf/uOrklmHxrayqFqFBB+rufAbQn1WINhMMAw3TQV9oHV39ucCCDqTbPmpqaQM
         k9vJ2QBuNK6LqminfiXx5DPsVT4tgDlojacxMfjbUrpyGE5SQpiWdQB4fe/VIVhp9LVv
         46z6k00JZk+ijLDUlX6PGZCBjRecDUXJ+YR7fcQdlkt6+7zY8n5HF/O8fqI2VnrUvh9e
         NM3EhtM5X6WWyzoay6gSmcL9sCZy1C5+8ItStYFKoVxzDV2KxCx8fbxI8zO1Jz19N7UB
         d2P0qLpaJno8qt97hPsVu4Qp84+1a0GIKUsjLZyoDpa+UTMEkDMTlMAz5j5ilNNduawB
         rz6A==
X-Forwarded-Encrypted: i=1; AJvYcCX44nHCqemFqwovGv+IJa60NsSiwFKO1+4Uf6XM99FXgT/z+3NrFypjMlmWOIAEuXd2uaHcRA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzaz1cGMMqto8Vo3K38zOmvw0DxeTjzVL9oTHCVh+c8A9FwpFQl
	QxN/HN2Rx/BTewD3PGBkehl+bOCtu1Ip6FfpTauUi8W1/S8SSwwH
X-Gm-Gg: ASbGncswz4jBP0hBA/mT4an7VcADnlJQH8UVF11AtN6EdyQYe2pAakee6m9dIgA3bqe
	383ZmnU1Vjk9Rrm7sZk7OG1H4d90K06Cw21RJxuQ6hM77KUSYNJ4Ft6NrIJk1+sPYKN1fF0IT0z
	aChq8Tc3CtNjuk3CV1Ofx3EN/x+JsNu4QTSKIQillIa+iFmvLDVy1SCXTqKBFGBG6HGgLE3Po7m
	EKKHG038GDYPpMK0eISfD5eU5ItYPJzVlefMwU0jkl1EP6ojd/8NXHKTwouNQK6ONM63sDoB4K+
	QdTVfy7ZjwUx2lHK9GaPzys5SukumnBljkORZaVcFLwZtQbJqw==
X-Google-Smtp-Source: AGHT+IG99ba+3EjbnJDKEadpRExVV0uXfnt4rvpxoh7E9vujPX4RITwsVLvUeQ3NSOG9KobH9SAa/A==
X-Received: by 2002:a5d:598e:0:b0:38a:8b56:f6c with SMTP id ffacd0b85a97d-38a8b56119emr6950772f8f.14.1736524203663;
        Fri, 10 Jan 2025 07:50:03 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1dc6sm4864460f8f.96.2025.01.10.07.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:50:03 -0800 (PST)
Message-ID: <fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com>
Date: Fri, 10 Jan 2025 15:50:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
From: Usama Arif <usamaarif642@gmail.com>
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
 <d3ee6521-fae3-41b2-a759-e454681dde6f@gmail.com>
Content-Language: en-US
In-Reply-To: <d3ee6521-fae3-41b2-a759-e454681dde6f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_075005_596784_2955D90B 
X-CRM114-Status: GOOD (  20.36  )
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



On 10/01/2025 14:31, Usama Arif wrote:
> 
> 
> On 10/01/2025 07:32, Ard Biesheuvel wrote:
>> On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 09/01/2025 16:15, Ard Biesheuvel wrote:
> 
>>> I think in the end whoevers' responsibility it is, the easiest path forward
>>> seems to be in kernel? (and not firmware or libstub)
>>>
>>
>> Agreed. But as I pointed out in the other thread, the memory
>> attributes table only augments the memory map with permission
>> information, and can be disregarded, and given how badly we mangle the
>> memory map on x86, maybe this is the right choice here.
>>
>>>>
>>>>> The next ideal place would be in libstub. However, it looks like
>>>>> InstallMemoryAttributesTable [2] is not available as a boot service
>>>>> call option [3], [4], and install_configuration_table does not
>>>>> seem to work as a valid substitute.
>>>>>
>>>>
>>>> To do what, exactly?
>>>>
>>>
>>> To change the memory type from System RAM to either reserved or
>>> something more appropriate, i.e. any type that is not touched by
>>> kexec or any other userspace.
>>>
>>> Basically the example code I attached at the end of the cover letter in
>>> https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
>>> It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
>>> touched by kexec.
>>>
>>
>> This is a kexec problem (on x86 only) so let's fix it there.
> 
> 
> I don't believe we can accurately tell if we are booting from a cold boot or kexec.
> There is bootloader_type available for x86, but not sure if we should rely on
> that. I think a way forward would be to move it behind a Kconfig option, something like
> below, which defaults to n for x86. Anyone who needs it can enable it. What do you think?
> 

Or we can do something like below?

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index d131781e2d7b..4add694b18d0 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -24,6 +24,15 @@ int __init efi_memattr_init(void)
        efi_memory_attributes_table_t *tbl;
        unsigned long size;
 
+#ifdef CONFIG_X86_64
+       /*
+        * On x86_64, do not initialize memory attributes table
+        * if booting from kexec
+        */
+       if (bootloader_type >> 4 == 0xd)
+               return 0;
+#endif
+
        if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
                return 0;

