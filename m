Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B4FC36016
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KKMJVcSSYFhFkaF9OI9BOHOle5JxWrFZ54yuemRi3B0=; b=Ms3lAfMRc+LMS8veXhLT1AEa0v
	opNXPWdil6rZV2BG9cmQ1DHA5j+us4lo41TYi/M1qdrK3q8NFijMZUYVr3X5kEHTiOySZs59BB2Cx
	dqXeWQ0zQZVsDC9f56fmoIH6L5uuBjCQ96q0+1F7lKQhGFAcgWjl47c5i6yMiN7HIjj6g6UdtXVrW
	bxWtIjrXMTr0pm14C4byVuokt1BX8ylbANhQ3Jge8XsLDw0OY4vSrpLmjqlwsfhCVi9c1RWGFVGtk
	FgdYk88iASO2rDa46D56b7gGZzcopGCpcvne3l8LrwOFATZXcuTebQdHyhbYpe9+WwDArOt1MfdWz
	a5eui75w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTw-0000000B67s-2VFX;
	Thu, 27 Mar 2025 13:41:16 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx4to-000000069JW-3vAU
	for kexec@lists.infradead.org;
	Tue, 25 Mar 2025 14:05:03 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7c542ffec37so597994585a.2
        for <kexec@lists.infradead.org>; Tue, 25 Mar 2025 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742911500; x=1743516300; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKMJVcSSYFhFkaF9OI9BOHOle5JxWrFZ54yuemRi3B0=;
        b=AROCbu2ANCTZKO/AYOds/JGwIxoOJ+ropXG02/nK/tawFCLaIv3WaTRaAdTmsJqv1/
         TYAVK0sFN/SMIrSBfH3J3Lo7PGYnGXwN/2DgD8mArjllHhIYglx8j7yNTv/voz+BM9sy
         Heql1rvI1XcPyT2Af2SqPszzRtBpT46fW/761lsAAq2OtihL+zEeFaG8VQuozExX7K8W
         I1nHpmbMRhXx9qSnrr6qV4Qfga7tmuWsYF7f/GjguzSXm874gmniR6q+tu6A0xfcTkjj
         6jCFSiakxYIDbxbsOIK/4nIckGHdgrpNlYzptcxYZIieAFyg/NRJUfWka6hBlEph4WBe
         qQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911500; x=1743516300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKMJVcSSYFhFkaF9OI9BOHOle5JxWrFZ54yuemRi3B0=;
        b=pYQPjY5wbItBV31em1WCWEuucDr+DJJ4qGj+dplmUw6GtbsEZswVOiaaPT15LYJ5RM
         3MdqcrQqCyrYoDDvPPHTTsZL+jir/p9QMpGl3Sc2tPSV+LxKbqmHOEwb+zHhNZgOySek
         2c0xaaVTi97/IDtMOFjoZMN6CzhrhK8cJMpXrnhCn3erpncx+M/9OzcKv1KA9Hws6RrZ
         ivx4AeadLQWVqB+2F0ZqCcl8HyNWwonSY68rnsSNS898xu2GA8aA4suoCEM9BXV5iRMY
         WjnHemTPSJf3Q5dqDFVjK2rRrsuRWe509BRJDkuyoucM4GCxEuJirptj9+CiFpyQiwWD
         DCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPj/x1eNlIX+PbdsN56BsqUu3cIO8LHiDYnv4b+6OXkEEFk8qW4INd5I9DLJ93VDJYjBgnzw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxYexPAYADLGf2oJwmyk+cbiHftPd8CQSRs3kDBjc3y+GaFxVOc
	IeJzk9IKqnMzD+nmcG85R1G417bCPv030g/qZa+hqhyqSLetGn4v/sN6APNK4wowuESmW+BdqYi
	SE3rV/by7JbN3q+u6ZKbIPsz4Zc5I//iaxAtinw==
