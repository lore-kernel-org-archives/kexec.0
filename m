Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5DAC3600B
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=risWjFwCypYzMEcsgslZMqIUPKF0hXh9xXq6g1dCnwU=; b=RBAcZ95L1TwbX7N1nRE6XcidfS
	kNAfr5nCpfModzX4jHm4ytwGjYt//vvbN3vLL+HS01Pfps5fSGEerhRQwGnVxh6iyc8s2bzLIfScW
	StYlLNLMR9mNJ2WSrn8vEV0AJ0IjitvzUZfSNVEkb+97UYy37f9UZqI7E0XkGsZUSvACmkG6lYEIx
	BqchgVCQ4osjAqxvvDZ5hJm4+WupiyhExivBPe7ifd5EWT7Q0cXe4XXxhhvstGFUB8klGKKhvdokH
	nGXlpq/lJrGAc9W6a3p52IE2Qf+2mCfYBZTamAEoEeN4N3grjF+1FFPHfMU62Xh6RyZa5XX0cc50c
	wVdDeHbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTs-0000000B60y-3LHF;
	Thu, 27 Mar 2025 13:41:12 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twnSE-000000044Tj-1Oda
	for kexec@lists.infradead.org;
	Mon, 24 Mar 2025 19:27:24 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-47663aeff1bso46589641cf.0
        for <kexec@lists.infradead.org>; Mon, 24 Mar 2025 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742844441; x=1743449241; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=risWjFwCypYzMEcsgslZMqIUPKF0hXh9xXq6g1dCnwU=;
        b=VabJL6MixCv/cPjjxb3oJg7Z/+8r9i6CHgJ1NguT1pwbb6haGitq3ybPZqGg6hoph3
         6tEZkH+Bn5I5o+ha+a+RCEo2M7q1tig5WLxzGcUqYjfpVb12IzmlftfZ9RuRVg859Wug
         aPEhOP/r9c77mNSi8rJzEU6sP49MVHdDr1bw1LLrIRPwobgevdiZhFRLSYOUmfaa6t00
         D6WxEHhhh4nYeELg5qqD5/7sr0V3SlZcv9+au/h2Upw6txbF5eqj1V0F2aOkklt2cL2Z
         t+1GvTkN1hSpCSndQxeT4zfRY+QGWJHe5WYq7FiecUjLgr3GBNZrO9SCVyJAufbDrx5J
         5hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742844441; x=1743449241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=risWjFwCypYzMEcsgslZMqIUPKF0hXh9xXq6g1dCnwU=;
        b=FH7+ytg/8qZo59SmuGd24wevAN3/IqSX0TYOFYYqifyLoLFmXyVwqmK1n8jE3rl2UT
         kRWNVhJKZ3U8y6swKIHR2S36ocEhDuu+zHb5medDgj+fCgMgcRLMahWDivKvmFU3NepO
         4eHjK9jE+QwFiC62Qrx6XJOlLpTngL+0l6Xd8xPZ1y8jKaS0+pACuTPm/IP9WZHICAZQ
         zmSfZeza2vXYmIYVIAWoHp3+wNJ3AfIK9zpe0KkjZJ4y7svOwBRf2UlVsbL1zzVcd2/S
         t2TKXaWAdmBlPjbZgfLr2TsxawwrbY6rxq73tnIa73sHzZoZEby1sg9uGkijs47NWAnq
         rYYw==
X-Forwarded-Encrypted: i=1; AJvYcCW5UHEBntz/Hd/Dl9EXyPW8ORU5FIcITR/wU/JKgsPcPRT71iPlgP0dtW4+w89QeGPbBiV7Vg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwbRyVcsoRz4t5QbulmUdHMklT/Q2HZMq6B/SFo2YWHZDCHnR+M
	IntiIdePfkMc1on9KBysGYlrPCdGIqvu25Key1jbZJ5af2+qodBOP+4MC1EMhlFHGutZwSMavYe
	nN36l+lJ9TNXaf8tt/0BBuD4dXFVCsHqZ9B6auQ==
