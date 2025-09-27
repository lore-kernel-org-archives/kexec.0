Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BCDCAC5B8
	for <kexec@archiver.kernel.org>; Sat, 27 Sep 2025 20:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9iKX971Yzh+vTHTZnyNwti+PFyVkjEP/KuLLQvtNxsU=; b=f+TTN88vf/8VrLoxNhSPcoIdY5
	/x4YxOJaHDBKazIAnVMs+OTHAYyfBLAEPikGzW53qdL/mmIjto5dy6Ls362Yt7pHCOkP1hsE1tnwe
	YXD3PNffNJuTgheKEJbuVwJIpEY3eCnXy8nvVb9dLlZ3VPWq5ylDT7tJ3RcVlg2QPDKmFnKwyk/OU
	hGxzpcYNxvNnBIYBMyQM1BrtWVze5hMHRYtmBVrHV9mby3CpuuWme2BQTNshCuqMbFtjo3gpkOICC
	sJjp8o8HI3iYvxeAuS/rW4i9qY0AvACj8pM5SW0z20tbO1KWvu6+0XaJL5ZzcXDZfRHeSKbpRDYKV
	OFom25uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2bVp-0000000CLW1-1eyd;
	Sat, 27 Sep 2025 20:27:21 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2bVl-0000000CLT9-3bkE
	for kexec@lists.infradead.org;
	Sat, 27 Sep 2025 20:27:19 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so1297913e0c.2
        for <kexec@lists.infradead.org>; Sat, 27 Sep 2025 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759004836; x=1759609636; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iKX971Yzh+vTHTZnyNwti+PFyVkjEP/KuLLQvtNxsU=;
        b=XhUrJxOlfP+v9p+PuCJl2j6H443LptBrlVOJtsGcCA/OJO49UXQozh6ppHqCGiiKgq
         rxEHoGOOaX7RK5Yh65S0WowiIQzmN2CC2F3br/hClgAG639knik29Yq5iD8olIuisjyC
         LrhqEZmj7vtNjzju50z/J2vGAV+WuaXjJAqSGSw3fOlZ56mLki25eRgE0p4bCi+O3H1C
         e5rm38t177Qasy0Fdx9RrhqlQdVkwdzq7h4PIl5AD/Rp40CDv3KXRpqDgij+3oxr8SkF
         2YSOCTrSdzJXLnfk/UWqSxIo9JnyX6M4PytjkD+wDzC226MY3tY64Nkb7QJcixO1QYP3
         bw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759004836; x=1759609636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iKX971Yzh+vTHTZnyNwti+PFyVkjEP/KuLLQvtNxsU=;
        b=UIlZczxavs4HAYxpT8uuSvu/8MLFI7tDr4LVF6EN6kLU1l/dSTnUJw5NMzJecATnBj
         WfWr0RDAfuplWuDZf2S8sPSb9MCnIzc/j6PQAFwPNODZYt4qDYlHteesERStPqZXUNvz
         CEx5BsW6lkg2L+ugotykvpKL8dbKw+eV0FJKT953KKyS+ZWgHjM4cOI/60Y9tnYwRn2w
         dYCKYB0sl8ATBGzo8o42qUS+sK7/wScf2UZIgit0gN4jb0uOTEeSeQfrNd0WBG7hL8Pu
         ruzbIh3e0X0y5SwWj92QWelhDt5h0gltTW/lP+0leIxZqQCdx0xTbBM/XrasYaaRdbau
         eMpg==
X-Forwarded-Encrypted: i=1; AJvYcCWUFMFc54OpVyJF4WnN6t0IOkLo7P7b0/XUMjSvcYHZoApA/fy8PNBa7h4cDxsB5UHncdFo5Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwTQmEtV7awkan19K363t0SLUAodC/sdJuzTOpykGMoXvZUMG7o
	4eRqjaSCGXUoCBS4zcufgfnDuPxgXhZbmk26mm/fWtdo3vR2Tjw6j066Pq1yatdNhm3jV0iD/Cj
	0dBc2aCth6Brp+9wZdQHGIoaJyoFk/IA=
X-Gm-Gg: ASbGncs/sfYAtCZuvvoaCV2jZHvp8NRwQ6f6OJJKKmmnE4ZEAQ5wfQngr8a8zgbPA5j
	+8HKxr445V8RpFVlkbzkcsMBrJWPShWycKW7SSSOQO9tNnLcbRWJTNxZZrUmTrPoUp+/EeLmm7W
	FrniZLOb/dTU35bonrk374LJgDJCuqPV11owxlPVA0+FBWSha1tzj/6r3GN5/KRkHtBFVdGQjFc
	DOXixDrkr1g8VayJX5M8FzVIzj2Aqmv3f4h0M2u
