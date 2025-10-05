Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEEBCAC5BB
	for <kexec@archiver.kernel.org>; Sun,  5 Oct 2025 23:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1sWGDXdMbugCpVOcY97EEpJwL5EuPZmTaXRTy5Y/MZ0=; b=0f8LWxr6UF142pdy/g2t/Zu7Ji
	QStMhsxxQ5Yewbd+VjPmcLaUNTq0hv9ZBGlM+BWf1C+wGNg7YU6EL3LAEqVjbucQ0/VV9oW94I/mK
	8XCDUGHbNzMq+11u8dwdtC7sZP7NVOpHHywgPPK1VExf8+jP1oeRX3coShIk5Px4uI6ndRbsuOdwt
	L9I9LD5fsSKcTT7EqavOXA1hrRLT+7GdoSXFuDVbVoiZUl4I3yTK6M6svyfWmYD81zLAZaYR/wd0V
	iKpQCvrcrr66AJNLzUUmInBcrRiHZm5jPUNG8iKz6zsosgpwfvEAUouMz08fPjMgqPGQWpaXEU4Zs
	kq/thgsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5Y7n-0000000GjEq-2Ksm;
	Sun, 05 Oct 2025 23:26:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5Y7j-0000000GjEV-1RDw
	for kexec@lists.infradead.org;
	Sun, 05 Oct 2025 23:26:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759706796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sWGDXdMbugCpVOcY97EEpJwL5EuPZmTaXRTy5Y/MZ0=;
	b=dHeCmhNWsx7OzoRFXEvE44Z0O0Fnzzl6lFGiP+sy8sYiYuEEZ9CLEAkG3QISSPcjX+fiVV
	Es4WKsTQqV5rqRlyUxK/8M9ftHU/7keDXbxspdxJ7STu84BV4Jpd3M2hqMzk2grOrIjy2C
	kZzpJDUKdaP07r7VxUeIWml4qM4yeio=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-ZkwnaSNPNrSihDNkoNxa8g-1; Sun, 05 Oct 2025 19:26:34 -0400
X-MC-Unique: ZkwnaSNPNrSihDNkoNxa8g-1
X-Mimecast-MFC-AGG-ID: ZkwnaSNPNrSihDNkoNxa8g_1759706794
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-84a3a7ac082so1007987785a.2
        for <kexec@lists.infradead.org>; Sun, 05 Oct 2025 16:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759706794; x=1760311594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sWGDXdMbugCpVOcY97EEpJwL5EuPZmTaXRTy5Y/MZ0=;
        b=jfh8U62nARmFNC5H63pAFZqoBsrZE7wVyxhGQkriT8sotLChemlOc5XbgLymcZwkd4
         lB3lg96+8OyUmI9ArY6b+jAPeOuuHJ0iU1Dks2tqSBGe3R1M/qQgla7N3dc6yqwa1xIq
         ivO9uXlv93sj4wDSyP5UGeUy2VIJTTg5p7NeoFR4nSX4pyuB3z40r0plyUSsSssJn5+T
         6CjL5cJG8ybFnCBkmhUy7+Rd1CU8NQZNMWc2/2MyM+9syOkxOe2w5T6cFrittuLVwIQ9
         tsQureXlteE7zuJwA/3KlJaTscY1j7bH7tKpskbhjBdrMteJ7AEd1Wqyh/k7rxCC2KOb
         MVpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkahA+RCJql0iovf9E7SbRHH0wOWmxr5g3rq1Qr93s6+8MFiUE3avEqV7ss8YLdC2EQ2W66Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxIJyjpgRwqxgHXmC13wpNuizWFjcDYoPxqe050uYwC3AleJr7T
	WzFFj1S8mrip0B+PcZAXNLVe51e7+fED2A6DS3MjVgrh4rVQT9lv2Ys/N9mW1GAkNQM1la/B12o
	yFbDAkQgGTl2qjJnVgKqHmZ4XzaJZp05yW+Ohf+6qXTSFEIL0WsFsiWOQj1E8r2bbGSSXn65Ydz
	uC21JVFIUHC5gHTNcRfB0C6RKLPsnDLwWpLABW
