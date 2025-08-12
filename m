Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011C7CA0EC4
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 03:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BoNxp0lL3Xlz3kqIP4P8JEYxy9uh3tnFCj/pIJSd04E=; b=i4g6nG04S2+EwF5jnyUsQLTu1+
	T9xt7EMmEonnBIxpMZzvkSttWatM4u1mKjXyxWDVxQtdYC0IERIgLH2BkD/4hLCGbKNROQtFk/pS5
	jcaHlAWM755R1i3dSjGI75jUV8jklVjv19LuOjVgu7WvgIual4RHV8BHldtyY34gz3Wdpwy/lnr+W
	U1S0RPdA16k7FOwxxT77PqDXlzTiVZSarOf8kqxzRlU+oZtcvOA/Bc7IgZKsueosJRlZwrL0HDDpT
	JTj53v9CaIIhLejKmizxgrOGwAFj1b3JqN0mmMNW9cadnRTDo9e+hZFsry8U+vtR6fNY3lXMl+sHL
	7b2Yn/4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulfK9-00000009fka-24Pr;
	Tue, 12 Aug 2025 03:05:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulfJ4-00000009faP-0YbD
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 03:04:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ABFC445E38
	for <kexec@lists.infradead.org>; Tue, 12 Aug 2025 03:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9C8C4AF09
	for <kexec@lists.infradead.org>; Tue, 12 Aug 2025 03:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754967849;
	bh=JZcssSDwXvkq47K2QFU0GKFjCEkGDp3/xk6/4k4s/jU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bcc+nNl/qbetm1EZdjaM2ELnQC1FlhvVLukQYTaHhMzeA7lc2qmxtKaxwXW4KEMVP
	 qjQaSSkwMxNH2iDhAGFlaali1B8cJIJXPRwHmKlwE/XFLnIVokJzfN4TLlQo2vo802
	 St1R9EbdDkYrYRvJrn75iUn7WFtOrU8cXuoVqhyiu/1HC7nCk8JVbfjB1h70A8HAEe
	 SBXiagSWNU+ZVPCPGXyj/dMTIE0BvoILlA1/WileNZmO/6mdapuGEniaRIU4q28hSp
	 ZJWVDGhViLRz7y+gQRaRAcU7ZmYlXo9Aj+gkcqjFdOBRe7hDlCyKaBQCqE3tzjH+Rp
	 lq4I9xFcJet+w==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61592ff5df8so6302989a12.1
        for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 20:04:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVt+ieF5oZFojoCowD4FJMowr3eR/T9dUCZ9k2V2NPgQafWgjeHbsaFrX5t6qmhrm5kOtoFJA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyzD0Xtg5KiaVWzEqWrldlZys4rPspjJal41Y2Fk1N9DXWihn5h
	CWJ5Nlh16qIy/zse9Yu6jeejPP/ePz2AiRruSoOyraymUeLXAnhNFjyR+UKJwKq458X3pLkuEmm
	COoUjt9Er4QKKYnbVB5OSHaZkBIyg068=
X-Google-Smtp-Source: AGHT+IEpJwbYH7nvlbwIEAKaW6ujz8pkWtW42xhS+xF8oiKPPlaUkSCWoy63SJWAR2gGIT1pakCRMbPUvsHqGJRiLT0=
X-Received: by 2002:a50:8ad8:0:b0:618:1250:ac54 with SMTP id
 4fb4d7f45d1cf-6184ecc363amr837963a12.21.1754967848164; Mon, 11 Aug 2025
 20:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-4-youling.tang@linux.dev> <CAAhV-H4Sf=74-ni=qUkg3doC4iLrVt=m2bCYCgfmVC0WLNhiDQ@mail.gmail.com>
 <15fdef37-f380-4b5c-85bb-24482e883dcc@linux.dev>
In-Reply-To: <15fdef37-f380-4b5c-85bb-24482e883dcc@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 12 Aug 2025 11:03:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4_9r=dG=mDU-s2thbv8agoso51U0kHXtx15gxt_wZwVw@mail.gmail.com>
X-Gm-Features: Ac12FXzivR9jQD2OLx7jwFn4TBUMS53K4UxBkvWIv0r6F9WVP2OGUGDgDn1X83E
Message-ID: <CAAhV-H4_9r=dG=mDU-s2thbv8agoso51U0kHXtx15gxt_wZwVw@mail.gmail.com>
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_200410_215493_1920B796 
X-CRM114-Status: GOOD (  28.24  )
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

On Tue, Aug 12, 2025 at 10:38=E2=80=AFAM Youling Tang <youling.tang@linux.d=
ev> wrote:
>
> Hi, Huacai
> On 2025/8/11 22:12, Huacai Chen wrote:
> > Hi, Youling,
> >
> > On Mon, Aug 11, 2025 at 5:28=E2=80=AFPM Youling Tang <youling.tang@linu=
x.dev> wrote:
> >> From: Youling Tang <tangyouling@kylinos.cn>
> >>
> >> Add inird loading support and pass it to the second kernel via the
> >> cmdline 'initrd=3Dstart,size'.
> > I think Patch-3 and Patch-5 should be merged into Patch-2.
> Not all cases require loading initrd, so Patch-2 is a runnable basic patc=
h.
> Separating it into different patches makes it easier to understand and
> review the code.
Unnecessary, without separating the code is clear enough.

