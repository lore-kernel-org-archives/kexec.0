Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AD4CA0EC4
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7H2BdFMcdz2fBOa3GV+HvCivCE63mLhX0lfQTHqR8Lg=; b=OI+CNwbTpMMemw5BjqH5BnLZoj
	Sxks5QJwfOVTCwMMEWpKBnn2P2U+RXoozEU1SJ+EjnXbXxK94EaRIOcY8rkYH9UOlkxxgcT3t9FjA
	vl1qAEHfkBE+UnOMPA8ACiq8kp3feyhLln423/J2DkoSHcB0/lHK4Yc+/B61n2EEkq3kUpwPmk72I
	rxFuRLvdFs/lgE3Zu74bt8lDxrSf57DW/AeuCc2IJEFGACzbUb8kf7sUJVLIgn7haXxIgEHZZuy14
	6GRNaZ6IKPofaM07Z9+NEgDgBwWiHCUlBnpb8cTanQXgdedKiVS78Cnm/inZ9YR4P7o57U7/Be5gp
	Xlbh7Kpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulVGC-00000008NfU-3y7B;
	Mon, 11 Aug 2025 16:20:32 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTGq-00000007ydM-0WM5
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 14:13:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3A0FEA56EC4
	for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 14:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D727AC4CEF7
	for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921582;
	bh=ELav7L/rjC/DoYOryidaLpumIaTmXrBrTPP8edfpB9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LWtYJ/PMd3AcafPatMCuWdiNoeKHyElVNa9LarP54iIpkUVprzgjghPa/OLACTGPL
	 9t+5OcIwLfLlfESQJuBLADc9kF3YU1YGKCb2roA0CVWWCmm1T+IHPBj6ZKlnL0xJUT
	 hsag/J6L4OfwIT8yCm5px05CeRLQAAJNsbSHvESljgHlBUuNASA5e0gbKvzfWicCZO
	 iAILBErnKZzMpDCTEJ3k1HMiH97NeQ06ajb/xthV3niQC3Lg/5rcKq621epdQ5m46e
	 n9Qbjoy7SouLhFvM7+xiEWUSoNq768Kzvvfxuikr5YaNpQhkwGgDaP9fP6yXmkMEC5
	 oZ/Q0ks47iR3Q==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so6832698a12.3
        for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 07:13:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2kljlJvw3namqIwhFrfVsADr2mFfMzN39YemnbYtQngvInvU6MDPSI2BhpC83BaDWsDfQRw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwrYF64YchlnSssPUIBzDcWnlb5EZcHqJeMQLJefQ4/SekbgAZK
	Lry0Na5TeAhWlitbTrAUmz9fRTlFviSGWVCzL1UhSgc9DMBnXvlCM/7yzVhq4NISA7j74MDZqOV
	iFeL4sd3nNCKQi0GPBz6qVTC8tVDZS0Y=
X-Google-Smtp-Source: AGHT+IGZoI+Finas9RuvpJlULges/ui1XxmQ3rKGmYlYfjLyb3FwJXeqgk+WERRbR3Na0+3IZvzJ7f6kvYuH7yVGzgo=
X-Received: by 2002:a05:6402:2047:b0:617:e1d0:cf80 with SMTP id
 4fb4d7f45d1cf-617e2bc5aabmr9135849a12.14.1754921581341; Mon, 11 Aug 2025
 07:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250811092659.14903-1-youling.tang@linux.dev> <20250811092659.14903-4-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-4-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 11 Aug 2025 22:12:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Sf=74-ni=qUkg3doC4iLrVt=m2bCYCgfmVC0WLNhiDQ@mail.gmail.com>
X-Gm-Features: Ac12FXyIA88QJIsDP-mLwA-4SwAZyUC9JhH_F7YcrkTIoEZQ6s0CHySqn9xPBBI
Message-ID: <CAAhV-H4Sf=74-ni=qUkg3doC4iLrVt=m2bCYCgfmVC0WLNhiDQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_071304_293101_90FCB24A 
X-CRM114-Status: GOOD (  23.89  )
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

