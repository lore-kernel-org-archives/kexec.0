Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB63C021A1
	for <kexec@archiver.kernel.org>; Tue, 11 Feb 2025 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f00g8h93qQX8OTMUbXqv3cBNa5BjAh6ZTXb5qUHVm6k=; b=DyrAtFNt5N9M3Dp9uHCvvY9RyT
	N8ZIiFxA7rmnOlHM/GE+RTQmZJ5a1afghgmuAcqFP5i0KlvVMdeLqgyh5laoGb0I8PJxhMf5CYV6n
	huggGIzpzddTZSzKrlr+O9tYEnbpqV85FBFsh6XowuktWyyyWnW1WABAKkx45M9U3qZ1tUEm0J1JX
	1h7OJILra+k1sNNb+Aon4LoaIMyX6zbV+Yw7iUQGeK/QvhBvMTt9M/lygUnzQTHal832GRvmlpbwh
	HYei3mi1rj36RnuJFRMTo4/X9LHJ61V2nGyLXu0weCCIwOR8djSEnI/8nYO4VDQh++MbMyiMalNyV
	6Wgpb8Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tht9n-00000004WCk-1SeK;
	Tue, 11 Feb 2025 16:30:43 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thsuK-00000004SCU-219H
	for kexec@lists.infradead.org;
	Tue, 11 Feb 2025 16:14:45 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-46c7855df10so106105681cf.3
        for <kexec@lists.infradead.org>; Tue, 11 Feb 2025 08:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1739290483; x=1739895283; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f00g8h93qQX8OTMUbXqv3cBNa5BjAh6ZTXb5qUHVm6k=;
        b=zGVxQKxbkuXoL7fsBev1KHK0oft68JUal6tE93jtjMHFrUGsAVLQM2WbKNnnpImG2s
         N8B7QVxLCJG40b3XX5KJ0SOPgn18o6Nx/ICy+4O2Rufc7LZno+/EbmRExzUmDMGKItMy
         L2dyMLb9cxA2dbWnQltiDIG6DP1rExiWF23AAdQ1ZA9Eme1SKVB6ugN48RMKuZ+metQn
         IEqrCd9klpsPHs/1jjITjwD57XbGqEvcPjVHX2RDwHe3djT9YVMkFUXv3jGFlmb0vqO8
         7BvpX+7vwUdYVxYHH2SREXPhofkRZpm3WvIdsL1cCr1FoauS1e/TDYDa0lrLdOzI0GZ1
         5I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290483; x=1739895283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f00g8h93qQX8OTMUbXqv3cBNa5BjAh6ZTXb5qUHVm6k=;
        b=GL72TcNGw64HzLJLd4y/hYiF1pvXxhGvmt71BI/QwpHriO3GcsZrmqKt9wAEapw6Gb
         1CfjH7dicpNIv+wUjbVSSCd0852uWJdbJwmB2RtQ1IiR75Z0cbPDM8XJyDZr5uG4rPWS
         V+/Y9zqDVd3JrA/ZCYK5kiNoBkGxuyLV0RDToV7hluPJ6hr40Rz8sV+/LSsqiot7vDZX
         ixVLK2jXY7BiIFpoTRioUy3w+iZOPlDbSFQIyt9/K5g/4yBLVwyPU3tnwdW/RBj/Wz4f
         w5NK6QsgEJruwiMmwtrmJ0hdj2JT9SMbIMidaMwyo4WQwCPlUH/P1GTDwUy6PeMFMZET
         Uhdw==
X-Forwarded-Encrypted: i=1; AJvYcCXV7yTA9YnSRQTxIT3iZWngifi4wUiyqNQYjYxZVUdpuwFnZS4lkf/6Xw6fBEsjMCO3LXAtug==@lists.infradead.org
X-Gm-Message-State: AOJu0YwfdrQ1umwH3HyS3mAtEWa5KT5o7ZsnDrmzEUCG3fwWAww99c15
	h6N2R2d0RW+PNU9Ui2Y6g3596kMVgNqiaR+4kuFf3Ujfj1s33jY5K3TsiYt8KL9aX7cEh5Qbxq+
	desTaTVoteS1rdf7qypDf+uINYGf3b6fXn8XesQ==
