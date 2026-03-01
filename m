Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A1FD0045
	for <kexec@archiver.kernel.org>; Sun,  1 Mar 2026 01:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ep1r+TxTVXsjleXDRELngb1lJHdD0DP3WlzMub74vCE=; b=Ug7vrxkYWZ4cchB+du8YJ3BygO
	NhR3YHQa9MkizogKGp+i7X2EwKahKF8vfV3WSo8xAb2tMQSJCounou/SU4dQIOZHrGNUZuQT767WQ
	l7uYg2DLqC+fMwlwXxIIE8JsmyM4lJ7yGU6uDkaN+ws/41/0Yx7fePPMFvHJ0U0GKqJ93cRBLIRNr
	5DEAPqnkVX8neePH1WI8vD2CZCTbG1tmGri+WLH8cxDUL2y0CXwzjnnzkZZFlXsn2E0sU0dhNoU7H
	u5Un+5C6Om2pkXEb5PTgjLhwEGn1J4QBxq8uVQEapXAu6VoviMwDS2vr8gNUCN2RSE8aoZNLjZB7r
	etJbwE5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwVr7-0000000AdIX-2kcT;
	Sun, 01 Mar 2026 01:44:25 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwVr5-0000000AdHz-0SYE
	for kexec@lists.infradead.org;
	Sun, 01 Mar 2026 01:44:24 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2ae3f822163so37815ad.0
        for <kexec@lists.infradead.org>; Sat, 28 Feb 2026 17:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772329461; x=1772934261; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ep1r+TxTVXsjleXDRELngb1lJHdD0DP3WlzMub74vCE=;
        b=4ZBqvdAlvja2DIt9qWyrIuEB2bAKw4kThX+d13CYdcPjg2cPk+zqorURN80Ro5At4u
         75zw6PnSk6N1EPatKLutTgrk6q6eiLECJUu36KBA1MVaympFATzaFf9yRC8WYDwB4Zkh
         n+8gWz49hhS6cLUQIiUUbsmtLHmCO+mUX7wdhyATc8dWHIVK/S8ORMEoEyZFTce3KBUb
         DRxHG8LLSGL9Lm7m1N/HhrjtYMpxre4/OZjkKAff1JSRJl2NE3RAmmuLqdQtv2tadOGD
         by98ORWT2QEv0SKvnV4SpGmlnLf5+0sv5F/X56B7+bbveigDZxoCDV9+aIzLNFmiaEN9
         SA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772329461; x=1772934261;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep1r+TxTVXsjleXDRELngb1lJHdD0DP3WlzMub74vCE=;
        b=g4TV+jTDX5F/5ZzjzW3T5tfPb3vVs8BQzSBiZDd7jaqwMp17j2dad07oJf5Av546zp
         T3Wb5P2GqVP03RdUnkPU8xex8BNlfSOStZpEcogi1D4UIhuePQDBlI90Z2Hu+PR6Y7W3
         Z/PGr5+HZDkCn3jI65InANbJoP+Xv0/cG7iG6GJb5byHrRN4KLTJqA/zS8xtfmhvTtxj
         nV5WjtT/WXdRpsx2zG/Q1dPUyQJyY96HS467ROQS5JpZvPj6vilvnWMADLgVhz99giiu
         09NghIGYLQfXtB7LI+YuWfDICIL6aW+e9wuAffnVJkBWdB+KmWl2cX3xkF0TB4aU3uvT
         zI6w==
X-Forwarded-Encrypted: i=1; AJvYcCUAMbo8FtW06D8PgqcS3nw7Dw0bPsMpNiQRL3wA/F2FuVwv+qtrBJaRleLAStTIJaTHQ3EXJA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxpPSBLR0CTHZ7t+7qy8niwI5ovKqxFI6p1TjzC1YLAg7jgInVg
	ggTIbhAo7a5872mnb8Yk7YzecNlOhqTGCyWX3Wmda8rBw4GVMLCheUUsI+OCXSnNzg==
X-Gm-Gg: ATEYQzyXBqrCMiLMIqpiLnFGS7FLkHHWS9Wb0Mx7AH0/3rSEwFpw27Y4RmTFZsfupYn
	4utLJb1IuiTBEPlmxcmln1YSay3HKd0gy4NSesZDGWeF98e3o8qmbgZyKpDJGLoEdtgQQs6thre
	obcerknvPayrxdTFGONS7gB/A3eKgOpXbtSWtSGuZtYufD+urMSISJm37jd4n6JJPwvgSitad2j
	XRMbHIJvmEI4uNY5qGfwGDilshNDmJfxepLOfHMgvbYkgxrOFlQe9ACex4CMzz7wWoiKSnxDcer
	11XOdlPZ/sInUDroSv0WA3rX8MwFdMQPYLcbvJWHxY92BBDACfIBwxkFWWi64bxaxMyE9tJcu2d
	je26S2iVMCVjEx+jTe66GKDn244Z8uS6jTqZByCtXPq0SYuCheOfchpDblwfy40uMUHQ6jLdlUb
	8W43x1RveiiF+Kg4MWzRNdPf0NNW2Bo8LxvhR+r/xfopikg63AKVQolVmJRj/WhLGSJmS5GrNX8
	MnnWiqpJfmTk6YGMaToFkZ/sO+JCziYtwJ+504wfW2Jho/6I9B0oA==
