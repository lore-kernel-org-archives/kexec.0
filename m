Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2473C02198
	for <kexec@archiver.kernel.org>; Sat,  8 Feb 2025 23:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HLLi9zQ99OQKa4jeeM1uEjERWUaiY/XgjD2LAy4mnqo=; b=YLNJtPxwW3UeZou+g2LuwVhbdy
	0BrMVFtGZp71R3PVyt8Pe/rU+XJ8c3ToYWq0vmyZ1CfdVizCVbqxx4WgiHTlp/0z6sTm4AMnc7NwK
	VhNxGyTIO+yNYk5Qcf6H9QmPcQypGJpnmJojNyXATGH+4aLuc7f3l0Uc7d9t9bhN/zCHZeuvI66TE
	RlokXlTFugmi62pyfR9S+cmhz98eYaah2WfbeyJ7xAGSYBfDC0n5Fz1YVtKnT807wY6dNy0xw10yL
	qWY7LVRkcm8sFf0q9mIZonE9E1SoSHaX1QynYz5o4+jArTwHxYm8Kkp36NSkDxRiHbbVxNUvKC/RS
	Af+fnreA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tguQ5-0000000DjOh-3H5A;
	Sat, 08 Feb 2025 23:39:29 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tguQ3-0000000DjO8-0mLO;
	Sat, 08 Feb 2025 23:39:28 +0000
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4ba7a9c17c0so1597223137.0;
        Sat, 08 Feb 2025 15:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739057965; x=1739662765; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLLi9zQ99OQKa4jeeM1uEjERWUaiY/XgjD2LAy4mnqo=;
        b=CSpYY9ONx86YJMwnOoi1YpfMnHXzZH55dUKHDcc+S7XsOeuJZC7AmOL4fkau03q3vT
         0g7KrnSosOGaBGN/BsJrOuXuI8J06R/swZ4H65Cg7lhHMmxqIA1bCzK9oZ5jsO3GaWmg
         A/ASNnLVj5y1esk5gXZXvx6EEKAnwjHF9ta0lAfINaH66XxHUGNYNL6XL6+pIuxY4CxR
         +rDaqVdSnmpL12aEX0cJsVj9U2ZVhhtezYcH0cHGyB84E+gdCQ9qiUyW131hY+ABbYg7
         ctjG9ilaBDwY/ZEbRJibCsBL9PaD9RdwMulcgSYliAtoIDLZmw2Yr5+tG/ge1hrxaXaM
         49LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739057965; x=1739662765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLLi9zQ99OQKa4jeeM1uEjERWUaiY/XgjD2LAy4mnqo=;
        b=gTiN9hq7usWB8IKi8d5QB4kyzda7UMm8JrIrPvyijaPW4Ne5u7vzwv+hyaFiCWCYnX
         4DXSpg7hkRmKWyLLMo0gqYFV7qpKdPzHia4GL0uvITPujKKbChvxjmVKbJJdy5QegJPc
         7HKM7vU7dNfEn7Ab4qubxETJBa77OT+xhTtQY/3Md+TeYPVpmdtCpUHZtH9xmXJy9g8G
         eYi0TPEA9cNoX9J4pvdCV28CY+73ligYNkoRV3dMNdQU6cB1Dg+1Lkzf9xe2gusRd5V+
         qDWufCJ3YqBuwin4B7eR6wYixlR5N8lOL1PfWJ0Uv1ShNcCiEWdvrYDQ/nvcFCYxfN2p
         lFwA==
X-Forwarded-Encrypted: i=1; AJvYcCVuJQlRe4AF0UBoj0dF1i3psHsNPD5y8uR3THwivJKmT2KrBpbqZTZD7FflcMBRzBQ5jKTBmA==@lists.infradead.org, AJvYcCVvGx744MKDI4DL7WudzsFXX6C3f5j5ZobQgfY++Ao1NL9oGsapgBmlQnoz/ng1PaOU5MzImU+3Js5XWFHghTqXoQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZtP+tEXuVtdrR+pEv7edUfzT0XNoSLPdhdf9QlSJaSonJVqxr
	w6ObqlV7vz4MtvrqvIlmz3UTxbyIl6ouWax45c8HS3wE8dcMDxxeBtadgN/V38kEqsO03V9NOLI
	7RTImm4Kb70/g5JqN2sRtFuy77C0=
