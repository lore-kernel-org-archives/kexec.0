Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE1DED7BBA
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqAmibWz9T2V8Sh69mik3yU47FnfM4uy3aS8tRv5p0g=; b=qkUUrvRhXZjN2EO+rzP8m0+ws4
	L1zNEFfLK+oAqjXojqEdVx+LPGgxnaRTtI6wC2RkDAUOtGhaI4qy/wu29M5/A5pZ5jkhdcgQcVj4x
	SiLShT7LfqPxLw4rFG5r0QTUKQwk/CiaaX9eyTvJcg9bgA6bSB/wphbuVlpQ7BCkh+xgP6hHocsOY
	GehMrgrl/CvuzkmBdlxilUnesVAhOFZgQoz4bg/etz0mBiBaxpk+7FQN2UwtDldRbTMUkePoMPVdp
	gH39BJDTIWtKnU/AyRDKG6cmmZdVIOPZfJ20OpyscebF4PKewNDNrxQ06JBiRONaumZT+LsuKViEW
	OLfODIEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbJn-0000000HB67-3ANO;
	Tue, 14 Apr 2026 10:48:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbJl-0000000HB5J-0XV6
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:48:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776163708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqAmibWz9T2V8Sh69mik3yU47FnfM4uy3aS8tRv5p0g=;
	b=F2jtbTKuyw5My0tgDL/RkAYgU214SRg9axZoe46iFsohV1yuAj8prtxtjJNjhS2d3uojQC
	ZFw/j/nfoenr7w9ZHiggU0tSK9HYIomhjZKcftPIxXpM6gWPEnTAiTNVO21MM8+ROu75AN
	t6QhjwznHC72JKh210wbUvvLUHp3cRc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-cdsCKKM8M7WpfRaWQczBjw-1; Tue, 14 Apr 2026 06:48:24 -0400
X-MC-Unique: cdsCKKM8M7WpfRaWQczBjw-1
X-Mimecast-MFC-AGG-ID: cdsCKKM8M7WpfRaWQczBjw_1776163704
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b44f7b7bbso129592271cf.3
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163704; x=1776768504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqAmibWz9T2V8Sh69mik3yU47FnfM4uy3aS8tRv5p0g=;
        b=p7T5bBPVUU+cBOBeqv+Uwhkfn5/8TO0VPM3VGGjqJ18Rx6NO+4Uo+33iurMBsv6Cod
         x+uxPasMi1CE2HV5EY9XJFB3/Ox2Hg1gdK4LvYpYqZxw+hPawdmR9E7jbO1crpeOffDx
         wWDEL6TNMuFhWzphMVHuRACLLoQtkhQ5z06DP2Vy7KX9+tgqsRwDrwCscFXRtqu2c+DP
         UwYEzslE2nVYDOCg+B8+53JKkSiInoTT/1mBXNgtWgAjPpGxa+14NlLnSCxTsBjr/nxz
         RE1UWCA28OjJcjxpEnXoUSCtmcb/teyi2ysM3gftas1GLV+sZvYIg8N9tJvDqwYTu9uP
         D+Jg==
X-Forwarded-Encrypted: i=1; AFNElJ/HRQ0GzvlZbabkOZCEtjJlwjqDjeox6A4R/oEQRl9DYHRAIUhoFjZtJ6dFooE2KfRV6PViFg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwGL7q+zU/2Ka0/9UuVqtiewdhZ6QKXB4b9ZzQsa2yFXUYNqldd
	y06PQtUY7VxxFx27tUi2/1m/EZJVL0iLadLKavIaQIfA/SOpB+bpt+vlY5jpTX8oVLJpxWaB9C6
	5T71qIp+V2ULAKgRbkuUX6kbuhXr/akG+61RDt+LkjQKXTYYwjkriniM0TG20lVtp2/90vmOU9l
	R/jk2O8YJL/s8uM5mjEoEW3VnOpRCsLT3xxC0/aCoaRWVuoFI=
X-Gm-Gg: AeBDieuZGciwywgQdrS/lJdOefPGd+Xi1NJjMYonGm98Z7yctcr4aMeILN0Odsbq6q9
	nIZ4dcQ4DkJh/2mOwa1lBOhvZvsPsB11Oahw/y45UIKzZudqbo3FlpvlUt5lA6grV8I4HW9OI1Z
	RsDJqrtvNjYsVsDv24sOqsQm7PN2AidiJhe4yg1JRLQQXhJsKlSKCpqD1VYvGA1GthSjsLWRfU4
	vpVWoMNfur1wA==
