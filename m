Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A63C021A0
	for <kexec@archiver.kernel.org>; Sun,  9 Feb 2025 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c1QNyMKSJ0hbPU3JV/DSlubSfGXUIpdwEbIrWUYwGH8=; b=A1XNva6YyDhJHO+ogBdBDpORkE
	kBIdEcEU4LMK9k+V23/MwaNEep+lug3TABqmnNd6Xl/4kMjLUIdNv7mIjW2vLaKosq0hhTiyIpxSJ
	bub2ysGt2ZyZoTW1QRjaLnENhdBwX8LETIl8/gmMY7mWkph7egBplRE/YnNEEkTUnLvZHRPYQFcRa
	feYFezwag9cZpvs1nSX7bMsnY4HzyiZXGX8tnGEr54cb0XKfjkQyZHgJtL7TK+WeRA7XezW+rjoNH
	LtDMmDkje4ikwTGu8/Ctzt5WWXrQNF9SGjXH9nbJhU2QNBOshlbiBLYzAu/VLkfGcvGh4hGj4v/rC
	POrNdYRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgvgV-0000000DofE-2wrX;
	Sun, 09 Feb 2025 01:00:31 +0000
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgvgS-0000000Doe2-1WVn;
	Sun, 09 Feb 2025 01:00:29 +0000
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4ba7787f128so791416137.1;
        Sat, 08 Feb 2025 17:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739062827; x=1739667627; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1QNyMKSJ0hbPU3JV/DSlubSfGXUIpdwEbIrWUYwGH8=;
        b=GubFv8cJvEfoIhCDSdhhC1FMR2bTCFMRd6TT2kGlIcr/96rVt3HiI/fZCLwuJBRhjT
         bfOdfTetkDOZ4fUprsp2orEpY+ylMhoG/1MLvIkC3WZyze/1xbq4uPMFdi/CTFt+D6Tj
         3bP455bsxpAqDYaqad9ACpOjAv0uUaEgyHxOL5YzwotidJXzJ+JBg0RsHwvBF67tk4PA
         5fEN4QncBoytGBSFZ12u1lbqMo4CiEPimCKnHZuAh+YmdYCC6SpufhWVhIpWOr1cuZhL
         lASvzSfa9rIPF1q3ZgMCrDFfFIowllsHHGNlL1RRWT9Tfh2vzvmn9x81Lk6SJw2TKk+U
         5q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739062827; x=1739667627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1QNyMKSJ0hbPU3JV/DSlubSfGXUIpdwEbIrWUYwGH8=;
        b=nK7f/hgbDpvDR3JiK0HN1TF2RYElEB98nZvk2n3qnDCntLdMwb9Jmep8hl/q0sQqkR
         8UhexlYB55K7VG5rUT/TjqRzZqzYX8XzMlUWETU3z2wwRecDiWgVdJ+Rr0Enzu9AQ+KQ
         ZeM9bHzKAgvIoPVVyzWgoBcJWq53H6MJ0jnvM8ifBnc7ZJ1cgFwhrKCo7MCyv8uY9tu8
         Gu0YlE8ShkJ2nlBnxuWXHU7OP6gR6Ds76h7vmWi9abtNQ2Maexd4DSN9/tfWOFBK3fO5
         jyU1Bx1anEEpsmG9OYHdydiAm7PPxqjp4jVRZSVcy0N5dBYyRGO+T2AIDO5pV/f+VMl6
         SVRw==
X-Forwarded-Encrypted: i=1; AJvYcCUo2EYqIGJcRY+0EWjJhPANh/nA6nVYTe9b6mO5NbhffXxiv9wMkd9cZo+VZkJLFq/9foaCUpBll9VFXtqRSSkLDw==@lists.infradead.org, AJvYcCWJ0r2d7YCaEmIyUivn7FCLUbL4fEzOTebv/Q8e05s+whPdppmayj0jXuRXhJJrWAii0QGKsQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3K+DLBgR/BYODc1Q5OysuBcq2e/UVDDpltYuSl9zeNoxbBOfU
	FHltmiwE09EGyhSwS0I4vpGqygBS02ZlHIgqyAA7O4BUQe9nn0LcTWfDFfwARs5xWo9T1tFVFxq
	gVfEpsYhtYJivzWaPcGF9752FVyU=
X-Gm-Gg: ASbGnctw3gd3Se1cRGZZPc2NwrdoWUj6U0OyJAGxv8grQetn81Rgt7rf6IsaPuW8L6u
	xCOt4un6I8AOfG18ZoDGIL81hkfwhX+uoXpLyR4DwVTszFUuzKxm41Ns9SFPY7QL1KQSfJkMnlb
	lPtPeExKsarHhekYbN1G/fuO/4RjET4A==
