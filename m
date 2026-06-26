Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA7BCD4F26
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDltzCJUDRmKYkrW1vbieyufI39hKX9sdD7dTyxWQpA=; b=Y9+YclwkNZIXf0o/i48WcowQAm
	+o9p+E33JK1MGyboVjQGfv2NfCuPF6C1aB9Z6ZmC9BfMTYwKe0YCI+DxDbyN05F3bjdL3pdx+1dVL
	puaAPLax6bg/OgOwzs/X6W8RH0q6w1gM32OyZvy24KjVSXa2kbFuGd9tazRKcvxm7X6PcsagiiQik
	ATIjN8nb8S2ieNxWgiUCXnNPSIikU+BICcX/6NmveZk/WBIR5TRvljjd1gb2R1KTGv91MQcKh3/Gs
	rmUiRuFpGHVbL8VYIMB/6SnyddM+2pe676dFMuI6VIQpoDPUQWewYWdknJKKhYEscOAkKr1CJuXdT
	lDYu57Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd25k-0000000AsRP-2EsN;
	Fri, 26 Jun 2026 08:39:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd25h-0000000AsQS-0heK
	for kexec@lists.infradead.org;
	Fri, 26 Jun 2026 08:39:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782463152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDltzCJUDRmKYkrW1vbieyufI39hKX9sdD7dTyxWQpA=;
	b=ffNp93CZNuk9Zcv3BFNQL7rqnVJlJgcBIbHYXIZTwDvZsryivK3HZedKnCYXx+GbPuDvj/
	hvVds8xxVxIlCRQJClSdGWXBvBiKYDEZPcbQpW5f614PZiec7BDn0qhJL5k/5bk/2ud0E6
	M0Intj77ypF1i6tUNkiDuSFRvM26G2Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-SIdW7egOPmCLt8T1oGlZjw-1; Fri, 26 Jun 2026 04:39:10 -0400
X-MC-Unique: SIdW7egOPmCLt8T1oGlZjw-1
X-Mimecast-MFC-AGG-ID: SIdW7egOPmCLt8T1oGlZjw_1782463150
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-519899abab8so12926971cf.2
        for <kexec@lists.infradead.org>; Fri, 26 Jun 2026 01:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463150; x=1783067950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDltzCJUDRmKYkrW1vbieyufI39hKX9sdD7dTyxWQpA=;
        b=PEow7MoOsIaf2/akoILbRiFqxoTctaJC4XQPXp3e4vifbMoNW4Hrl+EhCsPypZ0BWf
         Ga4CGdMDiUJO8rqhShkwdkjfSDwdt/HjXqriYQB9kkpWEU4Y9r8pJqQCSsdyKvyQFDmg
         eGbXZtFUCeWQy9M+L+TWcdw7oIpeyW65asyP+NCe+axB5swaAfZDjEjvj2wXzfjkW+jQ
         CHh1V75o/OH9bt7tHaQi48Tl+JzaxOqMImLEizq3VIAoM2ksM5CqWwqeR+ygFefIzA9B
         KHVZBNE5+7pfCT17lS3sKRPQNu1G7mJ9MTSmQpP9AZWKdaSqDLGJZB6U+5IMPvY9BSCt
         8hXA==
X-Gm-Message-State: AOJu0YzX1iJ71YmjvLsPxADkD6j+yVGI9RLM2Mg3BSlTFwkQmCfBpRMP
	OhIKL2UOaaNb5zTrh5maBwRz7I3n56vf0N0rhZOHkSQJYzGEsPUrv7K5qLqFhTmrBUWPsjN+K3f
	65/zXqK+mw6nbmWoZ91MCVGD9KgFmyfoW1cEEKY2VG+98oWv3wG+r6gbjOmdgETYRcd5wH6cOQ3
	4N0a5QuRKSL3lSFdt7Am7x4En/DPAVR/bYEjdu