X-Received: by 2002:ac8:7c41:0:b0:50d:6b6d:bc17 with SMTP id d75a77b69052e-50dd5af0abdmr236249231cf.23.1776163703623;
        Tue, 14 Apr 2026 03:48:23 -0700 (PDT)
X-Received: by 2002:ac8:7c41:0:b0:50d:6b6d:bc17 with SMTP id
 d75a77b69052e-50dd5af0abdmr236248831cf.23.1776163702997; Tue, 14 Apr 2026
 03:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260317150743.69590-1-ltao@redhat.com> <87ldf3ew7g.fsf@oracle.com>
In-Reply-To: <87ldf3ew7g.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 14 Apr 2026 22:47:46 +1200
X-Gm-Features: AQROBzA4LJOaupiAwRzyz4l4d5agmoC3j0QofGNbbUYaFuuG01nOLtXhuQTFm_E
Message-ID: <CAO7dBbUhOVZh_Vm3LCY9uMG+wXK3P+u7Po+wrJoHn3iH9FBVXA@mail.gmail.com>
Subject: Re: [PATCH v4][makedumpfile 0/7] btf/kallsyms based makedumpfile
 extension for mm page filtering
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z8kJh-cO2di6qg1cSxe2yigZRZiZASaJo4XX1N9LM1k_1776163704
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_034829_317650_27916808 
X-CRM114-Status: GOOD (  43.28  )
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

Thanks a lot for your feedback, sorry again for not reply in time.

