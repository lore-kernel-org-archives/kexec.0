Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD36DCD98E1
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 02:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/zRPFlFNV40UiifmpcsArwZtZ0GWpih5AZa2+q7NRi8=; b=WHHNZUC6xbdUvco6zLP0cZ0EtU
	+We5prpPj8VFZ0kiECivlzPbHYuoybej7TnzcRf1lruNM/55KRajKSqfvL7d+UxaPC3Wj0xkehILm
	1q1isC3ocAqYCIDhMeTq0UuJjufv888QrtHTINLOgFG7TGISBSuV0XsyF4v5vEfo69KzJE3t23kt2
	vlW+lBZQQv3pRs3e4F6nBqPMiCp0YGECZFfB4Ne1n44dE10HlZyJLcqdctt1yxhx3tGjg/6iUqB8u
	N4kTev/lX4SePltpV7vESN+9N1BJXhR7bXR+5Vi5arlE4wkzg85R42+ebDFewdf2x2KBL+P7vwNoB
	eEgQPN3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZg7W-0000000GW37-0ekh;
	Wed, 17 Jun 2026 02:35:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZg7S-0000000GW2F-3wrP
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 02:35:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781663707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zRPFlFNV40UiifmpcsArwZtZ0GWpih5AZa2+q7NRi8=;
	b=RZr9D1EiUawKdCNR5yXwJEpVCsGhOgAdwEmaiD2dpk+7sDaugNo9zZFyTYg4GxX9AEbXEQ
	/WjD1fj7qZfIFGbiamSPgfS1f844uNNQ8yp0q6m5GZauhZM18YDOCAlDsU8Jj5ytdjauRU
	/wn4qoFoRmkMzaOz7358hRWb5U4JSkk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-V9Hq7LCnMvGZ5i7Ou3iRdg-1; Tue, 16 Jun 2026 22:35:05 -0400
X-MC-Unique: V9Hq7LCnMvGZ5i7Ou3iRdg-1
X-Mimecast-MFC-AGG-ID: V9Hq7LCnMvGZ5i7Ou3iRdg_1781663705
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51989985485so38618351cf.1
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 19:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781663705; x=1782268505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zRPFlFNV40UiifmpcsArwZtZ0GWpih5AZa2+q7NRi8=;
        b=JlGVZ/cFZumGbqDCAR4S/skukVZjUhhy1CpZPY0Chm9Espd4irfNObZjgbQub8r1Uk
         7n8nnD0qlUhta2IJqf8FMKm/oP4i4Gdq0Qwcrh4nZ/wdWc4fo3nuV2qxm8420lYY1fOY
         B466Ms0CpQ6nErCHW/X/h9qplG+MM/uO9zE3HzCBbiGK4inaEBx0+nR1jzUhUQqnIE5L
         edlAiCzc+DkgoboC1M5KDioWpSI4ZJ0q4eF5qppEn2Wobx1t65hr+qUhnpFYg7pnkYIC
         qQCfdaeJZreuRAUsLGPqabq1BFP4Rgag0Y2S8RHpbYcxA07vtLTIoBYYSez3okYy1LLs
         bIeg==
X-Forwarded-Encrypted: i=1; AFNElJ+7Zxz9fgQnR68vqC4LZn+vzHoHnxaS7C8ZI2ecC3rTnSLC6OsdFC+rnsMJqmA6paMoeKdFxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyrTPZBm+APNhubtIX317V2dwdryoBCsP6bWcoLNbkBAOAvJatV
	fFuzltvYIEqDM3NuHrMAvZJsFAw5gkdbnAOX2fb+UKsHPKvJZT9Yz4JXpKMxDa697DPW1ynHaxt
	IfKoDEk77eByovBG1C26gyb2g4MbzBH8Rwp/ni7vc5htagfftU52o9L48pu2B/JlqK3MDMzBGB0
	1e2Hhtd0DtOMkomQjnOpyCY2l3GMtYRSsV44Vsa1UMlQoE
X-Gm-Gg: Acq92OHppmrmoh17hmWi2cASlLXc9Cv9USNlrc7DEEdeQK6NkbulMBg2rBFVoZP1lco
	osBseoSqpVzXL5Wl5mEBnT5TxOWYUC4u/1zCl9mrCB9nTj1tt141DjWafGBVCb/WIXfxel8xFBR
	sQrvulfr1mxkuz1KAaEt1rFfk5XBlQmwMPJ+OVO6wC6pblFneditC8eAbbKSLalnjZbg==
