Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C4610D148A
	for <kexec@archiver.kernel.org>; Sun, 29 Mar 2026 01:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4NsleX9u5aPhbjAVr0Nezc/nBr+cao/tGbHhc5N7BqY=; b=0i/g9vdQaaG/ySedKDTHFkO9xL
	mfrwGYADCoS3qzVzTuUf6pBrKUl+L+uCAeVjPlVZVVw8uJ7WA3LGG4GaYl4dgl5SVB/3OLKx0u0Q6
	0WI2Cre3dwk0v/UPyvUBUzpSO810IfLMCLDCe4ph+Tux45snN7yCVydiy1+Y3fGB1qMH2RHt6fpdD
	Sq04Hu4J0ijH1qilvE+PjK7bieQC4i/UTm35GbCxybl0Soj7MFmEW72R/MJ1LfMDQBbcpsD+EF+A+
	v2aNIreJM27Rc913gMO7OBHuPuCt7WK7OGg0wW179LNmDQi/z+N4N4dnzwrG/XwnN9lpaAguG+RpH
	eECM8DJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6eZ4-00000009Rdw-3Arj;
	Sun, 29 Mar 2026 01:03:42 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6eYy-00000009RdZ-1rDJ
	for kexec@lists.infradead.org;
	Sun, 29 Mar 2026 01:03:37 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2b0b260d309so56585ad.1
        for <kexec@lists.infradead.org>; Sat, 28 Mar 2026 18:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774746214; x=1775351014; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4NsleX9u5aPhbjAVr0Nezc/nBr+cao/tGbHhc5N7BqY=;
        b=TnmxYRobvTrPGJIPbwCi53TUKHtYW03he9BarwSMEh9ByAMAEi31zmKPoNov2EEvo7
         d3e98OPJN7m2YRjHGWtgGVNT7Cn6zifaLUUw3Br0RL/Fbi0sp3rEg3M1CS3GQRG3s3/4
         WbJdz8PmSnEY2Q0UJn0vLrzHyxGPdNo1E9Fp1Qt90lbz8q30LvKQSBv7VLtHqJ5YIrcr
         VGEn6vZw7PzNwXYGwU7U55csiTKZec+MQDjvDD9akJGlNw3o0ouqb947eh0hl3D3es8O
         QemalPuspcHwr6kR9/a3ugYY8TuGD4sf1L03xclLk28iCTuoNdseHO/KLsXi7hnMQYtw
         cO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774746214; x=1775351014;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NsleX9u5aPhbjAVr0Nezc/nBr+cao/tGbHhc5N7BqY=;
        b=L2gydZavaySJdoRXjkmbV0mMyPv9lCB6bUfI1GkysJ2TAn0WnwLIpW+Wj8alqsQ2D9
         CobEE2UupuA3nr3qjQU9k9SrHWGeg/fgBnMFnpXOvBTjEgipTQkFPQm4wwh9tn6YeogQ
         LKhW8H+x4KBBoiCUtwOLA4NM65kE1L4HmBH4j8Sq2k7vqqZbINDm39bgwnUMfHOWB/Y8
         gxD7mcUt6HSPACTlOqwgI4CzNwF2938N7BMnZ7ABI5c/SuAkjRelhT5gG3s0WI9tVe6k
         qk4FrulA6JxYt397LiCP+aXlq2S+IWg9J99X7tIk4BOLdm0BM1VeOsRmQK/CJL/RDer+
         O4WA==
X-Forwarded-Encrypted: i=1; AJvYcCXfG4buydfOA+VeFXNLUi+gPsnCVvbp3qGUiWrYs7PteCwZQClUITD9PaKVrXH4im63c0wi2Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxDzhlIoQLPjTeLyzkgdzNbUpvGWl9mjhC7EhnqalOUEhkoptfy
	NRC+aig20NMmSNQzKtxn3smzZhV53fvafuy4HJcX+NDki36s7SRhU3oXrVWOx/+oVA==
X-Gm-Gg: ATEYQzxGflbgxCKIO0qgV8jfQBwpm+4yFAo8cnzj0qSLV3/PzU4qJtviVI5x2TJAGs2
	fGhj5Rf8urbSgdYefWcYXJRp8fSMgXOnAAhnnFe9dsbDiPzEFCRQ4i51ellpnvrhGv3gmcdk436
	MGPpiTR4acNk/Iegnm8o5zfp9UEocgtamvZ3BhXwCneHE5NSRTVr5eOTsRd1WdIofjD2WWU+bZn
	499zbzfrHcvbIWekhKh7iFyy5+qWx5Xys7Bz9OZeOjiOClfiOZD6NH20NFLmFL8s8USGL6085dC
	OmxHfP6V86xEIH/G7xbCUxkJpVqx26DfvFIrmgCFzioaOwuls4HbS7y07UETAXHNJY+N1ukMMcs
	9aWZ4Dv2v7Vjf/vMhb3WZrA0PPUAtLyDvAP5YWJYpc8m77qNmgSdLPc5VfZP8D5AgcN2hSlm5fI
	5NRP9x7Vq8JFXHOZ77Mfsm2G9/6nnMbIDKvjC5cyS0KD32DIkBs1PQ8Jj25HejiYyKoH8u1V5dy
	0J7714DHfzhNmk0d5Bp2H3Gqk1NvzoWw3Na5mTCmA4dRzfe4I4mEQ==
