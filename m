Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B86606A320
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ftl4iLH8;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n039RvLz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M5BOmtE/8D5RrPoWo6N/EKi/wginAI3FukwfrzZJ0T4=; b=ftl4iLH8H8+68tNM9e4DvBH6WR
	DGhzB8COUjaDXSMkFp+lKRyp3AyotAbLvXUFhW6mkuWBltwuJ8e6/JGI/3hymXoFPdvNPlLXPa1Vz
	lavbKuo8xiowe4LtaJO9nkYJt6YBv1iwTcwtbAWVtv0LdUFMkHJ7SksCymMf+Crbp58L15Md9AtMR
	TSSZGaHlgknwOPfjxqxA0YWjHLsSA8aDKe1ghp1Nd05aAUAupVXCiPz8NVtgNmdHMsLNoUbWX66Pe
	OuMePkhbIy+5uph+rhHCVsm0ed6sy9U1+2F4RGaZ+bVq2FgxTWtE/ordlhu6LzVUknLkRJ/od0sXU
	zKSMwGkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMW1I-0000000AGKV-37DD;
	Thu, 29 Oct 2026 19:42:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMW1H-0000000AGK7-2zck
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 19:42:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DDA83407B0;
	Thu, 29 Oct 2026 19:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BE91F01816;
	Thu, 29 Oct 2026 19:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793302958;
	bh=M5BOmtE/8D5RrPoWo6N/EKi/wginAI3FukwfrzZJ0T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n039RvLz2MQBp9BfxMGzLnlsnUbqv3QH+HRwNf04y8I98V0PpNABrMhrQJMeaVmvi
	 3zd85eM31AJtqMMB13jFkSzHv20sMetPAlDdCrnN+gI7jS+LzruLhraQXgfy47gOTT
	 wpDzerJy0E9A5ce5AyJDoETbe3jRVDdWzHquTqzoqF3fmvcdz0PyWTAygUO988r7Re
	 Dfc0Ff9jntdVerieMBs8hG4DiJnjUPBGUKeH9lxbkdygoBOOVImf8qmcqQVIOKmaO7
	 aLxl7AN2nZfGozNkzCESmg2v5yIhJ/KpKEP2Bt8IAMYBLHSy7y/tY1SFFm/cPJ17Yg
	 pNfHWjm/hb5jw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Ard Biesheuvel" <ardb@kernel.org>
Cc: "George Guo" <dongtai.guo@linux.dev>,  "Mike Rapoport"
 <rppt@kernel.org>,  "Pasha Tatashin" <pasha.tatashin@soleen.com>,
  "Pratyush Yadav" <pratyush@kernel.org>,  "Huacai Chen"
 <chenhuacai@kernel.org>,  shuah@kernel.org,  "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  baoquan.he@linux.dev,
  ruirui.yang@linux.dev,  guodongtai@kylinos.cn,  "WANG Xuerui"
 <kernel@xen0n.name>,  "Alexander Graf" <graf@amazon.com>,
  liukexin@kylinos.cn,  loongarch@lists.linux.dev,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 1/8] efi: Pass KHO state to the next kernel in a
 configuration table
In-Reply-To: <2382a0ee-cb6d-4572-be6e-ce3cf4d006e5@app.fastmail.com> (Ard
	Biesheuvel's message of "Thu, 29 Oct 2026 20:28:01 +0100")
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
	<20261029172956.20791-2-dongtai.guo@linux.dev>
	<2382a0ee-cb6d-4572-be6e-ce3cf4d006e5@app.fastmail.com>
Date: Thu, 29 Oct 2026 20:42:34 +0100
Message-ID: <2vxzqzh8mgyd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ard,

On Thu, Oct 29 2026, Ard Biesheuvel wrote:

> On Thu, 29 Oct 2026, at 18:29, George Guo wrote:
>> From: George Guo <guodongtai@kylinos.cn>
>>
>> KHO has to give the next kernel two addresses: the KHO FDT and the
>> bootmem area list. arm64 and riscv put them under /chosen in the boot
>> FDT. LoongArch systems booting with EFI and ACPI do not require a boot
>> FDT, so KHO needs another way to pass this information.
>>
>> Add a Linux EFI configuration table for them, under
>> LINUX_EFI_KEXEC_HANDOVER_GUID. It points to a struct linux_efi_kho_data.
>>
>>   - On a cold boot, the LoongArch EFI stub installs the table, zeroed.
>>     Each kexec'd kernel is given the same EFI system table, so it finds
>>     the same table.
>>
>>   - In early boot, efi_config_parse_tables() reserves the table so
>>     neither the page allocator nor kexec segments use it, and calls
>>     kho_populate() if the table holds KHO state.
>>
>>   - Provide efi_kho_update() to update the table before kexec. Map the
>>     table during boot so updates do not require allocation or mapping
>>     at panic time.
>>
>>   - efi_kho_table_found() tells architecture code whether the table was
>>     found at boot, so it can turn KHO off when the table is missing.
>>
>> Only the LoongArch stub installs the table, and only with
>> CONFIG_KEXEC_HANDOVER. Elsewhere there is no table and this code does
>> nothing.
>>
>
> Can we handle this as an arch table then, and handle everything in
> the LoongArch arch code?

I think this is useful for all architectures that use EFI, not only
Loongarch. Today Loongarch is the only user, but this can very easily be
used by other architectures.

For example, I have been considering moving x86 over to this too. Today
we use setup_data. Once we get EFI support, I would like to get rid of
that and unify everything under EFI. It is much simpler to have a
universal way to pass KHO payload over.

-- 
Regards,
Pratyush Yadav