On Mon, Aug 11, 2025 at 5:28=E2=80=AFPM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> Add inird loading support and pass it to the second kernel via the
> cmdline 'initrd=3Dstart,size'.
I think Patch-3 and Patch-5 should be merged into Patch-2.

Huacai

>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/kernel/machine_kexec_file.c | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> index bc91ae0afa4c..e1240644f529 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -34,13 +34,84 @@ int arch_kimage_file_post_load_cleanup(struct kimage =
*image)
>         return kexec_image_post_load_cleanup_default(image);
>  }
>
> +/* Adds the "initrd=3Dstart,size" command line parameter to command line=
. */
> +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdl=
ine_tmplen,
> +                               char *modified_cmdline, unsigned long ini=
trd)
> +{
> +       int initrd_strlen;
> +
> +       initrd_strlen =3D sprintf(modified_cmdline + (*cmdline_tmplen), "=
initrd=3D0x%lx,0x%lx ",
> +               initrd, image->initrd_buf_len);
> +       *cmdline_tmplen +=3D initrd_strlen;
> +}
> +
> +/*
> + * Tries to add the initrd to the image. If it is not possible to find
> + * valid locations, this function will undo changes to the image and ret=
urn non
> + * zero.
> + */
>  int load_other_segments(struct kimage *image,
>                         unsigned long kernel_load_addr,
>                         unsigned long kernel_size,
>                         char *initrd, unsigned long initrd_len,
>                         char *cmdline, unsigned long cmdline_len)
>  {
> +       struct kexec_buf kbuf;
> +       unsigned long orig_segments =3D image->nr_segments;
> +       char *modified_cmdline =3D NULL;
> +       unsigned long cmdline_tmplen =3D 0;
> +       unsigned long initrd_load_addr =3D 0;
> +       int ret =3D 0;
> +
> +
> +       kbuf.image =3D image;
> +       /* not allocate anything below the kernel */
> +       kbuf.buf_min =3D kernel_load_addr + kernel_size;
> +
> +       modified_cmdline =3D kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
> +       if (!modified_cmdline)
> +               return -EINVAL;
> +
> +       /* Ensure it's nul terminated */
> +       modified_cmdline[COMMAND_LINE_SIZE - 1] =3D '\0';
> +
> +       /* load initrd */
> +       if (initrd) {
> +               kbuf.buffer =3D initrd;
> +               kbuf.bufsz =3D initrd_len;
> +               kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +               kbuf.memsz =3D initrd_len;
> +               kbuf.buf_align =3D 0;
> +               /* within 1GB-aligned window of up to 32GB in size */
> +               kbuf.buf_max =3D round_down(kernel_load_addr, SZ_1G)
> +                                               + (unsigned long)SZ_1G * =
32;
> +               kbuf.top_down =3D false;
> +
> +               ret =3D kexec_add_buffer(&kbuf);
> +               if (ret)
> +                       goto out_err;
> +               initrd_load_addr =3D kbuf.mem;
> +
> +               kexec_dprintk("Loaded initrd at 0x%lx bufsz=3D0x%lx memsz=
=3D0x%lx\n",
> +                             initrd_load_addr, kbuf.bufsz, kbuf.memsz);
> +
> +               /* Add the initrd=3Dstart,size parameter to the command l=
ine */
> +               cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdli=
ne, initrd_load_addr);
> +       }
> +
> +       if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
> +               pr_err("Appending kdump cmdline exceeds cmdline size\n");
> +               ret =3D -EINVAL;
> +               goto out_err;
> +       }
> +       memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
> +       cmdline =3D modified_cmdline;
>         image->arch.cmdline_ptr =3D (unsigned long)cmdline;
>
>         return 0;
> +
> +out_err:
> +       image->nr_segments =3D orig_segments;
> +       kfree(modified_cmdline);
> +       return ret;
>  }
> --
> 2.34.1
>

