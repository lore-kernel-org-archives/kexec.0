Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A21C0219E
	for <kexec@archiver.kernel.org>; Sun,  9 Feb 2025 00:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zHcRKHoHeO3yYwQrJ0rL+RTEHK8K10d3+YiRJ46SQRc=; b=iCjdQ3hmvQ4mWchWduOdQAa3kx
	o8DzVgjyNZ8nyycQiupZ1DEDq7Yai+xUZiRtGyfGUIR++YpDTxFdYk/ALCD7SJLxAx7WLryjybOsu
	R/Bvd+wR0YXrv31Q3crKkioBnyR5fN+IIkj7NxZc7oQEwYFis54q+asn2HTxGVaTky+s658aB9ttY
	bGDJDKB7Rry4bZ9eLvOyoV8pgguSnFB+NiXqF4f1cg8wcp56lhu6OK+tieB9M7SuYczM+cfdEWkJc
	e/bvrzg1Pse9bmq7GYwwKof++CYMQVBvsY2MACdH6PDzTxZ/Bzog/3ckb0IkSLMOJXYFCkRaa/mtI
	18Qer7/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tguxq-0000000DlaV-1S1g;
	Sun, 09 Feb 2025 00:14:22 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tguxn-0000000DlZR-1Fw9
	for kexec@lists.infradead.org;
	Sun, 09 Feb 2025 00:14:21 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4717bb7e7deso6404801cf.1
        for <kexec@lists.infradead.org>; Sat, 08 Feb 2025 16:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1739060058; x=1739664858; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHcRKHoHeO3yYwQrJ0rL+RTEHK8K10d3+YiRJ46SQRc=;
        b=buLQsUgMWhHuuZcSDvym0hOzaidvgMQdseyujiz5FfL0F9Dynb7BLAg1u5NwxbEXrg
         jSk256ZdgNxyJkucCSKLtgOZddg6xUfm4LWFvuOUPh4gShDhlSt7i89ICliEnyjkcll+
         PHom4Xm7CH18loDpApDLj/bKAW7SY0AQ+e2+gflHxvbP+qyWaR9bNuqJqmAxDPQbB69R
         mO8thc91CwahA6/R84UR9Sbr5jkdsAqf1WUwP7dwfYh6sb1CJWdq1xIWrY9JRr4U4fv0
         6wRXDiVCHrn8/tEnY+WxFSso7ZvmfmT9koJzkOx/MOPWpk6euyVhAzq4hV8YGHZcv1Av
         W/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739060058; x=1739664858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHcRKHoHeO3yYwQrJ0rL+RTEHK8K10d3+YiRJ46SQRc=;
        b=g8vo3f4mRNOI0sI91vPAPLksbgQSfDNI03nB2/bwDTR1hkDCTQHkGnpPNFMukqdvAd
         ALQxzf6WJ5VDcIfXO2hZSZHKz74w++wzLKjWXzqemkQZq50CnFGEIxCfulUkaf/cDpKm
         Nz3w0Pd345r4Lu0eN75bbEH8dBBIiAHVcemeS9PjbU77WQ8PTgvOTX1hmGLBDQbeZ5qQ
         dsFreyjg/Ac9Y9Uo48h6XWq2PxIHGQ7+wDGz7q7I9zooASsGAkVBeTwS4Ro+JLrB/0km
         nQpeoiGjXAPLMeAzVDxf8CKMEdXf6RreiBM+/D7F9yEe8ltnhsAl0PUdM11/gFF0RbJ6
         7pOw==
X-Forwarded-Encrypted: i=1; AJvYcCV5HSP7XZhY1En/q+vJCRw9Phz9JcVzU7d7wZ8mDAERdDznZsdI+NMYC1EFyBd3M0etIEwFLA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCTbT71fiUvSdWhjGBKKsW0pwlySt19/4Wm5fGmUaby0c0q0W6
	5PojIfMqNxxl16IfVwUbzrC3y60BnbwfdJ97YS/Q1/HhcdZvzm8xlb25BsVLKlg38C30BXIls/0
	P0re/DvDPt58istBuLBfqp0x/TreB+P3/iN+F3Q==
X-Gm-Gg: ASbGncvPzRb0dET4wGExdCvAWRdVYpyacIla9q48ZfPCTUTGHb6BXNhNQg3Z+lyEPC6
	gG2YKghAiCMys4k9qnrdbfa80G2+ZqcJTQucrY6gcKeYHzuCN8yMggQj3zUC9BUTsnUSu5A==
