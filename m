Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AEECCD1A5
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 08:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lfWCXbt+E5v5gvvPR2yBBq5yqOd4fnlzWEB8qlYzm9k=; b=see3bbwOL23fPCQhk3KyfT7Z4e
	PH8fU1Dz7C7y0COriwOB2lYMkK+UTs7Ax3NbAEdqS+pswQ3T323RG71HSULykwRWGm+l+URxUiIy0
	hY46sIjqlEKZKLIQAiKXkoZ9WDOcxrLRghLsux73JyG8ZIN55+E3RH7R3/VeCKzZ2hZm3yD8nqeda
	pmRyRRYD4nw/U5dFPJ+4yRZStQJ7t5Vpm0v9+9JNhodYlcEe9fzvDmi1noVcztWQcyvo9HLwqgz3g
	0HULlJ346J0HiXiBsXsbPQq0x5i5Si+5bmfevFyTdYrEEWcHC/V8mBJ/Cw0FuNLFu+mZI+aOPZKyc
	VNvRq9SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCwx-00000008eR4-1b7U;
	Fri, 24 Oct 2025 08:15:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCwv-00000008eQR-1YXg
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 08:15:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761293700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfWCXbt+E5v5gvvPR2yBBq5yqOd4fnlzWEB8qlYzm9k=;
	b=b9GyIm53+69fsaZz01Fxq2r5W7D/y2xfiyF1AlCi1Mbj7hPL6YDxGXsmOYCGitVtUf1BKs
	Jd3ypSBGsZAIFrFGlHTGx++bZB5ON2c/IAEmiqS9Uk6x/Wpq31IXPgAIgTY93yqz2J4BZV
	u9HFqkbIVt43mvIz+cc0eo8tFP+IxP0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-Cfj8OhxAMD-CS8_4Ubutug-1; Fri, 24 Oct 2025 04:14:58 -0400
X-MC-Unique: Cfj8OhxAMD-CS8_4Ubutug-1
X-Mimecast-MFC-AGG-ID: Cfj8OhxAMD-CS8_4Ubutug_1761293698
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e892acc0b3so52854681cf.2
        for <kexec@lists.infradead.org>; Fri, 24 Oct 2025 01:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293698; x=1761898498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfWCXbt+E5v5gvvPR2yBBq5yqOd4fnlzWEB8qlYzm9k=;
        b=QW8H90GAriUSA1AHd/+jxw8+b21R8ya2qN0oMb/MdumqDhSxIflDzQn6fhIewMWjBh
         75Fkol9ZLS3L9VywtBkc/DKpH7zZbI58o13GSi2hV61HSAi78PixNMmyJ9v/ORr9b2H9
         1bGWGTOzrmFiKOffFFdLKBCCrPeTVF8x7Z45zF2Gopk14+tcMKv8yOr5Y0SdCT6aNOYe
         B6VyTjkFb8e5LnjNS0Lh4+6X/vlHPIlnRJLSLtkmzKIP5114APtx41FhKReinVg9Z5BH
         mTdWqsMkNe4yvua6YoLfs+WrQZAbbLtS2358csBGEyYCMMGTT9d/ov4nfneqXhAs/Ygx
         xMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRKqUHed/I+3Y3LjYEwnjTokrWZpv1ohVPeBK2/hqaLIlKLw8PQvrG0sTB0S3VbeJRl5cL5A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzB2c/HpUZDG0+OHmx9SS/qcLJot6jkbHRyU9ua0kUSIYV/IzK4
	nsKzKQbXyqRC26VwTaqfJkl7eQcpm9Z1tPsUDlrKj4LQjrydfN4V0bufK5SlTinuEADjC+v0GsM
	NBNN50vJFhELvQURhNalWVx0w/uXY8LwPBPu0CY+YO4dk2Ptwvb+I26mFIzBedE8l27+9vNEqCn
	8/O9BgnIkudjpLvjO1kzAnfIW9cqRJnunCmMPWpeBx5s95km4=
X-Gm-Gg: ASbGncvzOIFpcJSO9zoYzD6O+ll0uO8/xmyp21O+FloZp6URQ8Y5WQwHAeHj1XdUJ9C
	uAxgYdMEWQxYr+TNHpPXDdoYiMTTFs9tINv5EYFA7SEQI7cLxCU0zyjl2lXUA9oRUx2oEmlZ0ai
	ekt5NmdqoYrrRV7+KhrVREfoXrtuYs8JNl0ACH8FFYoT73WDeyBg4L3mfT
X-Received: by 2002:ac8:590d:0:b0:4e8:b8d4:a79c with SMTP id d75a77b69052e-4e8b8d4b387mr251378961cf.80.1761293698086;
        Fri, 24 Oct 2025 01:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm8zkUQPNPv+WpGpF9Ae/2N3EQfjiwUrJAmfMWnjuUCBejGfyTE5hJMey+Gys2Ik4RRmlHNOX05x9Cqd1Fc5I=
