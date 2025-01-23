Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F852C02182
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 09:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cdsakhgboM6VWeRvwFvLq5VoOiUv/svy6u+PKuSLJbw=; b=XXYQ+5AIpHALg66PAyTccQ92mh
	SMcXwaGRr25vGQOkPOYZWuKBDfCEB8+9sOcjGRt+pHJooNs+LMKmrQE+QIdagXf4Cp2m/mw0FE4Q1
	zGu4DfeDXr6wxDtgF6IpDUf/UlEaNb9mrACnYMovQgFwy2K0xa9tQAtmafQ/zRKLMJ9n4IWCvx84S
	XoahwPpDGPCU0/QknkYjKmoXzgcNFwGVH/gHuga+CmSxt6QGFsm/koCws3alZJDlfHaVunUi4HE/M
	LJMcfWtCVan/KSpa2x69iG/Q7UZH4HnDcfBZ4h5xCBCiPuM2Up2U41MI74zpLvcJbovAUKi3HyVQJ
	NJOV5fSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tatLj-0000000C57T-3P6B;
	Thu, 23 Jan 2025 09:18:07 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tatLh-0000000C56Z-2gYO
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 09:18:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 66226A4068E
	for <kexec@lists.infradead.org>; Thu, 23 Jan 2025 09:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A243C4CEEA
	for <kexec@lists.infradead.org>; Thu, 23 Jan 2025 09:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737623884;
	bh=cwVbpER6j1F84CaEftcblW1AjMF+eT07Jp5Ea0UZq18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hQAuzL9ReXztjmjmw9mtKLNaC6QnhlVMLVm2uwvKOKMa34YAzVGubogED6ABFYdwP
	 DXhRiEkogOVKpEVTZWZlizGpLl49Vrpb2owiWnZ7rsxtiLQzRjLAi/oktuOhn4DOYW
	 WrVyi5yK2Y0ke/MUJL1OqdIWB2KzjMuz59s/MkmtSiO3ayiRO8hNqLwqMHL/GHmd2N
	 kNZjwThcJKVhIDCOAcDFrgUwBaJl0Y5SMNa1SYUU6G615Eo2eRcsvAywsiNG/DAZyz
	 VfJxeCNKkoYRJmAw2+7XrV88AxiCfIUZX+T1OLVQqOCCcC4wsVl1TyzTfIk0cuCNcT
	 dRWKXSWVa/Wqg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3072f8dc069so6604331fa.3
        for <kexec@lists.infradead.org>; Thu, 23 Jan 2025 01:18:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULOeXTEHx77ZNCUySGHQ3nhxwkG14qGQiB5TboCUpWOTjx09mG+TIY5nmY2XgNIuGvb7c94g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0Qgx7J++a1wOgBu9fTHrtXrARbrJQL8t+bsMvcsFX4gieuuDq
	FWdRfiKv6eaR7xB4ssnA3oyvvlt6NATBL0Ca48IltnsC0V6mYPJacQEZL+js6qwM6rqNfKnEKB7
	Qm+TV2jWd/bINzkVoxWUDYHYkMk0=
X-Google-Smtp-Source: AGHT+IFg5anTPNIwZuGThorwrA/7bluFKX5hdt4Mvyrgzh1VDjtaql2A/D3p2BY+f8cyS4uQ6EUccU0NX+ll7knhcsw=
X-Received: by 2002:a2e:a98e:0:b0:302:27ea:a56e with SMTP id
 38308e7fff4ca-3072cb3ee90mr100096001fa.32.1737623882947; Thu, 23 Jan 2025
 01:18:02 -0800 (PST)
MIME-Version: 1.0
References: <Z5Hja30Wb94uGQ3L@darkstar.users.ipa.redhat.com>
In-Reply-To: <Z5Hja30Wb94uGQ3L@darkstar.users.ipa.redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 23 Jan 2025 10:17:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH6yorrBNYyuO2YrX_Q4cCW8LoyHOZMb=a5k0Euuooznw@mail.gmail.com>
X-Gm-Features: AbW1kvb-93ZaeBmySOwZwTV0VF9jUFmzHZKRgAk2dsgRXgVRcwKkn0oNXh6Qwok
Message-ID: <CAMj1kXH6yorrBNYyuO2YrX_Q4cCW8LoyHOZMb=a5k0Euuooznw@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: skip memattr table on kexec boot
To: Dave Young <dyoung@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, kexec@lists.infradead.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_011805_747602_58DD3F62 
X-CRM114-Status: GOOD (  13.61  )
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

On Thu, 23 Jan 2025 at 07:36, Dave Young <dyoung@redhat.com> wrote:
>
> efi_memattr_init() added a sanity check to avoid firmware caused corruption.
> The check is based on efi memmap entry numbers, but kexec only takes the
> runtime related memmap entries thus this caused many false warnings, see
> below thread for details:
>
> https://lore.kernel.org/all/20250108215957.3437660-2-usamaarif642@gmail.com/
>
> Ard suggests to skip the efi memattr table in kexec, this makes sense because
> those memattr fixups are not critical.
>
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-and-tested-by: Usama Arif <usamaarif642@gmail.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Dave Young <dyoung@redhat.com>
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 846bf49f2508..553f330198f2 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
>
>                 if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
>                         ((efi_config_table_64_t *)p)->table = data->smbios;
> +
> +               /* Do not bother to play with mem attr table across kexec */
> +               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
> +                       ((efi_config_table_64_t *)p)->table = EFI_INVALID_TABLE_ADDR;
> +
>                 p += sz;
>         }
>         early_memunmap(tablep, nr_tables * sz);
>

Thanks. I've queued this up now.

