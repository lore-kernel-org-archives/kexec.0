Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42211CCD199
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 03:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k/cm1XbJlLFm4Qnd++2vjT56EGsEMrPgmqYWZpPb4es=; b=Vjc9FLpTaqFpoFLW56GhK8wqJC
	uDB+N3ETPixz2mCITd5JzTpbL7BKy5Eq/htGZYBd7njzvp/RfHdHkyZO9RNI8hmu+sVuPn6yO1eMQ
	QA1L0Ccaq7e2QBEg9DLFYyHtIbNodn5LZ7ao2OhZK3XZrbDyfWLod4cftxRLnOgKPhzFtco6dObmW
	gVhlDwGit8ORG1aB9bHB+9BjfQbkqCUQZlwtZvs+2E4SRGItTOSPwqO1wGNHP1fyv8ytCovT/f8rU
	yDuZRVfXLFz5VDMYf2FiFJB9jEm2UQsDa48svG2hNvjTMHm865dUEya2RoCWK2OkmzH8Nncysy0oH
	K3dqUrtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAgxP-0000000BoDK-3jGS;
	Mon, 20 Oct 2025 03:53:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAgxK-0000000BoCl-1N4Y
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 03:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760932388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/cm1XbJlLFm4Qnd++2vjT56EGsEMrPgmqYWZpPb4es=;
	b=d9nu6Drf+/w9FRRiMfzGZEhWgJn4XXSIBgvRgXB1vAPtpI5O4JiIsU4y2sflCCi02OS90f
	cVcpdMSmU/Q0iRAnLHQ+djKQaiL8TxJCJpdUXRJn2RStBafVBc7LkUAcvbNwRTiqJRZXe6
	bWyPArvcdnYGZMcoRIF7LUwSNJIU77c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-TUDU986NMXm_v_f6b-sVhQ-1; Sun, 19 Oct 2025 23:53:06 -0400
X-MC-Unique: TUDU986NMXm_v_f6b-sVhQ-1
X-Mimecast-MFC-AGG-ID: TUDU986NMXm_v_f6b-sVhQ_1760932386
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-891504015e5so528716085a.3
        for <kexec@lists.infradead.org>; Sun, 19 Oct 2025 20:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760932386; x=1761537186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/cm1XbJlLFm4Qnd++2vjT56EGsEMrPgmqYWZpPb4es=;
        b=MSPp9hp98rl0OEg0ex3tSDgqdgCcxBNO20QYoLNIFYlduvLhupquiTWG3xtEwFgi0n
         fyOkCvOPrWWitu04lOYR3MvRblNzZlbJa6X05H2R7EqB5awJ2MeRY2sZ3vRJj0IZtObK
         PSu2BSBNqPe/3/z3YoBMOblVVgs1AcAZddUmcWbhYJ0+LzSXLpblmgcpQ+Cith2KRXsZ
         +nsxXAm2nsDNq0fi6QFS8KdWGzIuioFis0pgmCX+/I6kJN4gserP26q2ao+UyX0FZt0c
         B3Eq/5mc4ZLc8XWy54Bfsh79rWXk8DsIMkqRmQ3xNyccVfrMbhGbJePFM3+7TLdMPAXs
         oZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWxkgwAWZxTkkVReMGjZMJwdTGPtn1axSodO4yOiQziPu4n3eSdYm8gcANpFIP9CiFWXBBkJg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwpIwMaw+co4dl0QwnMmarZc0jYj3d1bl3fqF0hK+Dn0hjcXx0M
	3X/e+UusCxhU4MTLn8CQ2jjlsaVn88jr6PKszMgOOmaDdVVifl4Q/CUIfdC8UjpaLcr/MSlMypz
	chKyWoOgt8ZV3O0K+uQpAWuZHQima+6gLWeRbGDJjiSRsfZ+oop0yxZ+eknl46xiBro9fwj/eO9
	8hnaRFBHlNocevsjcw1YYUOsT9c/4Z413Tt9RA
X-Gm-Gg: ASbGncvx+6JnDHcQELrv2KZJbDNN7YbxG+KkK/yYuw39dHaI72b0RKBq5KYtnpTbEm/
	7mN5s9MKXtid0wQ11JZ0Pys6cDwDJ6qhLhH2kRPIr0FTGbwDANF+JMgp284idtv3+vFiu+XvXFm
	nrMo35MLX2xXorva+KCypx96B3HdWjDoGB0z+AYa8zkv+rpqlxf1hNsIQ=
X-Received: by 2002:ac8:58cc:0:b0:4dd:2916:7980 with SMTP id d75a77b69052e-4e89d1ddf60mr175588951cf.2.1760932385839;
        Sun, 19 Oct 2025 20:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFURwkXvPt8z/1RWjIykDDq1bix+KqABTQvGTANiNOyMnvLuk/F8CMK+E1EZ9+4Q9o3yDxNcTKG9fyUhfXXt4Y=
X-Received: by 2002:ac8:58cc:0:b0:4dd:2916:7980 with SMTP id
 d75a77b69052e-4e89d1ddf60mr175588831cf.2.1760932385404; Sun, 19 Oct 2025
 20:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250610095743.18073-1-ltao@redhat.com> <20250610095743.18073-3-ltao@redhat.com>
 <8a3b3c55-f4f6-4c69-90f7-cdc7fc5094ee@nec.com>
