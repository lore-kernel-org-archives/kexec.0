Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E225F3ED4A
	for <kexec@archiver.kernel.org>; Sun, 12 Apr 2026 00:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lmunf8hKp3UcnRXrvQgVK828HP0WXdYhEtCShztRC04=; b=rQC0AmTDEyQDvh/OHPj2GoLGvo
	uh3TN770uQcxUOIfrUD3TZpIlwu+sSuFVgXz+WcN4oaEeKVTlgwxEkJb+sVwaQB4CrNc9eo6NpJ7T
	KYL6chExZPeN8vIU7xsOdMOD0wCVP93daAxBaYjvn6IpxntKtkAOVVVy+d7AQwGYR02PjHbmLB8sd
	aJSVjEtiMSpD7ce2DTbps98M6cbsxFq76Q8PEvGUL/9+NIGzIiEwy90rde0wvF/R4uHqpqqk/RGUY
	KIgoHhVBVFMdaIaE5NHg7J6U8Unh00+LOpDcLq5JBz0qnRVNvu1aKAANCk8c8V5f/AKOUqLkVt53H
	9+ugCblg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBiT9-0000000DuOu-0gzJ;
	Sun, 12 Apr 2026 00:14:31 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBiT3-0000000DuOJ-3h1k
	for kexec@lists.infradead.org;
	Sun, 12 Apr 2026 00:14:27 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2b243198058so275715ad.1
        for <kexec@lists.infradead.org>; Sat, 11 Apr 2026 17:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775952864; x=1776557664; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lmunf8hKp3UcnRXrvQgVK828HP0WXdYhEtCShztRC04=;
        b=nsIJr17b88SZGyKPPiJYFco0VJw8dN2WrKsk3sCsqhcXPo1Cseuj9Q5KvCboq3XJ77
         SZjE52pxVRWcpSauiNCIFvBFABJ3fwD4yc+MDgr7sJQ4si8db0j65vZOsNjP4VstLw2A
         g2/5SDhVvkCwaYdEJaFTKDsJO5qAJJKb87ko4XHfL6y4UkmOGr4ScayIdHzF1q+E8blW
         6lgT5rzXUgMlscMfEy1V+odhJHQ49o6dxMwnhe+IaLPIB58jJsH6zAY5R7c4gjmQKyM/
         /bSG+rehVha1M3Wzd5uN5zBYnABSJhAXyu4+k5rs4TokTta4JnkDYCRMx5p33Javb7Hr
         KqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775952864; x=1776557664;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmunf8hKp3UcnRXrvQgVK828HP0WXdYhEtCShztRC04=;
        b=rBPOpphwc6SG36J4Nbl4sesYR7eBFn6mLiqeLRFGjUhzW1Qv/5AOB2aGaUUgkRvaGb
         x8Yis1TtOhgcQ12++3pIb4nclB/EqzcYtGSoxv/BRe90cNosndAlzA0N3yug/364bxvg
         TfFVRhVj7ZhL1EYf96PvcgRKjC8s4fz0TZYXzwzhzSKXWk84oQ9Hdrv6SpBWSCrXQ7uQ
         YA2TEtY2jPvnwwKOpSRAqp9DPRSV9GQuCIWww7HOMqqigYtrFGkM0HB33Nj2WVGF9x/B
         b0tp9EbGg7AlqK5dK6XPA/KM6mxiD6dInw/A8/N3h5GGHFjkygYUmvEKhqBi8bTD4DAR
         dgPA==
X-Forwarded-Encrypted: i=1; AFNElJ/jZyEgCRnMzlZKb8zNd21zHxvAhdb60oYLcPC1thJtl8AIOYOW15HeL1d45+i8hZTWbN4ZCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxMBj/oDFh1PflBa6ciaJXj9u8qAkwlf++tcVXr/hENSeQd8cgb
	APCTzwSldl5ijcXfgGnbgGtyWU6dGwXnwvwr8XM5Ja2UH3nmg3MNkfbIW3/EG4MDZg==
X-Gm-Gg: AeBDieusG5/ZUdtXVCaxEbzCyS1K0ydZjIF2LugZrZJHsr+C0KUaI2+Rbte0c44OG9R
	7RsjRzqKWyz2Y+ZRI4B/Z1UXTm30Ncw/B1htR1R+aJd77ZdRwdXglxQk2DHfwFPjbR1YextGJW4
	Ts464M+lLMCs4ynsvhGl32NDEv3cMc5jnHcBE6jWLbDMCYetMyV2N+hmVEDJq1eVJFYlpXDOGoq
	6ixd1SohYdcQPzUbn02viniGNZCt0Fi6dw7MEtXoj37nUShsSGa/5SUvxOpCZwajl9GaykzSW12
	fpmqc7dUr5nMhnlC625B0EqEwTbxenoFeuKUgO4Q2VQpWQIEdLUOzV7SSeBrMRuCeAK0bTO4eWV
	NjIHO1RX5zS5sWTq2BKLRjYCijF1Z8mC1nc18ewo7F75h/giNwEjbC8jp1mEl48sbITdBMqt6ws
	PNBnnJ0srzTXgVecHmwyPeMD9DCZFGwa6D3jmNR6PgiOoq73QS+Z8+ZGTNYQSwdhNKtXuEmGpDc
	oPKr8uzI245XTftw5NZUbdE9CgIMhYOrU5hFD7HbQvWMPZRniSLPRUR70VDicy1nYHro24K
