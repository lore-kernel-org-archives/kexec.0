Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4880DCAC5B0
	for <kexec@archiver.kernel.org>; Tue, 30 Sep 2025 01:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WiHDcV0714a34zXo+utRSuXUBiCV5/Jy3OKfK13OE0Q=; b=GhXEN4A+lSx1Ob7TFuDrbdmMrW
	2PT76Srpvu20snL6S1whur9pKi4x9Lhq+uWXO6rS6yFylGdfuOx/P5wJRimuhJTBD5pTAwN4PbBHH
	kVW2lfYliQz2faGBIS1y471St2O7Ub+CYV9BnD9xbZmo89zxQgXK0vy9d0d9w6DWP1ywBMsDwCN5C
	nYDcp42tB4sOGjy0WHK/7fAwvKsOXt0EdVV8jT0dPfL0r+u4lQkmimWiTxJrcqgUc4cWhYgOpA1vW
	JJOKmDqggbProGqrCsHQDCh8Oa0drmwsNN6pO74V2NCMk9dbvqQjHErNGnEIJ69vbur4WMs5ZwF6X
	9mMDe0Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PQO-00000003oVs-2ENK;
	Tue, 30 Sep 2025 01:45:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PQM-00000003oUf-07fo
	for kexec@lists.infradead.org;
	Tue, 30 Sep 2025 01:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759196700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiHDcV0714a34zXo+utRSuXUBiCV5/Jy3OKfK13OE0Q=;
	b=N7bCvj3SNGQ+WwuOD4lM9wK4WGobVTi4aqQiX9QnNY1+ZaWsObDQdkPoVsXNLIgAh4mx2M
	COViJYOv6+I1ur6wKXz5abdN5VHYrGAUeSiqJg/WNBW3zDY70b7SoEw1na8I2qJmEVpoYs
	Z+QfVNZaeEm1+/rrZA7Bej66k3WQVYA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-IhatZnq6NeWlGM-Z8i1RLA-1; Mon, 29 Sep 2025 21:44:57 -0400
X-MC-Unique: IhatZnq6NeWlGM-Z8i1RLA-1
X-Mimecast-MFC-AGG-ID: IhatZnq6NeWlGM-Z8i1RLA_1759196696
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dd932741cfso97122381cf.1
        for <kexec@lists.infradead.org>; Mon, 29 Sep 2025 18:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759196696; x=1759801496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiHDcV0714a34zXo+utRSuXUBiCV5/Jy3OKfK13OE0Q=;
        b=OTzJJVGmEm0whHlmenPfemU7ht4yTd3AeNdLGOJghZXOGC4aUbcE4p8xWKxHli/2U2
         o9CxLMIzJT6cfWdTVsz+jVGGANPDlng/Up51jsy49mt90n/eUc9A6fQ2EXMGbHOXEOCA
         SDAdxXQJrGnymEch7jbqUiD4NKtVr3MQKPlV1V6vKLJu+7pi1QHkcEzI2FL3c1Ym5HX2
         b0wvCtXCWFakFgDtemQYLlJzXvzm1srWMvGtrpV4s0jIuPVRZW9lQihM4VcaE566TRKA
         jts3iuS5UmNJcKCqUUetASsPi/JmRhfDiXNZHOJeSzDaPgfuASsNtqzKvCJdsupccF8t
         4hzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX0aO2C4uPab5m5FUJhONBARRF6vJtrppj1ALLOhs5JsbViVVKLqKRtHgLIExq2aPtc4OtyQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxjF5h9Ep4JdByrCdUnKuwjlwipZH9PMAqoka/0n3zlkIqI+3PD
	wEIBihaAcjODuWcrTxVsAdYTSG3gu03l1MqVoMynTpxTBuxa8CQUzr3CzEtTd1S4+ckX5nuVdLB
	XQTc2gL2Z4on+taLQvowIhvvePi/k3pPJQzF70eO2wKyiBuCWqXaAYibRjzFSqCS/ZcPEucsTKT
	F1LIH6o93SZjLqtHNV9VQZbRPbzsWFDtZUxRm4
X-Gm-Gg: ASbGncvn2Ltm1kB5mDLwkQFf8LBhONxqrJ1lXbOPL1TVlvD9biXukXPp6OMiZfxV7OP
	vOhkfEnJ7SL5a82JbFeicRvu9U2TQQDNkmSDjiVFomRpkuwkb5M9Qf/9NgProBByONttkE3tZh/
	ZBkGHHkztOXilqSu4pN2KVLw==
