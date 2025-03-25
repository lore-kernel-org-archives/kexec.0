Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F64C36019
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=80YXslX43Vd+KzUMLEtvDw9pbdwUBTF2zW23HR+RDds=; b=vQN04s5/ht84i+UWkMaIUb9F40
	kBQjDYh7RUbScbFLwuaRM15Qq4VRSlTHFpS/WXsXVUvN1Mo3EQ8vm76+A8Gu1RAdzd/A/5+Bbr91Z
	dFtvo7NUoOSmm1IgAuDI+eSzmyxFHr0mI2pKXFMoGUt1RsTAs7dW+RLjAu5rs//JZRKYnYsqGpOJ4
	Qm4PMC6fLc/vbiQffcWSJaA9w5XKEMGRx8oBG4E00U4GUjd3sGu4ACg+jgoXfOQ6dRutVG/LPey/r
	SXmhVs+khXD8VsgYfuuhR+13WSNqMAwqNDeTvoie1np2EfYJzUYpvwT6tUsLfdU/eiW8ZM7MIKKk8
	QALfgpOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTu-0000000B644-1cYr;
	Thu, 27 Mar 2025 13:41:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twt17-00000004bRE-14op
	for kexec@lists.infradead.org;
	Tue, 25 Mar 2025 01:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742865823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80YXslX43Vd+KzUMLEtvDw9pbdwUBTF2zW23HR+RDds=;
	b=Oni1+47tB1OU7EAqp5eF68eTMmt54QyVeEyZB8LHbK014ecJI4NHj519XZKW2nzTe3bz5L
	UVWYJ3pslKmroeavmLuSdKNdd/ngyd3V1k0ekD/2/s6HY4yHAcgLldkMhmUhXMK4uiVyRl
	WrzBA9DaZMd9s5rEkXV/yXNB8niu3OI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-qxVy7mYRMumkoVN1TAhDYg-1; Mon, 24 Mar 2025 21:23:42 -0400
X-MC-Unique: qxVy7mYRMumkoVN1TAhDYg-1
X-Mimecast-MFC-AGG-ID: qxVy7mYRMumkoVN1TAhDYg_1742865821
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d43d3338d7so99028555ab.0
        for <kexec@lists.infradead.org>; Mon, 24 Mar 2025 18:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742865821; x=1743470621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80YXslX43Vd+KzUMLEtvDw9pbdwUBTF2zW23HR+RDds=;
        b=BKQNPWm4YYIyI6t9XljppoSZ34f55T2sATr6+a5rhDr9jbGz/ewazaxS8zFJXr23ez
         GdZ07BLeiiQ+6nR1BvYC/RBnBziSrwmSsm3hyOYf+R+bvnCGUH7NzFHQhLfA0rSh+do9
         NfMsrGSoIrgSGF6ITf/5ihFrbfkBpCo1rusG36237AqBAYcsRZoFvbeiXWWKdY/hgDwt
         roa3F+ncDxw6eAaI/hlXrGlC2Vx3xCbZmKHnL1rhZBhELlcevtFysn0Znx+px0fSTyT1
         rjwO408yBxrzg62nyf6odPFH6Ac3yx7XD/eatAPgWhLWXD6uwX8yjay4Tyf2GNZhpOsQ
         XJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwncwb7xQtH8hGygTz2qpl0O+rLa7olAKJzBj+ks0klBRaRVeNn8faD0fPg4ijRgAQZPU4NA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjJ5U1iKGX+KhhHkeiGSFjvqUDngT//rrckYCqDzczzU/wycxg
	sXHj2SOd61F2bZUzJf4dm3a2D45wdh/j+ef70PIzOyOGCOpj+UVlVukFHYm8iDPFBovz+OVNP3Z
	dzdln0699mk2jfKqkzQQs90boptIJO29msbw+ZxvlprfNJXyCjuXpoKjq95m9UYOPZI8Dw80V0D
	tzvEnrJCrT2VzEPcd1UV3arbSPlCMMa4dl
X-Gm-Gg: ASbGncvMPzChBYwO0xk5G5EwmaUk6/XVlzinHS3qLzQxHTX3ASUjzH9F08EuenMD2M8
	UHN4e6bGjQzlaJhg90/5KgS3F/Xi0qgF/ciNTW0M6jWyrTkdzuppxd+X6UKT2P/dsOe9zMPEfuQ
	==
X-Received: by 2002:a05:6e02:349c:b0:3d3:dd60:bc37 with SMTP id e9e14a558f8ab-3d5961c530dmr173137295ab.22.1742865821206;
        Mon, 24 Mar 2025 18:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/JUKTQmyT7rmzB1113MDJsVnMSnwa5fEmJ4QQvGW8nT/qrXson+JpXQKKM8geQr7VEFqwbzNfblKLM2iKFAI=
X-Received: by 2002:a05:6e02:349c:b0:3d3:dd60:bc37 with SMTP id
 e9e14a558f8ab-3d5961c530dmr173136965ab.22.1742865820779; Mon, 24 Mar 2025
 18:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <CA+CK2bC4PM0JnHOUm7qfpQ=wUhwsYQ-hJ12tTK_7pSWgYk+bhg@mail.gmail.com>
In-Reply-To: <CA+CK2bC4PM0JnHOUm7qfpQ=wUhwsYQ-hJ12tTK_7pSWgYk+bhg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 25 Mar 2025 09:24:02 +0800
X-Gm-Features: AQ5f1JqwitaQjBg4ofN5mWtcdKnJXVa6ylkj6L0R0h_oYxt_kysMu1ZOpV0VfzE
Message-ID: <CALu+AoRL+oHW2vN8nf1wpsG2Ki8d44AABQRCBMd+CE4_XzqRTw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: KKd--NwVJBKJgeeVjsR854aihBVWj11GDDXx9zki3eA_1742865821
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_182345_366771_0AA33917 
X-CRM114-Status: GOOD (  34.70  )
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

On Tue, 25 Mar 2025 at 03:27, Pasha Tatashin <pasha.tatashin@soleen.com> wr=
ote:
>
> On Mon, Mar 24, 2025 at 12:18=E2=80=AFAM Dave Young <dyoung@redhat.com> w=
rote:
> >
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
> As I understand cma low memory scratch reservation is needed only to
> support some legacy pci devices that cannot use the full 64-bit space.
> If so, I am not sure if KHO needs to be supported on machines with
> such devices. However, even if we keep it, it should really be small,
> so I would not expect that to be a problem for crash kernel memory
> reservation.

It is not easy to estimate how much of the KHO reserved memory is
needed.  I assume this as a mechanism for all different users, it is
not  predictable.  Also it is not only about the size, but also it
makes the memory fragmented.

>
> > kdump kernel dump the crazy scratch memory in vmcore is not very
> > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > so please disable this option for kdump.
>
> The scratch memory will appear as regular CMA in the vmcore. The crash
> kernel can be kexec loaded only from userland, long after the scratch
> memory is converted to CMA.

Depending on the reserved size, if big enough it should be excluded in
vmcore dumping.
Otherwise if it is a kdump kernel it should skip the handling of the
KHO passed previous old states.

>
> Pasha
>


