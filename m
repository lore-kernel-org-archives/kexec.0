Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC94FD9E2E
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 02:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MxM+CPBR7Ohg7XCtFajNeorsUraH9JbsyGjaezvyFGs=; b=pqmIofUiuLU4wMaeHSvFNm77iQ
	YOpZ2XZDfWpOzytfbSNW6lPpmvIuAAbbtcHH9meoN7zVVJR5aqR/k+Kj8uRY+Ux+1SaqIHuE71Lkv
	ViZsDT8bCmd77I8+vheZIqbuCCmtc9NLKeJD033iP4R6u0vUMqLngD0CizzKUdPOoiI5UJ5btAAZU
	8dvzjvvuF1DirPTh9gw9fRG91NcpaHtFw09dMu43z+csuGZwX31xx2BCzHzULoqtye30/Le/4sHzM
	p0+dfwdztG23z29BWbUhqyRZiuguTvrFA5gr0pPkllKJO2lTgQ8LHjbUmkx5XJ0hjYYFYQX9ubfRl
	xcYk+//Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvnmN-00000007YJE-37DN;
	Fri, 27 Feb 2026 02:40:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvnmK-00000007YIt-2nqT
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 02:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772160031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxM+CPBR7Ohg7XCtFajNeorsUraH9JbsyGjaezvyFGs=;
	b=Dr/5WsV89NPn/TehLDXicr6tH4tRmtPq/GleVqySjLIvtc/AZDy8y6mTcU1YuCLBQYZ509
	ZPeCDbYrToZLypIESQU3e/vv3V+J8xyCN8zMbQSjwR5uyouRSiNzoWkb0cYoeIN5AULaLB
	3Icaf4ZieZDtUsFnpZ49hhpGImxWMK0=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690--ymDm3mzP8G922JSfLlovA-1; Thu, 26 Feb 2026 21:40:27 -0500
X-MC-Unique: -ymDm3mzP8G922JSfLlovA-1
X-Mimecast-MFC-AGG-ID: -ymDm3mzP8G922JSfLlovA_1772160026
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bde0d4fb18so538842eec.1
        for <kexec@lists.infradead.org>; Thu, 26 Feb 2026 18:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772160026; x=1772764826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxM+CPBR7Ohg7XCtFajNeorsUraH9JbsyGjaezvyFGs=;
        b=i7tSDwfLK8q1c0lXGn4TLJfM4C6sR0RIgTtXSXEsS4sx4zYdiioS3xy2rXPoSS4BEs
         D/sIPqQ4k4OUw2LP++U+opCInzQkQJk+zPMC2ZPZpD+EBh9QQvqotM4vEXnLqni1JqC1
         6jl4EXKKKGBTFlYlrmB0kSOYrvsY1s8JuJ5UcdGN1VXTHAshV8Foda1xdSJKPUGFClzQ
         AvzXUXjuYIsJ+b3kRfV5fJ6EtWo1WkMPHfzWHE2lOc2lRU6W8cuXicgyXyROfsG2NI8T
         UhHi/y2ZCLWiI/Aq19CR5R9vL5kVjz3uDC7jd3d9kGkSAD5S867eF9W2sy367Dqqloe1
         THJg==
X-Gm-Message-State: AOJu0Yz3WK6n9QTgjWXewUFmmGMdsJ4wT8FnfZSOd94j968uaqU+TRDy
	TubAG3ogAiY1QqADGzwmBYIPBCyFo8BPcizfRU3/4LOhcBGTxkL+D3t0eJpK5m/z+KOLRsaNy0a
	+4pyRd3oBkaX4eXuVdPpP854Vcj28R2jVn2ef2EV8X/6hRhPinK4zKo/7dtyIIQ0BZz1pBE9oQd
	ipZqgl0BOvwojR1KLEkd6vvt6DuYgtRrRVPKV9
X-Gm-Gg: ATEYQzyyAtsmVQC1T7tQzS2YYHTD3Xse4zTrW0psQYVktKqHDFWOfslr7n/J87O107L
	BMw8GPNmif+KGneD4NbnE0tbczUWndy1kY2IVkEDDri1O/gIkk1UP2BsGbQILWZkwl9YZ6ZBQYo
	x7/FSrJIwhOCC/gwMfmV4x+yojnWeC/ssVyiUWv5fWILGp/MY+cjVfQ832ukHIVm4wJPqByyj0L
	S5pLrs=
X-Received: by 2002:a05:7300:880b:b0:2ba:7b0b:e207 with SMTP id 5a478bee46e88-2bde1d0db6fmr382128eec.23.1772160026135;
        Thu, 26 Feb 2026 18:40:26 -0800 (PST)
X-Received: by 2002:a05:7300:880b:b0:2ba:7b0b:e207 with SMTP id
 5a478bee46e88-2bde1d0db6fmr382114eec.23.1772160025698; Thu, 26 Feb 2026
 18:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20260119032424.10781-1-piliu@redhat.com> <20260119032424.10781-5-piliu@redhat.com>
 <20260226143743.7e963ba9@rotkaeppchen>