X-Google-Smtp-Source: AGHT+IFLWFnU1Qw8fGqOUkm2sS5SvMcAKUH0QtXlpgwftaLaCUSnrvhOVYmXAaAgSRLNlyGtO1hm5jHRnEYHFNzWo88=
X-Received: by 2002:a05:6102:1627:b0:4b6:1a4e:9ed7 with SMTP id
 ada2fe7eead31-4ba85d86d4fmr5498626137.5.1739062827035; Sat, 08 Feb 2025
 17:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <CAM_iQpU9DDg2Oi33_dfPqVpd9j_2O+WD7ovo__f48BA9DztwXQ@mail.gmail.com>
 <CA+CK2bBrO+khpX+U3F+d8wCb3GutVD=3HtU-94gHQJSoenQcKw@mail.gmail.com>
In-Reply-To: <CA+CK2bBrO+khpX+U3F+d8wCb3GutVD=3HtU-94gHQJSoenQcKw@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 8 Feb 2025 17:00:15 -0800
X-Gm-Features: AWEUYZkp7_4rFtvLgYaHqSNG2VFYTpgh1ezDSM27S0gX2m2SV5kBvj6jdSbSZAc
Message-ID: <CAM_iQpW4--H6wqcx-=O5_PhEOkdrZN52qUhRRZO9xwpMxxLPaw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Pasha Tatashin <pasha.tatashin@soleen.com>
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
X-CRM114-CacheID: sfid-20250208_170028_603942_D4F30366 
X-CRM114-Status: GOOD (  45.57  )
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

On Sat, Feb 8, 2025 at 4:14=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> On Sat, Feb 8, 2025 at 6:39=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.co=
m> wrote:
> >
> > Hi Mike,
> >
> > On Thu, Feb 6, 2025 at 5:28=E2=80=AFAM Mike Rapoport <rppt@kernel.org> =
wrote:
> > >
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > >
> > > Hi,
> > >
> > > This a next version of Alex's "kexec: Allow preservation of ftrace bu=
ffers"
> > > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.=
com),
> > > just to make things simpler instead of ftrace we decided to preserve
> > > "reserve_mem" regions.
> > >
> > > The patches are also available in git:
> > > https://git.kernel.org/rppt/h/kho/v4
> > >
> > >
> > > Kexec today considers itself purely a boot loader: When we enter the =
new
> > > kernel, any state the previous kernel left behind is irrelevant and t=
he
> > > new kernel reinitializes the system.
> > >
> > > However, there are use cases where this mode of operation is not what=
 we
> > > actually want. In virtualization hosts for example, we want to use ke=
xec
> > > to update the host kernel while virtual machine memory stays untouche=
d.
> > > When we add device assignment to the mix, we also need to ensure that
> > > IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA,=
 we
> > > need to do the same for the PCI subsystem. If we want to kexec while =
an
> > > SEV-SNP enabled virtual machine is running, we need to preserve the V=
M
> > > context pages and physical memory. See "pkernfs: Persisting guest mem=
ory
> > > and kernel/device state safely across kexec" Linux Plumbers
> > > Conference 2023 presentation for details:
> > >
> > >   https://lpc.events/event/17/contributions/1485/
> > >
> > > To start us on the journey to support all the use cases above, this p=
atch
> > > implements basic infrastructure to allow hand over of kernel state ac=
ross
> > > kexec (Kexec HandOver, aka KHO). As a really simple example target, w=
e use
> > > memblock's reserve_mem.
> > > With this patch set applied, memory that was reserved using "reserve_=
mem"
> > > command line options remains intact after kexec and it is guaranteed =
to
> > > reside at the same physical address.
> >
> > Nice work!
> >
> > One concern there is that using memblock to reserve memory as crashkern=
el=3D
> > is not flexible. I worked on kdump years ago and one of the biggest pai=
ns
> > of kdump is how much memory should be reserved with crashkernel=3D. And
> > it is still a pain today.
> >
> > If we reserve more, that would mean more waste for the 1st kernel. If w=
e
> > reserve less, that would induce more OOM for the 2nd kernel.
> >
> > I'd suggest considering using CMA, where the "reserved" memory can be
> > still reusable for other purposes, just that pages can be migrated out =
of this
> > reserved region on demand, that is, when loading a kexec kernel. Of cou=
rse,
> > we need to make sure they are not reused by what you want to preserve h=
ere,
> > e.g., IOMMU. So you might need additional work to make it work, but sti=
ll I
> > believe this is the right direction.
>
> This is exactly what scratch memory is used for. Unlike crashkernel=3D,
> the entire scratch area is available to user applications as CMA, as
> we know that no kernel-reserved memory will come from that area. This
> doesn't work for crashkernel=3D, because in some cases, the user pages
> might also need to be preserved in the crash dump. However, if user
> pages are going to be discarded from the crash dump (as is done 99% of
> the time), then it is better to also make it use CMA or ZONE_MOVABLE
> and use only the memory occupied by the crash kernel and do not waste
> any memory at all. We have an internal patch at Google that does this,
> and I think it would be a good improvement for the upstream kernel to
> carry as well.

Good to know CMA is already used, I could not tell from the cover letter.

The case that user-space pages need to be preserved is for scenarios like
RDMA which pins user-space pages for DMA transfer. Since the goal here
is also to preserve hardware states like RDMA's I guess the same concern
remains.

Thanks!

