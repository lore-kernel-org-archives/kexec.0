Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7C6ED7B9D
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AaE64E0QF3e6NMcPQmY/7P300QUEFvn6S/qoMgxtXkM=; b=VAWyXyqFffZpMLLV5omIp04oVF
	FKlDoFELdlxtcQVR6UTTTvPbQsyNSS/6GsAYSHcHMKPepOZ1+uZuZkCeXhtS0ph2qrfM3t8Fqc7Ef
	pTHHl74Q7sptMDuBnCIkrDOx2cKAu09cjrF3v9U3Rr/zkvFeWfbCc1ZNa0G3wdyePTeZZMIuACczS
	VFIKjBF0t2W3e5cqJD/sJ8hc+NVkYSXEAEmpf1Fz0td/Cqo9W3xr+9FesaAms57KbbiQyHztBf4Ns
	4/+m22ygU0W9rsrIL1La+FXCpSxxEv3mhgmHrIPriz7uDFzS/qteUfYdZo9BMp1m89BAYDbW/34Rn
	WWdpscjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCb9d-0000000HAMq-15FD;
	Tue, 14 Apr 2026 10:38:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCb9Z-0000000HAMR-3voi
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:37:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776163076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AaE64E0QF3e6NMcPQmY/7P300QUEFvn6S/qoMgxtXkM=;
	b=EdZH/yHoshLO6emdPaM/hYeFj9nHxX1wqK3h3M9nlYxjVCQwgfiBsb1X863Dv7XepfaW5J
	3zoxN2jF9NphSZe/EO4KnaYd5cJiThet2NIDizBIcpiNcY2LG542Ff6CV6JapZ6e/Ls4tD
	/TyTJ4WaqPf4Yzl3dBv+ZpJmWyyJcJU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-ju1gYCRJPSiolpSOOysDxg-1; Tue, 14 Apr 2026 06:37:55 -0400
X-MC-Unique: ju1gYCRJPSiolpSOOysDxg-1
X-Mimecast-MFC-AGG-ID: ju1gYCRJPSiolpSOOysDxg_1776163075
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4076dc16so132978081cf.2
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163075; x=1776767875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AaE64E0QF3e6NMcPQmY/7P300QUEFvn6S/qoMgxtXkM=;
        b=nbu2+SNUSOhWqeDGw15+WbhEcTd9WwDJjEvjyoFJnuZw7hEk5B+cas6fEU8Zh7dAaI
         yd6vZzSWTamdE593vnxNcehAJ8TkBOPANNRYn/Dr/wooksTmkQvFXiSI8+txMa2tQsMN
         76TkglmXe+fWk3CZvpDlMBWxeHu95dA+KQ8HDeyLl1CbrUJU3m1ZrhqqwSSP3U7vry5+
         WMbi9cNzPcuvIgPJ6Q5RCwA5XK3FKNwFcjvrONaU4CmyObRnYuuMTT/BzDJxTodZAqwN
         dGxoL/Wp3dOES3z25vTqpMZ8hV5rKOuFTqiboUJ0dbfqye5mFJBp6DTpz7Wr3TWwKJGC
         FwtA==
X-Forwarded-Encrypted: i=1; AFNElJ+fifmEWwXGgsUEJrZugLxHqtszNj+fihp1rElZcJaQf3F6uOTqBFfmRyINwZM1bM/G5Q+qAg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwIhJWL93/ASF9mKIWcpSj2lA2t8D/QeCLJaNO2GuBhWBu3EyX9
	mQrVbRJ3qV/h5I1uMEkw1650oGDrtBfuCFHFPWYnq8n8Rba//7ZgPkQDg/RPYJBrX+FitHdY23v
	KQxumLYpmv06CtBEzUWvLDujZlhyF3wuo6/ERHc0WHyYGah+6F3Aqgi2lV/nM4o75xewX2v7ff5
	5o8mXakaFchmS35lNZPxpIT9KlDUmgNTd3/M2E
