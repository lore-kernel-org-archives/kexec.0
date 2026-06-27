Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AC6C43458
	for <kexec@archiver.kernel.org>; Sat, 27 Jun 2026 22:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nq/qbeOSvV0DP48ZHPx+WEEivWUHK4HRs81Tz5g5RA0=; b=DDYyWbNPekPFXiy2S3/6QaCRBO
	tx8vF41FWv51CKyLXvZjKPwv4Ut4RB1rh4mCdlR+0akR7Mj6W8O9+ZgCitkoXqitoWngQOt6IYRvP
	pSNOCRcXcKeVj6zl5WLAVtZOMWAycpsn8Oa+jcHVVjA/wMAGzfX7Z8/yiSouGwy4k7/1OdoWZl5p6
	A3TEx+f2KbyLqJ3QwHlEfbOrOewT9+N6C9LueTiZp9qqsIBcEUfeAcSy4ZvlLJpKRvnK750t6acvM
	3WJxFlMhj49K3twON0YcOvQR/OXXq/pn9HBxOoe4UfwQcbqtrCcWZguS0mlaTHXHkH+dZE22iTLrp
	1bMhyFoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdbfg-0000000CniL-2brR;
	Sat, 27 Jun 2026 22:38:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdbfd-0000000CnhW-1ORV
	for kexec@lists.infradead.org;
	Sat, 27 Jun 2026 22:38:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782599920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nq/qbeOSvV0DP48ZHPx+WEEivWUHK4HRs81Tz5g5RA0=;
	b=TWyuVfzVKPPc5qpJHUAS2WL9axX9j2KkgMgyjmRTCDDqLAR/n2o+8hQ+KoD0fUUoWGdwu/
	2C0vjtxhTbx2INMF1JcJE7eHJ2WeJCb40PwTQq1eeHfMgsmZ3P09PgSO2M4qITUymWbI9y
	tQNE8nap4Tio+AX7crwGIMpyWEXJccc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-q5p7J23dMTas2F3eNBLXZg-1; Sat, 27 Jun 2026 18:38:37 -0400
X-MC-Unique: q5p7J23dMTas2F3eNBLXZg-1
X-Mimecast-MFC-AGG-ID: q5p7J23dMTas2F3eNBLXZg_1782599917
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf2b2c0dbso877581cf.0
        for <kexec@lists.infradead.org>; Sat, 27 Jun 2026 15:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782599917; x=1783204717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nq/qbeOSvV0DP48ZHPx+WEEivWUHK4HRs81Tz5g5RA0=;
        b=s2gZtpJd6a7rS2p97PXQCFsu6vc3RVMPZ9dpfobsmtX5J0YgvXPGGPkhcyMJkQm8Cd
         ROVn9wbdyqPFWiOaWjwHJsIYShO9tY+9SXXmZPLnS19ifBJoxX+fKxFCkym62JjsOzrr
         Ppv0rEIYzjR1DjRrdXS6dJg6BadszGPvJqq8xSuW19Pneyr7dLPP7vZC0sKN/3n7Kpg+
         AMbR1nUz/gk+N3cnPxFlUGUAOqwEEMsbF+3Fzgui7Pm23cH2LypgUpLu2AN45AH2ap5x
         EWWqPDu6hRkp/k+jbQr63fzXUGtOw5/e7Kji0CeMx0aSVZF1XEIvSDdqoN9W0VQwHeGb
         7MhQ==
X-Gm-Message-State: AOJu0Yxhy2ybyZMfWAah2DkHKvGF7fp9b7xMBEURFImWzQrZs0IoRWC6
	DZww4n5WRnasdRnPgoaq9PF7wUrjmWnt6HUDb57l+fKFgff52tnXgSdaDp4+GEzcsFbmEDaTquj
	BHr7VUDvv5viLs3/QKzM6HJSkAFj6IyRpXnY9zXvdlJ3bp4G9ugiTix2+sE00eDRXf7gB1JEn9v
	Ry8f7HnWFw8FBl5YBNwplZFu4asOCe3QB6rHq+
X-Gm-Gg: AfdE7cn78pYOQVSbuumVW1aRwFYA6pbt4V2uNL7yL+vtYuhLI1+nt9EMZBi+w//SoX8
	nI429ecI7pjwyO8T0IFD4YM3aVRxEyZxzOqqqMlgmxPF3gQZFPuc4h5/zYg2qF2eMsS33rAn8P/
	P/U1q2NPREgRJnipfow8w/zEBOvJ1e1MhJrYANcVZoG10wTKVanzQjU2iVpmz9GFMz+1A=