On Sat, Apr 4, 2026 at 7:27=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hello,
>
> My testing of the patch series involves my own extension, userstack.so,
> which I've implemented here[1] on top of this branch:
>
> [1]: https://github.com/brenns10/makedumpfile/commits/stepbren_userstack_=
upstream_v4/
>
> To test, I have a vmcore created at dump-level 23, and I'm using
> makedumpfile to re-filter the vmcore at dump-level 31, either including
> the userspace stacks, or not using an extension at all:
>
> $ /usr/bin/time ./makedumpfile -z -d31 --extension userstack.so ./dump.wi=
thuser.img ./extension.img
> ...
> 9.66user 0.86system 0:10.56elapsed 99%CPU (0avgtext+0avgdata 15108maxresi=
dent)k
> 0inputs+1133800outputs (0major+2184minor)pagefaults 0swaps
>
> $ /usr/bin/time ./makedumpfile -z -d31 ./dump.withuser.img ./baseline.img
> ...
> 9.28user 0.84system 0:10.17elapsed 99%CPU (0avgtext+0avgdata 3336maxresid=
ent)k
> 0inputs+1132120outputs (0major+236minor)pagefaults 0swaps
>
> $ ls -l *.img
> -rw------- 1 stepbren stepbren  577384093 Apr  3 10:55 baseline.img
> -rw------- 1 stepbren stepbren 1746475073 Apr  2 15:21 dump.withuser.img
> -rw------- 1 stepbren stepbren  578253346 Apr  3 10:54 extension.img
>
>
> With drgn's contrib/pstack.py, we can dump a stack trace for an example
> process in the vmcore. I'll show it here three times: first with the
> original vmcore containing all userspace pages: it works, but the vmcore
> is 1.7 GiB, more than 3x larger than a dump-level 31 vmcore. Second with
> the baseline, which is at dump-level 31: the userspace stack cannot be
> retrieved. Third, with the userstack.so extension: despite being less
> than 1 MiB larger than the prior core, it contains the necessary stack
> pages and thus the stack trace is the same as the original.
>
>
> $ drgn -c dump.withuser.img /usr/share/drgn/contrib/pstack.py pstack -p 1=
9284
> [PID: 19284 COMM: bash]
>   Thread 0 TID=3D19284 [S] CPU=3D18 ('bash')
>     #0  context_switch (kernel/sched/core.c:5367:2)
>     #1  __schedule (kernel/sched/core.c:6752:8)
>     #2  __schedule_loop (kernel/sched/core.c:6829:3)
>     #3  schedule (kernel/sched/core.c:6844:2)
>     #4  do_wait (kernel/exit.c:1698:3)
>     #5  kernel_wait4 (kernel/exit.c:1852:8)
>     #6  __do_sys_wait4 (kernel/exit.c:1880:13)
>     #7  do_syscall_x64 (arch/x86/entry/common.c:47:14)
>     #8  do_syscall_64 (arch/x86/entry/common.c:84:7)
>     #9  entry_SYSCALL_64+0xaf/0x14c (arch/x86/entry/entry_64.S:121)
>     #10 0x7f46e82b63d7
>     ------ userspace ---------
>     #0  wait4+0x17/0xa3 (from /usr/lib64/libc.so.6 +0x1103d7)
>     #1  waitchld.isra.0+0x102/0xc42 (from /usr/bin/bash +0x10bd52)
>     #2  wait_for+0x15a/0xda6 (from /usr/bin/bash +0x5b54a)
>     #3  execute_command_internal+0x3186/0x3877 (from /usr/bin/bash +0x3e9=
76)
>     #4  execute_command+0xcc/0x1c8 (from /usr/bin/bash +0x3f13c)
>     #5  reader_loop+0x1ea/0x39a (from /usr/bin/bash +0x311da)
>     #6  main+0xe2a/0x1a94 (from /usr/bin/bash +0x2548a)
>     #7  __libc_start_call_main+0x7e/0xac (from /usr/lib64/libc.so.6 +0x2d=
39e)
>     #8  __libc_start_main@@GLIBC_2.34+0x89/0x14c (from /usr/lib64/libc.so=
.6 +0x2d459)
>     #9  _start+0x25/0x26 (from /usr/bin/bash +0x26125)
>     #10 ???
>
>
> $ drgn -c baseline.img /usr/share/drgn/contrib/pstack.py pstack -p 19284
> [PID: 19284 COMM: bash]
>   Thread 0 TID=3D19284 [S] CPU=3D18 ('bash')
>     #0  context_switch (kernel/sched/core.c:5367:2)
>     #1  __schedule (kernel/sched/core.c:6752:8)
>     #2  __schedule_loop (kernel/sched/core.c:6829:3)
>     #3  schedule (kernel/sched/core.c:6844:2)
>     #4  do_wait (kernel/exit.c:1698:3)
>     #5  kernel_wait4 (kernel/exit.c:1852:8)
>     #6  __do_sys_wait4 (kernel/exit.c:1880:13)
>     #7  do_syscall_x64 (arch/x86/entry/common.c:47:14)
>     #8  do_syscall_64 (arch/x86/entry/common.c:84:7)
>     #9  entry_SYSCALL_64+0xaf/0x14c (arch/x86/entry/entry_64.S:121)
>     #10 0x7f46e82b63d7
>     ------ userspace ---------
>     #0  wait4+0x17/0xa3 (from /usr/lib64/libc.so.6 +0x1103d7)
>
>
> $ drgn -c extension.img /usr/share/drgn/contrib/pstack.py pstack -p 19284
> [PID: 19284 COMM: bash]
>   Thread 0 TID=3D19284 [S] CPU=3D18 ('bash')
>     #0  context_switch (kernel/sched/core.c:5367:2)
>     #1  __schedule (kernel/sched/core.c:6752:8)
>     #2  __schedule_loop (kernel/sched/core.c:6829:3)
>     #3  schedule (kernel/sched/core.c:6844:2)
>     #4  do_wait (kernel/exit.c:1698:3)
>     #5  kernel_wait4 (kernel/exit.c:1852:8)
>     #6  __do_sys_wait4 (kernel/exit.c:1880:13)
>     #7  do_syscall_x64 (arch/x86/entry/common.c:47:14)
>     #8  do_syscall_64 (arch/x86/entry/common.c:84:7)
>     #9  entry_SYSCALL_64+0xaf/0x14c (arch/x86/entry/entry_64.S:121)
>     #10 0x7f46e82b63d7
>     ------ userspace ---------
>     #0  wait4+0x17/0xa3 (from /usr/lib64/libc.so.6 +0x1103d7)
>     #1  waitchld.isra.0+0x102/0xc42 (from /usr/bin/bash +0x10bd52)
>     #2  wait_for+0x15a/0xda6 (from /usr/bin/bash +0x5b54a)
>     #3  execute_command_internal+0x3186/0x3877 (from /usr/bin/bash +0x3e9=
76)
>     #4  execute_command+0xcc/0x1c8 (from /usr/bin/bash +0x3f13c)
>     #5  reader_loop+0x1ea/0x39a (from /usr/bin/bash +0x311da)
>     #6  main+0xe2a/0x1a94 (from /usr/bin/bash +0x2548a)
>     #7  __libc_start_call_main+0x7e/0xac (from /usr/lib64/libc.so.6 +0x2d=
39e)
>     #8  __libc_start_main@@GLIBC_2.34+0x89/0x14c (from /usr/lib64/libc.so=
.6 +0x2d459)
>     #9  _start+0x25/0x26 (from /usr/bin/bash +0x26125)
>     #10 ???
>
> Beyond my testing / use case, the only other feedback I wanted to share
> on this patch series, is that I think it would be good to have the
> amdgpu and userstack extensions contributed upstream, rather than kept
> as external customizations.
>
> Given that there's not a defined extension API or ABI, I don't think
> extensions yet make sense to be indpendent: they depend heavily on the
> internals of makedumpfile. There's probably not going to be a
> "makedumpfile-devel" package any time soon which allows building
> and maintaining external extensions for your system makedumpfile. So the
> only way make use of the system would be either (a) the Linux distro
> bundles their own extension, or (b) the user builds and manually
> installs a custom version of makedumpfile & extensions.
>
> The main purpose of the extension API is to provide these specific
> functionalities which are impossible with page-based filtering. Ideally,
> I think makedumpfile should provide the real, useful capability and not
> just the framework for a motivated developer to make it happen.