In-Reply-To: <20260226143743.7e963ba9@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 27 Feb 2026 10:40:13 +0800
X-Gm-Features: AaiRm51JnGpS93nCE3-RTCORT-gV1_XekO5k86v7D4IWPLe5twAugzqBcKxFNYo
Message-ID: <CAF+s44RxsvVEKSg=OZpbq1YTp4qi4j-+ZnS=BK5dcHW5Q61W7w@mail.gmail.com>
Subject: Re: [PATCHv6 04/13] kexec_file: Use bpf-prog to decompose image
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kjqnqpqb5HFFQ5AkYuJ5HxjH5TJTq17L05fPBdG-ln8_1772160026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_184032_802287_D3539DCB 
X-CRM114-Status: GOOD (  26.30  )
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

On Thu, Feb 26, 2026 at 9:37=E2=80=AFPM Philipp Rudo <prudo@redhat.com> wro=
te:
>
> Hi Pingfan,
>
> On Mon, 19 Jan 2026 11:24:15 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> [...]
>
> > diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> > new file mode 100644
> > index 0000000000000..dc59e1389da94
> > --- /dev/null
> > +++ b/kernel/kexec_bpf_loader.c
> > @@ -0,0 +1,161 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Kexec image bpf section helpers
> > + *
> > + * Copyright (C) 2025, 2026 Red Hat, Inc
> > + */
> > +
> > +#define pr_fmt(fmt)  "kexec_file(Image): " fmt
> > +
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/list.h>
> > +#include <linux/kernel.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/kexec.h>
> > +#include <linux/elf.h>
> > +#include <linux/string.h>
> > +#include <linux/bpf.h>
> > +#include <linux/filter.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/image.h>
> > +#include <asm/memory.h>
> > +#include "kexec_internal.h"
> > +
> > +/* Load a ELF */
> > +static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void disarm_bpf_prog(void)
> > +{
> > +}
> > +
> > +struct kexec_context {
> > +     bool kdump;
> > +     char *kernel;
> > +     int kernel_sz;
> > +     char *initrd;
> > +     int initrd_sz;
> > +     char *cmdline;
> > +     int cmdline_sz;
> > +};
> > +
> > +void kexec_image_parser_anchor(struct kexec_context *context,
> > +             unsigned long parser_id);
> > +
> > +/*
> > + * optimize("O0") prevents inline, compiler constant propagation
> > + *
> > + * Let bpf be the program context pointer so that it will not be spill=
ed into
> > + * stack.
> > + */
> > +__attribute__((used, optimize("O0"))) void kexec_image_parser_anchor(
> > +             struct kexec_context *context,
> > +             unsigned long parser_id)
> > +{
> > +     /*
> > +      * To prevent linker from Identical Code Folding (ICF) with kexec=
_image_parser_anchor,
> > +      * making them have different code.
> > +      */
> > +     volatile int dummy =3D 0;
> > +
> > +     dummy +=3D 1;
> > +}
> > +
> > +
> > +BTF_KFUNCS_START(kexec_modify_return_ids)
> > +BTF_ID_FLAGS(func, kexec_image_parser_anchor, KF_SLEEPABLE)
> > +BTF_KFUNCS_END(kexec_modify_return_ids)
> > +
> > +static const struct btf_kfunc_id_set kexec_modify_return_set =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .set =3D &kexec_modify_return_ids,
> > +};
> > +
> > +static int __init kexec_bpf_prog_run_init(void)
> > +{
> > +     return register_btf_fmodret_id_set(&kexec_modify_return_set);
> > +}
> > +late_initcall(kexec_bpf_prog_run_init);
> > +
> > +static int kexec_buff_parser(struct bpf_parser_context *parser)
> > +{
> > +     return 0;
> > +}
> > +
> > +/* At present, only PE format file with .bpf section is supported */
> > +#define file_has_bpf_section pe_has_bpf_section
> > +#define file_get_section     pe_get_section
> > +
> > +int decompose_kexec_image(struct kimage *image, int extended_fd)
> > +{
> > +     struct kexec_context context =3D { 0 };
> > +     struct bpf_parser_context *bpf;
> > +     unsigned long kernel_sz, bpf_sz;
> > +     char *kernel_start, *bpf_start;
> > +     int ret =3D 0;
> > +
> > +     if (image->type !=3D KEXEC_TYPE_CRASH)
> > +             context.kdump =3D false;
> > +     else
> > +             context.kdump =3D true;
> > +
> > +     kernel_start =3D image->kernel_buf;
> > +     kernel_sz =3D image->kernel_buf_len;
> > +
> > +     while (file_has_bpf_section(kernel_start, kernel_sz)) {
> > +
> > +             bpf =3D alloc_bpf_parser_context(kexec_buff_parser, &cont=
ext);
> > +             if (!bpf)
> > +                     return -ENOMEM;
> > +             file_get_section((const char *)kernel_start, ".bpf", &bpf=
_start, &bpf_sz);
> > +             if (!!bpf_sz) {
> > +                     /* load and attach bpf-prog */
> > +                     ret =3D arm_bpf_prog(bpf_start, bpf_sz);
> > +                     if (ret) {
> > +                             put_bpf_parser_context(bpf);
> > +                             pr_err("Fail to load .bpf section\n");
> > +                             goto err;
> > +                     }
> > +             }
>
> I'm not sure this works as intended. In case a .bpf section exists but
> bpf_sz is 0, the function will skip arming the bpf-prog but still
> continue. That doesn't look right to me. IIUC a zero size bpf-prog
> should be an error. Or am I missing something?
>

Yes, you are right. It's better to treat a zero bpf_sz as an invalid format=
.

Thanks,

Pingfan


