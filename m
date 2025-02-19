Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEF7C021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SMHHlCMcxXYtVaRR1wTwHJJB8CwWA0AX/SUXLDYSpC4=; b=qhyOSiufzg+3FvcoRqRWkNv776
	pZoEi4hdVCF/3a/V1u58+VYCclDwiZ0uGBc09LT1xkJfJw9JnD532O30eouLKkRj/AlOunLh+qPyI
	yLCSHrK4d4HJHVcpVjWTxrFWj0m2MCfQFhg3Bou0QM8riKzW7CUYHIpHXMeK7Bb+lTMx3y2cquMxm
	OfDF5LqBz46ykRE3MeaEtcn0nIxWAJ3sbjwp27QLTSO1/FbzAYdL6mApiXSQLZv1knXYQdaO/NHBB
	hPw20kYWFsUp469iIrgxA7shipumAQXLljOuSoUX5mHYzdPfdsFo3ogD7YO+ofzlJ1AHKdPJO5w0o
	NJuawGEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkjXj-0000000Cm1K-0Aiu;
	Wed, 19 Feb 2025 12:51:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkjVc-0000000Cl7N-10B2
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 12:49:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739969338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMHHlCMcxXYtVaRR1wTwHJJB8CwWA0AX/SUXLDYSpC4=;
	b=cj8fGW3r/87s7KQtC4JOfRk/0Sxp0LwdoIEJM2B5r6qX6mC0giFQgLTdyBsimx29Sy33MB
	oHDLPpTsyhjYgogiB4Qe/rlDtA/5F9m4wjSqzHvSo1mx87/B16sDNhvgYB6vsx5j8d+WyR
	IV4TZE7C5HKHX2xFVJ84i9PBwv2WRV8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-27CRKpObOWKuGIpLRNTlXQ-1; Wed, 19 Feb 2025 07:48:55 -0500
X-MC-Unique: 27CRKpObOWKuGIpLRNTlXQ-1
X-Mimecast-MFC-AGG-ID: 27CRKpObOWKuGIpLRNTlXQ_1739969334
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so126977475ab.0
        for <kexec@lists.infradead.org>; Wed, 19 Feb 2025 04:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969334; x=1740574134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMHHlCMcxXYtVaRR1wTwHJJB8CwWA0AX/SUXLDYSpC4=;
        b=FFA/5+hKZo/nMmuz+VoJylLD9DKEBXIKP12+FjSB64ihEnYirfvGoHHESc8uldumqt
         CUeuBuin0dVH22JhWSws8ejDPMITH9PsI/QFcp/VnFEBHb2kb028MSnEpVLfdFa8Wh6o
         Xl0aLaVJeZioeEwckATlKS2iaYv4CKaApvDX4csHTjASvun9dX13+VjiMCyE+RMmviRn
         AlwXKAd5hPIif2xHzgX1r1kYZfQ78vVsaVqadhY+k6iTz7ulgFHeolsj49UGy5a+4J6n
         Gt0c6G8NAbGlP7Utwh54iitXfaHksJUKQCkxCb0nZSR7kHnqPCVS27d3p74eyH/KZm8w
         41ow==
X-Forwarded-Encrypted: i=1; AJvYcCWA40Cbgb62mZHdedqlztE8dYYYQRrNejBineagIff+1Wly9lvTMtc3EfFqa5u4naQ05VO7Yg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyUr8ZX9xdBMMYSk1THuJ3P/0kOz1KhegnIrbjn0xv19mzanWSW
	o9Wv/GDu5kJ5aQbeGyPBuM6Bn657pcG/pX79Mn3gGuCP5rNts5l6ao3GxcaPdj46HwZt6SAGuWH
	vZATAL1/NgzYB5jmCfB5f9DjxdR6JdD8YkIGsG8tPsJydb4q+pQqeaje0UsC+yex8xXiHK+cEy2
	cF5NbsZCMpxwqggTOuqvt6wtxL8hXuvxlE
X-Gm-Gg: ASbGncvwq1PvTLew/BloBLbkMKRQKdCr1drUBlwdhgONATxneZE1ENLeiJHGYqUXYuV
	AvPpOKh/9XW9DtUPlWm+G/ls/acD1Cs7BJAX7RoAc4pyHVWTLl9ajqBT+Q2A7FLA=
X-Received: by 2002:a05:6e02:184d:b0:3cf:bb3e:884c with SMTP id e9e14a558f8ab-3d280940c90mr162914045ab.16.1739969334530;
        Wed, 19 Feb 2025 04:48:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQzXwQKpyH3rywpGs7BzP6mbj6/B897FEVbfIit3jAtaZt2ga8Vr+6/m/vSCYkDIbGIHSmC6KPV/ULHybcxNs=
X-Received: by 2002:a05:6e02:184d:b0:3cf:bb3e:884c with SMTP id
 e9e14a558f8ab-3d280940c90mr162913745ab.16.1739969334259; Wed, 19 Feb 2025
 04:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
 <Z7WJD6eBLuIRnLwk@kernel.org>
In-Reply-To: <Z7WJD6eBLuIRnLwk@kernel.org>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 19 Feb 2025 20:49:07 +0800
X-Gm-Features: AWEUYZlzn2-E8ZdtRbfhtM_eLch7RFvZ-yzSIrzOWYzAtm2oUJ9ngWc6Obau8Nc
Message-ID: <CALu+AoSaEthfed1NOYPiQgm_g-dhibVMRAp0+=_+9qTT4_x=tg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mmpdhDC0ygUOLek_iNiWTgErn18RKgJ5GveImTdB20I_1739969334
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_044900_348034_9B7FA780 
X-CRM114-Status: GOOD (  25.35  )
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

On Wed, 19 Feb 2025 at 15:32, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Feb 17, 2025 at 11:19:45AM +0800, RuiRui Yang wrote:
> > On Thu, 6 Feb 2025 at 21:34, Mike Rapoport <rppt@kernel.org> wrote:
> > > == Limitations ==
> > >
> > > Currently KHO is only implemented for file based kexec. The kernel
> > > interfaces in the patch set are already in place to support user space
> > > kexec as well, but it is still not implemented it yet inside kexec tools.
> > >
> >
> > What architecture exactly does this KHO work fine?   Device Tree
> > should be ok on arm*, x86 and power*, but how about s390?
>
> KHO does not use device tree as the boot protocol, it uses FDT as a data
> structure and adds architecture specific bits to the boot structures to
> point to that data, very similar to how IMA_KEXEC works.
>
> Currently KHO is implemented on arm64 and x86, but there is no fundamental
> reason why it wouldn't work on any architecture that supports kexec.

Well,  the problem is whether there is a way to  add dtb in the early
boot path,  for X86 it is added via setup_data,  if there is no such
way I'm not sure if it is doable especially for passing some info for
early boot use.  Then the KHO will be only for limited use cases.

>
> > Thanks
> > Dae
> >
>
> --
> Sincerely yours,
> Mike.
>