I agree with your idea, and I'm even happier if makedumpfile
maintainer is willing to maintain the extensions along with
makedumpfile, that will make our lives much easier. But I fully
understand the makedumpfile extension case is similar to the crash
utility extension case, which is maintained seperately, I know the
maintainance work can expand greatly with more and more extensions
been integrated. So it is fully acceptable to me of whatever the
maintainance stratage made regarding to the makedumpfile extensions.

Thanks,
Tao Liu

>
> That said, I know it's a maintenance overhead and there may not be a
> clear test strategy for every extension.
>
> Thanks,
> Stephen
>
> Tao Liu <ltao@redhat.com> writes:
> > A) This patchset will introduce the following features to makedumpfile:
> >
> >   1) Add .so extension support to makedumpfile
> >   2) Enable btf and kallsyms for symbol type and address resolving.
> >
> > B) The purpose of the features are:
> >
> >   1) Currently makedumpfile filters mm pages based on page flags, becau=
se flags
> >      can help to determine one page's usage. But this page-flag-checkin=
g method
> >      lacks of flexibility in certain cases, e.g. if we want to filter t=
hose mm
> >      pages occupied by GPU during vmcore dumping due to:
> >
> >      a) GPU may be taking a large memory and contains sensitive data;
> >      b) GPU mm pages have no relations to kernel crash and useless for =
vmcore
> >         analysis.
> >
> >      But there is no GPU mm page specific flags, and apparently we don'=
t need
> >      to create one just for kdump use. A programmable filtering tool is=
 more
> >      suitable for such cases. In addition, different GPU vendors may us=
e
> >      different ways for mm pages allocating, programmable filtering is =
better
> >      than hard coding these GPU specific logics into makedumpfile in th=
is case.
> >
> >   2) Currently makedumpfile already contains a programmable filtering t=
ool, aka
> >      eppic script, which allows user to write customized code for data =
erasing.
> >      However it has the following drawbacks:
> >
> >      a) cannot do mm page filtering.
> >      b) need to access to debuginfo of both kernel and modules, which i=
s not
> >         applicable in the 2nd kernel.
> >      c) eppic library has memory leaks which are not all resolved [1]. =
This
> >         is not acceptable in 2nd kernel.
> >
> >      makedumpfile need to resolve the dwarf data from debuginfo, to get=
 symbols
> >      types and addresses. In recent kernel there are dwarf alternatives=
 such