In-Reply-To: <8a3b3c55-f4f6-4c69-90f7-cdc7fc5094ee@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 20 Oct 2025 16:52:29 +1300
X-Gm-Features: AS18NWDUkS-8GJ_rqSYTzeKgEQFzG7piUC51fTaRmgF0ij0boz0d9sWnX1j39dk
Message-ID: <CAO7dBbVZK17J_ptJ1SU3ivTHRUadAXMAk+bEcfTXu6eBrxVzoA@mail.gmail.com>
Subject: Re: [PATCH RFC][makedumpfile 02/10] dwarf_info: Fix a infinite
 recursion bug for search_domain
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>, 
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YV9kZEX0hOAHAeyBmahCUgJZyVE5eTMDje3_x3j3fqc_1760932386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251019_205310_437980_3ABF12D9 
X-CRM114-Status: GOOD (  29.96  )
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

Hi Kauz,

On Fri, Oct 17, 2025 at 5:21=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> Hi Tao,
>
> thank you for the fix.
>
> On 2025/06/10 18:57, Tao Liu wrote:
> > There is an infinite recursion bug noticed in rust symbols. The root ca=
use is
> > unclear to me. This patch will avoid the bug by skip the recursion of r=
ust
> > symbols, since currently we don't need to deal with those.
>
> I confirmed that the recursive dwarf_child() calls result in a loop, and
> I'm also not sure how we can avoid it correctly.  I think for now there
> is no demand for eppic + Rust with makedumpfile, so I can agree about
> skipping Rust DIEs.
>
> I think that probably you tried to support them as much as possible, so
> the patch has the lang check in search_domain().  but a halfway support
> may be confusing, i.e. maybe a user cannot determine whether it's not
> supported or a bug.

Agreed.
>
> So could we skip it in get_debug_info() like below and describe that the
> eppic extension does not support Rust's debug information in the man page=
?

Sure, thanks for your suggestion, I will update it in v2.

>
> @@ -1007,6 +1010,12 @@ get_debug_info(void)
>                          ERRMSG("Can't get CU die.\n");
>                          goto out;
>                  }
> +
> +               /* NOTE: currently Rust is not supported. */
> +               if (dwarf_srclang(&cu_die) =3D=3D DW_LANG_Rust)
> +                       continue;
> +

The following change works for me:

               /* NOTE: currently Rust is not supported. */
               if (dwarf_srclang(&cu_die) =3D=3D DW_LANG_Rust) {
                       off =3D next_off;
                       continue;
               }

I'm currently testing and will get it improved in v2

Thanks,
Tao Liu

>                  search_die_tree(&cu_die, &found);
>                  if (found)
>                          break;
>
> Thanks,
> Kazu
>
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >   dwarf_info.c | 15 ++++++++-------
> >   1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/dwarf_info.c b/dwarf_info.c
> > index a3a2fd6..73842ab 100644
> > --- a/dwarf_info.c
> > +++ b/dwarf_info.c
> > @@ -837,7 +837,7 @@ search_symbol(Dwarf_Die *die, int *found)
> >   }
> >
> >   static void
> > -search_domain(Dwarf_Die *die, int *found)
> > +search_domain(Dwarf_Die *die, int *found, int lang)
> >   {
> >       int tag;
> >       const char *name;
> > @@ -859,10 +859,11 @@ search_domain(Dwarf_Die *die, int *found)
> >                       if (is_container(&die_type)) {
> >                               Dwarf_Die child;
> >
> > -                             if (dwarf_child(&die_type, &child) !=3D 0=
)
> > +                             if (dwarf_child(&die_type, &child) !=3D 0=
 ||
> > +                                 lang =3D=3D DW_LANG_Rust)
> >                                       continue;
> >
> > -                             search_domain(&child, found);
> > +                             search_domain(&child, found, lang);
> >
> >                               if (*found)
> >                                       return;
> > @@ -924,7 +925,7 @@ search_die(Dwarf_Die *die, int *found)
> >   }
> >
> >   static void
> > -search_die_tree(Dwarf_Die *die, int *found)
> > +search_die_tree(Dwarf_Die *die, int *found, int lang)
> >   {
> >       Dwarf_Die child;
> >
> > @@ -932,7 +933,7 @@ search_die_tree(Dwarf_Die *die, int *found)
> >        * start by looking at the children
> >        */
> >       if (dwarf_child(die, &child) =3D=3D 0)
> > -             search_die_tree(&child, found);
> > +             search_die_tree(&child, found, lang);
> >
> >       if (*found)
> >               return;
> > @@ -950,7 +951,7 @@ search_die_tree(Dwarf_Die *die, int *found)
> >               search_typedef(die, found);
> >
> >       else if (is_search_domain(dwarf_info.cmd))
> > -             search_domain(die, found);
> > +             search_domain(die, found, lang);
> >
> >       else if (is_search_die(dwarf_info.cmd))
> >               search_die(die, found);
> > @@ -1007,7 +1008,7 @@ get_debug_info(void)
> >                       ERRMSG("Can't get CU die.\n");
> >                       goto out;
> >               }
> > -             search_die_tree(&cu_die, &found);
> > +             search_die_tree(&cu_die, &found, dwarf_srclang(&cu_die));
> >               if (found)
> >                       break;
> >               off =3D next_off;