X-Received: by 2002:a05:622a:1886:b0:4b7:a3ac:701c with SMTP id d75a77b69052e-4da4782967fmr232743621cf.13.1759196696630;
        Mon, 29 Sep 2025 18:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjv5sAGAXb04qFd5QbWmNnT65dvWxg2NK3/EGQmgOWHEvkj2DwWQSphr80VFWBJcQbUr14CxSD09duCtYQks4=
X-Received: by 2002:a05:622a:1886:b0:4b7:a3ac:701c with SMTP id
 d75a77b69052e-4da4782967fmr232743521cf.13.1759196696276; Mon, 29 Sep 2025
 18:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250610095743.18073-1-ltao@redhat.com> <20250610095743.18073-2-ltao@redhat.com>
 <c1b21df8-580a-4119-8c61-fce52fa0e8e1@nec.com> <CAO7dBbULH_mk+aGPoMv6jKrbWmzzgVz_44sWVovxXg4-FR+NHg@mail.gmail.com>
 <0aa08746-3253-486b-acbc-98b1218e7d5a@nec.com>
In-Reply-To: <0aa08746-3253-486b-acbc-98b1218e7d5a@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 30 Sep 2025 14:44:20 +1300
X-Gm-Features: AS18NWD2cHBpT70K4iASJAV7faVXNSaKDJ1tXFfi-7__onv5J2KCRAlgvCTaJt8
Message-ID: <CAO7dBbXWyTiYs7nUceKrUxpoxMJir=ikj+OcOONA6SJr7rQaMw@mail.gmail.com>
Subject: Re: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel
 address randomization
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>, 
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uJDKfuNH_t0qIDuBjz4rYfH-SGIu8BZ6KWa5i3g6ee0_1759196696
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_184502_153215_F45A3397 
X-CRM114-Status: GOOD (  26.34  )
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

On Tue, Sep 30, 2025 at 2:29=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> On 2025/09/30 9:34, Tao Liu wrote:
> > Hi Kazu,
> >
> > Thanks for your review of the patch [1 & 2].
>
> ah sorry, the ack was for 01/10, I will review 02/10 later.

Oh I see, no worries, please take your time :)

Thanks,
Tao Liu

>
> >
> > As for the left [3 - 10] patches, I will redraft and post v2 later.
>
> I see.
>
> Thanks,
> Kazu
>
>
> >
> > Thanks,
> > Tao Liu
> >
> > On Mon, Sep 29, 2025 at 7:30=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=
=BE=E3=80=80=E4=B8=80=E4=BB=81)
> > <k-hagio-ab@nec.com> wrote:
> >>
> >> Hi Tao,
> >>
> >> On 2025/06/10 18:57, Tao Liu wrote:
> >>> There is a bug of not supporting randomized kernel address, this patc=
h fix it.
> >>>
> >>> Signed-off-by: Tao Liu <ltao@redhat.com>
> >>
> >> apologies for my long delay and thank you for the patch.
> >>
> >> This patch looks good to me and I would like to merge this separately
> >> from the series, so
> >>
> >> Acked-by: Kazuhito Hagio <k-hagio-ab@nec.com>
> >>
> >> Thanks,
> >> Kazu
> >>
> >>> ---
> >>>    erase_info.c | 8 ++++----
> >>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/erase_info.c b/erase_info.c
> >>> index af6bfae..b67d1d0 100644
> >>> --- a/erase_info.c
> >>> +++ b/erase_info.c
> >>> @@ -1881,7 +1881,7 @@ get_symbol_addr_all(char *name) {
> >>>        if (!strcmp(get_dwarf_module_name(), "vmlinux")) {
> >>>                symbol_addr =3D get_symbol_addr(name);
> >>>                if (symbol_addr)
> >>> -                     return symbol_addr;
> >>> +                     return symbol_addr + info->kaslr_offset;
> >>>
> >>>                vmlinux_searched =3D 1;
> >>>        }
> >>> @@ -1942,9 +1942,9 @@ get_symbol_addr_all(char *name) {
> >>>         * this function is called with debuginfo set to a particular
> >>>         * kernel module and we are looking for symbol in vmlinux
> >>>         */
> >>> -     if (!vmlinux_searched)
> >>> -             return get_symbol_addr(name);
> >>> -     else
> >>> +     if (!vmlinux_searched && !!(symbol_addr =3D get_symbol_addr(nam=
e))) {
> >>> +             return symbol_addr + info->kaslr_offset;
> >>> +     } else
> >>>                return NOT_FOUND_SYMBOL;
> >>>    }
> >>>


