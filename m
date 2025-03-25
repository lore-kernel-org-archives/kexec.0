Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EE7C36013
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8QX+zFdWjeuQlzuCcAZM/kErn+a5XVCQ6Ck8ssaU/og=; b=Yrr55WssEx09XJBSEKd4oDxXZT
	T7+vDwhPCcMFGAvnpncBxVvEtO2GYRe+wMnlVVhVT7Bcc+07EizF6d32sokX+2IwRr6jYbYPl5FWU
	ZN7TrVihpN/DBv985vl8ckJeNEkuIID1pRvg3ua+U/J6HkUv2OPSXx0inFxrEfIhkzVjVFwvIzUD2
	Z2NDEnfwidcfrdnb5G6v+An8EX465Zpw24mTWNbJdcIhM/mfINkco71zbCZtZAURojYXCAGkTz22f
	z/MUpEL9iRrq5K/ngs58Vzrl/UXsWZfABqEmFqBA6zOpJQL46DBSfxoJgD2mko5l5lrGC92OqsrTz
	8YNxVEKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTu-0000000B64o-3msL;
	Thu, 27 Mar 2025 13:41:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twucs-00000004jLJ-3pIf
	for kexec@lists.infradead.org;
	Tue, 25 Mar 2025 03:06:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742872008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QX+zFdWjeuQlzuCcAZM/kErn+a5XVCQ6Ck8ssaU/og=;
	b=gt/DY1J/08YJGkLPSbtFsj9R0wa9fKrpv0qFhOS8BcAQTTB+X7Wy+jG+mVWQ1vMk4yrREM
	ZiH3R+YzkRLR9m9doV7s1JZsBY85LNv/o6pLKGyiTEx2Exp1aluntf5+ihk8Y6OuwmzG8v
	29RgOsYkL7AjGDiqBAM+q01qch4kb1w=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-XcjJolfMNAeZrIQudvd6Zw-1; Mon, 24 Mar 2025 23:06:46 -0400
X-MC-Unique: XcjJolfMNAeZrIQudvd6Zw-1
X-Mimecast-MFC-AGG-ID: XcjJolfMNAeZrIQudvd6Zw_1742872006
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b5878a66cso1080817739f.2
        for <kexec@lists.infradead.org>; Mon, 24 Mar 2025 20:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742872006; x=1743476806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QX+zFdWjeuQlzuCcAZM/kErn+a5XVCQ6Ck8ssaU/og=;
        b=jTWYQi1AyXusorUwMLKGhGMey+bcPVWJp71Pzd27kRVGijdKfdvffgXJEaBFziGMhl
         jdYXStI3P/fM9/V9QOPBfefyecpHPvlhq65bqrX0t9GpTtTLSLcehQPta7shaergY3aj
         su0qL6z+eiQRSCUUfmRC+YW/R4G4N+bRTEeOVqw/qfDW4zUeJeSGG9eMeJ5Pm6j7x18+
         9aOA+jCfe/90k5tCXSKqm3+mhwXsSMP7fCxUJ9T0kkLJvMOWodJXMiVJYLCC0kMSSkWm
         ewSLeEJWMwcXB2jo2d8s8PFxdwLzMjuQz/l0sR0IbUxItlY9WSpCnVLDvi4Y+8yGAac/
         /jhg==
X-Forwarded-Encrypted: i=1; AJvYcCXbdQ7bacAQVISs5c0pYoqbYZX7tFDDzdiVnv7Qx3+i7DYYzPD31X3J4IASjqpgu7+uL+Mv/g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxiiCFToRWr3zJuo5x7TByRpMHbksXCDOcTwkGImgIo+PVjrwl3
	29ItgpDeRy0uzByCcbB/GBYtSF7uTq+5qDuhalWpRKRFBPvWWO7NXtquY56oJB7mQ/JbpdrdlQD
	8jUQdvPMi0tTPn6lOus5HhMT1+oNUE4U7+YSFZ4USAIf4YLcUUYEs/RHQBljPjhyTj1K9c8XPat
	S9R/SnXf74wsaDRMBA+vjNlKU48gfmGkRv
X-Gm-Gg: ASbGncu98u2rxfu1VdFed35ILBunqZuSNbhKITvfaVh2GO4rzRtticFHusuIEy1dpmN
	3fm7aaaB8ia7JAfl/DKjI24bm4GdLcQzUM+xyc5EcaQ3XURJXaF+nAVKeBqdeoiUoUdVjH1xi4w
	==
X-Received: by 2002:a05:6e02:748:b0:3d4:6e2f:b493 with SMTP id e9e14a558f8ab-3d59615d9b2mr153651355ab.11.1742872006027;
        Mon, 24 Mar 2025 20:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5XTfTYA1qkf4MGjSh6Evza+A2MB/jUqh1YG/uG3OXh4qzNNvGTBc1K4PgXO/eVmwdqOvHcPKX5AjVSKaQhLs=