X-Received: by 2002:a05:622a:1e0d:b0:517:5beb:9b17 with SMTP id d75a77b69052e-519a8ca3157mr36292701cf.1.1781663704936;
        Tue, 16 Jun 2026 19:35:04 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0d:b0:517:5beb:9b17 with SMTP id
 d75a77b69052e-519a8ca3157mr36292301cf.1.1781663704409; Tue, 16 Jun 2026
 19:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com> <20260414102656.55200-7-ltao@redhat.com>
 <8b0079dd-e50a-4667-aabf-1612921b022a@nec.com> <874ij3zq1k.fsf@oracle.com>
 <CAO7dBbU6V7XYYO9M+z_CK8UCnzfX7TB7DZka4Z_kqP-WvDbTaA@mail.gmail.com>
 <f15ae344-bdcc-48a1-9c7b-0ea264d061d4@nec.com> <CAO7dBbXLBX9_Ut9yQDkOr3pWq-mSx-5=tMUU9FL83eA3Lz0c_g@mail.gmail.com>
 <ab1b5e58-bad6-4565-a408-b1fb3d489465@nec.com> <ajEmEtudVb_YqEkM@localhost.localdomain>
 <33ce6e2b-516d-410d-8828-8be7fc77d182@nec.com>
In-Reply-To: <33ce6e2b-516d-410d-8828-8be7fc77d182@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 17 Jun 2026 14:34:26 +1200
X-Gm-Features: AVVi8CdObR9QvKVOk9qPGmH-GxFDPd1WF0s5AZUPkv9RkpwZf_hh1GZPmxZ5KD0
Message-ID: <CAO7dBbV2VZjLkntmKM_=amf+v-oZDFb22WrFwT_AuHr3sYdntg@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: psA8UVcboW6F48rW6vjqaNS0GYvoNm8KN1v8OP8T3sI_1781663705
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_193511_073639_0F0E20B9 
X-CRM114-Status: GOOD (  43.87  )
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

