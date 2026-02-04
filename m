Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A94E83EF4
	for <kexec@archiver.kernel.org>; Wed,  4 Feb 2026 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXVID8qFuewbvCRySmR5+vpVCM9JBfNCyWP0EBZmju8=; b=310/pgeMNkkee0a8XkPGMbky7O
	u65vq5kABNQ+GrOVZ38GJ6PbTIXb4F12R3N1pw9d0kVQ9DCytI+GsIa7FUDnsPYMxk5SmUqdk+3iD
	JwwcZn7vv3yewfANGu55CbFCBhTXKt36h37VLpdgcOoC7sXMXjvmCmaBoBauLqp/3CJP2zMfKq+Ql
	fa8iRNytcA1SN5EeQEUvljFne4VzuuKTrJ3b82vPJEF6lCBoo9DaTJKKpGshS2xUdQkwyPcdl4+QV
	uW+WvIYz0Bzz/jvvsr7VaBHpgpTwV4Cuc9KpJ36Oz29Vbv01ypLaNjWFIrJm9tUbEzCya8Xr797Qt
	4ppdsNag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnYb6-0000000892e-2edi;
	Wed, 04 Feb 2026 08:50:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnYb3-0000000892K-2WYH
	for kexec@lists.infradead.org;
	Wed, 04 Feb 2026 08:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770195048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXVID8qFuewbvCRySmR5+vpVCM9JBfNCyWP0EBZmju8=;
	b=EMfN4DYkE8gwpK0F1uvNlBnlNo/N5s3UJy62toiWqIfohsht5HUMK3f3xsWF3lodmBqiU6
	zXwUQB1yUDbM68Vc2BrWHhZdj9hGmrBj0v5nyEprEKYjRb6DSsBOyqg/VDzuPxtJfC/9jj
	F03H1zimSWizENIVTmISRFZJhE6uJ5A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-VdtA-ADVPGCh6Abbuf-AOA-1; Wed, 04 Feb 2026 03:50:47 -0500
X-MC-Unique: VdtA-ADVPGCh6Abbuf-AOA-1
X-Mimecast-MFC-AGG-ID: VdtA-ADVPGCh6Abbuf-AOA_1770195046
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5061d1ef1f3so20097061cf.0
        for <kexec@lists.infradead.org>; Wed, 04 Feb 2026 00:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770195046; x=1770799846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXVID8qFuewbvCRySmR5+vpVCM9JBfNCyWP0EBZmju8=;
        b=Av0ehBSQ5F6XetJzGtJMWpqdVnse4tsh7kCUvOiDgh5c3jhp5sy7Cv9sMh7/NygSXb
         1Ff4ldHrXjXgyUxPimMBUXHIfE0Zx4BLRD/FMx7gBy2EUL+WLJb8KoW2R2jpIAn7uj8W
         gw8saqpOUCGa4GGlf+FQ0opT1F4iTnjLJoRaeMc/GXfC0sc2Iwir2wlOTttCSXDX7eJJ
         M3k8v0xrA7TGLlhBjW/fdDmElG2TnCcQWQfNfoYzN26r7M8e087FgwrSjdJOYrcARzqu
         533a5lEMCWcT5VYYDT8y9hCKn79EAaOkU23ITh4e4boKcvDP14ry0MakPuO8TjHLZsD4
         qwOA==
X-Forwarded-Encrypted: i=1; AJvYcCWUrMzUYIUQks5cFA+vTXNipyq+53GghgMzbF6jlaCNsx5dhgG8xQRS2t+Vz5RfTzmOjc/LXw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxVmAUjaWLKqLBcqOxX6fYa4lNc5j7sZCUpJjDKA497cWnpKbZJ
	w13V985dLt7E1Ijx7rXk3VlwZyBKk32UkSwJJCQ9jpV9a33iV/bhEo0rOIhgLzAxFjDu+2Ly88T
	kMNFPi7DwhCaXG+zW06AkdZBKkbYwbidApIROBZZxaTKUwAzu52WFlIgZUs2hfkgLGyQBbiTdYI
	TeFn8ETNH3lQF122l5WS2/vMRe0A2GelnRIb6NbhSgPixagXk=
X-Gm-Gg: AZuq6aJRLGzilT/JAjZWGbFkZtU1HcBBUuIAl8mqZD5ulpeyMFUn5stbj6HXWq8mcZC
	VfntNl/kUbk+MbDvC7mDuAXBPYZMv/3qIcF9lOHZ9kc5sS2IxgyT+KB7Iw6HLMcNtJzd/y7GkuF
	iwemYaqmyip7T8nZ05JXJbQBrgLDZzdg23/Qx3EQrwwK9jPPrsm7tlM5EhO0PLHtwB1KI=
X-Received: by 2002:ac8:7f07:0:b0:503:36ba:1315 with SMTP id d75a77b69052e-5061c0dd470mr22571371cf.17.1770195046196;
        Wed, 04 Feb 2026 00:50:46 -0800 (PST)
X-Received: by 2002:ac8:7f07:0:b0:503:36ba:1315 with SMTP id
 d75a77b69052e-5061c0dd470mr22571261cf.17.1770195045833; Wed, 04 Feb 2026
 00:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20260120025500.25095-1-ltao@redhat.com> <d794c85a-d529-45b9-a8ab-0361546a6d98@nec.com>
