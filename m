Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BC4CA0EFF
	for <kexec@archiver.kernel.org>; Wed, 27 Aug 2025 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lyur06Xx7tcErc6JbYpd+yK564TDQI8cZXW5+wOKuBs=; b=ziUxndw/E1HUSZqw2XZK2YiaZQ
	Ujqbt9jn1uqcQMA/5akmQJKWz85usXlQdCPRdMklqsmbPfIdAWKCNigliCOAdam+rSi8uFDPfUvq3
	TJQ9pNf5Rgy2XVuhI1OE1RbL+KghSrWxTM9wXVs5BsHO4yBl0Ne+zarCR5hpSRYP84E4PeiqZ/5Qm
	O5AqcLQGqKNRAPJGyDPjnxLM8MQd6I1LOvf842/5Eb2rS8EJa+XkEs+5NWwDuAnA2GkSgbVGPLn/A
	XDNptfJaoaTjk6Lzd6jnt8hwdhA/LAllmRebE6Mz9XHjxRz+LMmZ/3j9jLqmBj/sgOzdBWGuZyc2t
	HT5/iq9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urAjO-0000000ES9I-2jPB;
	Wed, 27 Aug 2025 07:38:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urAib-0000000ERx8-3hHh
	for kexec@lists.infradead.org;
	Wed, 27 Aug 2025 07:37:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A0B044834
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2025 07:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5A3C4CEEB
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2025 07:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756280237;
	bh=Sh0yJk4cq763Z2S0AabEdm8SBSV2vslsylW6HkFUQaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QtxBPYu7fDtFycNHJZ2LlU0AUcE4nnO7Q69SU1yBU54GFd/bGX8OOEI0BoOyxD0Ok
	 isaGIW3gfkiXjKjb54VwDPd+us46jmMNnbFnVro2LXQidKaCeDfQOpqyVvsUdkVGL8
	 ZUwGmQt5f4w2fjhSUE9T9Efw7ywEIVA7ewDEOOu3AF2YOE1IbhvvbDATFSUeWm/FlB
	 X0aoJrPMhYaCJc0wXMp9sAjoI0Gss/q4uk/9uLGY7HBlg6sB77xJla0XZIJZVPqw3Q
	 BrLDCRnoN897a4UA/9pIzw1uiWnBoPg6c44KAOTWo06inXYPdILerPKwR765FVuudF
	 cnwetJuHMc7vQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61caa266828so1745409a12.1
        for <kexec@lists.infradead.org>; Wed, 27 Aug 2025 00:37:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/AMrGJ/6ihNU75zUStx4DPyVm1edDjweG+GIhqCbsZoqimLOkeDUahykEAlZk2WEtkii5yg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywqxz0sh4bJBvh61ViiBJY2H74iU9waVpj46c6Ffl/yJy280lsU
	VFC+HZjio8JMYjv+B3rXfDVYuTnYUqCxHK2wrIW0aWUK6mxFci6bkWZqQspnIqb5xRniac3mbHO
	RH3E4gQwozR+KOkUSLe1C4NSb06sU3ds=
X-Google-Smtp-Source: AGHT+IHmE5mRPrt9MQZ5SrGZ/Eh0fnCb6y74Ut+o4kT2Qo/McnYzAh+aX1nwaWNUnvryQLwksDNy0JK0iUscSWykyZo=
X-Received: by 2002:a05:6402:504e:b0:618:2257:7fcf with SMTP id
 4fb4d7f45d1cf-61c1b705748mr13883285a12.18.1756280235646; Wed, 27 Aug 2025
 00:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250826011722.82391-1-youling.tang@linux.dev> <20250826011722.82391-2-youling.tang@linux.dev>
In-Reply-To: <20250826011722.82391-2-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 27 Aug 2025 15:37:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7csV-vce6QGjFGd-R4JrLmbgoEs4UwKayKUxdgc3Ki=w@mail.gmail.com>
X-Gm-Features: Ac12FXwQWG9U9zLqW3Fy0iKKmm6IRWH5-eIBaw6-dIEfjnX1uwk4CAdRYKGbcgk
Message-ID: <CAAhV-H7csV-vce6QGjFGd-R4JrLmbgoEs4UwKayKUxdgc3Ki=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] LoongArch: Add struct loongarch_image_header for
 kernel image
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, Yao Zi <ziyao@disroot.org>, 
	kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_003718_040197_5238AEA1 
X-CRM114-Status: GOOD (  19.42  )
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

Hi, Youling,

On Tue, Aug 26, 2025 at 9:18=E2=80=AFAM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> Define a dedicated image header structure for LoongArch architecture to
> standardize kernel loading in bootloaders (primarily for kexec_file).
>
> This header includes critical metadata such as PE signature, entry points=
,
> image size and load address offset, etc.
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/include/asm/image.h | 40 ++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/image.h
>
> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/=
asm/image.h
> new file mode 100644
> index 000000000000..1f090736e71d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/image.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * LoongArch binary image header.
> + *
> + * Author: Youling Tang <tangyouling@kylinos.cn>
> + * Copyright (C) 2025 KylinSoft Corporation.
> + *
> + * Most code is derived from LoongArch port of kexec-tools
> + */
> +
> +#ifndef __ASM_IMAGE_H
> +#define __ASM_IMAGE_H
> +#ifndef __ASSEMBLY__

__ASSEMBLY__ is replaced by __ASSEMBLER__ now.

> +
> +/**
> + * struct loongarch_image_header
> + *
> + * @pe_sig: Optional PE format 'MZ' signature.
> + * @reserved_1: Reserved.
> + * @kernel_entry: Kernel image entry pointer.
> + * @image_size: An estimated size of the memory image size in LSB byte o=
rder.
> + * @text_offset: The image load offset in LSB byte order.
> + * @reserved_2: Reserved.
> + * @reserved_3: Reserved.
> + * @pe_header: Optional offset to a PE format header.
> + **/
> +
> +struct loongarch_image_header {
> +       uint8_t pe_sig[2];
Use dos_sig is better.

> +       uint16_t reserved_1[3];
Use padding_1[3] is better.

> +       uint64_t kernel_entry;
> +       uint64_t image_size;
Use kernel_asize to keep consistency with head.S.

> +       uint64_t text_offset;
> +       uint64_t reserved_2[3];
> +       uint32_t reserved_3;
Just use uint32_t reserved_2[7] here?


Huacai

> +       uint32_t pe_header;
> +};
> +
> +#endif /* __ASSEMBLY__ */
> +#endif /* __ASM_IMAGE_H */
> --
> 2.43.0
>