> >      as btf/kallsyms which can be used for this purpose. And btf/kallsy=
ms info
> >      are already packed within vmcore, so we can use it directly.
> >
> >   With these, this patchset introduces makedumpfile extensions, which i=
s based
> >   on btf/kallsyms symbol resolving, and is programmable for mm page fil=
tering.
> >   The following section shows its usage and performance, please note th=
e tests
> >   are performed in 1st kernel.
> >
> >   3) Compile and run makedumpfile extensions:
> >
> >   $ make LINKTYPE=3Ddynamic USELZO=3Don USESNAPPY=3Don USEZSTD=3Don
> >   $ make extensions
> >
> >   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-=
06-10-18\:03\:12/vmcore
> >     /tmp/extension.out --extension amdgpu_filter.so
> >     Loaded extension: ./extensions/amdgpu_filter.so
> >     makedumpfile Completed.
> >       User time (seconds): 5.08
> >       System time (seconds): 0.84
> >       Percent of CPU this job got: 99%
> >       Elapsed (wall clock) time (h:mm:ss or m:ss): 0:05.95
> >         Maximum resident set size (kbytes): 17360
> >         ...
> >
> >      To contrast with eppic script of v2 [2]:
> >
> >   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-=
06-10-18\:03\:12/vmcore
> >     /tmp/eppic.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
> >     makedumpfile Completed.
> >         User time (seconds): 8.23
> >         System time (seconds): 0.88
> >         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:09.16
> >         Maximum resident set size (kbytes): 57128
> >         ...
> >
> >   -rw------- 1 root root 367475074 Jan 19 19:01 /tmp/extension.out
> >   -rw------- 1 root root 367475074 Jan 19 19:48 /tmp/eppic.out
> >   -rw------- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-20=
25-06-10-18:03:12/vmcore
> >
> > C) Discussion:
> >
> >   1) GPU types: Currently only tested with amdgpu's mm page filtering, =
others
> >      are not tested.
> >   2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/pp=
c64.
> >      Others are not tested.
> >
> > D) Testing:
> >
> >      If you don't want to create your vmcore, you can find a vmcore whi=
ch I
> >      created with amdgpu mm pages unfiltered [3], the amdgpu mm pages a=
re
> >      allocated by program [4]. You can use the vmcore in 1st kernel to =
filter
> >      the amdgpu mm pages by the previous performance testing cmdline. T=
o
> >      verify the pages are filtered in crash:
> >
> >      Unfiltered:
> >      crash> search -c "!QAZXSW@#EDC"
> >      ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXX
> >      ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXX
> >      crash> rd ffff96b7fa800000
> >      ffff96b7fa800000:  405753585a415121                    !QAZXSW@
> >      crash> rd ffff96b87c800000
> >      ffff96b87c800000:  405753585a415121                    !QAZXSW@
> >
> >      Filtered:
> >      crash> search -c "!QAZXSW@#EDC"
> >      crash> rd ffff96b7fa800000
> >      rd: page excluded: kernel virtual address: ffff96b7fa800000  type:=
 "64-bit KVADDR"
> >      crash> rd ffff96b87c800000
> >      rd: page excluded: kernel virtual address: ffff96b87c800000  type:=
 "64-bit KVADDR"
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
> >    will be stored, rather than install all kernel's syms/types. To do t=
his,
> >    special elf sections as .init_ksyms/ktypes are used for the required=
 info
> >    declaration/storage.
> >
> > 2) Support extension callback for makedumpfile, so during mm page
> >    filtering, extension can help to decide if keep/discard the page.
> >
> > 3) The patches are organized as follows:
> >
> >     --- <only for test purpose, don't merge> ---
> >     7. Filter amdgpu mm pages
> >
> >     --- <code should be merged> ---
> >     6. Add makedumpfile extensions support
> >     5. Implement kernel module's btf resolving
> >     4. Implement kernel module's kallsyms resolving
> >     3. Implement kernel btf resolving
> >     2. Implement kernel kallsyms resolving
> >     1. Reserve sections for makedumpfile and extenions
> >
> >     Patch 7 is customization specific, which can be maintained separate=
ly.
> >     Patch 1 ~ 6 are common code which should be integrate with makedump=
file.
> >
> > Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@r=
edhat.com/
> > Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@re=
dhat.com/
> > Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@r=
edhat.com/
> >
> > Tao Liu (7):
> >   Reserve sections for makedumpfile and extenions
> >   Implement kernel kallsyms resolving
> >   Implement kernel btf resolving
> >   Implement kernel module's kallsyms resolving
> >   Implement kernel module's btf resolving
> >   Add makedumpfile extensions support
> >   Filter amdgpu mm pages
> >
> >  Makefile                   |  11 +-
> >  btf_info.c                 | 345 +++++++++++++++++++++++++++
> >  btf_info.h                 |  92 ++++++++
> >  extension.c                | 300 +++++++++++++++++++++++
> >  extension.h                |  12 +
> >  extensions/Makefile        |  12 +
> >  extensions/amdgpu_filter.c | 190 +++++++++++++++
> >  extensions/maple_tree.c    | 307 ++++++++++++++++++++++++
> >  extensions/maple_tree.h    |   6 +
> >  kallsyms.c                 | 473 +++++++++++++++++++++++++++++++++++++
> >  kallsyms.h                 |  94 ++++++++
> >  makedumpfile.c             |  41 +++-
> >  makedumpfile.h             |  13 +
> >  makedumpfile.ld            |  15 ++
> >  14 files changed, 1903 insertions(+), 8 deletions(-)
> >  create mode 100644 btf_info.c
> >  create mode 100644 btf_info.h
> >  create mode 100644 extension.c
> >  create mode 100644 extension.h
> >  create mode 100644 extensions/Makefile
> >  create mode 100644 extensions/amdgpu_filter.c
> >  create mode 100644 extensions/maple_tree.c
> >  create mode 100644 extensions/maple_tree.h
> >  create mode 100644 kallsyms.c
> >  create mode 100644 kallsyms.h
> >  create mode 100644 makedumpfile.ld
> >
> > --
> > 2.47.0
>