X-Received: by 2002:a05:622a:5809:b0:517:5f04:f23f with SMTP id d75a77b69052e-51a7212ec0cmr162163971cf.4.1782599916906;
        Sat, 27 Jun 2026 15:38:36 -0700 (PDT)
X-Received: by 2002:a05:622a:5809:b0:517:5f04:f23f with SMTP id
 d75a77b69052e-51a7212ec0cmr162163781cf.4.1782599916504; Sat, 27 Jun 2026
 15:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260529032739.13264-2-ltao@redhat.com> <CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
 <CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com> <CAO7dBbW55P9eibE5o74s8Hn+fsZ5CeasyEtLMcpkCM=kVzF7zQ@mail.gmail.com>
In-Reply-To: <CAO7dBbW55P9eibE5o74s8Hn+fsZ5CeasyEtLMcpkCM=kVzF7zQ@mail.gmail.com>
From: Tao Liu <ltao@redhat.com>
Date: Sun, 28 Jun 2026 10:38:00 +1200
X-Gm-Features: AVVi8Cc1IgNnVY-oF9acv_xVzyt_jMPxm05ZHOf7GFa7ENYpBTtJTdXSdt5FR2E
Message-ID: <CAO7dBbVfMtHDocudv2LgoJR1dNy8CufjB8SEz=BZ+hK6Ycu6Yw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in machine_kexec_prepare
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UzgDsiD4hgKjaBG7l3hRkaKZ7HgO4yyXDXTmOR8eRvE_1782599917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_153841_473771_33A47B45 
X-CRM114-Status: GOOD (  32.34  )
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

On Fri, Jun 26, 2026 at 8:38=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
>
> Hi Baoquan,
>
> Glad to see your message again!
>
> Thanks for the Ack and the suggestion for the comment, I will add it
> in the next version.
>
> In the meantime, I will check if similar issue exists on LoongArch as wel=
l.
>
> Thanks,
> Tao Liu
>
> On Fri, Jun 26, 2026 at 8:04=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote=
:
> >
> > Add kexec ML to CC.
> >
> > On Fri, Jun 26, 2026 at 7:46=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote=
:
> > >
> > > Kindly ping, any comments?
> > >
> > > Thanks,
> > > Tao Liu
> > >
> > > On Fri, May 29, 2026 at 3:35=E2=80=AFPM Tao Liu <ltao@redhat.com> wro=
te:
> > > >
> > > > A NULL pointer reference issue is noticed in riscv's machine_kexec_=
prepare,
> > > > where image->segment[i].buf might be NULL and copied unchecked.
> > > >
> > > > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> > > > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> > > > but kbuf.buffer is NULL.
> > > >
> > > > Fix this by simply adding a check before copy.
> > > >
> > > > Signed-off-by: Tao Liu <ltao@redhat.com>
> > > > ---
> > > >  arch/riscv/kernel/machine_kexec.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/=
machine_kexec.c
> > > > index 2306ce3e5f22..d81d576f9cb5 100644
> > > > --- a/arch/riscv/kernel/machine_kexec.c
> > > > +++ b/arch/riscv/kernel/machine_kexec.c
> > > > @@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
> > > >                 if (image->segment[i].memsz <=3D sizeof(fdt))
> > > >                         continue;
> > > >
> > > > +               if (image->segment[i].buf =3D=3D NULL)
> > > > +                       continue;
> > > > +
> >
> > This is a good fix, maybe we can add code comments to explain it as
> > below, just for reference.
> >
> >                /*
> >                 * Some segments (e.g. IMA) reserve space but have no bu=
ffer
> >                 * loaded yet. Skip them as they cannot contain an FDT.
> >                 */
> > And is there any other place where the similar issue exists? e.g on Loo=
ngArch?

I have tested in LoongArch, it doesn't have the similar issue. The
reason is, in arch/loongarch/kernel/machine_kexec.c:machine_kexec_prepare()=
,
the unchecked memcpy() only happens for none kexec file load, however
ima_add_kexec_buffer() requires kexec file load. So the condition
isn't met.

> >
> > Other than above concerns, this patch looks good to me:
> >
> > Acked-by: Baoquan He <bhe@redhat.com>

Thanks for your code review and suggestions!

Thanks,
Tao Liu

> >
> > > >                 if (image->file_mode)
> > > >                         memcpy(&fdt, image->segment[i].buf, sizeof(=
fdt));
> > > >                 else if (copy_from_user(&fdt, image->segment[i].buf=
, sizeof(fdt)))
> > > > --
> > > > 2.47.0
> > > >
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> >


