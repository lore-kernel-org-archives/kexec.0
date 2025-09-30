Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18D3CAC5B9
	for <kexec@archiver.kernel.org>; Tue, 30 Sep 2025 00:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5y9dDFkn6dM+xKzwMVSrxZQYOHZtK1ileeMBel7MUw=; b=F5tWgpVpeBconRkGsZeC04XhcD
	LSvHlx6ILhUNlorIW31qnMXomoMtss6mku+Qn6cgCYojnomfOlSQ0e+PDLLOhgts8h60EITiVOOTf
	Od/w5/tkX3nCRDvMiBJdnAcVrOsY8Gm2xMySxNcl/gY8iNgtlo5G0ZdDezSmc4No6QC3gn9tTiWLA
	s+THx6lymAwA7gT+4tAp+baxR+tFpbJxdHFSNpmhGyBpR3Ie3vJ3zJy2FGDSnG5uDtSwcsNsNCIpd
	3AH9eYmlFNkJTz2F9qbEm165LwJ6e5jkJ/0ZWgKaHi6IQfbqfH9ahswuOv4RVTcYkQFVzQSClD46O
	dUUr7ncg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3OKP-00000003hkz-2kq9;
	Tue, 30 Sep 2025 00:34:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3OKM-00000003hkP-0Web
	for kexec@lists.infradead.org;
	Tue, 30 Sep 2025 00:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759192483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5y9dDFkn6dM+xKzwMVSrxZQYOHZtK1ileeMBel7MUw=;
	b=GD61JJZK09ShgUBBNFJEtpNVNme/GeHOjAAL/uCzNBQMTGe5bxf/CqBPkQ5CpvCKvFxOTm
	hJa5Z35CMkJqpk54cREJzBnKNYLsRm/Y+gKwJpp78app9Dcp/5M5LSos5y7vY6BQmHoouG
	KyvMDFqb1oGc/L0KOnrxjvuWFmhMdS0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-yPxoRVCCMFK1GvXcJdgumg-1; Mon, 29 Sep 2025 20:34:42 -0400
X-MC-Unique: yPxoRVCCMFK1GvXcJdgumg-1
X-Mimecast-MFC-AGG-ID: yPxoRVCCMFK1GvXcJdgumg_1759192482
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d6a82099cfso135419011cf.2
        for <kexec@lists.infradead.org>; Mon, 29 Sep 2025 17:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759192481; x=1759797281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5y9dDFkn6dM+xKzwMVSrxZQYOHZtK1ileeMBel7MUw=;
        b=P7BDmTLieUbfQthVIlOZNbvg2Isfho/pIyoOMijnz+4FhXBS7RwQ96e/oP+4gH2UWV
         KTB9Nn9uEHp1FiCVzS1WGcgIY6G2mPVfvw+tZJ1zsHE1e7PC3i8NALii/3LwxPzaBWCw
         Xxq7jtNTOYBehwuiOf2S84UhBT797xKXguilLMovXqchBApIU0VafqUaeR5OcNMBIp0X
         n0DgJY97np9qKp/Tdzk8JUgusf1IeXvuvMq+6k1dj8yXvjH9i6mYkjfV/RXZMkRt12gs
         62AIaj7rvk7zGKC4b6DzIZZEQ/JpUgjNET/Lvb2z+vB5SQf+5cMZFOaSX3ohDc5aWvOn
         kwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqkzuk6Nsm4Ds1UmULgfErRpCp428e1I/neRKzsrJK0P75D6O62zjzGvUcqCOihovCwdMy9g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyYvS9o/q9tNMImuwRTgi9Cj6BlLI0ShVs1foPCZnIXEjAzFaEV
	fm1dO0Uuvpmw7d1ZjJZJUu/VJ7BRNlSKLesP1rOeDU+diLIvipsx5aaExwzgaODMHoyMYYs1qEE
	C0XHqB2ANyuUOpZxroAErg7QNZM4WQkKnWNnn669Vc4sJIlehdc9DDITqLk/4EQjjY+yRbdFgpn
	rBRiButJEMC7eYfRMlJgMh0mpfszRu7xBIBilUtOq68djT
