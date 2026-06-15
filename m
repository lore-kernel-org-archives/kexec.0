Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C36CD98DE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 23:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xLHQ1i8be8AeCChCjG9icEs4OO9Y0Y22T/IpwWqPo9A=; b=xN4AS1lWqOAUJWN8yBKWXLikc6
	J6Rp8SP2nvVtiPnhm5QsXkMNUoD1YVS0M8C216fvxVJqer9NJxHvffXKzj4FciAhoa51dh8ZrFSY5
	EWuJQq4j+uj9Vvq4rouBpDq2CHB0pdGT/ete1gjDvfhZdNceCt8SvupBOCDhEYZhP8LIvWPixno6L
	Uc5t8htYFtGVcFghmjUnhMc433k+3tThqqnDY7z7FH0M5a7iWf8TOoxs0EGbsGuuh08/aWwCVD56a
	S3NvJK1kHq7vE4ju+h/GT5Yn6avdJKCqgqEBonNHKbNuqbqoN6wISdZ2MrpYSr6PunuWbsV5HqS7k
	DSRKNwEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZGNB-0000000EvUa-1MIY;
	Mon, 15 Jun 2026 23:05:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZGN8-0000000EvUD-3xs2
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 23:05:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781564737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLHQ1i8be8AeCChCjG9icEs4OO9Y0Y22T/IpwWqPo9A=;
	b=PXtRBmJFMFNDBzIcJseCH54Gg4ZRfI4YmNzdx3zYlinPGL/BGLFu1JtXEkyioksJgkuZUY
	i69aniW9xP5wKuU5iswh4HyV/dRJTcFPX/5bmK1XORwKK0S3IEO8v8W0q7aCO1AVxfI7a9
	Rc9jyIMmaIILHfzIYUZa+Oj49OZ0IYQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Nxk3jGL7N2SBgkyC42Mi9A-1; Mon, 15 Jun 2026 19:05:36 -0400
X-MC-Unique: Nxk3jGL7N2SBgkyC42Mi9A-1
X-Mimecast-MFC-AGG-ID: Nxk3jGL7N2SBgkyC42Mi9A_1781564736
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5177f07eb05so88298581cf.3
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 16:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781564736; x=1782169536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xLHQ1i8be8AeCChCjG9icEs4OO9Y0Y22T/IpwWqPo9A=;
        b=m7RYzdkNpRAJopDHuIQ3AetUb2H9lDehSzuLP8l0mg6Gpbw1GdKZ0TIv7PSKacdey6
         QXWVad6R+PgXU3XlAepQ5O8V2q80l63uUbNosB4aL1nADi5Bp34xEJXUhqw1GROLUDHs
         uwD8HoMVG8lgWsMmZC3eyEocK2NfY0GEiEqwZiaZjP03HSE+W7JrCwUeMsb4QmPhiX/A
         RDYI/LLqKsuEFqr+2Cbhk0Dj6nlMetgHIMbnE4+Dyl33yV6C6LfdDPomnUddS4S2by+T
         6/2Foz4CHCAbx8YJWEkE5mlBfl73NpfWIJkZq3OLsuHDZybHGrBgYRutojhxUvfDrZ/1
         o84w==
X-Forwarded-Encrypted: i=1; AFNElJ+HQ7gQFZsU7hURE+Tv0DSV3egYNaKjH9FgVa+BkJpPwa7OtZYWpFVnXpFiH833EVrcfwDvDw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzoYbeDSoa3AD4PmklIX41gH+9YkiPlptDQxbLuujBmecGCfY7Z
	BZmLmzfHuYDNRTaeuaYFluu809sfUnME50au80wY4sy4uyD1BVaRshZOxsJUfwXXwqk6hCALKhv
	GX1uc41EPWgn+dyMgzkveYkNz4HIXq3aMn8992EzK1lgvAC3Vy3ogY+MZ2G41gvqlSG1QR6ddWu
	FMtNEjhujX7wG+IE2T8EdWmzBLBiJ0g2Fx00pX
X-Gm-Gg: Acq92OEoz6Axrwq2yRUsyYyv5xtgVw6ZxiWKLmUiNISr42qdY3JRyqSf+CVl6b3kWwj
	CusQyOI/ikocRUoktdjx1ikmrKTx0G4U6L0//RMTKe+U28BzeQlY1/2hRKoLyNnen2DhPpuIU0x
	5y3V42M1LpOaMVHh2fKbNFihhH1jhGW9M6KN2NFSXq6KcQmaD/GtObQXvVUlmFt9am9+2zsGHsV
	0a2
X-Received: by 2002:ac8:7fc7:0:b0:516:e9ea:1c32 with SMTP id d75a77b69052e-519916ae7edmr16230601cf.9.1781564735742;
        Mon, 15 Jun 2026 16:05:35 -0700 (PDT)
X-Received: by 2002:ac8:7fc7:0:b0:516:e9ea:1c32 with SMTP id
 d75a77b69052e-519916ae7edmr16230091cf.9.1781564735331; Mon, 15 Jun 2026
 16:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com> <20260414102656.55200-3-ltao@redhat.com>
 <22a28d23-d941-4ef0-bff0-93c97c3e9956@nec.com>
In-Reply-To: <22a28d23-d941-4ef0-bff0-93c97c3e9956@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 16 Jun 2026 11:04:58 +1200
X-Gm-Features: AVVi8CejFo7-xO6od8Kq5eotmfRWTXo_RVi9x5IQ2js_v7hyht69eyiPmxlS8Ng
Message-ID: <CAO7dBbXhzztftYU35nEWid-7R1wa4CoOp2ujyZzFG6qfp82GZw@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 2/9] Implement kernel kallsyms resolving
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CPYMzOboZJsCtfFDrdUFt59oAo4G3SKo8-j0vwasQ08_1781564736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_160539_062868_6C3212F8 
X-CRM114-Status: GOOD (  12.52  )
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

Ah, you are right, I missed those. I will fix the fprintf()s in the
macro and send v6.

Thanks,
Tao Liu

On Mon, Jun 15, 2026 at 8:09=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> Hi Tao,
>
> thank you for the update, almost finished.
> there are a few of slight comments.
>
> On 2026/04/14 19:26, Tao Liu wrote:
>
> > +#define REGISTER_SECTION(T)                                          \
> > +bool register_##T##_section(char *start, char *stop)                 \
> > +{                                                                    \
> > +     struct section_range *new_sr;                                   \
> > +     struct T##_info **p;                                            \
> > +     bool ret =3D false;                                              =
 \
> > +                                                                     \
> > +     if (!start || !stop) {                                          \
> > +             fprintf(stderr, "%s: Invalid section start/stop\n",     \
> > +                     __func__);                                      \
> > +             goto out;                                               \
> > +     }                                                               \
> > +                                                                     \
> > +     for (p =3D (struct T##_info **)start;                            =
 \
> > +          p < (struct T##_info **)stop;                              \
> > +          p++) {                                                     \
> > +             if (!add_##T##_modname((*p)->modname))                  \
> > +                     goto out;                                       \
> > +     }                                                               \
> > +                                                                     \
> > +     new_sr =3D malloc(sizeof(struct section_range));                 =
 \
> > +     if (!new_sr) {                                                  \
> > +             fprintf(stderr, "%s: Not enough memory!\n", __func__);  \
>
> fprintf()s still exist in this macro.
>
> Thanks,
> Kazu