X-Gm-Gg: ASbGncvUj7ozD4gdLvri4T5yr6Q/h0tOP6j7PJfDvOTVWPtbhXjvr4lRs70Is58JMP9
	NIXjk6+Ehar3IBv94z7C8AZpdCUHF0tNqDOED78FBdCRgqjIKihbkoRju9+XIJAp6+L7IPnxy2g
	qtBOU2kgdmGk1TlLouFPBeOwbREhIJALJfE7E=
X-Google-Smtp-Source: AGHT+IGstsIg4qTmJ5YmWZYDNChDQ3+AV2nMWCj2a+cFs02lJM90kE8eqj7HIwLM8JIykyDhXLdef0fVOQCXvqByXHY=
X-Received: by 2002:a05:622a:550f:b0:472:bbb:1bab with SMTP id
 d75a77b69052e-4771dd88e91mr196322501cf.24.1742844440714; Mon, 24 Mar 2025
 12:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
In-Reply-To: <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 24 Mar 2025 15:26:43 -0400
X-Gm-Features: AQ5f1JrjPincvTv7ELB8J7T2hdmnlfkqUUS0uCgm9_GvQ7ohVp8PZ0NaxW7sdEs
Message-ID: <CA+CK2bC4PM0JnHOUm7qfpQ=wUhwsYQ-hJ12tTK_7pSWgYk+bhg@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Dave Young <dyoung@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_122722_649636_563CAA30 
X-CRM114-Status: GOOD (  26.24  )
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

On Mon, Mar 24, 2025 at 12:18=E2=80=AFAM Dave Young <dyoung@redhat.com> wro=
te:
>
> On Thu, 20 Mar 2025 at 23:05, Changyuan Lyu <changyuanl@google.com> wrote=
:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
> > We have all generic code in place now to support Kexec with KHO. This
> > patch adds a config option that depends on architecture support to
> > enable KHO support.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  kernel/Kconfig.kexec | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > index 4d111f871951..57db99e758a8 100644
> > --- a/kernel/Kconfig.kexec
> > +++ b/kernel/Kconfig.kexec
> > @@ -95,6 +95,21 @@ config KEXEC_JUMP
> >           Jump between original kernel and kexeced kernel and invoke
> >           code in physical address mode via KEXEC
> >
> > +config KEXEC_HANDOVER
> > +       bool "kexec handover"
> > +       depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_=
FILE
> > +       select MEMBLOCK_KHO_SCRATCH
> > +       select KEXEC_FILE
> > +       select DEBUG_FS
> > +       select LIBFDT
> > +       select CMA
> > +       select XXHASH
> > +       help
> > +         Allow kexec to hand over state across kernels by generating a=
nd
> > +         passing additional metadata to the target kernel. This is use=
ful
> > +         to keep data or state alive across the kexec. For this to wor=
k,
> > +         both source and target kernels need to have this option enabl=
ed.
> > +
>
> Have you tested kdump?  In my mind there are two issues,  one is with
> CMA enabled, it could cause kdump crashkernel memory reservation
> failures more often due to the fragmented low memory.  Secondly,  in

As I understand cma low memory scratch reservation is needed only to
support some legacy pci devices that cannot use the full 64-bit space.
If so, I am not sure if KHO needs to be supported on machines with
such devices. However, even if we keep it, it should really be small,
so I would not expect that to be a problem for crash kernel memory
reservation.

> kdump kernel dump the crazy scratch memory in vmcore is not very
> meaningful.  Otherwise I suspect this is not tested under kdump.  If
> so please disable this option for kdump.

The scratch memory will appear as regular CMA in the vmcore. The crash
kernel can be kexec loaded only from userland, long after the scratch
memory is converted to CMA.

Pasha