On Wed, Jun 17, 2026 at 1:50=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> On 2026/06/16 19:31, Tao Liu wrote:
> > Hi Kazu,
> >
> > On Tue, Jun 16, 2026 at 07:51:47AM +0000, HAGIO KAZUHITO(=E8=90=A9=E5=
=B0=BE =E4=B8=80=E4=BB=81) wrote:
> >> On 2026/06/16 11:17, Tao Liu wrote:
> >>> On Tue, Jun 16, 2026 at 1:39=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=
=B0=BE=E3=80=80=E4=B8=80=E4=BB=81)
> >>> <k-hagio-ab@nec.com> wrote:
> >>>>
> >>>> On 2026/06/16 8:03, Tao Liu wrote:
> >>>>> Hi Stephen & Kazu,
> >>>>>
> >>>>> On Tue, Jun 16, 2026 at 5:12=E2=80=AFAM Stephen Brennan
> >>>>> <stephen.s.brennan@oracle.com> wrote:
> >>>>>>
> >>>>>> HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=80=80=E4=B8=80=E4=BB=81)   <k=
-hagio-ab@nec.com> writes:
> >>>>>>> On 2026/04/14 19:26, Tao Liu wrote:
> >>>>>>>
> >>>>>>>> +static bool init_kallsyms_btf(void)
> >>>>>>>> +{
> >>>>>>>> +    int count;
> >>>>>>>> +    bool ret =3D false;
> >>>>>>>> +    /* We will load module's btf/kallsyms on demand */
> >>>>>>>> +    bool init_ksyms_module =3D false;
> >>>>>>>> +    bool init_ktypes_module =3D false;
> >>>>>>>> +
> >>>>>>>> +    if (check_ksyms_require_modname("vmlinux", &count)) {
> >>>>>>>
> >>>>>>> Thank you for the explanation [1].
> >>>>>>>
> >>>>>>> so which code path adds "vmlinux" to the mods array before this l=
ine?
> >>>>>>> I could not find it.
> >>>>>>
> >>>>>> Hello Kazu,
> >>>>>>
> >>>>>> In kallsyms.c from patch 2, there is the line:
> >>>>>>      INIT_MOD_SYM(vmlinux, _stext);
> >>>>>> This adds a struct ksym_info to the main makedumpfile executable's
> >>>>>> array, which requests symbol "_stext" from vmlinux.
> >>>>>>
> >>>>>> In kallsyms.c "init_kernel_kallsyms()", again from patch 2, the fi=
rst
> >>>>>> step is to call:
> >>>>>>       register_ksym_section((char *)__start_init_ksyms,
> >>>>>>                             (char *)__stop_init_ksyms))
> >>>>>> Which is a function generated by the macro REGISTER_SECTION(). The
> >>>>>> implementation will use add_ksym_modname() whens it encounters thi=
s
> >>>>>> symbol, ensuring that "vmlinux" is part of the modname array.
> >>>>>
> >>>>> Thanks for the detailed info, yes, it is exactly how "vmlinux" is
> >>>>> added to the array.
> >>>>
> >>>> hmm, maybe I still misread it though..
> >>>>
> >>>> The init_kernel_kallsyms() is called _after_ check_ksyms_require_mod=
name().
> >>>> so I've meant that if no extension adds "vmlinux" to the modname arr=
ay,
> >>>> no one calls it.  is it ok?
> >>>>
> >>>>            if (check_ksyms_require_modname("vmlinux", &count)) {
> >>>>                    if (!init_kernel_kallsyms())
> >>>
> >>> No, even if you create a extension which doesn't require symbols from
> >>> "vmlinux", once you load it, the check_ksyms_require_modname() will
> >>> still be true and init_kernel_kallsyms() is called.
> >>>
> >>> The reason is, with the introduction of makedumpfile.ld, and the line
> >>> "INIT_MOD_SYM(vmlinux, _stext);" in kallsyms.c, makedumpfile and
> >>> extensions have a similar section structure, you can regard
> >>> makedumpfile itself as an extension:
> >>>
> >>> $ readelf -S makedumpfile | grep -E 'ksyms|ktypes'
> >>>     [25] .init_ksyms       PROGBITS         000000000046ee90  0006de9=
0
> >>>     [26] .init_ktypes      PROGBITS         000000000046eeb8  0006deb=
8
> >>> $ readelf -S extensions/sample.so | grep -E 'ksyms|ktypes'
> >>>     [24] .init_ksyms       PROGBITS         0000000000003108  0000210=
8
> >>>     [25] .init_ktypes      PROGBITS         0000000000003110  0000211=
0
> >>>
> >>> If makedumpfile doesn't load any extensions, then makedumpfile doesn'=
t
> >>> need to initialize its .init_ksyms/ktypes section, the behaviour stay=
s
> >>> the same as before;
> >>> If makedumpfile load at least one extensions, then the extension
> >>> subsystem will register all .init_ksyms/ktypes sections, both
> >>> extenison's and makedumpfile's.
> >>>
> >>> This is like, extension say "I need sym1 & sym2 to be ready before I
> >>> can run", then makedumpfile say "OK, I got it, but before I can
> >>> resolve your sym1 & sym2, I need to resolve some symbol(e.g. vmlinux'=
s
> >>> _stext) formyself first". So check_ksyms_require_modname("vmlinux",
> >>> &count) will be true.
> >>
> >> hmm, but as far as I've tested with "extensions/sample.c" on RHEL10.2:
> >>
> >> 1) add INIT_MOD_SYM(xfs, xfsstats) and GET_MOD_SYM(xfs, xfsstats)
> >>
> >> ok
> >>
> >> Loaded extension: /share/tmp/makedumpfile/extensions/sample.so
> >> sample.so: The address of xfsstats is: ffffffffc0c0b540   <<--- ok
> >> sample.so: The address of init_task is: ffffffffb4412940
> >> sample.so: The size of task_struct is: 10240 bytes
> >> sample.so: The offset of member mm within task_struct is: 2704 bytes
> >> sample.so: The size of member mm within task_struct is: 8 bytes
> >> sample.so: Your kernel is using maple tree in mm_struct
> >>
> >> 2) remove all "vmlinux" entries (only INIT_MOD_SYM(xfs, xfsstats))
> >>
> >> skipped
> >>
> >> Loaded extension: /share/tmp/makedumpfile/extensions/sample.so
> >> check_required_ksyms_all_resolved: Symbol xfsstats in xfs not found
> >> init_extensions: Skip 1th extension
> >>
> >
> > This is a bug which shouldn't happen, thanks for pointing it out.
> >
> >> 3) restore INIT_MOD_SYM(vmlinux, init_task) and GET_MOD_SYM(vmlinux, i=
nit_task)
> >>
> >> still skipped
> >>
> >> Loaded extension: /share/tmp/makedumpfile/extensions/sample.so
> >> check_required_ksyms_all_resolved: Symbol xfsstats in xfs not found
> >> init_extensions: Skip 1th extension
> >>
> >
> > Also a bug. I made a code modification based on the v5 to fix, could yo=
u please
> > give a try? If no problem I will integrate it with v6.
>
> This patch tested ok and looks good and consistent with the condition che=
cks
> in init_kallsyms_btf().

