Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43ADD2F7ED
	for <kexec@archiver.kernel.org>; Thu, 17 Oct 2024 04:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=g9C+gZvRCqmVdxohbquupL1jqQCJ43xEUQtRh6n1pGQ=; b=z60V3JX4pG7HXd
	PCp+/CTwoocPpIyxs7iclMUBIoVLPE/MgIe2ZNGXd22ZpcXm7u+dM9WaOiblAc4aNb+hNeV4EMA3C
	xFWiG+w72QgugpEOFhHMBXQ6R+C7A1sqF+pM8YshybIJKg2BE2nhBR9tcAbB62TZyFRGvfkAe+DM8
	Otmjsd1BWoejnEADIHdcXfFsrSePYTxLa/9jEvgHLnpfqk/wZThbEmsmZ1X2snf45mDbKYLgoCLv6
	oLCeopO3tRoNNkDdrH3xVMSdR37KbB8y1wN7lC3n2HF4uvrf4A/wgcogWEK3x1kDHj+52m6Ero5RX
	+VIvSho1/xEnfeyavjhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1IKx-0000000Djck-1AuZ;
	Thu, 17 Oct 2024 04:42:11 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1IKu-0000000Djc0-09tL
	for kexec@lists.infradead.org;
	Thu, 17 Oct 2024 04:42:09 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-20ca03687fdso105995ad.0
        for <kexec@lists.infradead.org>; Wed, 16 Oct 2024 21:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729140127; x=1729744927; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SxwDXIKxjXP21FdsmXkLH79jYy6JTiroXLnGAM677n8=;
        b=PDCG3hRfscHwj0tHB7xqHwF6sRIYmEOjAE1w2JC860whSJJwjH+gMoT3RAQ8/boTQk
         kxC/vTZZxFbOyWZ2TAEmnaGOyTt5wpqSR5UUEi54vfi1LfTtS9TO4IOqZL7xoQ/rlXCH
         r6/+5hOIJXFmD8JKdWF+16lgkwnOgfFsG+SntZyEpvT227dvak8wB86uxohtxPuchbTF
         LPrBbCOmks8bQJRKMVb/fy/iqFMj2qhqbd0oymGM3eRdbOvqhcrLsqiq2SWNKoiwoF7v
         CVaWXB7fcT82oAipvtZMSjqAZEEGScusCCx4+80g06eDRyE0e1SPMnl98LR4f6sIwacS
         MEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729140127; x=1729744927;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxwDXIKxjXP21FdsmXkLH79jYy6JTiroXLnGAM677n8=;
        b=Wl7vLOQ5bRhtHvW1wefvRtBB29PW13gvJpMrtLwYGjzyOzTSpqlnFDdogS0R+DiZVf
         KeRwxZncn2PmjNOdYIFiGNKR2Av8p+caELPhM7YXZ/9yz6+77yVh43TLUTO8tcNYxNJs
         sRSyJOHVhptNKR2gkJcg48glzRBrS/aPP6FQgtBbOq/3hFpDSpZJprqRcHKSgNXJV3vD
         wj8dF5AJGUQV8koHe+szdKYvX3ofRjj5jLH1H+/8x0K7/VfKjfxwP5TVRXLiF84T9lFs
         t9W0Q6ipCITG9CQuPqHMFhTxtLE9yrY/1Mmxu2DTNLDM/sHEwt0ea+Q3BTHn4mQ7T/2f
         +SNA==
X-Forwarded-Encrypted: i=1; AJvYcCXUBsi6sCEKM9iHajNw8wUTWp7/QwAGEBsgWiF5w2gYQuYevV+CvEL8JO/MQ4oSjuD15TtNaw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxNsVqKglv1O1z7zJaJSCIZ/CaRCRM1PznWCTZ77xwzWi14ruX6
	BNH5RCs70lk2VCAvbFaHlP4YHk/klsXy4FnXIJm1PKamW1CjgaV1LRJt9Axeog==
X-Google-Smtp-Source: AGHT+IGRlbQ6kzPJ28NkEONzWnblgHBvnulYQfVkCGoqmNaYRFSvxEl8c3XOA+M6/Wu7YgwzqX7aVw==
X-Received: by 2002:a17:902:f542:b0:20c:f87f:b7ef with SMTP id d9443c01a7336-20d49640d27mr1707435ad.22.1729140126312;
        Wed, 16 Oct 2024 21:42:06 -0700 (PDT)
Received: from [2620:0:1008:15:2231:4da8:e0e:5534] ([2620:0:1008:15:2231:4da8:e0e:5534])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a29f6sm4020888b3a.140.2024.10.16.21.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 21:42:05 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:42:04 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: James Gowans <jgowans@amazon.com>, Dave Hansen <dave.hansen@intel.com>, 
    David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
    Mike Rapoport <mike.rapoport@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Peter Xu <peterx@redhat.com>, 
    Alexander Graf <graf@amazon.com>, Ashish Kalra <ashish.kalra@amd.com>, 
    Tom Lendacky <thomas.lendacky@amd.com>, 
    David Woodhouse <dwmw@amazon.co.uk>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Frank van der Linden <fvdl@google.com>, Vipin Sharma <vipinsh@google.com>, 
    David Matlack <dmatlack@google.com>, 
    Steve Rutherford <srutherford@google.com>, 
    Erdem Aktas <erdemaktas@google.com>, Alper Gun <alpergun@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    Ackerley Tng <ackerleytng@google.com>, Sagi Shahar <sagis@google.com>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Pmemfs/guestmemfs discussion recap and open questions