X-Gm-Gg: ASbGncvylh4b6oHBBPFdTYq6sVgUFs8gXNwtN3sJf97Rtan4I8gB14HQE4UwfzXf0Kn
	H1fuHJKwvozDTKKH04eJgpXVNFqhkacScKVRFkmVgA6GazZBBkL9MGUAm0IKWconQ0mSGMmaZlC
	8VU9SEASF3/tdYEVOgje0tzxWdBag=
X-Received: by 2002:a05:620a:198d:b0:861:9992:26ab with SMTP id af79cd13be357-87a3b98592dmr1145904085a.82.1759706794017;
        Sun, 05 Oct 2025 16:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzM7F2ffMKEy1nf09oEF49LLLu0aXeC3HVzr0z+jPnGji3FVWmLMsnvUpOQfLZmCmI1aIsoIwvSjO7FKWtuQc=
X-Received: by 2002:a05:620a:198d:b0:861:9992:26ab with SMTP id
 af79cd13be357-87a3b98592dmr1145903285a.82.1759706793566; Sun, 05 Oct 2025
 16:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250610095743.18073-1-ltao@redhat.com> <20250610095743.18073-3-ltao@redhat.com>
 <ec719745-caa8-4b97-945e-6409234a217d@nec.com>
In-Reply-To: <ec719745-caa8-4b97-945e-6409234a217d@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 6 Oct 2025 12:25:57 +1300
X-Gm-Features: AS18NWABX8zEdHKVODkH0h2qO6ij-g6Qb7Afd1JnKjzr70PMH7IIJPn7tp2a4EY
Message-ID: <CAO7dBbXvWxJrhSG+cKxroLub3saP=yqfp=FQnVOO_C8bKsO04A@mail.gmail.com>
Subject: Re: [PATCH RFC][makedumpfile 02/10] dwarf_info: Fix a infinite
 recursion bug for search_domain
To: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>, 
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ku6PGuAl1FuN6OUFhOualDtXEQmW4FCLHXIMBi4u2zs_1759706794
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251005_162639_797769_73770FB2 
X-CRM114-Status: GOOD (  25.12  )
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

Hi YAMAZAKI,

On Fri, Oct 3, 2025 at 8:23=E2=80=AFPM YAMAZAKI MASAMITSU(=E5=B1=B1=E5=B4=
=8E=E3=80=80=E7=9C=9F=E5=85=89)
<yamazaki-msmt@nec.com> wrote:
>
> On 2025/06/10 18:57, Tao Liu wrote:
> > There is an infinite recursion bug noticed in rust symbols. The root ca=
use is
> > unclear to me. This patch will avoid the bug by skip the recursion of r=
ust
> > symbols, since currently we don't need to deal with those.
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
>
> Hi Liu
>
> This problem need to be solve. But I don't know how to reproduce.
> If Your server is running rust program. Or Or is it running as a
> module by rust? Please tell me how to reproduce it.

Sure
E.g. using the following eppic program: /tmp/test.c:
string test_opt(){return "";}
string test_usage(){return "";}
static void test_showusage(){printf("");}
string test_help(){return "";}

int test()
{
struct task_struct *p;
unsigned long offset;

p =3D (struct task_struct *)&init_task;
offset =3D (unsigned long)&(p->tasks) - (unsigned long)p;

do {
printf("%d\n", (int)(p->pid));
p =3D (struct task_struct *)((unsigned long)(p->tasks.next) - (unsigned lon=
g)p);
} while (p !=3D &init_task);
return 1;
}

$ ./makedumpfile --dry-run -d 31 -l
/var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore /tmp/out -x
/lib/debug/lib/modules/6.11.8-300.fc41.x86_64/vmlinux --eppic
/tmp/test.c
Segmentation fault (core dumped)

With the patch, no segfault.

The vmcore/vmlinux should contain rust symbols: CONFIG_RUST=3Dy, you can
use the following vmcore https://people.redhat.com/~ltao/core/vmcore +
https://kojipkgs.fedoraproject.org//packages/kernel/6.11.8/300.fc41/x86_64/=
kernel-debuginfo-6.11.8-300.fc41.x86_64.rpm
for vmlinux and vmcore to test.

Thanks,
Tao Liu

>
> Thanks,
> Masa
>


