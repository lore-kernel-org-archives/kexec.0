Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F3DCA0FED
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 06:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cenFOI/SXOBj6EQa97hlTVk/LcnpQcEaDWbcJHQYPqg=; b=nAn397LIPR9c7g5skE/e/84GLw
	JMyoQkqSs6KZoRXegCY/i4TBODnIzEQ9x+IXGfWBhUf3x12GtKQWJ5YAl9ev3QsaK+JtcADlWkjCy
	tadWgMnZibxLARtgpvT8ZFeZikDmHuldi5uzESW+moQIVRL/u3lT2m01nPyVbsAulSsq7hJiS1vBZ
	e58AqAaFujE+lULhbbDz6vzGYvNSQ84FnSgw1vywLUjsMQdcJ7ASQ4eKHXtZjrO/NV9pIVjQJBOiw
	UsyXOHeBrrZ6AfqONnm+OC3inlUc20g/72cwmzJnWJnR9jkVBEP1HTw+VUpt/0/VEUgMPrDyANJqm
	bvFQL+Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvsJI-00000004yjd-2Tk8;
	Tue, 09 Sep 2025 06:58:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvqqU-00000004PjM-2BWr
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 05:24:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757395484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cenFOI/SXOBj6EQa97hlTVk/LcnpQcEaDWbcJHQYPqg=;
	b=bfyzxq4K06PgBBt6rfgidljF2QbZ01hXs3rddoMJSgeBx6KVSmO6AnxEJ9iLNuOdTNkG1F
	3zEjd1ojMXS5NAUfPkDvG98GfKLKlwm6+os3h6sk6GkFgTqvFZFNYyYxStZhKrd9ZNfUGF
	uMV70HbaPOPR4SJ0q/r644tMfAvyH14=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-mY23YzQRPD29qqUuYWanLA-1; Tue, 09 Sep 2025 01:24:43 -0400
X-MC-Unique: mY23YzQRPD29qqUuYWanLA-1
X-Mimecast-MFC-AGG-ID: mY23YzQRPD29qqUuYWanLA_1757395482
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f75c17a3so84663251cf.3
        for <kexec@lists.infradead.org>; Mon, 08 Sep 2025 22:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757395482; x=1758000282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cenFOI/SXOBj6EQa97hlTVk/LcnpQcEaDWbcJHQYPqg=;
        b=jdxB4eg07g6/xD7zRbMjIh6lkWXqcMqv/wr+UxH/hxhL1ZVIHwl5SxT5kbLRD2PFSv
         d853Aklf3Qhu0fcPWn/w5/Ym+twwBba1uLFnqAGs2sMBx1S1vT+MuHzFuDCvcTltBHYj
         Kezqff+6vrnuNKT/eBHa0To9aSHDwSoE6zm+BBW/6xedFR7E0yNo4ma63FnjhSczRovJ
         mzuccJrUkLkP3O1B8Ombz9iR/DKGjhpSBUyPCHC+M1Z0m2Exin1yan/DjTwelxTf63WF
         yx7q1Eoy7/Ulxqc6Mo3TQ/wCHgjE3A+CPmJZoz1FtSHSDrO2BqG3qzRrOTyEhl1CpWFo
         w0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTcF+aAZodFNq2gRXi53hytVdX7KFRaRc76Kz47LyXaSJ7wh75vuaQntKUR+fmo5PBB3PW3w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxh5aw6dlpUjaTN2vq/g/oKVmzugW9ACyiYv8qkxMUvi4XLDVol
	VwqPBQV78JIZSZXVr8NiatONIr9AfjVIYMMdD3By1WPKUdnkySGjjPPuIzICz++EjnUel1uGMQP
	t2Yj8eVtVVhCJq8ovcj0cdb8fFVt3bq5kpByIt2AJxU6JAIDk2p0iIvW4hoiA3jfFgN2FM6+rv8
	hOeD5rNiDOVaOJJaMouQDRDgrlwPvg0amNrtot
X-Gm-Gg: ASbGncsyecCIV912BkiKu7QnEdkaUCrgqx7NSS3YmaGT2Wa102a7M0WEIb8Fxfqi68J
	XSLXZ+T/PuEJ8g2slTWXHSqmbH3S7q+RLXvis/fQTzxctqAQY5h/+kCSfqCStHLHmK1892E2Oea
	xcfFNT8hWawI8KOBl+hySY
