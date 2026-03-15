Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DE510854B6
	for <kexec@archiver.kernel.org>; Sun, 15 Mar 2026 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=breDgvR98s/9To7zMmpKVC/JH/4VMjY7A6WXWrwfXbg=; b=KQsA2ukMwre/muASoZcgFm1vc7
	4ydrDNz60lzFb45npuGnsMUw08sRJqzi/7V2j173tbbQLvk8niK5GxrqSaQHPssS9enHHFUDFgfJR
	gWTl2eTHrkGgiyflfAZYdCN9EwqO0zL2h4eePjKoLtjSfNteOwX69oAeRiXmNhp7Ktc1jmCeivsI1
	tlMX06rWDecBq45nbKPuY6UrC2ithWuKDs3XyPjyE0J7TlazpMhJlV9TpDAFOZEvfoE+BOEIjXLLz
	JQ6OXAxTfkFCZ0/DbTVKlmAzfXTvNsiXVmchWnAM6w4Oi6/0mq6iZPCQc4+hwR0dDToCElO0tC8Fg
	2/XKzGZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1ZwB-00000002Hjr-13rx;
	Sun, 15 Mar 2026 01:06:35 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1Zw8-00000002HjV-2OVT
	for kexec@lists.infradead.org;
	Sun, 15 Mar 2026 01:06:33 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2aeab6ff148so56955ad.1
        for <kexec@lists.infradead.org>; Sat, 14 Mar 2026 18:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773536791; x=1774141591; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=breDgvR98s/9To7zMmpKVC/JH/4VMjY7A6WXWrwfXbg=;
        b=YawjKyb5Cm9W/LObnqsYV6jo1UWFWfO1LmKbYll6MKeLKuK0Zh7mzjv19dKdPyT7qU
         xanjf0QmxWes5kUp+R3eety1h6M+qzYV98CvYp7E6fu/dq4+16SQSFK5ZY37s0pX5Jmi
         Bqc9a0hoQDot9t9OwHjza6f+XQgiZzZBOqhVT1PX2Q2s+y2jSXEqscoM4tDhnq9Q8eSM
         gN3z5AAihQDgzPCn92y3FgohCIGcl6dtlhHo56pV8Lef3pkc6k+kbiz2dTWxd9r4GsHK
         eLpMzSydNPpW1i8CrSeikmiTJ+mauqsara63vh51FplGqru7aJjPx0WOJ2cOlKCD3BgG
         5pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773536791; x=1774141591;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=breDgvR98s/9To7zMmpKVC/JH/4VMjY7A6WXWrwfXbg=;
        b=g5WjT1C4/I3hPG2uI0aeeYWUGlo//gkppzH0mGIzkdet3i6VknvYwbw0bcqQjm00wY
         KXyhgRG/zAeeq2s8hsRdvla34yY1h0QsyKBu5pcT7JauEVUubGUPamLMMytUar1+JH3q
         Q5qFd14z0oOkyd9AOSHJiJ/5UoWutf4SsYWA/UAAFRYk/oLSBDaU37Z5msWsqXsCrOaS
         YLa5btKiht1K8JaxCVY5o1cUoqZA/1NlykyAm90tYXJGaoftRwi3hdnaDdtxHuR38WjH
         z3i7KAkkvlg9EXbs84qXAjy0auDwVDoprzvSYfI0vg2711oal55KwlkE/XPAWghvHBeZ
         4TRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7ogBENjkHyK77+6j8+IGvM9UcQbCkCKtqvttP0N5+bU2r9fTwM5ccV2iNQh3Gyu69Qtzj2g==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywe0hHrcOgiQl2/hiLH312aZHDwfxKbB3xr8uwqo1CqUz6IjWNe
	O9PNYe1q/iyIwIN+DI1EItpnRGBXHznCqclJ8baF46pWPiyfodptTmmfymeZ8SHyKw==
X-Gm-Gg: ATEYQzwrkZ2x3+GIgrJWSXjgTNaiuqztGzD4gRIzpuKDh7ZJ/jM4VisUKWRHPSLimaU
	RtyVgZFm7E36H29LYt95/8P3Cc4EmpNoADUX0e1UHqJESmALFS1X9kJBxAIT0JXAlP62PeljcP9
	qxeFlsBcGoQ3SNB8S3a0xXmXdWN/MD2rjXasxZbcFHSI1ew1IvJUvYvH13qsqm6/wcO75ZLAWE8
	DrNOUynqm54AWTMjFfHveCFD+b7lrgt2XcKTHcV0qVctl3GdjxK3FwQ4eRrWk3TUWqLGXTTTq5H
	eRv17pW1zo/MuOqT2ttdNnHuyxIgBiOFd6bj6dtBY+6Glky/qdw/BFZSAoCtZSjXAPEY5kpNUE2
	lxtgOBcuX4n4HpDrRoL1ROiwdlsnFbAYVtMH3zOg+2Dg2c6ALyBgkAOCIcZ62kKdzAkWDXFcQve
	zFG7nPHm8u1KIKQ5uCfXXfn7Wp8KqeASqhQbABGJXjinwR8SeJ7xnOCRDcYvqvhPOfcCDyPWzoJ
	Yqh75ZsS74CIyE6I9O5blLql/VtS1yEaZNQJ9XClvnj1NOB4o93NQ==