X-Google-Smtp-Source: AGHT+IFl7dzGGOpBRgseA/NydkGTFZOWYjWGRoA+aFytHMvygeb0WWmRJxaS+K8TrsIzykl6wViA3ZMadBOP3gnRlPQ=
X-Received: by 2002:a05:6122:202a:b0:54a:a782:47c5 with SMTP id
 71dfb90a1353d-54bea37dc27mr4953333e0c.15.1759004836452; Sat, 27 Sep 2025
 13:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <aNZWTB_AbK1qtacy@kernel.org>
In-Reply-To: <aNZWTB_AbK1qtacy@kernel.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 27 Sep 2025 13:27:04 -0700
X-Gm-Features: AS18NWAh5kZoQgB4hGz8PTAEfvsQyei1Zk5nXGW3DAd6TlCiQepkU5cVpkemP2Q
Message-ID: <CAM_iQpWBHWscTbuUm54G3tvqf-EQhSYaFJqEJD4M73doeH=TKQ@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250927_132717_911034_E57B95C6 
X-CRM114-Status: GOOD (  28.34  )
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

On Fri, Sep 26, 2025 at 2:01=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > This patch series introduces multikernel architecture support, enabling
> > multiple independent kernel instances to coexist and communicate on a
> > single physical machine. Each kernel instance can run on dedicated CPU
> > cores while sharing the underlying hardware resources.
> >
> > The multikernel architecture provides several key benefits:
> > - Improved fault isolation between different workloads
> > - Enhanced security through kernel-level separation
> > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > - Potential zero-down kernel update with KHO (Kernel Hand Over)
>
> This list is like asking AI to list benefits, or like the whole cover
> letter has that type of feel.

Sorry for giving you that feeling. Please let me know how I can
improve it for you.

>
> I'd probably work on benchmarks and other types of tests that can
> deliver comparative figures, and show data that addresses workloads
> with KVM, namespaces/cgroups and this, reflecting these qualities.

Sure, I think performance comes after usability, not vice versa.


>
> E.g. consider "Enhanced security through kernel-level separation".
> It's a pre-existing feature probably since dawn of time. Any new layer
> makes obviously more complex version "kernel-level separation". You'd
> had to prove that this even more complex version is more secure than
> pre-existing science.

Apologize for this. Do you mind explaining why this is more complex
than the KVM/Qemu/vhost/virtio/VDPA stack?

>
> kexec and its various corner cases and how this patch set addresses
> them is the part where I'm most lost.

Sorry for that. I will post Youtube videos to explain kexec in detail,
please follow our Youtube channel if you are interested. (I don't
want to post a link here in case people think I am promoting my
own interest, please email me privately.)

>
> If I look at one of multikernel distros (I don't know any other
> tbh) that I know it's really VT-d and that type of hardware
> enforcement that make Qubes shine:
>
> https://www.qubes-os.org/
>
> That said, I did not look how/if this is using CPU virtualization
> features as part of the solution, so correct me if I'm wrong.

Qubes OS is based on Xen:
https://en.wikipedia.org/wiki/Qubes_OS

>
> I'm not entirely sure whether this is aimed to be alternative to
> namespaces/cgroups or vms but more in the direction of Solaris Zones
> would be imho better alternative at least for containers because
> it saves the overhead of an extra kernel. There's also a patch set
> for this:
>
> https://lwn.net/Articles/780364/?ref=3Dalian.info

Solaris Zones also share a single kernel. Or maybe I guess
you meant Kernel Zones? Isn't it a justification for our multikernel
approach for Linux? :-)

BTW, it is less flexible since it completely isolates kernels
without inter-kernel communication. With our design, you can
still choose not to use inter-kernel IPI's, which turns dynamic
into static.

>
> VM barrier combined with IOMMU is pretty strong and hardware
> enforced, and with polished configuration it can be fairly
> performant (e.g. via page cache bypass and stuff like that)
> so really the overhead that this is fighting against is
> context switch overhead.
>
> In security I don't believe this has any realistic chances to
> win over VMs and IOMMU...

I appreciate you sharing your opinions. I hope my information
helps.

Regards,
Cong Wang