X-Received: by 2002:a05:622a:409:b0:4b4:9666:f1d0 with SMTP id d75a77b69052e-4b5f8445a7emr108821071cf.49.1757395482354;
        Mon, 08 Sep 2025 22:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUfoSjqVU3K+sCFAr26uKvX5ValqEM3JMPDQjfavGf7c6Q9I4mYsYuahvuaTnw27jMjkEnncXEqyYEOuJ9EjI=
X-Received: by 2002:a05:622a:409:b0:4b4:9666:f1d0 with SMTP id
 d75a77b69052e-4b5f8445a7emr108820961cf.49.1757395481923; Mon, 08 Sep 2025
 22:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250610095743.18073-1-ltao@redhat.com> <20250610095743.18073-2-ltao@redhat.com>
 <16a049cc-11c1-4e46-84a3-5ff5f0f00c00@nec.com>
In-Reply-To: <16a049cc-11c1-4e46-84a3-5ff5f0f00c00@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 9 Sep 2025 17:24:05 +1200
X-Gm-Features: Ac12FXz7dBaCGtyGAYs4fuMRLY7s-x-crWCotUXwZrOoC8mlCu8vWU84d4NJzDE
Message-ID: <CAO7dBbVC1YBVp2YE1xyrs4wBt9k0-TFx7V-ZwyBXQ9sssG1cfw@mail.gmail.com>
Subject: Re: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel
 address randomization
To: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>, 
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TxSnwP9dGatanrvBuaWhrPbg8Q0H6uX4E4SJE7NPMd0_1757395482
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_222446_983447_97928F39 
X-CRM114-Status: GOOD (  29.11  )
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

On Mon, Sep 8, 2025 at 11:11=E2=80=AFPM YAMAZAKI MASAMITSU(=E5=B1=B1=E5=B4=
=8E=E3=80=80=E7=9C=9F=E5=85=89)
<yamazaki-msmt@nec.com> wrote:
>
> Hi,Liu
>
> Thanks your patch. What kind of environment did you test
> this KASLR problem ? Especialy is it kernel verssion
> 6.11.8-300.fc41.x86_64 ? Have you checked other versions?
> Additionally, do you know the version of eppic ?

I had primarily tested the patchset within 6.11.8-300.fc41.x86_64,
since it has been a while, and I have updated my kernel to 6.16.3. The
dwarf issue(PATCH 01/10 & PATCH 02/10) can still be reproduced there,
see the following:

1) Env:
$ uname -a
Linux localhost.localdomain 6.16.3 #3 SMP PREEMPT_DYNAMIC Thu Aug 28
15:12:38 2025 x86_64 GNU/Linux

liutgnu@localhost:~/sources/up-makedumpfile$ git log --oneline | head -2
65bf4c9 [PATCH v2] Fix a data race in multi-threading mode (--num-threads=
=3DN)

liutgnu@localhost:~/sources/up-eppic$ git branch
* master
  v5.0
liutgnu@localhost:~/sources/up-eppic$ git log --oneline | head -2
72da440 Merge pull request #20 from yselkowitz/master
5ecafb7 Fix build with glibc-2.42

liutgnu@localhost:~/sources/up-makedumpfile$ cat eppic_scripts/test.c
string test_opt() {...}
string test_usage() {...}
static void test_showusage() {...}
string test_help() {...}
int test()
{
printf("linux banner: %lx\n", (unsigned long)&linux_banner);
return 0;
}

2) The recursive issue as fixed in PATCH 02/10:

