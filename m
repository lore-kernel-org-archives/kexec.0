Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF89CCD1AB
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 08:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXU439Cap5fMMVQXpitiBVbhBf41t1ZoD8dMaibAu40=; b=GhABULAY4z+piW/6d7OEzYGL0t
	M38MuSxtVdcP6RLHqit/BTK6k1ycbVZCF2rmAwl85MP9ltZzaH+JblpMlgVcokOuSpyx5IS7CpLz9
	i3l6WL3UP22/WPgzQNwSrzs0ff9uxNUUcXXsGiUyHhDi09iOSAnXuMh879AKeLL/9IakW+yV1G8Sl
	zfMAD++XApJhANIn+9kwG67Rm+hgPjllkmIWcBdZQ1FZqBV7+J4FDmugmgnAZosOcqI6ORFGTPiEo
	oqKEdgzOqeIoWytRMzUcbXUGincKdtgFre3Od5e1n4rpSMUQu/zXGSBJd5miAA71qfd4VAgoDWx5L
	TSx3RCHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCw4-00000008eA6-34TE;
	Fri, 24 Oct 2025 08:14:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCw2-00000008e9D-1JfC
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 08:14:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761293644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXU439Cap5fMMVQXpitiBVbhBf41t1ZoD8dMaibAu40=;
	b=Fw0tLdiGQ70RrR4vCgdAQJpnZvE7LuM7pMZmAqgGS/QQnxr4A7xvLesaNii0WfKZL3EIb3
	/KwtxCac7oehXiVNxsyUIk4AQYzTpWaop0eKx3UNK1i1YBe48e3QPiMhkiE0lMMADw4WXS
	8RctJ/0ae7oR513qYl/A+PfDAkBmhdU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-tviuFLYGM9SbuZmV2fgYuQ-1; Fri, 24 Oct 2025 04:14:02 -0400
X-MC-Unique: tviuFLYGM9SbuZmV2fgYuQ-1
X-Mimecast-MFC-AGG-ID: tviuFLYGM9SbuZmV2fgYuQ_1761293642
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8984d8833so81953611cf.0
        for <kexec@lists.infradead.org>; Fri, 24 Oct 2025 01:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293642; x=1761898442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXU439Cap5fMMVQXpitiBVbhBf41t1ZoD8dMaibAu40=;
        b=NUZCaow+kZHoe9m7pxgK31pKzaPUT3v92IyW7LsadDD+vuSjYEDLanQzeZ/5uRLXYG
         tXTU2GAK2u9Smn5EHmEds1Sct5OP+0jqItv+kBBGwZEP7ToCcombTCCyZR/k/RqLhJqe
         KX+2DtQs1IFdKaifaeCMc3IvZnSrvnWYD6sq7pf1HwLZWXNe9tNe915rVzrl1AE7zJ81
         a9oJwci59oFikRN3EIF5B8yKfoQvZIVcM/NajybA90h1Qn89njzoMwoFpCTM82SRtOyP
         ycwasTy3y4ViUgLQOyXuOzD7CHIVJhEociLoIzofUmL1Nfx8Tlg5fDERT5/m+eDLHukf
         /69w==
X-Forwarded-Encrypted: i=1; AJvYcCVezcisAvVMWdFKYOxTqrh2YeLLfvelmbWKDLUQK+hmDI3q5adfPrpCuXmFGSPBkm+Bd1bpSw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzMsttkjvuL4KPZHiANeNNqvS5WtdJZnQuJLDpOBLwv5N+wgHlp
	P3OoOU/wMBEE9piPI24zL/AmAnwTLb9wNiAnlxJv9QgZeYOFyaJDUZpecW4IMA6wAsCKW+t0haR
	3E/0n3E8uEoQaGgis5uEfD0g0pcA8mYuoLXkBm05vDPR3EDu6VbVgwqjUbm7PuNe7IysK5KOXa/
	QfeShSpnNnDOISvbVrX43Nd7bggvrezSDNiUi8
X-Gm-Gg: ASbGncu2LrhF6FVEWTEbLYjomzM9kpLP64dUlFie8FhYOUiAlz630CmyDiw4FRVyfO/
	ZtM4tCiVCExesKr6u0EpOzUQx/1I3B3wrklYjMXNSvitDCGNmwqVvvKku8wUAYjxstpjGJjXmmY
	4RMNWTQl/gvPAHFzmKcJCUllgz0bOHLbzBDzNq1o8oBeN1n77ww2plLG8g