X-Gm-Gg: ASbGncuQIAMO6GLWA/qjFD46Pgn+zsGs/R1gdxVjyqVjcQKKV99XOLfDzfshrgdYHus
	XNKHgzkNSKExnCGS48/TGaRHa5Sln7ufIr+xhC2lUWQJcGgcU8M9qfEKbAsErV790Ig4+gutQP3
	XPMdayXRhYLst0QbFky9td5cNU
X-Google-Smtp-Source: AGHT+IGMYVQtiX/h+EVJlPHZz5Rq/az3V8wIPVjd4SZUiiPGocRCmY6VSmvm0irS2U8qQcxFKzIzc2oRCd6fuO2LGmc=
X-Received: by 2002:a05:622a:248e:b0:476:b56d:eb46 with SMTP id
 d75a77b69052e-4771dd77d25mr264001271cf.15.1742911499617; Tue, 25 Mar 2025
 07:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
In-Reply-To: <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Mar 2025 10:04:21 -0400
X-Gm-Features: AQ5f1Jrjo6HkojvC1uIVMuAy34VVl7CYnqSMt1jjfTIiYkTHpp9oYG_kKxOqyPA
Message-ID: <CA+CK2bB-qPV-QnqUwAv+OGujZwWLAAgBT0xH6fyKY8-cP1bNSQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	linux-kernel@vger.kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	luto@kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, 
	robh@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, will@kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_070501_062016_F00C89E5 
X-CRM114-Status: GOOD (  29.30  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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

On Tue, Mar 25, 2025 at 2:58=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 03/24/25 at 12:18pm, Dave Young wrote:
> > On Thu, 20 Mar 2025 at 23:05, Changyuan Lyu <changyuanl@google.com> wro=
te:
> > >
> > > From: Alexander Graf <graf@amazon.com>
> > >
> > > We have all generic code in place now to support Kexec with KHO. This
> > > patch adds a config option that depends on architecture support to
> > > enable KHO support.
> > >
> > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > > ---
> > >  kernel/Kconfig.kexec | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > > index 4d111f871951..57db99e758a8 100644
> > > --- a/kernel/Kconfig.kexec
> > > +++ b/kernel/Kconfig.kexec
> > > @@ -95,6 +95,21 @@ config KEXEC_JUMP
> > >           Jump between original kernel and kexeced kernel and invoke
> > >           code in physical address mode via KEXEC
> > >
> > > +config KEXEC_HANDOVER
> > > +       bool "kexec handover"
> > > +       depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXE=
C_FILE
> > > +       select MEMBLOCK_KHO_SCRATCH
> > > +       select KEXEC_FILE
> > > +       select DEBUG_FS
> > > +       select LIBFDT
> > > +       select CMA
> > > +       select XXHASH
> > > +       help
> > > +         Allow kexec to hand over state across kernels by generating=
 and
> > > +         passing additional metadata to the target kernel. This is u=
seful
> > > +         to keep data or state alive across the kexec. For this to w=
ork,
> > > +         both source and target kernels need to have this option ena=
bled.
> > > +
> >
> > Have you tested kdump?  In my mind there are two issues,  one is with
> > CMA enabled, it could cause kdump crashkernel memory reservation
> > failures more often due to the fragmented low memory.  Secondly,  in
>
> kho scracth memorys are reserved much later than crashkernel, we may not
> need to worry about it.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> start_kernel()
>   ......
>   -->setup_arch(&command_line);
>      -->arch_reserve_crashkernel();
>   ......
>   -->mm_core_init();
>      -->kho_memory_init();
>
> > kdump kernel dump the crazy scratch memory in vmcore is not very
> > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > so please disable this option for kdump.
>
> Yeah, it's not meaningful to dump out scratch memorys into vmcore. We
> may need to dig them out from eflcorehdr. While it's an optimization,
> kho scratch is not big relative to the entire system memory. It can be
> done in later stage. My personal opinion.

But, we don't; we only dump out the regular CMA memory that absolutely
should be part of vmcore. When scratch is used during boot, it is used
for regular early boot kernel allocations, such as to allocate memmap,
which is an essential part of the crash dump.

Pasha