X-Received: by 2002:a17:903:15cf:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2b242ceb47cmr1976585ad.19.1774746213717;
        Sat, 28 Mar 2026 18:03:33 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:a947:3e4f:679c:4c03] ([2a00:79e0:2eb0:8:a947:3e4f:679c:4c03])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843d8e5sm3682786b3a.5.2026.03.28.18.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 18:03:32 -0700 (PDT)
Date: Sat, 28 Mar 2026 18:03:31 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from March 23, 2026
Message-ID: <d07decf3-bd88-0ebc-1aeb-f91545318d3f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260328_180336_518432_8C2B25A6 
X-CRM114-Status: GOOD (  26.87  )
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
on Monday, March 23.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha updated on the status of luod and a good conversation with Luca who 
is interested in integration.  Luca had proposed to do it in phases with 
the first phase being support for systemd logging during shutdown when 
devices are unmounted.  Luod will require preserving the logs and passing 
them to the next kernel and next systemd.  He was also interested in the 
next LPC discussion on the topic.

Pasha also updated that there are new tabs added to the design doc[1], 
this will be expanded for systemd and its communication channel.  The plan 
is to have 100% integration into systemd.

Jork Loeser noted in his discussions that systemd was very adamant about 
supporting fd store and asked to what extent we need multiple sessions per 
service.  This would include the LUO client interface as well.  Pasha 
noted there were discussions on how many files per session we can save, 
for example, and added a limits tab to the design doc.  Right now, it's 
about 128 files and a thousand sessions.  In the future, the file and 
session count limits should be removed entirely.  Jork was asking about 
whether systemd should expose an interface to the clients where the yget 
explicitly tied and create multiple sessions, or whether the interface was 
just fd store.  Pasha said the plan was that systemd would expose the 
sessions interface so clients can create new sessions.

Pasha said next steps include getting the design ready and then the first 
implementation for systemd logging.  The latter would be implemented 
before the next LPC.

----->o-----
We chatted about deferred struct page initialization.  The patches are not 
yet ready to be merged so we would follow up next time.

Pasha noted that Pratyush and Jork had discussed scalability of memblock 
reservations.  Jork said a couple approaches were discussed one of which 
is to move the quadratic initialization or setup of the memblock list to 
be linear.  This would allow us to interate over the struct pages as well 
as the KHO tree to avoid restoring the memblock list.  There was also an 
idea to side-step the memblock entirely and to use the buddy allocator.

Pasha asked about the proposed changes to the radix tree: if we move the 
order then the bit in the bitmap at the leaf levels would not represent 
the order size but rather represent the page size.  So the memory overhead 
could be much larger.

Pasha suggested allowing the scratch areas to grow when needed by finding 
the biggest hole in the radix tree, this could help to solve some 
scalability problems.

----->o-----
David Matlack updated on VFIO v3 which is pretty much done and is going 
through final testing for posting this week.  v4 should include a roadmap 
for what comes next.  Starting at v4, the series may get split into two: 
PCI patches are growing so it may make sense to split PCI and VFIO 
patches.  Most of the code is behind config options that should help with 
merging as well as the new documentation that should also move this along.

----->o-----
Samiullah updated on IOMMU persistence: his series is getting reviews 
upstream.  He's preparing for the next verison of the series.  There was 
no update on the hitless replacement, this would be worked on next.  There 
was a comment that we should standardize on naming in the tree between LU 
shorthand and using liveupdate as a single word.

----->o-----
Ackerley updated on the UAPI for guest_memfd HugeTLB enligthenment, he is 
still working on the conversion support.  That work is pushing out into 
April.

----->o-----
Next meeting will be on Monday, April 6 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - luod design feedback and intersection with systemd; implementation and
   next steps
 - KHO optimizations for boot time performance including initialization of
   memblock list and deferred struct page initialization
 - HugeTLB preservation support including selftests
   + debrief discussion from Linux MM Alignment Session
 - VFIO v3 patch series posting to the list and roadmap for v4
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