X-Received: by 2002:a05:6e02:748:b0:3d4:6e2f:b493 with SMTP id
 e9e14a558f8ab-3d59615d9b2mr153650885ab.11.1742872005537; Mon, 24 Mar 2025
 20:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <CA+CK2bC4PM0JnHOUm7qfpQ=wUhwsYQ-hJ12tTK_7pSWgYk+bhg@mail.gmail.com> <CALu+AoRL+oHW2vN8nf1wpsG2Ki8d44AABQRCBMd+CE4_XzqRTw@mail.gmail.com>
In-Reply-To: <CALu+AoRL+oHW2vN8nf1wpsG2Ki8d44AABQRCBMd+CE4_XzqRTw@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 25 Mar 2025 11:07:06 +0800
X-Gm-Features: AQ5f1JodZdPjZPmn7C-4IUrPojZILVca8awRM4MpIz-0KIylSAlKoZUHH0RUnGg
Message-ID: <CALu+AoSzOixDBHiFdry=RbFGX5Umk5XxLC=BmPKMYW7rCLUxSw@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org, graf@amazon.com, 
	akpm@linux-foundation.org, luto@kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, 
	robh@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, will@kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a3hiyHE9QYImHq7IC-sli_v0AFPN4uH9g2ZNcv9yHKM_1742872006
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_200651_037498_6036ECFC 
X-CRM114-Status: GOOD (  39.67  )
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

On Tue, 25 Mar 2025 at 09:24, Dave Young <dyoung@redhat.com> wrote:
>
> On Tue, 25 Mar 2025 at 03:27, Pasha Tatashin <pasha.tatashin@soleen.com> =
wrote:
> >
> > On Mon, Mar 24, 2025 at 12:18=E2=80=AFAM Dave Young <dyoung@redhat.com>=
 wrote:
> > >
> > > On Thu, 20 Mar 2025 at 23:05, Changyuan Lyu <changyuanl@google.com> w=
rote:
> > > >
> > > > From: Alexander Graf <graf@amazon.com>
> > > >
> > > > We have all generic code in place now to support Kexec with KHO. Th=
is
> > > > patch adds a config option that depends on architecture support to
> > > > enable KHO support.
> > > >
> > > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > > > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > > > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > > > ---
> > > >  kernel/Kconfig.kexec | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > > > index 4d111f871951..57db99e758a8 100644
> > > > --- a/kernel/Kconfig.kexec
> > > > +++ b/kernel/Kconfig.kexec
> > > > @@ -95,6 +95,21 @@ config KEXEC_JUMP
> > > >           Jump between original kernel and kexeced kernel and invok=
e
> > > >           code in physical address mode via KEXEC
> > > >
> > > > +config KEXEC_HANDOVER
> > > > +       bool "kexec handover"
> > > > +       depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KE=
XEC_FILE
> > > > +       select MEMBLOCK_KHO_SCRATCH
> > > > +       select KEXEC_FILE
> > > > +       select DEBUG_FS
> > > > +       select LIBFDT
> > > > +       select CMA
> > > > +       select XXHASH
> > > > +       help
> > > > +         Allow kexec to hand over state across kernels by generati=
ng and
> > > > +         passing additional metadata to the target kernel. This is=
 useful
> > > > +         to keep data or state alive across the kexec. For this to=
 work,
> > > > +         both source and target kernels need to have this option e=
nabled.
> > > > +
> > >
> > > Have you tested kdump?  In my mind there are two issues,  one is with
> > > CMA enabled, it could cause kdump crashkernel memory reservation
> > > failures more often due to the fragmented low memory.  Secondly,  in
> >
> > As I understand cma low memory scratch reservation is needed only to
> > support some legacy pci devices that cannot use the full 64-bit space.
> > If so, I am not sure if KHO needs to be supported on machines with
> > such devices. However, even if we keep it, it should really be small,
> > so I would not expect that to be a problem for crash kernel memory
> > reservation.
>
> It is not easy to estimate how much of the KHO reserved memory is
> needed.  I assume this as a mechanism for all different users, it is
> not  predictable.  Also it is not only about the size, but also it
> makes the memory fragmented.
>
> >
> > > kdump kernel dump the crazy scratch memory in vmcore is not very
> > > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > > so please disable this option for kdump.
> >
> > The scratch memory will appear as regular CMA in the vmcore. The crash
> > kernel can be kexec loaded only from userland, long after the scratch
> > memory is converted to CMA.
>
> Depending on the reserved size, if big enough it should be excluded in
> vmcore dumping.
> Otherwise if it is a kdump kernel it should skip the handling of the
> KHO passed previous old states.

If you do not want to make the KHO conflicts with kdump, then the
above should be handled and well tested.  And then leave to end user
and distribution to determine if they want the both enabled
considering the risk of crashkernel reservation failure.

>
> >
> > Pasha
> >