$ ./makedumpfile -d 31 -l vmcore /tmp/out -x vmlinux --eppic
eppic_scripts/test.c --dry-run
Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7c3ca4b in pthread_rwlock_unlock@GLIBC_2.2.5 () from
target:/lib64/libc.so.6
(gdb) bt
...
#5  0x0000000000409a67 in search_domain (die=3D0x7fffff7ff220,
found=3D0x7fffffffcf24) at dwarf_info.c:904
#6  0x0000000000409978 in search_domain (die=3D0x7fffff7ff290,
found=3D0x7fffffffcf24) at dwarf_info.c:865
#7  0x0000000000409978 in search_domain (die=3D0x7fffff7ff300,
found=3D0x7fffffffcf24) at dwarf_info.c:865
...
#74820 0x0000000000409978 in search_domain (die=3D0x7fffffffcdb0,
found=3D0x7fffffffcf24) at dwarf_info.c:865
#74821 0x0000000000409978 in search_domain (die=3D0x7fffffffce60,
found=3D0x7fffffffcf24) at dwarf_info.c:865
#74822 0x0000000000409bfc in search_die_tree (die=3D0x7fffffffce60,
found=3D0x7fffffffcf24) at dwarf_info.c:953
#74823 0x0000000000409b2c in search_die_tree (die=3D0x7fffffffce90,
found=3D0x7fffffffcf24) at dwarf_info.c:935
#74824 0x0000000000409ec7 in get_debug_info () at dwarf_info.c:1010
#74825 0x000000000040af2a in get_domain (symname=3D0x90aeb0 "memset",
cmd=3D13, die=3D0x7fffffffd020) at dwarf_info.c:1381
#74826 0x00000000004143d0 in get_domain_all (symname=3D0x90aeb0
"memset", cmd=3D13, die=3D0x7fffffffd020) at erase_info.c:1965
#74827 0x00007ffff76c0fc1 in apigetctype (ctype=3D7, name=3D0x90aeb0
"memset", tout=3D0x48be80) at extension_eppic.c:280
#74828 0x00007ffff76cab1b in eppic_getctype (ctype=3D7, name=3D0x90aeb0
"memset", silent=3D1) at eppic_api.c:454
#74829 0x00007ffff76d56c0 in eppiclex () at lex.eppic.c:1831
#74830 0x00007ffff76d2ae5 in eppicparse () at eppic.tab.c:1804
#74831 0x00007ffff76c1f4d in eppic_parsexpr (expr=3D0x7ffff7707364 "int
memset(char *, int, int)") at eppic_func.c:437
#74832 0x00007ffff76c740e in eppic_builtin (proto=3D0x7ffff7707364 "int
memset(char *, int, int)", fp=3D0x7ffff76c1349 <eppic_memset>)
    at eppic_builtin.c:252
#74833 0x00007ffff76c1420 in eppic_init (fun_ptr=3D0x473600 <eppic_cb>)
at extension_eppic.c:461
#74834 0x0000000000414f83 in process_eppic_file
(name_config=3D0x7fffffffe0b7 "eppic_scripts/test.c") at
erase_info.c:2226
#74835 0x0000000000415513 in gather_filter_info () at erase_info.c:2357
#74836 0x000000000044f237 in create_dumpfile () at makedumpfile.c:10885
#74837 0x000000000045569a in main (argc=3D11, argv=3D0x7fffffffdc08) at
makedumpfile.c:12478
(gdb) frame 74821
#74821 0x0000000000409978 in search_domain (die=3D0x7fffffffce60,
found=3D0x7fffffffcf24) at dwarf_info.c:865
865 search_domain(&child, found);
(gdb) p name
$1 =3D 0x7ffff1bdb782 "&core::num::fmt::Part"
...
(gdb) frame 6
#6  0x0000000000409978 in search_domain (die=3D0x7fffff7ff290,
found=3D0x7fffffffcf24) at dwarf_info.c:865
865 search_domain(&child, found);
(gdb) p name
$8 =3D 0x7ffff1bdbe1f "and_then<char, (),
core::net::parser::{impl#0}::read_given_char::{closure#0}::{closure_env#0}>=
"

So the stack overflows, and is caused by rust symbols. I have no idea
why rust symbols will cause this, so in PATCH 02/10, I skipped all
rust symbols for now. With the patch applied, no segfaults.

3) The kaslr issue as fixed in PATCH 01/10:

$ ./makedumpfile -d 31 -l vmcore /tmp/out -x vmlinux --eppic
eppic_scripts/test.c --dry-run
__vtop4_x86_64: Can't get a valid pmd_pte.
readmem: Can't convert a virtual address(ffffffff828445f0) to physical addr=
ess.
readmem: type_addr: 0, addr:ffffffff828445f0, size:1
linux banner: ffffffff828445f0

crash> sym linux_banner
ffffffff938445f0 (D) linux_banner

liutgnu@localhost:/lib/modules/6.16.3/build$ cat System.map |grep linux_ban=
ner
ffffffff828445f0 D linux_banner

So the value outputted by eppic script is not kaslred. With the patch
applied, the eppic can output the correct value as crash's:

$ ./makedumpfile -d 31 -l vmcore /tmp/out -x vmlinux --eppic
eppic_scripts/test.c --dry-run
linux banner: ffffffff938445f0

Hope the debug process can help for PATCH 01/10 & PATCH 02/10

Thanks,
Tao Liu

>
> Also, if possible, show this problem results when an error occurs
> and the results when it is correct. Please tell me.
>
> Sincerely
>
> On 2025/06/10 18:57, Tao Liu wrote:
> > There is a bug of not supporting randomized kernel address, this patch =
fix it.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
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