Glad to know that! I'm working on v6 and will post it upstream later.

Thanks,
Tao Liu

>
> Thanks,
> Kazu
>
>
> >
> > diff --git a/btf_info.c b/btf_info.c
> > index 1506152..fbb487b 100644
> > --- a/btf_info.c
> > +++ b/btf_info.c
> > @@ -202,10 +202,6 @@ bool init_kernel_btf(void)
> >               goto out;
> >       }
> >
> > -     if (!register_ktype_section((char *)__start_init_ktypes,
> > -                                 (char *)__stop_init_ktypes))
> > -             return ret;
> > -
> >       size =3D stop_btf - start_btf;
> >       buf =3D (char *)malloc(size);
> >       if (!buf) {
> > diff --git a/extension.c b/extension.c
> > index 190dd9e..276ffb1 100644
> > --- a/extension.c
> > +++ b/extension.c
> > @@ -153,7 +153,7 @@ static void load_extensions(void)
> >       }
> >   }
> >
> > -static bool register_extension_sections(void)
> > +static bool register_ksyms_ktypes_sections(void)
> >   {
> >       char *start, *stop;
> >       int i;
> > @@ -170,6 +170,18 @@ static bool register_extension_sections(void)
> >               if (!register_ktype_section(start, stop))
> >                       goto out;
> >       }
> > +     /* If no extensions, don't register makedumpfile's section */
> > +     if (handle_cbs_len > 0) {
> > +             start =3D dlsym(NULL, "__start_init_ksyms");
> > +             stop =3D dlsym(NULL, "__stop_init_ksyms");
> > +             if (!register_ksym_section(start, stop))
> > +                     goto out;
> > +
> > +             start =3D dlsym(NULL, "__start_init_ktypes");
> > +             stop =3D dlsym(NULL, "__stop_init_ktypes");
> > +             if (!register_ktype_section(start, stop))
> > +                     goto out;
> > +     }
> >       ret =3D true;
> >   out:
> >       return ret;
> > @@ -260,7 +272,7 @@ void init_extensions(void)
> >       void (*init)(void);
> >
> >       load_extensions();
> > -     if (!register_extension_sections())
> > +     if (!register_ksyms_ktypes_sections())
> >               goto fail;
> >       if (!init_kallsyms_btf())
> >               goto fail;
> > diff --git a/kallsyms.c b/kallsyms.c
> > index f231a06..0037600 100644
> > --- a/kallsyms.c
> > +++ b/kallsyms.c
> > @@ -276,10 +276,6 @@ bool init_kernel_kallsyms(void)
> >               return ret;
> >       }
> >
> > -     if (!register_ksym_section((char *)__start_init_ksyms,
> > -                                (char *)__stop_init_ksyms))
> > -             return ret;
> > -
> >       if (!readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms=
,
> >               sizeof(kallsyms_num_syms))) {
> >               ERRMSG("Can't get kallsyms_num_syms!\n");
> >
> >
> >> 4) also restore INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, mm) and
> >>      GET_MOD_STRUCT_MEMBER_SSIZE(vmlinux, task_struct, mm)
> >>
> >> ok
> >>
> >> Loaded extension: /share/tmp/makedumpfile/extensions/sample.so
> >> sample.so: The address of xfsstats is: ffffffffc0c0b540
> >> sample.so: The address of init_task is: ffffffffb4412940
> >> sample.so: The size of task_struct is: 10240 bytes
> >>
> >>
> >> So, it looks like, with the current condition check in init_kallsyms_b=
tf()
> >> (check_ksyms_require_modname and check_ktypes_require_modname),
> >> a module needs to use INIT_* for vmlinux's kallsyms and BTF.
> >>
> >> I'm still missing something..?
> >>
> >> Thanks,
> >> Kazu


