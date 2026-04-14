Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDD4F531DE
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 11:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V43wC+2vroLodSoJLi9DVeqCS8mXjxnbV2o8UZ/+89c=; b=B7QgV8XhBtdvYqD8WqZH6jwLRv
	X2XKgiogPFAANYgH6zwH5fm+5VPI3hul7fcfUi0zqqOCb9rjQ2SoiVfQuHVOWFVAi56gfh5TMgwCM
	KhDhukRwNSYTTarax9iWCsQ2Xfz+NfRUQES9qQnLATNwlOgY529q+ou4BxsOZC/mxmwVkHPSse27Y
	wTfGxKcYkp+95X1RTunh3DdqLMkwIK8sy6Nhf2Q1xIpkiYdulqSCeS6kEvszrYJzjVakBKNSnDh+Q
	pu45RPOQGqffN6njtVCUthg0Ym0VoDKEil2xoz0/rVMzpmkb6Eoe/6xFHYFY1beZN3VkrKnecnV1Q
	lWbI091g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbYz-0000000HCAN-2Yjc;
	Tue, 14 Apr 2026 11:04:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbYx-0000000HC9V-2fES
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 11:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776164650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V43wC+2vroLodSoJLi9DVeqCS8mXjxnbV2o8UZ/+89c=;
	b=ZATbvVO0hkm7sid3q92Hmw5L4HqUBh9x+/fKnQFKW1Y7paZHZ+/JuqoD3GxEJT76QsX1x5
	fChHBA8H8gSuxyVNGFz6kJO6Q2+JGEDQLs4BzhxYYAA8fOAzL5PUWlLIE1HLhx50E31PGO
	aRX6hzzM7IRF6XlW5kevCVqQNvXvjfg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-lc_LBgn4MCeclZ2SSBPjPg-1; Tue, 14 Apr 2026 07:04:07 -0400
X-MC-Unique: lc_LBgn4MCeclZ2SSBPjPg-1
X-Mimecast-MFC-AGG-ID: lc_LBgn4MCeclZ2SSBPjPg_1776164647
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d9a6a853bso131847771cf.0
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 04:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164647; x=1776769447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V43wC+2vroLodSoJLi9DVeqCS8mXjxnbV2o8UZ/+89c=;
        b=qdfP//dVyaaNG7nHHBLG5s1+3Z2hx8I/JWOqz8w31VKQIAUDUQSphAY/0eA0370lf6
         KFT0TLOJVSnQ1bfcBf4JsNp1kLbzWEY6iDmRlZ8uLhmYILuv036yFIyqkTKUicirT0ba
         J+nzlmOQqO2Vk779ap9J6HdjnIN2Wgbsps9NyflW4U38SvLB/Wj4NetUBdMiJm5w/lUF
         ije1khG3h5IAPkybZaXndSOmlKvo3wylBkcHwJgHO7J4HCBhtwk+8Bby0ejicZipPssV
         W9wW4HNq7Oo2mXWpOl5SpkPO0aGBCGCDby3qSmFAMqIcwTZE69wbcULzJ1bg9dES7Ule
         neew==
X-Forwarded-Encrypted: i=1; AFNElJ+Z8L0CNYCySIvSe3AQvW56Ehm5gpDQ8zY3gJ4mKpK3pV9uHW6xpAkvznnp9Dd5VovsxwDbrg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXgYNR7dEb+vOnBLlSq0NYZE2CWUmvyqWHSa84mjMSFKSwkk4A
	tI4urb9AlGd4LwOXoIQE1Dyv8TQ+3uUdeWFcmlvjk/xQF3ecWe3LVCYD6bv/8bKJ+QVbfHu1KMi
	MigqTjRoaONefvflB+B93QJhUi4WdWH2ejm1Torb4XkX6eq3u/v752joSaLEJoYEPQ0DK+KwCmh
	qushR9WgHShwKJKLLAN4KaWfGYdJkSyppEf8gu
X-Gm-Gg: AeBDiesnDahMnmhOETc368KXiR3U1/ngCrXscJhoQhcPdIxnk5cpit+6p3m/7PhaI4Q
	RmZXxQPHjN+0JuaEkNavJ5i3coQyvLU8SnX8opWO+ZxlmGUT/yGXBCSGlLdhPsWjpOrRA8sPM5Q
	LVAuC0YIcWE8LY8qUE4HErFyH0pKYhNr9yCtECghPZ4DEmkR40wfjyl5ApatNArMXDIvPCueF28
	K8+YIaJ4P3tcQ==
X-Received: by 2002:a05:622a:4106:b0:50d:5d96:568a with SMTP id d75a77b69052e-50dd5b016camr249669531cf.27.1776164647057;
        Tue, 14 Apr 2026 04:04:07 -0700 (PDT)
X-Received: by 2002:a05:622a:4106:b0:50d:5d96:568a with SMTP id
 d75a77b69052e-50dd5b016camr249669231cf.27.1776164646590; Tue, 14 Apr 2026
 04:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260317150743.69590-1-ltao@redhat.com> <20260317150743.69590-2-ltao@redhat.com>
 <875x69ey7g.fsf@oracle.com>
