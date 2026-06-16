Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881BACD98DA
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 02:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QUj8MvA8NgTAJ6dJwkG0O9RLmBj4yEu2Z6ITuPmj+YU=; b=jvRHLuuFiPEZhkIVC+Pa82oMoK
	YHWMWQjA9WPg3WDsUwQBzwg2hhx/q1hZSIpbdrDP2rRhUT62MUOusrU9XgvKiLz4+Qt4hekJ/ialY
	aGcWtM/NtbYLs8wvFuYDGNrmosNQhBV0UyQnmithMCkYkVJ51UnwnxdX3L6DF+VYLg2xCyqgi0kmm
	SASERojzjZWHb2Ps9S/yarE8U8V2fen9ZiwQreDZ4soyK43lREVAVq1QSABF74ga5ZoP1hE5aoqnU
	971xJ/SsSSVkcCNe3VcQIpSFVEtqmueEzB6cPLGcOw6ZrqtGRUrGlcEfFb1p/boQ2wb237S6PDarE
	2W5Yj9vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZJN5-0000000F6Jl-2jNq;
	Tue, 16 Jun 2026 02:17:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZJN1-0000000F6J1-0p7s
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 02:17:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781576261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUj8MvA8NgTAJ6dJwkG0O9RLmBj4yEu2Z6ITuPmj+YU=;
	b=fg5TrrE4O2nemEGHC5IV1U5Mm1K4EOkN75gZuhtcmzegr6jz55inf+KGMwgqHxn9A/vjS7
	ltBUC7PnQlwpyS67wqiLt88tr7vqXg2TvsQx2Q8axb8GIGp7AO04g1TLMo0QYtiywVuzYP
	6xk3bqaIH7fAhZbarL1PE7C271RzEdc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Vaw3ZzTRO5ue9g9J5i28RQ-1; Mon, 15 Jun 2026 22:17:40 -0400
X-MC-Unique: Vaw3ZzTRO5ue9g9J5i28RQ-1
X-Mimecast-MFC-AGG-ID: Vaw3ZzTRO5ue9g9J5i28RQ_1781576259
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5177f07ea82so82194161cf.3
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 19:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781576259; x=1782181059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUj8MvA8NgTAJ6dJwkG0O9RLmBj4yEu2Z6ITuPmj+YU=;
        b=Dac3XzP9dxZSg5COx+n5wIV2yOYm8sgr+lPX0rZCKgN6VbIS42Oyb9BiML2DPeF707
         YCd2bAw6VqHe0/vE1YnxeffS1+NlseoNrG5EJjPH9i3ABY0ShhAvdUhPBhPXHlwhp3Lq
         vQlFxwHPTqGnUO4QEQ4Cb9mXekLUU+AXrOfErONirVsyR0ji11WKSWqv8JFa+bJej6j0
         qx+cIcDZCF4BnpU0/yIQd+HsYBOWqIAZLrsDjNehpQ9JUjPMtUUZjSO8zw13i08oivOa
         PbBrHsFZz6AJBa4kYvYuHi3JcvaRxPzvknZPaHNYpkh8cs5/Y+S5WJ/sSG/xxMgJdOqH
         xGHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7RfFUaylM6w2LcCKdpyFKjfMa/IJ2hgpCBYrHlek3kf+Ho5aZ7BORVYlyHX9h27Zk253I0w==@lists.infradead.org
X-Gm-Message-State: AOJu0YyzxOTKOvG+v0sKvu36hyPvX0zoY0z/uwpji1+rAfVVbqEORYXx
	JahkZUBEW0x2Gtch6Nl7K4pTGtSCDWGTIwmZ2wmIgwtzAV+ARe3R0v0S8ohyTdb/vlGL76F1t1O
	m5TKvHd22T27c9Od2InAZTO6BSnNfRWu8zdrKz42P3j25hXuFNojeRupEEnBEpUcGyhtP3x06+5
	DSu5ORn8Oawcg6+xrfyL+3TsfxOfNyIZzSj+J/
X-Gm-Gg: Acq92OFvoJokh9gvfeW3rkPtcvf8031wr4hiBNI+Tfxm1fRiRDZu/lpu/ED1RJPhpvI
	LbX2ry7eN5GGjYKrbC+n80kjYtcFLIKGUn7oktaOWAKHX4PsFeF71hmtTdG96QjAoqsLfqhQj/R
	Rd8urnvAxSZ2jiirrFZNOJawPGIZC84/iQMNsyRGRpUlw3VSjJgA6Tql9xzFdg4Uaw6cFm3WmC2
	3Wh
X-Received: by 2002:a05:622a:114e:b0:517:7e26:36a4 with SMTP id d75a77b69052e-517fe4ddbe8mr241883671cf.34.1781576259264;
        Mon, 15 Jun 2026 19:17:39 -0700 (PDT)
X-Received: by 2002:a05:622a:114e:b0:517:7e26:36a4 with SMTP id
 d75a77b69052e-517fe4ddbe8mr241883341cf.34.1781576258712; Mon, 15 Jun 2026
 19:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com> <20260414102656.55200-7-ltao@redhat.com>
 <8b0079dd-e50a-4667-aabf-1612921b022a@nec.com> <874ij3zq1k.fsf@oracle.com>
 <CAO7dBbU6V7XYYO9M+z_CK8UCnzfX7TB7DZka4Z_kqP-WvDbTaA@mail.gmail.com> <f15ae344-bdcc-48a1-9c7b-0ea264d061d4@nec.com>