X-Received: by 2002:a17:902:e849:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2b042087e19mr2365515ad.6.1773536790052;
        Sat, 14 Mar 2026 18:06:30 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:f531:45b8:548c:e004] ([2a00:79e0:2eb0:8:f531:45b8:548c:e004])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07287ef8sm10728741b3a.29.2026.03.14.18.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 18:06:28 -0700 (PDT)
Date: Sat, 14 Mar 2026 18:06:28 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    "Andersen, Tycho" <Tycho.Andersen@amd.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Baolu Lu <baolu.lu@linux.intel.com>, David Hildenbrand <david@kernel.org>, 
    David Matlack <dmatlack@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from March 9, 2026
Message-ID: <2c094579-77d8-7de1-0a49-9138aeb69e84@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260314_180632_671729_AE885A17 
X-CRM114-Status: GOOD (  25.85  )
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

Hi everybody,

Here are the notes from the last Hypervisor Live Update call that happened 
on Monday, March 9.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha updated on stateless KHO: it's now in Andrew's tree and ready to go 
for the next merge window.  He noted that deferred struct page 
initialization was being worked on as a next step and then attention will 
shift to optimizing start up performance.  We want to make sure KHO is not 
the long pole.

Pratyush noted that there is a weird interaction between HVO, sparse init, 
and KHO.  HugeTLB pages must be allocated before sparse init but when in 
KHO boot we are in scratch only which wouldn't allow for allocating such 
large amounts of memory.  Pasha noted that there is an exception available 
where we can ensure that memory is coming from the preserved tree.  
Pratyush said we should parse the bitmaps and make the memblock 
reservations but we don't set the order in struct page, then turn off 
scratch and do the hugepage allocation and then parse the bitmap again to 
set the orders.

----->o-----
We briefly talked about KHO enlightenment for ASI which wasn't deemed to 
be super urgent.  ASI can be merged without KHO enlightenment so this 
could be a later extension.

----->o-----
Pasha noted that he received some comments from Pratyush on the luod 
design[1] that he would be iterating through.  We welcomed anybody else to 
continue to provide feedback as well directly on the doc.  Pasha discussed 
with Jork and there will be a three-way meeting that will determine what 
the intercept will be with systemd.

We discussed versioning support and when the timelines for landing the 
support would be.  Pasha suggested that we would need this when we start 
making strong guarantees about supporting live update from version to 
version.  Pratyush was working on HugeTLB preservation support ahead of 
this.

----->o-----
Pratyush updated on HugeTLB preservation support and how it would be split 
into multiple parts.  Part one is selftests that he sent out to the 
mailing list for review.  He is currently blocked on the ordering issue 
mentioned above.  Pratyush suggested upstream code review from upstream 
HugeTLB experts would be very useful on the list.  We discussed handling 
this at the next Linux MM Alignment Session on Wednesday, March 18.

----->o-----
David Matlack is prepping v3 of the VFIO support.  He was working on 
preserving VFIO file descriptors but not preserving a lot of the device 
state itself.  A question arose upstream about userspace being aware that 
we're in this development phase where files are preserved but not 
everything on the device is preserved.  He didn't see a long-term need for 
a UAPI that expresses that it's saving bits and pieces of a device or 
letting userspace control what the kernel preserves and what it does not 
preseve.  He was thinking of doing this under CONFIG_EXPERIMENTAL.

----->o-----
Sami received some feedback for IOMMU persistence but otherwise no major 
updates.  There were some patches sent from Intel that would be a small 
dependency for hitless replacement that Sami is looking at.

----->o-----
Pasha brought up plans for the next steps for live update while keeping 
CPUs running through the reboot, which will be a long-term discussion.  
This will need to involve KVM folks in the upstream discussion.  Jason 
said it would be very useful to demonstrate kexec live update with a very 
simple VM with no VFIO.  David suggested a KVM selftest would be useful 
for this type of demo.

----->o-----
Next meeting will be on Monday, March 23 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - luod design feedback and intersection with systemd; implementation and
   next steps
 - improving KHO and boot time performance, including deferred struct page
   initialization
 - HugeTLB preservation support including selftests
   + debrief discussion from Linux MM Alignment Session
 - VFIO patch series review from the list 
 - phase 1 of IOMMU persistence patch series, then phase 2 status and
   updates
 - hitless replacement for iommu domains and patches from Intel
 - guest_memfd HugeTLB enlightenment: conversion support, HugeTLB support
   without restructuring, and HugeTLB support with restructuring
 - later: versioning support for luod to negotiate
 - later: ordering issues when disabling interrupts based on feedback from
   Nvidia
 - later: update on PCI preservation series and next steps
 - later: KHO enlightenment for ASI

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://tinyurl.com/luoddesign