X-Gm-Gg: ASbGncsoPh6E8sBBlbNGpE2BQhpkUH/xVo6JuhDQlPgYN1jygcSsb0V0OdyQnPlxGrl
	OCjLLTXlWEcHGhUySI4BXyxDJvYlImsjaZnJBWEaZ4hxtEX4Hosm7xEKiGhrmC4+ofxdfynPa04
	FM3wDW6cAhDJYzYcfcyOllkS+K4Y8=
X-Received: by 2002:a05:622a:1493:b0:4cb:979:646b with SMTP id d75a77b69052e-4da4d21eda3mr203647541cf.55.1759192481547;
        Mon, 29 Sep 2025 17:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkJWMgmlK9TjmnhCVPhSVeGJCJenyfOdRxF1cqTGiOSBaD5/cBaTEJOP6T8KIEsOh+6VEDuHhhfbPwvdRVBe8=
X-Received: by 2002:a05:622a:1493:b0:4cb:979:646b with SMTP id
 d75a77b69052e-4da4d21eda3mr203647351cf.55.1759192481056; Mon, 29 Sep 2025
 17:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250610095743.18073-1-ltao@redhat.com> <20250610095743.18073-2-ltao@redhat.com>
 <c1b21df8-580a-4119-8c61-fce52fa0e8e1@nec.com>
In-Reply-To: <c1b21df8-580a-4119-8c61-fce52fa0e8e1@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 30 Sep 2025 13:34:04 +1300
X-Gm-Features: AS18NWDX1p_23RL8oroSR3rTGJcXwE4IrtH_AEEdx5e4o_yHh61XRLrVOY4vvaU
Message-ID: <CAO7dBbULH_mk+aGPoMv6jKrbWmzzgVz_44sWVovxXg4-FR+NHg@mail.gmail.com>
Subject: Re: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel
 address randomization
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>, 
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I5FKoFLkAqKzBRNb3S4jxd81p7nI2x_zlAzCSO1Hr-I_1759192482
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_173446_601009_304878CF 
X-CRM114-Status: GOOD (  24.52  )
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

Hi Kazu,

Thanks for your review of the patch [1 & 2].

As for the left [3 - 10] patches, I will redraft and post v2 later.

Thanks,
Tao Liu

On Mon, Sep 29, 2025 at 7:30=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> Hi Tao,
>
> On 2025/06/10 18:57, Tao Liu wrote:
> > There is a bug of not supporting randomized kernel address, this patch =
fix it.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
>
> apologies for my long delay and thank you for the patch.
>
> This patch looks good to me and I would like to merge this separately
> from the series, so
>
> Acked-by: Kazuhito Hagio <k-hagio-ab@nec.com>
>
> Thanks,
> Kazu
>
> > ---
> >   erase_info.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/erase_info.c b/erase_info.c
> > index af6bfae..b67d1d0 100644
> > --- a/erase_info.c
> > +++ b/erase_info.c
> > @@ -1881,7 +1881,7 @@ get_symbol_addr_all(char *name) {
> >       if (!strcmp(get_dwarf_module_name(), "vmlinux")) {
> >               symbol_addr =3D get_symbol_addr(name);
> >               if (symbol_addr)
> > -                     return symbol_addr;
> > +                     return symbol_addr + info->kaslr_offset;
> >
> >               vmlinux_searched =3D 1;
> >       }
> > @@ -1942,9 +1942,9 @@ get_symbol_addr_all(char *name) {
> >        * this function is called with debuginfo set to a particular
> >        * kernel module and we are looking for symbol in vmlinux
> >        */
> > -     if (!vmlinux_searched)
> > -             return get_symbol_addr(name);
> > -     else
> > +     if (!vmlinux_searched && !!(symbol_addr =3D get_symbol_addr(name)=
)) {
> > +             return symbol_addr + info->kaslr_offset;
> > +     } else
> >               return NOT_FOUND_SYMBOL;
> >   }
> >