X-Gm-Gg: AeBDietsi6ng03LcS6Ck3QrLw1rdu5fa4xtpLtXTqrAsQldcC4u8lwo/K6Dz6tWc2IN
	4zHvF34rMUW9yZHjUx1V6J/4qUl6PbqqZmOhcDcPe/KuHCHqCrWMK5/L0Ym3Q2v0OnORwHdsjJv
	wpApbZgE7L0dZXO6nqF/1l9HJDBB9iF0KaMuNnvNZA1HFBg8bc20ncZdwTTclSNfkIMlpNLKl/9
	y1F696pvelQXQ==
X-Received: by 2002:a05:622a:2b09:b0:50d:7c4b:5c5b with SMTP id d75a77b69052e-50dd5b9562fmr230123911cf.5.1776163075078;
        Tue, 14 Apr 2026 03:37:55 -0700 (PDT)
X-Received: by 2002:a05:622a:2b09:b0:50d:7c4b:5c5b with SMTP id
 d75a77b69052e-50dd5b9562fmr230123441cf.5.1776163074473; Tue, 14 Apr 2026
 03:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260317150743.69590-1-ltao@redhat.com> <fc189a38-856d-423a-af59-68b25eae638d@nec.com>
In-Reply-To: <fc189a38-856d-423a-af59-68b25eae638d@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 14 Apr 2026 22:37:18 +1200
X-Gm-Features: AQROBzCBOi7Ifcoue2jbkZCkc2SauhAZq084i8LfCGYvlHiY-U1U0LG6Rbp8lVY
Message-ID: <CAO7dBbXxO5uU6ERLLf=Ki2Czrt9Fita+Jm+MP2ZSRwvf9yYP1Q@mail.gmail.com>
Subject: Re: [PATCH v4][makedumpfile 0/7] btf/kallsyms based makedumpfile
 extension for mm page filtering
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kDPr5R5Q9lQtVU5mgA9TQ7MDzYsocW-TJdXLQitLylM_1776163075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_033758_169896_04F8C3EF 
X-CRM114-Status: GOOD (  51.79  )
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

Thanks a lot for your review, and sorry for the late reply.

On Fri, Apr 3, 2026 at 9:07=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=
=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>
> On 2026/03/18 0:07, Tao Liu wrote:
> > A) This patchset will introduce the following features to makedumpfile:
> >
> >    1) Add .so extension support to makedumpfile
> >    2) Enable btf and kallsyms for symbol type and address resolving.
> >
> > B) The purpose of the features are:
> >
> >    1) Currently makedumpfile filters mm pages based on page flags, beca=
use flags
> >       can help to determine one page's usage. But this page-flag-checki=
ng method
> >       lacks of flexibility in certain cases, e.g. if we want to filter =
those mm
> >       pages occupied by GPU during vmcore dumping due to:
> >
> >       a) GPU may be taking a large memory and contains sensitive data;
> >       b) GPU mm pages have no relations to kernel crash and useless for=
 vmcore
> >          analysis.
> >
> >       But there is no GPU mm page specific flags, and apparently we don=
't need
> >       to create one just for kdump use. A programmable filtering tool i=
s more
> >       suitable for such cases. In addition, different GPU vendors may u=
se
> >       different ways for mm pages allocating, programmable filtering is=
 better
> >       than hard coding these GPU specific logics into makedumpfile in t=
his case.
> >
> >    2) Currently makedumpfile already contains a programmable filtering =
tool, aka
> >       eppic script, which allows user to write customized code for data=
 erasing.
> >       However it has the following drawbacks:
> >
> >       a) cannot do mm page filtering.
> >       b) need to access to debuginfo of both kernel and modules, which =
is not
> >          applicable in the 2nd kernel.
> >       c) eppic library has memory leaks which are not all resolved [1].=
 This