X-Received: by 2002:a17:902:e785:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2b2c79eaf87mr10814865ad.6.1775952863560;
        Sat, 11 Apr 2026 17:14:23 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:3927:c82:6a08:f01a] ([2a00:79e0:2eb0:8:3927:c82:6a08:f01a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd7faasm70316735ad.26.2026.04.11.17.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 17:14:22 -0700 (PDT)
Date: Sat, 11 Apr 2026 17:14:21 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    "Andersen, Tycho" <Tycho.Andersen@amd.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Baolu Lu <baolu.lu@linux.intel.com>, David Hildenbrand <david@kernel.org>, 
    David Matlack <dmatlack@google.com>, 
    "Heyne, Maximillian" <mheyne@amazon.de>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from April 6, 2026
Message-ID: <82db97e1-791b-770a-ebea-0e364dbd08d7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260411_171425_953613_D0EE8799 
X-CRM114-Status: GOOD (  27.86  )
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
on Monday, April 6.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha noted that discussions happened between Luca, Jork, and Pratyush for 
LUO integration into systemd.  Luca had written a first attempt at 
integration and it required some changes for LUO.  It was also discussed 
that unit files that start the VMMs will include the session name in the 
unit file itself so at shutdown, systemd will know the sessions that are 
created.  There was no update on the timeline for this work, however, the 
next step was to start discussions with other systemd maintainers.

There was no update on the status of boot time performance optimizations 
like deferred struct page initialization.

----->o-----
Pratyush had no updates for HugeTLB preservation after being out of 
office; he thinks that the memfd selftest series is close to landing 
upstream, however.  He also updated offline that KHO patches to lift the 
limit on the maximum preservation order from folios has been in the mm 
tree for a while and should ideally land in the next merge window.  This 
work is a prerequisite for the HugeTLB preservation extension.

Pratyush is also working on a fallback allocation strategy for KHO when 
scratch runs out.  When walking the preservation bit maps, the goal is to 
find a big gap to fulfill the allocation; he had an initial patch series 
that works and is still iterating on it internally.  This is also going to 
be a prerequisite for HugeTLB preservation.

I provided the link to the Linux MM Alignment Session that was had on 
these HugeTLB topics if people were interested in watching the video.  
Pasha noted that the biggest takeaway from that session was the CMA 
limitation and supporting early boot HVO because KHO requires a struct 
page for every page that is being preserved early in boot, and this turns 
out to be incompatible with HVO.  These would need to be resolved to be 
fully compatible with upstream support.

----->o-----
David Matlack updated on VFIO v3 which was getting feedback upstream 
especially on PCI.  v4 will split this series into two with David posting 
the first series (PCI) and Vipin Sharma posting the second series (VFIO 
and selftests).  This will allow for faster iteration.

Pasha asked if the PCI changes are likely to be able to stay within the 
PCI subsystem itself or will it have broader scope.  David did not think 
we would need to change anything in struct device.  Pasha asked about the 
scenario where a host driver needs to be preserved, David said this would 
still be the struct for PCI device on top of the struct device driver; he 
was optimistic we would be able to come up with changes in PCI core 
without becoming overly broad.  The group wanted to fork off a separate 
discussion on non-FD related PCI drivers and how to support them in a 
generic way.

----->o-----
Samiullah updated on the status of the IOMMU persistence patch series, he 
was planning on the next series to be posted over the next week or week 
and a half.

----->o-----
Ackerley also updated on the status of guest_memfd HugeTLB support and 
indicated he was still working on the conversion support.  He suggested 
there will be an update over the next two weeks and was targeting final 
reviews by the end of April.

Pasha asked about current limitations in Ackerley's series, what features 
are needed as follow-up after his work is going to be done.  Vishal noted 
that there may be some memory error handling that would need to be 
extended.  Other than that, it was targeting full parity with HugeTLB.  
Vishal noted that direct map removal was under discussion upstream to 
support CVM use cases.

----->o-----
Vishal noted that Sagi was starting to look at KHO support for CVMs.  
Vishal asked about KVM page tables and the memory donated to the TDX 
module and, in the future, will also be used for ARM CC.  He asked for 
example of preservation of kernel owned memory.  David Matlack noted that 
IOMMU preserves page tables so we could look at Samiullah's patches.  
Pasha noted that if memory is going to be preserved then it has to be 
pinned.  The consensus of the group was to get started with guest_memfd 
preservation and then to add support for CVM use cases on top of that.

----->o-----
Next meeting will be on Monday, April 20 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - systemd integration for LUO, socializing the design ideas with other
   systemd maintainers
 - any progress for KHO optimizations for boot time performance including
   initialization of memblock list and deferred struct page initialization
 - HugeTLB preservation support including selftests and fallback
   allocation strategy
 - VFIO v4 patch series status, separated between PCI and VFIO+selftests
 - IOMMU persistence patch series status
 - Maximillian: supporting CRIU with KHO by using memfd to store the
   state of a process, moving mmemory from a process to memfd
 - guest_memfd HugeTLB enlightenment: conversion support, HugeTLB support
   without restructuring, and HugeTLB support with restructuring
 - KHO support for Confidential VMs including page table preservation and
   pinning
 - later: versioning support for luod to negotiate
 - later: KHO enlightenment for ASI

Please let me know if you'd like to propose additional topics for
discussion, thank you!