X-Received: by 2002:a05:622a:507:b0:4eb:77cb:378a with SMTP id d75a77b69052e-4eb77cb3c8fmr111625371cf.74.1761293641883;
        Fri, 24 Oct 2025 01:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwCTgnOqWkDx+2HuPD+5c1QHqb3sv3ME8ydKoSv3R7PslXqoUER9P7x8A1S1Aa//Vi8863GxOIWropOiLM4E8=
X-Received: by 2002:a05:622a:507:b0:4eb:77cb:378a with SMTP id
 d75a77b69052e-4eb77cb3c8fmr111625231cf.74.1761293641545; Fri, 24 Oct 2025
 01:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251020222410.8235-1-ltao@redhat.com> <20251020222410.8235-4-ltao@redhat.com>
 <11f97cb2-725e-41f0-beb2-b4a4562ea7b1@nec.com> <f032d44c-b077-49e9-8636-8ba0bf6b296c@nec.com>
In-Reply-To: <f032d44c-b077-49e9-8636-8ba0bf6b296c@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 24 Oct 2025 21:13:24 +1300
X-Gm-Features: AS18NWAjhP1zRxMyvm8zqUnRoIDUIuKEEbjRFugdAgfkX7vNiiiE1HyQnuR7odc
Message-ID: <CAO7dBbVkeWoQAuqjj4DtLx-+mtHESo3-4wAkWERG=ExvWqfhmw@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile 03/14] dwarf_info: Support kernel address randomization
To: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4MWy2eYli_TcgjFadBpgY_cWf4TwUN9RqM0OngpL3ks_1761293642
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_011406_422780_43A6EAFC 
X-CRM114-Status: GOOD (  20.26  )
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

Thank you for reviewing and ack the patch!

Thanks,
Tao Liu

On Fri, Oct 24, 2025 at 8:19=E2=80=AFPM YAMAZAKI MASAMITSU(=E5=B1=B1=E5=B4=
=8E=E3=80=80=E7=9C=9F=E5=85=89)
<yamazaki-msmt@nec.com> wrote:
>
> Liu
>
> Thanks your new patch.
> I think the patche is good.
> I ack this patch.
>
> Acked-by: YAMAZAKI Masamitsu <yamazaki-msmt@nec.com>
>
> Thanks,
> Masa
>
> On 2025/10/22 15:37, HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE =E4=B8=80=E4=BB=81=
) wrote:
> > On 2025/10/21 7:23, Tao Liu wrote:
> >> There is a bug of not supporting randomized kernel address, this patch=
 fix it.
> >>
> >> Signed-off-by: Tao Liu <ltao@redhat.com>
> > for applying this 03/14 patch separately before the 1.7.8 release,
> >
> > Acked-by: Kazuhito Hagio <k-hagio-ab@nec.com>
> >
> > Thanks,
> > Kazu
> >
> >> ---
> >>    erase_info.c | 8 ++++----
> >>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/erase_info.c b/erase_info.c
> >> index fd316c1..d68e1a2 100644
> >> --- a/erase_info.c
> >> +++ b/erase_info.c
> >> @@ -1881,7 +1881,7 @@ get_symbol_addr_all(char *name) {
> >>      if (!strcmp(get_dwarf_module_name(), "vmlinux")) {
> >>              symbol_addr =3D get_symbol_addr(name);
> >>              if (symbol_addr)
> >> -                    return symbol_addr;
> >> +                    return symbol_addr + info->kaslr_offset;
> >>
> >>              vmlinux_searched =3D 1;
> >>      }
> >> @@ -1942,9 +1942,9 @@ get_symbol_addr_all(char *name) {
> >>       * this function is called with debuginfo set to a particular
> >>       * kernel module and we are looking for symbol in vmlinux
> >>       */
> >> -    if (!vmlinux_searched)
> >> -            return get_symbol_addr(name);
> >> -    else
> >> +    if (!vmlinux_searched && !!(symbol_addr =3D get_symbol_addr(name)=
)) {
> >> +            return symbol_addr + info->kaslr_offset;
> >> +    } else
> >>              return NOT_FOUND_SYMBOL;
> >>    }
> >>