> >          is not acceptable in 2nd kernel.
> >
> >       makedumpfile need to resolve the dwarf data from debuginfo, to ge=
t symbols
> >       types and addresses. In recent kernel there are dwarf alternative=
s such
> >       as btf/kallsyms which can be used for this purpose. And btf/kalls=
yms info
> >       are already packed within vmcore, so we can use it directly.
> >
> >    With these, this patchset introduces makedumpfile extensions, which =
is based
> >    on btf/kallsyms symbol resolving, and is programmable for mm page fi=
ltering.
> >    The following section shows its usage and performance, please note t=
he tests
> >    are performed in 1st kernel.
> >
> >    3) Compile and run makedumpfile extensions:
> >
> >    $ make LINKTYPE=3Ddynamic USELZO=3Don USESNAPPY=3Don USEZSTD=3Don
> >    $ make extensions
> >
> >    $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025=
-06-10-18\:03\:12/vmcore
> >      /tmp/extension.out --extension amdgpu_filter.so
> >      Loaded extension: ./extensions/amdgpu_filter.so
> >      makedumpfile Completed.
> >       User time (seconds): 5.08
> >       System time (seconds): 0.84
> >       Percent of CPU this job got: 99%
> >       Elapsed (wall clock) time (h:mm:ss or m:ss): 0:05.95
> >          Maximum resident set size (kbytes): 17360
> >          ...
> >
> >       To contrast with eppic script of v2 [2]:
> >
> >    $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025=
-06-10-18\:03\:12/vmcore
> >      /tmp/eppic.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
> >      makedumpfile Completed.
> >          User time (seconds): 8.23
> >          System time (seconds): 0.88
> >          Elapsed (wall clock) time (h:mm:ss or m:ss): 0:09.16
> >          Maximum resident set size (kbytes): 57128
> >          ...
> >
> >    -rw------- 1 root root 367475074 Jan 19 19:01 /tmp/extension.out
> >    -rw------- 1 root root 367475074 Jan 19 19:48 /tmp/eppic.out
> >    -rw------- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-2=
025-06-10-18:03:12/vmcore
> >
> > C) Discussion:
> >
> >    1) GPU types: Currently only tested with amdgpu's mm page filtering,=
 others
> >       are not tested.
> >    2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/p=
pc64.
> >       Others are not tested.
> >
> > D) Testing:
> >
> >       If you don't want to create your vmcore, you can find a vmcore wh=
ich I
> >       created with amdgpu mm pages unfiltered [3], the amdgpu mm pages =
are
> >       allocated by program [4]. You can use the vmcore in 1st kernel to=
 filter
> >       the amdgpu mm pages by the previous performance testing cmdline. =
To
> >       verify the pages are filtered in crash:
> >
> >       Unfiltered:
> >       crash> search -c "!QAZXSW@#EDC"
> >       ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXX
> >       ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXX
> >       crash> rd ffff96b7fa800000
> >       ffff96b7fa800000:  405753585a415121                    !QAZXSW@
> >       crash> rd ffff96b87c800000
> >       ffff96b87c800000:  405753585a415121                    !QAZXSW@
> >
> >       Filtered:
> >       crash> search -c "!QAZXSW@#EDC"
> >       crash> rd ffff96b7fa800000
> >       rd: page excluded: kernel virtual address: ffff96b7fa800000  type=
: "64-bit KVADDR"
> >       crash> rd ffff96b87c800000
> >       rd: page excluded: kernel virtual address: ffff96b87c800000  type=
: "64-bit KVADDR"
> >
> > [1]: https://github.com/lucchouina/eppic/pull/32
> > [2]: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.co=
m/
> > [3]: https://people.redhat.com/~ltao/core/vmcore
> > [4]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df
> >
> > v4 -> v3:
> >
> > 1) Get rid of all hash table usage. So only required syms/types info
> >     will be stored, rather than install all kernel's syms/types. To do =
this,
> >     special elf sections as .init_ksyms/ktypes are used for the require=
d info
> >     declaration/storage.
> >
> > 2) Support extension callback for makedumpfile, so during mm page
> >     filtering, extension can help to decide if keep/discard the page.
> >
> > 3) The patches are organized as follows:
> >
> >      --- <only for test purpose, don't merge> ---
> >      7. Filter amdgpu mm pages
> >
> >      --- <code should be merged> ---
> >      6. Add makedumpfile extensions support
> >      5. Implement kernel module's btf resolving
> >      4. Implement kernel module's kallsyms resolving
> >      3. Implement kernel btf resolving
> >      2. Implement kernel kallsyms resolving
> >      1. Reserve sections for makedumpfile and extenions
> >
> >      Patch 7 is customization specific, which can be maintained separat=
ely.
> >      Patch 1 ~ 6 are common code which should be integrate with makedum=
pfile.
>
> Hi Tao,
>
> thank you for the update, nice and interesting implementation :-)
>
> Here is my comments to the whole patchset:
>
> - I think we need a documentation about this function and it's better to
> have a simple example extension (that does not need to be updated) if
> possible.