In-Reply-To: <875x69ey7g.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 14 Apr 2026 23:03:30 +1200
X-Gm-Features: AQROBzDlhQFn2ITwPXhkszQK78YjQRZ29l1eKnDaZpMrx6nbbmRPcmmrlDiZAqs
Message-ID: <CAO7dBbV8WWHqHxi5A53jt_XfVZgJFkWiWb=ZVoFUkomO+r0UmA@mail.gmail.com>
Subject: Re: [PATCH v4][makedumpfile 1/7] Reserve sections for makedumpfile
 and extenions
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XEIiwOytzf2LOcpaiwNHaoEvyiDp_YOdje8G_vfz63k_1776164647
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_040411_747662_6E68C2C4 
X-CRM114-Status: GOOD (  30.32  )
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

Hi Stephen,

On Fri, Apr 3, 2026 at 12:31=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Tao Liu <ltao@redhat.com> writes:
> > This patch makes preparation for btf/kallsyms support of
> > makedumpfile and extensions. Any needed kernel symbols/types
> > will be reserved within a special section, .init_ksyms for
> > kallsyms symbols and .init_ktypes for kernel types. During
> > makedumpfile kallsyms/btf initialization, those missing info
> > will be resolved. A makedumpfile.ld script is introduced for the
> > purpose.
> >
> > Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > Signed-off-by: Tao Liu <ltao@redhat.com>
>
> As I mentioned before, I don't think this patch is strictly necessary.
> If we rename the sections to avoid the "." at the start of the names,
> then the compiler should automatically provide the start and stop
> symbols. But that said, there's nothing wrong with doing it this way,
> and it is a bit more explicit, so I see the value in keeping it.
>
Please checkout the repo[1] with the "." removed for section names. I
didn't see the section start/end symbols generated automatically when
the makedumpfile.ld script is disabled. This is what I hit:

$ ./makedumpfile -d 31 -l
/var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore /tmp/out --extension
sample.so
Loaded extension: ./extensions/sample.so
register_ksym_section: Invalid section start/stop
init_extensions: fail & skip all extensions
$ ls
amdgpu_filter.c  amdgpu_filter.so  Makefile  Makefile.orig
maple_tree.c  maple_tree.h  sample.c  sample.so
$ nm sample.so |grep __start_init_ksyms
$ nm sample.so |grep __start_init_ktypes

However with makedumpfile.ld enabled, I can see:
$ nm sample.so |grep ksyms
0000000000004108 D __start_init_ksyms
0000000000004110 D __stop_init_ksyms
$ nm sample.so |grep ktypes
0000000000004110 D __start_init_ktypes
0000000000004128 D __stop_init_ktypes

Maybe I didn't code it correctly, or due to the version of gcc, I'm not sur=
e.

[1]: https://github.com/liutgnu/makedumpfile/commits/v5/

> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Sorry I didn't take your "Reviewed-by" signature in v5, because v5
contains plenty of code change since v4, and I'm not sure if you are
still OK with v5 or any improvement should be made. I will add your
signature in later upstream posts when the code is stable. Thanks
again for your patch review / suggestion and being a great support!

Thanks,
Tao Liu

>
> > ---
> >  Makefile        |  2 +-
> >  makedumpfile.ld | 15 +++++++++++++++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >  create mode 100644 makedumpfile.ld
> >
> > diff --git a/Makefile b/Makefile
> > index 05ab5f2..15a4ba0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -113,7 +113,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
> >       $(CC) $(CFLAGS_ARCH) -c -o ./$@ $(VPATH)$(@:.o=3D.c)
> >
> >  makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
> > -     $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $=
@ $< $(LIBS)
> > +     $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -Wl,=
-T,makedumpfile.ld -o $@ $< $(LIBS)
> >       @sed -e "s/@DATE@/$(DATE)/" \
> >            -e "s/@VERSION@/$(VERSION)/" \
> >            $(VPATH)makedumpfile.8.in > $(VPATH)makedumpfile.8
> > diff --git a/makedumpfile.ld b/makedumpfile.ld
> > new file mode 100644
> > index 0000000..231a162
> > --- /dev/null
> > +++ b/makedumpfile.ld
> > @@ -0,0 +1,15 @@
> > +SECTIONS
> > +{
> > +     .init_ksyms ALIGN(8) : {
> > +             __start_init_ksyms =3D .;
> > +             KEEP(*(.init_ksyms*))
> > +             __stop_init_ksyms =3D .;
> > +     }
> > +
> > +     .init_ktypes ALIGN(8) : {
> > +             __start_init_ktypes =3D .;
> > +             KEEP(*(.init_ktypes*))
> > +             __stop_init_ktypes =3D .;
> > +     }
> > +}
> > +INSERT AFTER .data;
> > \ No newline at end of file
> > --
> > 2.47.0
>