X-Gm-Gg: AfdE7cmD1zJ8OuwVK9B+a9Jzs1lU5ktim/DYsXHGeg1Hui+ulS80aczuqWuYDjcq2hL
	W0hyOiDEkiLdYnXDJhC4ZCPV/VxrqftUK2xx0sFwRQ4ydh617OpYgi7fD4U+KLbybG5CSR7oCTk
	5v4NyHJlcM2w79/3F5RUNsfen23Xp52Y5yGZ6xmSQv1cn+rXaM4DZvYhVf2J8MAFjWPxA=
X-Received: by 2002:ac8:5d8f:0:b0:517:7e26:36a4 with SMTP id d75a77b69052e-51a727a6b4emr38094581cf.34.1782463149696;
        Fri, 26 Jun 2026 01:39:09 -0700 (PDT)
X-Received: by 2002:ac8:5d8f:0:b0:517:7e26:36a4 with SMTP id
 d75a77b69052e-51a727a6b4emr38094311cf.34.1782463149181; Fri, 26 Jun 2026
 01:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260529032739.13264-2-ltao@redhat.com> <CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
 <CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
In-Reply-To: <CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 26 Jun 2026 20:38:32 +1200
X-Gm-Features: AVVi8CcC6SRLbaRMcmDZcOqEvJBqXMu3cyxkiJ8WEEu_YPQEWrWyMZoL0N-5qwY
Message-ID: <CAO7dBbW55P9eibE5o74s8Hn+fsZ5CeasyEtLMcpkCM=kVzF7zQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in machine_kexec_prepare
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mbI_9flNC2kCK_6PvHpnZN-JrRVys7AVVQWDCtdMXCw_1782463150
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_013913_286738_2B8CC884 
X-CRM114-Status: GOOD (  26.85  )
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

Hi Baoquan,

Glad to see your message again!

Thanks for the Ack and the suggestion for the comment, I will add it
in the next version.

In the meantime, I will check if similar issue exists on LoongArch as well.

Thanks,
Tao Liu

On Fri, Jun 26, 2026 at 8:04=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> Add kexec ML to CC.
>
> On Fri, Jun 26, 2026 at 7:46=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote:
> >
> > Kindly ping, any comments?
> >
> > Thanks,
> > Tao Liu
> >
> > On Fri, May 29, 2026 at 3:35=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote=
:
> > >
> > > A NULL pointer reference issue is noticed in riscv's machine_kexec_pr=
epare,
> > > where image->segment[i].buf might be NULL and copied unchecked.
> > >
> > > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> > > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> > > but kbuf.buffer is NULL.
> > >
> > > Fix this by simply adding a check before copy.
> > >
> > > Signed-off-by: Tao Liu <ltao@redhat.com>
> > > ---
> > >  arch/riscv/kernel/machine_kexec.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/ma=
chine_kexec.c
> > > index 2306ce3e5f22..d81d576f9cb5 100644
> > > --- a/arch/riscv/kernel/machine_kexec.c
> > > +++ b/arch/riscv/kernel/machine_kexec.c
> > > @@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
> > >                 if (image->segment[i].memsz <=3D sizeof(fdt))
> > >                         continue;
> > >
> > > +               if (image->segment[i].buf =3D=3D NULL)
> > > +                       continue;
> > > +
>
> This is a good fix, maybe we can add code comments to explain it as
> below, just for reference.
>
>                /*
>                 * Some segments (e.g. IMA) reserve space but have no buff=
er
>                 * loaded yet. Skip them as they cannot contain an FDT.
>                 */
> And is there any other place where the similar issue exists? e.g on Loong=
Arch?
>
> Other than above concerns, this patch looks good to me:
>
> Acked-by: Baoquan He <bhe@redhat.com>
>
> > >                 if (image->file_mode)
> > >                         memcpy(&fdt, image->segment[i].buf, sizeof(fd=
t));
> > >                 else if (copy_from_user(&fdt, image->segment[i].buf, =
sizeof(fdt)))
> > > --
> > > 2.47.0
> > >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
>