Please check the v5 that I just posted upstream. I have updated the
doc, as well as a sample extension for code reference.

>
> - It could not be built on RHEL8 and it's ok if libbpf is too old, but
> which version of libbpf is required?  It should be written in a
> documentation.

Yes, updated the version info of libbpf in v5. In addition, I have
tested the rhel8 kernel won't not work for makedumpfile extension. It
is because the vmcoreinfo lacks kallsyms info, which kernel patch is
not backported to rhel8. A rhel-10+/rhel9.5+ or fedora 41+  can do.

>
> - Looking at this, e.g. "makedumpfile -d 1 --extension foo.so" does not
> run run_extension_callback(), is it intended?

It is a bug, fixed in v5, thanks for pointing it out.

>
>          /*
>           * Exclude cache pages, cache private pages, user data pages,
>           * and hwpoison pages.
>           */
>          if (info->dump_level & DL_EXCLUDE_CACHE ||
>              info->dump_level & DL_EXCLUDE_CACHE_PRI ||
>              info->dump_level & DL_EXCLUDE_USER_DATA ||
>              NUMBER(PG_hwpoison) !=3D NOT_FOUND_NUMBER ||
>              ((info->dump_level & DL_EXCLUDE_FREE) &&
> info->page_is_buddy)) {
>                  if (!exclude_unnecessary_pages(cycle)) {
>                          ERRMSG("Can't exclude unnecessary pages.\n");
>                          return FALSE;
>                  }
>          }
>
> - I'm concerned that readmem()s don't have check on return value, it's
> better to be able to determine which value is unable to be read.

All checked in v5.

>
> The other comments are in each patch.
>
> Thanks,
> Kazu
>
> >
> > Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@r=
edhat.com/
> > Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@re=
dhat.com/
> > Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@r=
edhat.com/
> >
> > Tao Liu (7):
> >    Reserve sections for makedumpfile and extenions
> >    Implement kernel kallsyms resolving
> >    Implement kernel btf resolving
> >    Implement kernel module's kallsyms resolving
> >    Implement kernel module's btf resolving
> >    Add makedumpfile extensions support
> >    Filter amdgpu mm pages
> >
> >   Makefile                   |  11 +-
> >   btf_info.c                 | 345 +++++++++++++++++++++++++++
> >   btf_info.h                 |  92 ++++++++
> >   extension.c                | 300 +++++++++++++++++++++++
> >   extension.h                |  12 +
> >   extensions/Makefile        |  12 +
> >   extensions/amdgpu_filter.c | 190 +++++++++++++++
> >   extensions/maple_tree.c    | 307 ++++++++++++++++++++++++
> >   extensions/maple_tree.h    |   6 +
> >   kallsyms.c                 | 473 ++++++++++++++++++++++++++++++++++++=
+
> >   kallsyms.h                 |  94 ++++++++
> >   makedumpfile.c             |  41 +++-
> >   makedumpfile.h             |  13 +
> >   makedumpfile.ld            |  15 ++
> >   14 files changed, 1903 insertions(+), 8 deletions(-)
> >   create mode 100644 btf_info.c
> >   create mode 100644 btf_info.h
> >   create mode 100644 extension.c
> >   create mode 100644 extension.h
> >   create mode 100644 extensions/Makefile
> >   create mode 100644 extensions/amdgpu_filter.c
> >   create mode 100644 extensions/maple_tree.c
> >   create mode 100644 extensions/maple_tree.h
> >   create mode 100644 kallsyms.c
> >   create mode 100644 kallsyms.h
> >   create mode 100644 makedumpfile.ld
> >


