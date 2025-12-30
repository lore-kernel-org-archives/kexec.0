Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DE4EE020A
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3XEZ16r/np+0BpHZEzmtxDGM0fdTpCICHyYjlfdyoeQ=; b=ITAMC8XBXMhB8azy8+ywh/ZE5r
	qMCkUzYY+CxJOrv3K87BDD974qLAtfDWE6Td0BMIeOTYtGuyknYvqy0g9axP23kzj6beDtXN3FDPs
	1PG4GeL4aQIgeBMMh4f0X/gi8VGu5rt5x1Ju9RgE/SmY732JQOr7FP38UQd1ar3DabnV1rTCFFIGJ
	GzzwZO6eA47Z7U08zKuQUzFgb9McBUumaWVnYAWSyIjE7Bqq91ckAnmGaWTnwU5ESGJeLrcoB+Uwl
	/AnvxGdA6YT/w86UQrZdkDECEvh1nTpKgYSIC3avW9YNvJu6T2740P4cN8frfwcf5FVX4hmjPmbND
	9Ret2k5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vabGn-00000004yP1-3X8x;
	Tue, 30 Dec 2025 15:04:21 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vabGl-00000004yON-1SI2
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 15:04:20 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso16712183a12.1
        for <kexec@lists.infradead.org>; Tue, 30 Dec 2025 07:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1767107056; x=1767711856; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XEZ16r/np+0BpHZEzmtxDGM0fdTpCICHyYjlfdyoeQ=;
        b=V2WGOJvduhx3Gj56/SGGxAW1qY2uJZAsOIvos5kjpaEQcve6UtRCcXMSxKBg4rg/o+
         /lxLsddWGlCSHZzMyf4KZLlM5BsLHf+ZYA61qZH8Bo8OlZUM/8gSKilb1gEgUxrRnXrw
         u9A6HefqvOjZqiRv3hK9nahwz9bIsIqIiymepssfw/bArKKNKB6CO9WUtPoHZBY8ql/b
         IVUOHiGMG6yKqTP0VZCrYdwz8qjyK1CC08bihqGifm1gaYieNY/SbinAIJ9yHeqDHs5B
         4+x5wwyPpNdoVztr7hfxLSrMYkCQJhbu0joEJTH7yyLLCNTHXyJvt7GCc0PP798P3r+k
         S8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767107056; x=1767711856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3XEZ16r/np+0BpHZEzmtxDGM0fdTpCICHyYjlfdyoeQ=;
        b=xLsa7QQ/F3V1BKqK6DhUewL/3NdhJO2LZ4fY0jKsQE8yIIy/KKUiCzvqhUdFQ7FqDW
         3BO1QgaGFDS/am6LuywA7JkZs0pBet7xzr8iXVCLL/hFXMKk2aSAS8tS/CflvAXIqVw0
         7YA9jFrCGShGybe1Y0Kf7MFWqkcrjpajeiRrrBCsODZ+yuiUQCAmmeI2mBUgLZu08CIx
         EZ4mCLwc/c6ZO+0D4JAxrglpQ5NiO43u7a7EDPv/3TxYPXCvjQZhh7FcGuHESjkr59HR
         h3tzErQxp4w7ghJ5INT1QNgEBwKBUHzvTKGNfju8WYsT5vrvrcpViRycMmqtHttGuU02
         4wLw==
X-Forwarded-Encrypted: i=1; AJvYcCXATal1g7O1KQdltVS35zHwRbw+pHvrH4Jhif+R7lIANMtEyz6HmScnAmVcE4vbDvCkcdXEkg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyJVg1i/s1f3OUTgXSSay5AGCbQqGiyosoouc6PvYqSA2CsAldb
	wuP6tvqjqpV6gos08CfwwDOKg2purpZdgbOJ/HchdZ9RHmGP0wp8LTYJhUxSTspSlLCHULzKbqD
	BbnZ5ydRz87QOWSB8QShq0BGW6h9pbltEvKqXSWNKf14nAsrjAbTG
X-Gm-Gg: AY/fxX6cE9xCHvsgOm/E6ywFzrFWHOlgTxepwEccjxI87J7+A4IxdSVFlE0z4rdJETH
	OkgGDdahDQKXc0m+KRZkpwA7Yke7MT+pm2eN8b5p8a32pvhV++zgZFrxi+boJeacaOrVAAMlOH3
	ZfdeBWzVvw0LCFLOR/anShc38FGtRFo9ENSZ18+RO0ZPDfmaV+1OTi1GIOkmoOdLCqaFaw9geWs
	GC6/iKemxJqxROB5VP1nmg/gabo2BrV7dqLaNHsPdN9uOUSZDG7bf1kVL9pEnJydI9MrgT//kUK
	uJGlWlj7qraRoj29P54NKOTHwQ==
X-Google-Smtp-Source: AGHT+IHQMNdZxKpFplxLNEZDOJPbPyGwfr/HlkFZY36RmkmAFCMov8zhCujR2fQsSGMcUi5+FxSA2oJ6tr2W+Ngwqlc=
X-Received: by 2002:a05:6402:1d53:b0:64b:654f:8738 with SMTP id
 4fb4d7f45d1cf-64b8e94bf4emr28321463a12.14.1767107056147; Tue, 30 Dec 2025
 07:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20251230-kho-v1-1-4d795a24da9e@debian.org>
In-Reply-To: <20251230-kho-v1-1-4d795a24da9e@debian.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Dec 2025 10:03:38 -0500
X-Gm-Features: AQt7F2rG1eJ6wegbNUrAZYGhxgtB9GBYd5uKgFVrn4Rx6w8K7hySaB_w8u97UO4
Message-ID: <CA+CK2bDCKQrK3+6832Lxw8fZx_yt+8z0fFPdugC59p1zdSeSZQ@mail.gmail.com>
Subject: Re: [PATCH RFC] kexec: add option to print previous kernel release
 after kexec
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, usamaarif642@gmail.com, 
	rmikey@meta.com, clm@fb.com, riel@surriel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_070419_403233_F4B096F0 
X-CRM114-Status: GOOD (  19.52  )
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

On Tue, Dec 30, 2025 at 9:13=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Introduce a new Kconfig option, CONFIG_KEXEC_SHOW_PREVIOUS_RELEASE,

I don't think we need a config for this. Let's just show the previous
kernel version unconditionally when KHO is enabled.

> which enables the storage and display of the previous kernel's release
> version across kexec boots when using Kexec Handover (KHO).
>
> Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Kernel bugs that depend on the version of the previously running kernel
> are not uncommon, especially in scenarios where a buggy kernel kexecs
> into a new one and the issue only manifests in the subsequent kernel.
>
> Recent examples include:
>
>  * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level p=
aging transition")
>  * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to a=
void corruption")
>  * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")
>
> As kexec-based reboots become more widespread among Linux users, these
> issues are becoming increasingly prominent.
>
> When such crashes occur, correlating them to the previous kernel version
> is challenging, especially at scale, where the problem may only appear in
> specific cases and it is hard to correlate.
>
> With the introduction of Kexec Handover (KHO), we now have a reliable
> mechanism to pass information between kernels. This presents an
> opportunity to address the problem by carrying the previous kernel's
> release version to the next kernel and printing it at boot time.

LUO added the number of times a machine has been live updated to help
debugging problems that are related to live update, perhaps, in
addition to the previous kernel version, we should also add a number
of times the machine has been kexec'd. It is useful when a bug
manifests only after a number of kexec's which is also sometimes a
case.

Pasha