X-Google-Smtp-Source: AGHT+IEZxHNt3mZP0AuiY+W9AaSnauAT6AJRQRznlE6PgIrsIXbAga4WSCyQOQlcL+3VJDDj9abWUIyU1/BOi9O7OEA=
X-Received: by 2002:a05:622a:1186:b0:471:8a10:63c0 with SMTP id
 d75a77b69052e-4718a1066demr10288491cf.10.1739060057757; Sat, 08 Feb 2025
 16:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <CAM_iQpU9DDg2Oi33_dfPqVpd9j_2O+WD7ovo__f48BA9DztwXQ@mail.gmail.com>
In-Reply-To: <CAM_iQpU9DDg2Oi33_dfPqVpd9j_2O+WD7ovo__f48BA9DztwXQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Feb 2025 19:13:40 -0500
X-Gm-Features: AWEUYZm7hjYyWx8OgJnvEXBjFKJR8cD76rObTCepJOM4ok5LDKRuBdQi0XQitL0
Message-ID: <CA+CK2bBrO+khpX+U3F+d8wCb3GutVD=3HtU-94gHQJSoenQcKw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Cong Wang <xiyou.wangcong@gmail.com>
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
X-CRM114-CacheID: sfid-20250208_161419_872390_D2B0CBAA 
X-CRM114-Status: GOOD (  41.37  )
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

On Sat, Feb 8, 2025 at 6:39=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> Hi Mike,
>
> On Thu, Feb 6, 2025 at 5:28=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
> >
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Hi,
> >
> > This a next version of Alex's "kexec: Allow preservation of ftrace buff=
ers"
> > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.co=
m),
> > just to make things simpler instead of ftrace we decided to preserve
> > "reserve_mem" regions.
> >
> > The patches are also available in git:
> > https://git.kernel.org/rppt/h/kho/v4
> >
> >
> > Kexec today considers itself purely a boot loader: When we enter the ne=
w
> > kernel, any state the previous kernel left behind is irrelevant and the
> > new kernel reinitializes the system.
> >
> > However, there are use cases where this mode of operation is not what w=
e
> > actually want. In virtualization hosts for example, we want to use kexe=
c
> > to update the host kernel while virtual machine memory stays untouched.
> > When we add device assignment to the mix, we also need to ensure that
> > IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, w=
e
> > need to do the same for the PCI subsystem. If we want to kexec while an
> > SEV-SNP enabled virtual machine is running, we need to preserve the VM
> > context pages and physical memory. See "pkernfs: Persisting guest memor=
y
> > and kernel/device state safely across kexec" Linux Plumbers
> > Conference 2023 presentation for details:
> >
> >   https://lpc.events/event/17/contributions/1485/
> >
> > To start us on the journey to support all the use cases above, this pat=
ch
> > implements basic infrastructure to allow hand over of kernel state acro=
ss
> > kexec (Kexec HandOver, aka KHO). As a really simple example target, we =
use
> > memblock's reserve_mem.
> > With this patch set applied, memory that was reserved using "reserve_me=
m"
> > command line options remains intact after kexec and it is guaranteed to
> > reside at the same physical address.
>
> Nice work!
>
> One concern there is that using memblock to reserve memory as crashkernel=
=3D
> is not flexible. I worked on kdump years ago and one of the biggest pains
> of kdump is how much memory should be reserved with crashkernel=3D. And
> it is still a pain today.
>
> If we reserve more, that would mean more waste for the 1st kernel. If we
> reserve less, that would induce more OOM for the 2nd kernel.
>
> I'd suggest considering using CMA, where the "reserved" memory can be
> still reusable for other purposes, just that pages can be migrated out of=
 this
> reserved region on demand, that is, when loading a kexec kernel. Of cours=
e,
> we need to make sure they are not reused by what you want to preserve her=
e,
> e.g., IOMMU. So you might need additional work to make it work, but still=
 I
> believe this is the right direction.

This is exactly what scratch memory is used for. Unlike crashkernel=3D,
the entire scratch area is available to user applications as CMA, as
we know that no kernel-reserved memory will come from that area. This
doesn't work for crashkernel=3D, because in some cases, the user pages
might also need to be preserved in the crash dump. However, if user
pages are going to be discarded from the crash dump (as is done 99% of
the time), then it is better to also make it use CMA or ZONE_MOVABLE
and use only the memory occupied by the crash kernel and do not waste
any memory at all. We have an internal patch at Google that does this,
and I think it would be a good improvement for the upstream kernel to
carry as well.

Pasha

>
> Just my two cents.
>
> Thanks!

