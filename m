Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40221C61DB8
	for <kexec@archiver.kernel.org>; Wed, 28 Aug 2024 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZRTbmP/Myf3gqxTKQ1T/+IHbpx2l42ncaNzemQ/QLo4=; b=CjkaTOlrmg/k5Y
	I+uNa4Ync42UvsQoO3uLIUfya4xomLFKJVpXAYqMqXyn9w+VVn8jYU3vXHenpLrlhSB5JYfapokYi
	t77CASemIoa7H8x4pfgVuh/3Fk6rhC+mGjx35VE+irKMHN0LEd3zRJTZ+iUGwbIMZ03wZjGCAlTBL
	ENjjBpWB2WkxQe3cPP/z8UZpS5IDYv+U6BzcUuK1wDInsLGfIGqhFWgq/aURhgArcijc6ID0IR2th
	IHs3em2hWTr/t+cTBJrjOJvzS/SJfpf8IikngEZM/XvkRF+MeEkIrGXyZZ12mfYZT89D2V/ahFTrr
	LLZjR00tyws2xKPotPpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjL3J-0000000G6Zv-1a5e;
	Wed, 28 Aug 2024 15:57:45 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjL2y-0000000G6T0-0lPs
	for kexec@lists.infradead.org;
	Wed, 28 Aug 2024 15:57:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F3152A41AD6
	for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 15:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCC1C4FEAD
	for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724851694;
	bh=KW5R7PwTkwJ7eH25MlLERl4o7RhFtKAZw+Vph435i7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DuDgMfT0kvoDLyx95ArYFHwsNqDzm6c4x7/q1V3hvhbqF/TzT9iKEZmBTYQmJP3RM
	 HPuxl935jLmeaVpD3uiIJOk/F8xg+tsHUClxjXJXn5DHGKz6essCDjGPBHQZc+GpUY
	 mIkNt3AKSXkJhltbBvo1fMG67b2lHr/w2H2n3iRLLH6IW1TzWvm9nEEisO6wXskNAn
	 R7RxpO1/C9HmRd4/LRTUovmmqAyWIj3sh78gT+FLw0n9vTAHvN14l5Ks1oPvNu77QS
	 Y/0HqKcmC+hf0rpS7iU+3oEH98sl5rVrjvSRivMAOw/ROX+P2B3CM7b1BHV6kNI1lL
	 uHbuvLz2oDC4w==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f025b94e07so61905941fa.0
        for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 06:28:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVm9OUwlSAyiEaHizMlwMXJD7HdVE5+9uYsAQMCri5PswjJHY1ppsRHmVPi7nCg5u6UKAqWCw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzvMFKW3Gay2/tUJ6ftNILluiyTMeRPEC+t8xE5CJMVfHUqxAa2
	1WbybyceP97XCUY+Wmd0lz9apfK8zbk/bE1jv3ybyfxZZv38QrpDJPeJiPy0KaLnWq5luN2hgMh
	6QwGgkuePWPbFb+7hqemnZCHRYuE=
X-Google-Smtp-Source: AGHT+IFPpXqgB2ZHxGcUOd4HwSoKV4p7KRCTOVZffH5Q1PrkpitY1msj3d+3/H33hv0TesEGqrq38ufbKq5w17FoLjM=
X-Received: by 2002:a2e:a54e:0:b0:2f3:e2f0:af15 with SMTP id
 38308e7fff4ca-2f5617dca81mr13124511fa.30.1724851692671; Wed, 28 Aug 2024
 06:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <20240819145417.23367-2-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-2-piliu@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 15:28:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG_TynaQni6mzXYg6sCybSMba7cuwnyb4qi5LNZ=53pKQ@mail.gmail.com>
Message-ID: <CAMj1kXG_TynaQni6mzXYg6sCybSMba7cuwnyb4qi5LNZ=53pKQ@mail.gmail.com>
Subject: Re: [RFCv2 1/9] efi/libstub: Ask efi_random_alloc() to skip unusable memory
To: Pingfan Liu <piliu@redhat.com>
Cc: linux-efi@vger.kernel.org, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Philipp Rudo <prudo@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_085724_374568_1662AB07 
X-CRM114-Status: GOOD (  18.55  )
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

On Mon, 19 Aug 2024 at 16:55, Pingfan Liu <piliu@redhat.com> wrote:
>
> efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
> but the current implement can not ensure the selected target locates
> inside free area, that is to exclude EFI_BOOT_SERVICES_*,
> EFI_RUNTIME_SERVICES_* etc.
>
> Fix the issue by checking md->type.
>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> To: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/libstub/randomalloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
> index c41e7b2091cdd..7304e767688f2 100644
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -79,6 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
>                 efi_memory_desc_t *md = (void *)map->map + map_offset;
>                 unsigned long slots;
>
> +               if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
> +                       continue;

This is wrong in 3 different ways:
- md->type is not a bitmask
- || is not bitwise but boolean
- get_entry_num_slots() ignores all memory types except
EFI_CONVENTIONAL_MEMORY anyway.

So what exactly are you trying to fix here?


>                 slots = get_entry_num_slots(md, size, ilog2(align), alloc_min,
>                                             alloc_max);
>                 MD_NUM_SLOTS(md) = slots;
> @@ -111,6 +113,9 @@ efi_status_t efi_random_alloc(unsigned long size,
>                 efi_physical_addr_t target;
>                 unsigned long pages;
>
> +               if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
> +                       continue;
> +
>                 if (total_mirrored_slots > 0 &&
>                     !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
>                         continue;
> --
> 2.41.0
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