In-Reply-To: <f15ae344-bdcc-48a1-9c7b-0ea264d061d4@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 16 Jun 2026 14:17:01 +1200
X-Gm-Features: AVVi8Cd2khA0sMZoKS0_mfsCFMHIZ2va2GgXZk8c9c10s4sBUbK3XgZvEPoRbHk
Message-ID: <CAO7dBbXLBX9_Ut9yQDkOr3pWq-mSx-5=tMUU9FL83eA3Lz0c_g@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cqXCciLoxFvHxtsVAaYDZo7hV1GmYdp02A_7Xw4olRw_1781576259
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_191743_337186_A0AEED2B 
X-CRM114-Status: GOOD (  29.95  )
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

On Tue, Jun 16, 2026 at 1:39=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> On 2026/06/16 8:03, Tao Liu wrote:
> > Hi Stephen & Kazu,
> >
> > On Tue, Jun 16, 2026 at 5:12=E2=80=AFAM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >>
> >> HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=80=80=E4=B8=80=E4=BB=81)   <k-hag=
io-ab@nec.com> writes:
> >>> On 2026/04/14 19:26, Tao Liu wrote:
> >>>
> >>>> +static bool init_kallsyms_btf(void)
> >>>> +{
> >>>> +    int count;
> >>>> +    bool ret =3D false;
> >>>> +    /* We will load module's btf/kallsyms on demand */
> >>>> +    bool init_ksyms_module =3D false;
> >>>> +    bool init_ktypes_module =3D false;
> >>>> +
> >>>> +    if (check_ksyms_require_modname("vmlinux", &count)) {
> >>>
> >>> Thank you for the explanation [1].
> >>>
> >>> so which code path adds "vmlinux" to the mods array before this line?
> >>> I could not find it.
> >>
> >> Hello Kazu,
> >>
> >> In kallsyms.c from patch 2, there is the line:
> >>    INIT_MOD_SYM(vmlinux, _stext);
> >> This adds a struct ksym_info to the main makedumpfile executable's
> >> array, which requests symbol "_stext" from vmlinux.
> >>
> >> In kallsyms.c "init_kernel_kallsyms()", again from patch 2, the first
> >> step is to call:
> >>     register_ksym_section((char *)__start_init_ksyms,
> >>                           (char *)__stop_init_ksyms))
> >> Which is a function generated by the macro REGISTER_SECTION(). The
> >> implementation will use add_ksym_modname() whens it encounters this
> >> symbol, ensuring that "vmlinux" is part of the modname array.
> >
> > Thanks for the detailed info, yes, it is exactly how "vmlinux" is
> > added to the array.
>
> hmm, maybe I still misread it though..
>
> The init_kernel_kallsyms() is called _after_ check_ksyms_require_modname(=
).
> so I've meant that if no extension adds "vmlinux" to the modname array,
> no one calls it.  is it ok?
>
>          if (check_ksyms_require_modname("vmlinux", &count)) {
>                  if (!init_kernel_kallsyms())

No, even if you create a extension which doesn't require symbols from
"vmlinux", once you load it, the check_ksyms_require_modname() will
still be true and init_kernel_kallsyms() is called.

The reason is, with the introduction of makedumpfile.ld, and the line
"INIT_MOD_SYM(vmlinux, _stext);" in kallsyms.c, makedumpfile and
extensions have a similar section structure, you can regard
makedumpfile itself as an extension:

$ readelf -S makedumpfile | grep -E 'ksyms|ktypes'
  [25] .init_ksyms       PROGBITS         000000000046ee90  0006de90
  [26] .init_ktypes      PROGBITS         000000000046eeb8  0006deb8
$ readelf -S extensions/sample.so | grep -E 'ksyms|ktypes'
  [24] .init_ksyms       PROGBITS         0000000000003108  00002108
  [25] .init_ktypes      PROGBITS         0000000000003110  00002110

If makedumpfile doesn't load any extensions, then makedumpfile doesn't
need to initialize its .init_ksyms/ktypes section, the behaviour stays
the same as before;
If makedumpfile load at least one extensions, then the extension
subsystem will register all .init_ksyms/ktypes sections, both
extenison's and makedumpfile's.

This is like, extension say "I need sym1 & sym2 to be ready before I
can run", then makedumpfile say "OK, I got it, but before I can
resolve your sym1 & sym2, I need to resolve some symbol(e.g. vmlinux's
_stext) formyself first". So check_ksyms_require_modname("vmlinux",
&count) will be true.

Hope this helps.

Thanks,
Tao Liu


>
> Thanks,
> Kazu
>
> >
> >>
> >> Thanks,
> >> Stephen
> >>
> >>> [1] https://lore.kernel.org/kexec/CAO7dBbUa_8H0fe+9bTNTQWjMVy9qCPiu0f=
o3g8XamiDS_Mr8eA@mail.gmail.com/
> >>>
> >>>
> >>>> +
> >>>> +bool has_extension_loaded(void)
> >>>> +{
> >>>> +    return extension_opts_len > 0;
> >>>
> >>> If an extension is skipped, this looks > 0 with no extention.
> >>> handle_cbs_len is better?
> >
> > Yeah, I agree, `has_extension_loaded()` should also be updated to
> > `has_extension_callback()`. I will fix it in v6.
> >
> > Thanks,
> > Tao Liu
> >
> >>>
> >>>
> >>> Thanks,
> >>> Kazu
> >>