X-Gm-Gg: ASbGnctS/B1JoV2wB8h+IjZBjhPpMxl9R/uEEKDqy6ufGkLeO2VUwM40DNbFyaN4gAt
	T/ZRR06wNVcj4WMCjTab0DmVnpCZm8u4Zk4HHbYtDpM0K2QhLOLucoWJaVwTA7r6/3k/NtRUA+6
	8Uz6ooCI4nihyYcaZGVRlaHrcC+POygA==
X-Google-Smtp-Source: AGHT+IHmuA9yI8oIa2KsmkgQWv2DRmFgZtiHlP+mcm3z0bsdHAAi0IXmrnafXkrbEDLixwCrvDHR7uvtSxfCF6dSkfY=
X-Received: by 2002:a05:6102:548a:b0:4b3:fee3:2820 with SMTP id
 ada2fe7eead31-4ba8714179fmr4328252137.9.1739057965418; Sat, 08 Feb 2025
 15:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org>
In-Reply-To: <20250206132754.2596694-1-rppt@kernel.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 8 Feb 2025 15:39:14 -0800
X-Gm-Features: AWEUYZmi8qx_aJGxEbGM8RQjVoiD2zsmGiS4HbL5u3CyG-yT-ostr9_GwuABT9M
Message-ID: <CAM_iQpU9DDg2Oi33_dfPqVpd9j_2O+WD7ovo__f48BA9DztwXQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250208_153927_296658_5C5A0DAD 
X-CRM114-Status: GOOD (  28.35  )
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

Hi Mike,

On Thu, Feb 6, 2025 at 5:28=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Hi,
>
> This a next version of Alex's "kexec: Allow preservation of ftrace buffer=
s"
> series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com)=
,
> just to make things simpler instead of ftrace we decided to preserve
> "reserve_mem" regions.
>
> The patches are also available in git:
> https://git.kernel.org/rppt/h/kho/v4
>
>
> Kexec today considers itself purely a boot loader: When we enter the new
> kernel, any state the previous kernel left behind is irrelevant and the
> new kernel reinitializes the system.
>
> However, there are use cases where this mode of operation is not what we
> actually want. In virtualization hosts for example, we want to use kexec
> to update the host kernel while virtual machine memory stays untouched.
> When we add device assignment to the mix, we also need to ensure that
> IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, we
> need to do the same for the PCI subsystem. If we want to kexec while an
> SEV-SNP enabled virtual machine is running, we need to preserve the VM
> context pages and physical memory. See "pkernfs: Persisting guest memory
> and kernel/device state safely across kexec" Linux Plumbers
> Conference 2023 presentation for details:
>
>   https://lpc.events/event/17/contributions/1485/
>
> To start us on the journey to support all the use cases above, this patch
> implements basic infrastructure to allow hand over of kernel state across
> kexec (Kexec HandOver, aka KHO). As a really simple example target, we us=
e
> memblock's reserve_mem.
> With this patch set applied, memory that was reserved using "reserve_mem"
> command line options remains intact after kexec and it is guaranteed to
> reside at the same physical address.

Nice work!

One concern there is that using memblock to reserve memory as crashkernel=
=3D
is not flexible. I worked on kdump years ago and one of the biggest pains
of kdump is how much memory should be reserved with crashkernel=3D. And
it is still a pain today.

If we reserve more, that would mean more waste for the 1st kernel. If we
reserve less, that would induce more OOM for the 2nd kernel.

I'd suggest considering using CMA, where the "reserved" memory can be
still reusable for other purposes, just that pages can be migrated out of t=
his
reserved region on demand, that is, when loading a kexec kernel. Of course,
we need to make sure they are not reused by what you want to preserve here,
e.g., IOMMU. So you might need additional work to make it work, but still I
believe this is the right direction.

Just my two cents.

Thanks!