X-Received: by 2002:ac8:590d:0:b0:4e8:b8d4:a79c with SMTP id
 d75a77b69052e-4e8b8d4b387mr251378791cf.80.1761293697607; Fri, 24 Oct 2025
 01:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251020222410.8235-1-ltao@redhat.com> <20251020222410.8235-5-ltao@redhat.com>
 <c05710da-4807-4a98-9af7-f54ce4beb459@nec.com> <7ba9471f-6119-4353-8218-6486bbc85103@nec.com>
In-Reply-To: <7ba9471f-6119-4353-8218-6486bbc85103@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 24 Oct 2025 21:14:21 +1300
X-Gm-Features: AS18NWCARz2ILq1aN5N-1sYPK0Qeg-RlvxygcosA9uZsAXzrbfZ7SLyimW_yedg
Message-ID: <CAO7dBbVyQoZXpCKWTzVtPgJ6xOqvya7tF=iYEwuSOF-cs9Ayrg@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile 04/14] dwarf_info: Fix a infinite
 recursion bug for rust symbols
To: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ma2J0keiv2CjcE8zLwxFUcovd66is0BFx0ee9KkriFg_1761293698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_011501_511391_747F826B 
X-CRM114-Status: GOOD (  28.26  )
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

Hi YAMAZAKI & Kazu,

Thanks for Kazu's suggestion on the v1, and thank you for reviewing
and ack the patch!

Thanks,
Tao Liu

On Fri, Oct 24, 2025 at 8:20=E2=80=AFPM YAMAZAKI MASAMITSU(=E5=B1=B1=E5=B4=
=8E=E3=80=80=E7=9C=9F=E5=85=89)
<yamazaki-msmt@nec.com> wrote:
>
> Liu
>
> Thanks your new patch.
> I think the patche is better than before. So I ack this patch.
>
> As you pointed out, if exists Rust modules then processing for
> dwarf occur infinite loop. This will add the function to the
> stack and cause an error. I also have resarch this bug, but
> cannot find the root cause.
>
> Therefore, I think it would be better not to support Rust now.
> However, the cause should eventually be revealed.
>
> Acked-by: YAMAZAKI Masamitsu <yamazaki-msmt@nec.com>
>
> Thanks,
> Masa
>
> On 2025/10/22 15:38, HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE =E4=B8=80=E4=BB=81=
) wrote:
> > On 2025/10/21 7:24, Tao Liu wrote:
> >> There is an infinite recursion bug noticed in rust symbols. The root c=
ause is
> >> unclear to me. This patch will avoid the bug by skip the rust
> >> CompileUnits, since currently we don't need to deal with rust symbols.
> >>
> >> Signed-off-by: Tao Liu <ltao@redhat.com>
> >> Suggested-by: Kazuhito Hagio <k-hagio-ab@nec.com>
> > For applying this 04/14 patch separately before the 1.7.8 release, with
> > adding the following note to the man page:
> >
> > --- a/makedumpfile.8.in
> > +++ b/makedumpfile.8.in
> > @@ -80,6 +80,7 @@ nested loops to traverse and erase kernel data. --epp=
ic requires
> >    can be built from makedumpfile source. Refer to
> >    \fBhttp://code.google.com/p/eppic/\fR to build eppic library \fBlibe=
ppic.a\fR
> >    and for more information on writing eppic macros.
> > +NOTE: currently Rust is not supported in this function.
> >    .PP
> >    To analyze the first kernel's memory usage, makedumpfile can refer t=
o
> >    \fIVMCOREINFO\fR instead of \fIVMLINUX\fR. \fIVMCOREINFO\fR contains=
 the first
> >
> >
> > Acked-by: Kazuhito Hagio <k-hagio-ab@nec.com>
> >
> > Thanks,
> > Kazu
> >
> >> ---
> >>    dwarf_info.c | 7 +++++++
> >>    1 file changed, 7 insertions(+)
> >>
> >> diff --git a/dwarf_info.c b/dwarf_info.c
> >> index a3a2fd6..14cf7ca 100644
> >> --- a/dwarf_info.c
> >> +++ b/dwarf_info.c
> >> @@ -1007,6 +1007,13 @@ get_debug_info(void)
> >>                      ERRMSG("Can't get CU die.\n");
> >>                      goto out;
> >>              }
> >> +
> >> +            /* NOTE: currently Rust is not supported. */
> >> +            if (dwarf_srclang(&cu_die) =3D=3D DW_LANG_Rust) {
> >> +                    off =3D next_off;
> >> +                    continue;
> >> +            }
> >> +
> >>              search_die_tree(&cu_die, &found);
> >>              if (found)
> >>                      break;