Message-ID: <f44f317a-2dcb-cfe2-013c-7508907ce3df@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_214208_103903_87E5C318 
X-CRM114-Status: GOOD (  30.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi all,

We had a very interesting discussion today led by James Gowans in the
Linux MM Alignment Session, thank you James!  And thanks to everybody who
attended and provided great questions, suggestions, and feedback.

Guestmemfs[*] is proposed to provide an in-memory persistent filesystem
primarily aimed at Kexec Hand-Over (KHO) use cases: 1GB allocations, no
struct pages, unmapped from the kernel direct map.  The memory for this
filesystem is set aside by the memblock allocator as defined by the
kernel command line (like guestmemfs=900G on a 1TB system).


----->o-----
Feedback from David Hildenbrand was that we may want to leverge HVO
to get struct page savings and the alignment was to define this as
part of the filesystem configuration: do you want all struct pages to
be gone and memory unmapped from the kernel direct map, or in the
kernel direct map with tail pages freed for I/O?  You get to choose!


----->o-----
It was noted that the premise for guestmemfs sounded very similar to
guest_memfd, a filesystem that would index non-anonymous guest_memfds;
indeed, this is not dissimilar to persistent guest_memfd.  The new
kernel would need to present the fds to userspace so they can
be used once again, so a filesystem abstraction may make sense.  We
may also want to use uid and gid permissions.

It's highly desirable for the kernel to share the same infrastructure and 
source code, like struct page optimizations and unmapping from the kernel 
direct map, and name the guest_memfd.  We'd want to avoid duplicating 
this, but it's still questionable how this would be glued together.

David Hildenbrand brought up the idea of a persistent filesystem that
even databases could use that may not be guest_memfd.  Persistent
filesystems do exist, but lack the 1GB memory allocation requirement; if
we were to support databases or other workloads that want to persist
memory across kexec, this instead would become a new optimized filesystem 
for generic use cases that require persistence.  Mike Rapoport noted that 
tying the ability to persist memory across kexec to only guests would 
preclude this without major changes.

Frank van der Linden noted the abstraction between guest_memfd and
guestmemfs doesn't mesh very well and we may want to do this at the
allocator level instead: basically a factory that gives you exactly what
you want -- memory unmapped from the kernel direct map, with HVO instead,
etc.

Jason Gunthorpe noted there's a desire to add iommufd connections to
guest_memfd and that would have to be duplicated for guestmemfs.  KVM has
special connections to it, ioctls, etc.  So likely a whole new API
surface is coming around guest_memfd that guestmemfs will want to re-use.

To support this, it was also noted that guest_memfd is largely used for
confidential computing and pKVM today, and confidential computing is a
requirement for cloud providers: they need to expose guest_memfd style 
interface for such VMs as well.

Jason suggested that when you create a file on the filesystem, you tell
it exactly what you want: unmapped memory, guest_memfd semantics, or just
a plain file.  James expanded on this by brainstorming an API for such
use cases and backed by this new kind of allocator to provide exactly
what you need.


----->o-----
James also noted some users are interested in smaller regions of memory
that aren't preallocated, like tmpfs, so there is interest in "persistent
tmpfs," including dynamic sizing.  This may be tricky because tmpfs uses 
page cache.  In this case, the preallocation would not be needed.  Mike 
Rapoport noted the same is the case for memory mapped into the kernel 
direct map which is not required for persistence (including if you want to 
do I/O).

The tricky part of this is to determine what should and should not be
solved with the same solution.  Is it acceptable to have something like
guestmemfs which is very specific to cloud providers running VMs in most
of their host memory?

Matthew Wilcox noted there perhaps are ways to support persistence in
tmpfs, such as with swap, for this other use case, James noted this could
be used for things like systemd information that people have brought up
for containerization.  He indicated we should ensure KHO can mark tmpfs
pages to be persistent.  We'd need to follow up with Alex.


----->o-----
Pasha Tatashin asked about NUMA support with the current guestmemfs
proposal.  James noted this would be an essential requirement.  When
specifying the kernel command line with guestmemfs=, we could specify
the lengths required from each NUMA node.  This would result in per-node
mount points.


----->o-----
Peter Xu asked if IOMMU page tables could be stored on the guestmemfs
themselves to preserve across kexec.  James noted previous solutions for
this existed, but were tricky because of filesystem ordering at boot.  
This led to the conclusion that if we want persistent devices, then we 
need persistent memory as well; only files from guestmemfs that are known 
to be persistent can be mapped into a persistent VMA domain.  In the case 
of IOMMU page tables, the IOMMU driver needs to tell KHO that they must be
persisted.


----->o-----
My takeaway: based on the feedback that was provided in the discussion:

 - we need an allocator abstraction for persistent memory that can return
   memory with various characteristics: 1GB or not, kernel direct map or
   not, HVO or not, etc.

 - built on top of that, we need the ability to carve out very large
   ranges of memory (cloud provider use case) with NUMA awareness on the
   kernel command line

 - we also need the ability to be able to dynamically resize this or
   provide hints at allocation time that memory must be persisted across
   kexec to support the non-cloud provider use case

 - we need a filesystem abstraction that map memory of the type that is
   requested, including guest_memfd and then deal with all the fun of
   multitenancy since it would be drawing from a finite per-NUMA node
   pool of persistent memory

 - absolutely critical to this discussion is defining what is the core
   infrastructure that is required for a generally acceptable solution
   and then what builds off of that to be more special cased (like the
   cloud provider use case or persistent tmpfs use case)

We're looking to continue that discussion here and then come together 
again in a few weeks.

Thanks!

[*] https://lore.kernel.org/kvm/20240805093245.889357-1-jgowans@amazon.com/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