X-Gm-Gg: ASbGncsX2ygvmtkjE5Z4Nd2Cs+E0p06CWJXp70psa72uVs4MowUCgJNAYbV5CJpLjIu
	6Ky6tKPGW8Ml+f909tkkSndOXW0rmpvQ9Fd39GHctIyJhUGfxbVXsjpbdi3x60/DtWHOJQA==
X-Google-Smtp-Source: AGHT+IFV/2SwK8xAi9MTHEKrLCagsybkvEOxgGEB7IziCVbPaPZ5quI5gxUrWQ8mdomSEUM9RDcaJ8/FU9MUgrz9PW4=
X-Received: by 2002:ac8:7d86:0:b0:462:c14f:d13f with SMTP id
 d75a77b69052e-47167ae2791mr311026341cf.41.1739290483262; Tue, 11 Feb 2025
 08:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <20250206132754.2596694-6-rppt@kernel.org>
 <20250210202220.GC3765641@nvidia.com> <CA+CK2bBBX+HgD0HLj-AyTScM59F2wXq11BEPgejPMHoEwqj+_Q@mail.gmail.com>
 <20250211124943.GC3754072@nvidia.com>
In-Reply-To: <20250211124943.GC3754072@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 11 Feb 2025 11:14:06 -0500
X-Gm-Features: AWEUYZnZrdGQlINhll4ZCmxy4_MiFjWVL9mBm_3F0LCmRscyspW8dY4HAyEeygc
Message-ID: <CA+CK2bAEnaPUJmd3LxFwCRa9xWrSJ478c4xisvD4pwvNMiTCgA@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation helpers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Eric Biederman <ebiederm@xmission.com>, 
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_081444_526079_A8EA357F 
X-CRM114-Status: GOOD (  27.35  )
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

On Tue, Feb 11, 2025 at 7:49=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Feb 10, 2025 at 03:58:00PM -0500, Pasha Tatashin wrote:
> > >
> > > > +What:                /sys/kernel/kho/dt_max
> > > > +Date:                December 2023
> > > > +Contact:     Alexander Graf <graf@amazon.com>
> > > > +Description:
> > > > +             KHO needs to allocate a buffer for the DT that gets
> > > > +             generated before it knows the final size. By default,=
 it
> > > > +             will allocate 10 MiB for it. You can write to this fi=
le
> > > > +             to modify the size of that allocation.
> > >
> > > Seems gross, why can't it use a non-contiguous page list to generate
> > > the FDT? :\
> >
> > We will consider some of these ideas in the future version. I like the
> > idea of using preserved memory to carry sparse KHO tree: i.e FDT over
> > sparse memory, maybe use the anchor page to describe how it should be
> > vmapped into a virtually contiguous tree in the next kernel?
>
> Yeah, but this is now permanent uAPI that has to be kept forever. I

Agree, what I meant in the future patch version is before it gets
merged. I should have been more clear.

> think you should not add this when there are enough ideas on how to
> completely avoid it.

Thinking about it some more, I'm actually leaning towards keeping
things as they are, instead of going with a sparse FDT. With a sparse
KHO-tree, we'd be kinda trying to fix something that should be handled
higher up. All userspace preservable memory (like emulated pmem with
devdax/fsdax and also pstore for logging) can already survive cold
reboots with modified firmware Google and Microsoft do this.
Similarly, the firmware could give the kernel the KHO-tree (generated
by firmware or from the previous kernel) to keep stuff like telemetry,
oops messages, time stamps etc. KHO should not be considered
explicitly as a mechanism to carry device serialization data, the KHO
should be a standard and simple way to pass kernel data between
reboots. The more complex state can be built on top of it, for example
guestmemfs, could preserve terabytes of data and have only one node in
the KHO tree.

>
> Jason