>
> Patch-5 coming out separately can better illustrate the role of "mem"
> parameters in capturing the kernel.
Emm, Patch-5 should be squashed to Patch-4, not Patch-2.

Huacai

>
> Youling.
> >
> > Huacai
> >
> >> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> >> ---
> >>   arch/loongarch/kernel/machine_kexec_file.c | 71 ++++++++++++++++++++=
++
> >>   1 file changed, 71 insertions(+)
> >>
> >> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongar=
ch/kernel/machine_kexec_file.c
> >> index bc91ae0afa4c..e1240644f529 100644
> >> --- a/arch/loongarch/kernel/machine_kexec_file.c
> >> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> >> @@ -34,13 +34,84 @@ int arch_kimage_file_post_load_cleanup(struct kima=
ge *image)
> >>          return kexec_image_post_load_cleanup_default(image);
> >>   }
> >>
> >> +/* Adds the "initrd=3Dstart,size" command line parameter to command l=
ine. */
> >> +static void cmdline_add_initrd(struct kimage *image, unsigned long *c=
mdline_tmplen,
> >> +                               char *modified_cmdline, unsigned long =
initrd)
> >> +{
> >> +       int initrd_strlen;
> >> +
> >> +       initrd_strlen =3D sprintf(modified_cmdline + (*cmdline_tmplen)=
, "initrd=3D0x%lx,0x%lx ",
> >> +               initrd, image->initrd_buf_len);
> >> +       *cmdline_tmplen +=3D initrd_strlen;
> >> +}
> >> +
> >> +/*
> >> + * Tries to add the initrd to the image. If it is not possible to fin=
d
> >> + * valid locations, this function will undo changes to the image and =
return non
> >> + * zero.
> >> + */
> >>   int load_other_segments(struct kimage *image,
> >>                          unsigned long kernel_load_addr,
> >>                          unsigned long kernel_size,
> >>                          char *initrd, unsigned long initrd_len,
> >>                          char *cmdline, unsigned long cmdline_len)
> >>   {
> >> +       struct kexec_buf kbuf;
> >> +       unsigned long orig_segments =3D image->nr_segments;
> >> +       char *modified_cmdline =3D NULL;
> >> +       unsigned long cmdline_tmplen =3D 0;
> >> +       unsigned long initrd_load_addr =3D 0;
> >> +       int ret =3D 0;
> >> +
> >> +
> >> +       kbuf.image =3D image;
> >> +       /* not allocate anything below the kernel */
> >> +       kbuf.buf_min =3D kernel_load_addr + kernel_size;
> >> +
> >> +       modified_cmdline =3D kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
> >> +       if (!modified_cmdline)
> >> +               return -EINVAL;
> >> +
> >> +       /* Ensure it's nul terminated */
> >> +       modified_cmdline[COMMAND_LINE_SIZE - 1] =3D '\0';
> >> +
> >> +       /* load initrd */
> >> +       if (initrd) {
> >> +               kbuf.buffer =3D initrd;
> >> +               kbuf.bufsz =3D initrd_len;
> >> +               kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >> +               kbuf.memsz =3D initrd_len;
> >> +               kbuf.buf_align =3D 0;
> >> +               /* within 1GB-aligned window of up to 32GB in size */
> >> +               kbuf.buf_max =3D round_down(kernel_load_addr, SZ_1G)
> >> +                                               + (unsigned long)SZ_1G=
 * 32;
> >> +               kbuf.top_down =3D false;
> >> +
> >> +               ret =3D kexec_add_buffer(&kbuf);
> >> +               if (ret)
> >> +                       goto out_err;
> >> +               initrd_load_addr =3D kbuf.mem;
> >> +
> >> +               kexec_dprintk("Loaded initrd at 0x%lx bufsz=3D0x%lx me=
msz=3D0x%lx\n",
> >> +                             initrd_load_addr, kbuf.bufsz, kbuf.memsz=
);
> >> +
> >> +               /* Add the initrd=3Dstart,size parameter to the comman=
d line */
> >> +               cmdline_add_initrd(image, &cmdline_tmplen, modified_cm=
dline, initrd_load_addr);
> >> +       }
> >> +
> >> +       if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
> >> +               pr_err("Appending kdump cmdline exceeds cmdline size\n=
");
> >> +               ret =3D -EINVAL;
> >> +               goto out_err;
> >> +       }
> >> +       memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len=
);
> >> +       cmdline =3D modified_cmdline;
> >>          image->arch.cmdline_ptr =3D (unsigned long)cmdline;
> >>
> >>          return 0;
> >> +
> >> +out_err:
> >> +       image->nr_segments =3D orig_segments;
> >> +       kfree(modified_cmdline);
> >> +       return ret;
> >>   }
> >> --
> >> 2.34.1
> >>