In-Reply-To: <d794c85a-d529-45b9-a8ab-0361546a6d98@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 4 Feb 2026 21:50:09 +1300
X-Gm-Features: AZwV_QgxhasGqPKIDmWrKeLCquGpnj1FLpM8IMfVkY2UsXhcyyxrxVS8vY7pJqY
Message-ID: <CAO7dBbXiDBJug5B8N44BG_q7HeedbU_7CAtsgoTkPeNq2_5-+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] btf/kallsyms based makedumpfile extension for mm
 page filtering
To: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>, 
	"aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jIKeh2NJyGmXeT8nXzkyXyf9-uypFNEuYs_KN2qgCNY_1770195046
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_005049_733625_E5A51661 
X-CRM114-Status: GOOD (  47.14  )
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

Sorry for the late reply.

On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM YAMAZAKI MASAMITSU(=E5=B1=B1=E5=B4=
=8E=E3=80=80=E7=9C=9F=E5=85=89)
<yamazaki-msmt@nec.com> wrote:
>
> On 2026/01/20 11:54, Tao Liu wrote:
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
> >      /tmp/extension.out
> >      Loaded extension: ./extensions/amdgpu_filter.so
> >      makedumpfile Completed.
> >          User time (seconds): 6.37
> >          System time (seconds): 0.70
> >          Elapsed (wall clock) time (h:mm:ss or m:ss): 0:07.10
> >          Maximum resident set size (kbytes): 38024
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
> > v3 -> v2:
> >
> > 1) Removed btf/kallsyms support for eppic script, and introduced
> >     makedumpfile .so extension instead. The reason of removing eppic
> >     support is:
> >     a) Native binary code as .so has better performance than scripting,
> >        see the time consumption contrast above.
> >     b) Eppic library has memory leaks which hasn't been fixed totally,
> >        memeory leaks in 2nd kernel might be fatal.
> >
> > 2) Removed the code of manually parsing btf info, and used libbpf for
> >     btf info parsing instead. The reason of removing manually parsing i=
s:
> >     a) Less code modification to makedumpfile, easier to maintain.
> >     b) The performance of using libbpf is as good as manual parsing +
> >        hash table indexing, as well as less memory consumption, see tim=
e
> >        and memory consumption contrast above.
> >
> > 3) The patches are organized as follows:
> >
> >      --- <only for test purpose, don't merge> ---
> >      8.Filter amdgpu mm pages
> >      7.Add maple tree support to makedumpfile extension
> >
> >      --- <code should be merged> ---
> >      6.Add page filtering function
> >      5.Add makedumpfile extension support
> >      4.Implement kernel modules' btf resolving
> >      3.Implement kernel modules' kallsyms resolving
> >      2.Implement kernel btf resolving
> >      1.Implement kernel kallsyms resolving
> >
> >      Patch 7 & 8 are customization specific, which can be maintained se=
parately.
> >      Patch 1 ~ 6 are common code which should be integrate with makedum=
pfile.
> >
> > Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@re=
dhat.com/
> > Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@r=
edhat.com/
> >
> > Tao Liu (8):
> >    Implement kernel kallsyms resolving
> >    Implement kernel btf resolving
> >    Implement kernel modules' kallsyms resolving
> >    Implement kernel modules' btf resolving
> >    Add makedumpfile extension support
> >    Add page filtering function
> >    Add maple tree support to makedumpfile extension
> >    Filter amdgpu mm pages
> >
> >   Makefile                   |   9 +-
> >   btf_info.c                 | 260 +++++++++++++++++++++++++
> >   btf_info.h                 |  66 +++++++
> >   erase_info.c               |  98 ++++++++++
> >   erase_info.h               |  12 ++
> >   extension.c                |  82 ++++++++
> >   extensions/Makefile        |  10 +
> >   extensions/amdgpu_filter.c |  90 +++++++++
> >   extensions/maple_tree.c    | 336 +++++++++++++++++++++++++++++++++
> >   extensions/maple_tree.h    |   6 +
> >   kallsyms.c                 | 376 ++++++++++++++++++++++++++++++++++++=
+
> >   kallsyms.h                 |  20 ++
> >   makedumpfile.c             |  35 +++-
> >   makedumpfile.h             |  11 ++
> >   14 files changed, 1405 insertions(+), 6 deletions(-)
> >   create mode 100644 btf_info.c
> >   create mode 100644 btf_info.h
> >   create mode 100644 extension.c
> >   create mode 100644 extensions/Makefile
> >   create mode 100644 extensions/amdgpu_filter.c
> >   create mode 100644 extensions/maple_tree.c
> >   create mode 100644 extensions/maple_tree.h
> >   create mode 100644 kallsyms.c
> >   create mode 100644 kallsyms.h
>
> Thank you for your the v3 patch. And thanks for the appropriate
> improvements.
>
> I believe the results will be significantly improved by stopping use
> of eppic and using libbpf instead.
>
> My concerns are as follows:
>
> * Performance has improved compared to the version using eppic,
> but I would like to see a comparison of performance without these patches
> applied.

Sure, I will attach the performance comparison for v4. Currently I'm
cooperating with Stephen on a drafted v4. Once we are OK with it, I
will post the final v4 to upstream later.

>
> * This mechanism is enabled when .so (shared libraries) are present,
> but I think it would be better to have an option to turn this feature
> on or off. If you don't use shared libraries, you have to delete or move
> them,
>   which can be inconvenient.

I guess your meaning is, when no .so extensions are needed, then
btf/kallsyms code won't get executed. Currently I'm introducing a
"--extension" option to makedumpfile. Only when specified, the
btf/kallsyms of makedumpfile will be initialized.

>
> I'm looking forward to v4, which will improve things like calculation Ord=
er.

Sure, no problem. Thanks again for your suggestions!

Thanks,
Tao Liu
>
> Masa