X-Received: by 2002:a17:903:3903:b0:2aa:d604:62f3 with SMTP id d9443c01a7336-2ae397254c0mr1958145ad.10.1772329460775;
        Sat, 28 Feb 2026 17:44:20 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:963e:838d:a96b:8016] ([2a00:79e0:2eb0:8:963e:838d:a96b:8016])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a9dasm9104749b3a.49.2026.02.28.17.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 17:44:19 -0800 (PST)
Date: Sat, 28 Feb 2026 17:44:18 -0800 (PST)
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
Subject: [Hypervisor Live Update] Notes from February 23, 2026
Message-ID: <8dff046d-a819-ac8e-c1fa-8b5a35740cbb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260228_174423_155916_3FF7C052 
X-CRM114-Status: GOOD (  30.19  )
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
on Monday, February 23.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
We briefly mentioned the luod design doc[1] and asked people for review, 
Pratyush noted that he would be taking a look at it.

----->o-----
Jork Loeser noted that he was looking at HyperV partition survival.  They 
donate pages to HyperV which is a concept that doesn't exist in KVM.  
These pages are removed from Linux entirely and cannot be accessed.  He 
was playing with stateless KHO and extended some features but is not ready 
to send the patches out for review.  He was wondering if there was a 
possibility of landing changes in 7.1.

Pratyush noted that stateless KHO should go into the tree independently.  
Any consumers of the radix tree can be independent and build on top of 
those patches.  He noted that he would be happy to review the patches when 
they come out.

----->o-----
Pratyush noted that there were no updates for versioning support.  There 
is a clear plan forward for it but it hasn't been implemented yet.

He said he updated the HugeTLB preservation support with the requested 
changes from the mailing list but doesn't have selftests done yet.  In two 
weeks, he was hoping that these would be posted to the list.

----->o-----
David Matlack noted for interrupt ordering that discussions are still 
ongoing with NV on the topic.  Right now the simple approach is being used 
for disabling interrupts on the device and then reenabling them after live 
update.

For VFIO, there hasn't been a lot of feedback yet.  He was going to ask 
Bjorn and Alex to take a look.

----->o-----
Sami sent out phase 1 of the IOMMU preservation series and is looking 
forward to the next phase.  He was asking people for review upstream.  
Sami is using the VFIO patch series as a dependency.

----->o-----
Ackerley Tng went through guest_memfd HugeTLB support; the link to the 
slides are included in the cover letter for participants.  He briefly 
touched on an introduction to guest_memfd as a guest-first memory provider 
to KVM.  He then discussed how guest_memfd simply wraps existing sources 
of memory like pages from the buddy allocator or HugeTLB pages.  The 
folios are put into the filemap.

Every page is individually tracked to be either shared or private.  
Confidential guests can request a private page to be shared with the host 
and vice versa.  For shared-to-private conversion, the userspace VMM makes 
sure that devices stop using the memory requested by checking refcounts 
and then sends the SET_MEMORY_ATTRIBUTES ioctl to guest_memfd; that unmaps 
the range from the userspace page tables and records the page as private 
before returning to the guest.

Refcounting for a HugeTLB page is taken for the entire hugepage so we 
cannot identify which page within the hugepage the refcount was taken for.  
For all private-to-shared conversions this requires splitting hugepages 
into pages.  Split folios have to be merged back together but may also 
out-live the guest_memfd; for example if the fd is closed the memory may 
finally be unpinned.  This requires tracking outside of KVM such as the 
original size of the folio and which memcg was charged for it.  This is 
also required for memory error handling.

For KHO preservation, for guest_memfd pages (not HugeTLB pages) we need to 
preserve the filemap and associated folios, mempolicy, and memory 
attributes from the Maple Tree.  For HugeTLB pages we must preserve the 
restructuring metadata.  It was noted that there is no memory failure 
tracking today, it could be a future extension.

Pratyush asked if we can disallow any conversions after prepare.  Ackerley 
said if this period is very short than this should be fine.  Pratyush also 
asked if we should associate the guest_memfd with the host VM which, 
today, we rely on the VMM to do.

For timelines, Ackerley suggested that we would be able to merge 
conversion support with private/shared tracking in March and then HugeTLB 
support without restructuring in June.  He was hoping to have 
restructuring support later this year.

----->o-----
NOTE!!  Daylight Savings Time starts on Sunday, March 8 so the time of the 
meeting may have changed for some participants.

Next meeting will be on Monday, March 9 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - stateless KHO patch status in Andrew's tree
 - determine if luod would become part of systemd and discussions with
   Luca; implementation and next steps
 - versioning support for luod to negotiate
 - HugeTLB preservation support
 - ordering issues when disabling interrupts based on feedback from NV
 - VFIO patch series review from the list 
 - phase 1 of IOMMU persistence patch series, then phase 2 status and
   updates
 - hitless replacement for iommu domains
 - guest_memfd HugeTLB enlightenment: conversion support, HugeTLB support
   without restructuring, and HugeTLB support with restructuring
 - live update related topics to propose for LSF/MM/BPF 2026
 - KHO enlightenment for ASI
 - later: update on PCI preservation series and next steps
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update, including deferred
   struct page initialization

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://tinyurl.com/luoddesign

