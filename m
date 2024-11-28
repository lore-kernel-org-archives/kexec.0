Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D0BD690EB
	for <kexec@archiver.kernel.org>; Thu, 28 Nov 2024 08:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5NSN/0lDne+akCm3WWKmwH1H6R/w4T/EKwLN1O8iNGQ=; b=J8TYnr8rhf6eG0/fv6W9tV2clw
	jtdVjzQqXGQQ6v+i1qDZglHz0XQnJednNm4cDty1oMNNtVWdQbTfeMGn6YMNfldglk0y8UJ/2hF47
	E/Et8TfPRLCS4W+m4iMyNxomXj86q8ARnOfWwmLZjiBvsTivVfqkrrnQYTYQL2GKXsAlW13XXjXrK
	bYlIHKPa3oGOPuAMf129eZlWcM8oVD1qVqqi0qkUFIqRH8xwtrGAiK0oK0hfV3xw9/fZvpneJlXqv
	T+evs3CX+y2Xt0mOiXeWmJ/7gKMY3hK5TH96kiyo5J33prxWi5UuKtq4n/AjT0KAo6qvmNYVjreRg
	uLK6kAnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZsZ-0000000F0Bg-3Hpr;
	Thu, 28 Nov 2024 08:28:03 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZrP-0000000Ezwe-3oTs
	for kexec@lists.infradead.org;
	Thu, 28 Nov 2024 08:26:53 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-21238b669c5so56395ad.0
        for <kexec@lists.infradead.org>; Thu, 28 Nov 2024 00:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732782410; x=1733387210; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5NSN/0lDne+akCm3WWKmwH1H6R/w4T/EKwLN1O8iNGQ=;
        b=YHUYIqIQOYGoPpfnuvPAf1mlg6FIzmkeMqQ/YZUDJ6RJisXZyerUiAt4h+Rq8hPNLM
         h0weE5LoQT8Y/iBJa1Gp/6OCwRchL3jkd52uycK3/SwIpUj5697j4FksUpZt4oyXLqKA
         Oej1PkjKbRH2ILAY1YZTXe0Yy6pZdhYZtkYIDHdGicnIU24Z0LtHoRRgggT+BvvZZPD4
         bNEUA0l/aCgqddL4LxeYcoQh4q5XUM/2YrV0meC7HU2dyFadmryqOdE4kS6Tdn0w39CP
         NM2vNB0VEpTxvxbYIbErg8pGnIo9YxFk4HoZpwBN92tFwclrFjSdFYNLgEy7FNSyN/m5
         BtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732782410; x=1733387210;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NSN/0lDne+akCm3WWKmwH1H6R/w4T/EKwLN1O8iNGQ=;
        b=tWiQ9ggiJArXp8Pt2mSXXPX7DtS9BPUt0utY+BR5iEpB6rbh9CbA5YEKrLi7HL0bHd
         Xk89QAWag44r+373F3b7aNFUFlnHLa2cJHIOZ8vLt4u7W/CwxUqKPcW54h5mTq1e3ATP
         fYhHtSJiY0/RPc17/almjnIEP2UewXZedpHz47607Kz30cvHrKiWgEHjWaami4S9P0O8
         VOBRkeVYMu/tiXbcVGZNVuquwSlej0zzmYZyAHYN5vZcdTKgLhR6ihcPavH1doA7cBLC
         LiyT3zkVmvpazb70nSrs15LVOygXYGFQkJyN0p8nxHNSllVeCSz8YYLCOirpDllmDS5N
         4BXg==
X-Forwarded-Encrypted: i=1; AJvYcCVCtBP6ehjH2QFpogG1vkP84B4m72D0MIKUAAFrf/Ojxaxqh5YkPfkNEhWHgwra+RR1C2DMkQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3Zeuadm9QmLH5tYN1kH+gYNUlGSFuMnOOnPz+mddtt/xngiOF
	Rqqi+XuMG3alCkZ5c8xqJAd6/qZzIIwo2eBh/q5aNCnegQCuC/4HT46FEwONww==
X-Gm-Gg: ASbGncvQwU5ljGa0bWRxaPQrvX001uYhmkjqcdYpM3AG2GqR0X3Xh8D9Kv3PtMIA1ZS
	VQluM4B6d4q5pyCPf5sQLpOYCEPemabw6fPVpwElVujYMN/vf7//sBkB/W67BkqITKOGyI2Q/PN
	v46GHGw8VT4wiod2CgeUJ9EnQnu6sJ3J8dn8xNHxLS797DRT9oXKNKmI4jahCmQqMq/xvTj6JQY
	dk408i7ohGyFwc1RcbKoNIiLEb4hNym88kti83E0vAu7ZWb6JI8hFO0XVuGiJPzEEz/Jn3/zv10
	vA==
X-Google-Smtp-Source: AGHT+IEtj8CkDXMiXmCbKs6BX4Rxy94ikWgsDJaNIhQ2jSby+1T+GFcvsbimQUMi0XtSxOhhPkA3uw==
X-Received: by 2002:a17:902:f649:b0:20c:e8df:2500 with SMTP id d9443c01a7336-21521acaba3mr989185ad.3.1732782410032;
        Thu, 28 Nov 2024 00:26:50 -0800 (PST)
Received: from [2620:0:1008:15:730:7cb8:2b36:45fd] ([2620:0:1008:15:730:7cb8:2b36:45fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541770349sm932627b3a.76.2024.11.28.00.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:26:49 -0800 (PST)
Date: Thu, 28 Nov 2024 00:26:48 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: James Gowans <jgowans@amazon.com>, Dave Hansen <dave.hansen@intel.com>, 
    David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
    Mike Rapoport <mike.rapoport@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Alexander Graf <graf@amazon.com>, 
    David Woodhouse <dwmw@amazon.co.uk>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Frank van der Linden <fvdl@google.com>, Vipin Sharma <vipinsh@google.com>, 
    David Matlack <dmatlack@google.com>, Junaid Shahid <junaids@google.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Pratyush Yadav <pratyush@kernel.org>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Kexec HandOver (KHO) discussion recap and open questions
Message-ID: <52e189fa-bbb4-f031-8a64-716ddee14599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_002651_974283_5843F22F 
X-CRM114-Status: GOOD (  42.24  )
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

Hi all,

We had a great discussion today led by Mike Rapoport and James Gowans in
the Linux MM Alignment Session, thank you both!  Thanks to everybody who
attended and provided great questions, suggestions, and feedback.

Kexec HandOver (KHO)[1] is a proposal that enables compatible drivers to
hand over their state to the kexec kernel.  Mainly geared toward enabling
live updates for cloud providers, so that the host kernel can update
without disruption to virtual machines, additional use cases have also
been discussed such as persistence for database workloads.

----->o-----
Mike noted there have been several memory persistence proposals over the
past ten years: PRAM[2], PKRAM[3], persistent memory pools[4], prmem[5],
and now KHO + guestmemfs[6].  The goal for KHO is to provide a framework
for drivers to hook into and describe state while preserving arbitrary
non-GFP_MOVABLE memory pages.

On x86, the DT is not required to boot and is passed through when data
is filled in during the kexec.  Kirill Shutemov noted there's been a use
of EFI configuration tables which was used for unaccepted memory to pass
a bitmap of which memory has been accepted already.

Mike described scratch memory as a CMA range reserved by the first kernel
to be leveraged for GFP_MOVABLE during the lifetime of that kernel, but
when used for kexec for the new kernel, it will use this scratch region
as the only available memory.  This guarantees that memory that we want
to persist across kexec remains outside of the usage of the first kernel.
James thinks of this as a chunk of ephemeral memory, memory that will be
blown away during kexec to be used as early memory.

----->o-----
Pasha Tatashin asked what attributes affect the reboot performance in
terms of being proportional to the amount of memory preserved, for
example if you have one large preserved region this would be fast
because there is only thing we'd need to reserve.  Mike noted that we
wanted to use the scratch area all the way up until the buddy allocator
was active.  For preserved pages, we don't push these to buddy allocator
freelists.

Pasha noted if we had one large area of persistence, this may be faster,
and suggested it would be up to the device to carve this memory out.
Mike noted there were earlier proposals for this that were not well
received, although could be an extension later but not as part of KHO.

----->o-----
Pasha also asked whether persistence being specified during page
allocation was still being considered for the design.  Mike believed this
to be outside the scope of KHO.  James chimed in that any unmovable
allocation could potentially be in scope for being preserved, and the
use of persistent memory pools[4] could be done on top of KHO.  Callers
could use these pools instead of general kernel memory allocations.
Pasha noted this may be useful for some device drivers, although James
noted changing allocations to do this was decided to not be a hard
requirement.

Pasha asked whether the DT could be recreated before the reboot or only
during serialization time.  Mike noted the DT was currently recreated on
kexec load, not kexec execute, which was something still to address.
Pasha noted that removing kexec load from the critical path would very
much be needed.  James clarified that this was not exactly kexec load,
but rather KHO's own activate phase which is driven by userspace right
before the actual kexec.

Mike agreed that this should be decoupled from kexec load and that we
should be able to create the DT long before kexec execute.

----->o-----
Kirill asked if the use case would differ at all between crash kernels
and this use case.  Pasha noted that we could load the new kernel in the
same way that the crash kernel is loaded today and then reboot when
needed.

Pasha noted this would be useful for storing state even before the
shutdown, for things like kernel logs of the original kernel.

----->o-----
Mike noted that the CMA area intended to be repurposed as the scratch
area would be available as the same length for any future kexec as well.
IOW, kernel n+1 would have the same size of scratch as kernel n.  The CMA
area can only allocate movable allocations, which guarantees that no
persistent memory is allocated from the scratch space.

Pratyush Yadev noted that if we run out of memory that we could extend
the scratch area, we would be able to use ranges of memory that are not
used but this is not guaranteed to be available.  Mike acknowledged that
running out of memory could become a problem since reclaiming from other
memory and creating contiguous ranges out of it would only be best
effort.

I asked if this memory is carved out by the kernel command line and needs
to be consistent between the original kernel and the kexec kernel.  Mike
clarified that the CMA area is currently sized automatically based on the
number of memblock allocations in the first kernel.  There was debate
about whether this sizing should be automatically discovered or
explicitly declared on the kernel command line, like crash kernel use
cases.  This memory is not throwaway memory since it can be used by the
original kernel before kexec, since it can be used for movable
allocations at runtime.

----->o-----
Junaid Shahid asked about preserving any non-movable allocation, the
concern was that the kexec kernel would be doing buddy allocations from
the CMA region that were non-movable and if we preserve them then we
would have less scratch area available for the following kernel after
that.  Mike clarified that the assumption was that we'll never preserve
movable allocations and CMA does not allow non-movable allocations to be
allocated from its areas, and the allocations using this scratch area are
also not preserved.

----->o-----
Pratyush noted he has been working on supporting persistent tmpfs on top
of KHO using its own structure that has a "stable" version.  Kirill
expressed the concern that we need to be careful because it becomes part
of the kernel ABI.

Pratyush, would it be possible to share your example code that you were
referring to in chat today in response to this thread?

----->o-----
The question came up about whether we should port hugetlbfs to use KHO
and whether this would be useful for database workloads.  Matthew Wilcox
noted hugetlbfs is used as a replacement for anonymous memory for the
database, effectively as a way to share memory that would be anonymous
across multiple processes (it's the database's page cache).  Matthew was
unsure if this would need to be persistent across kexec.

Mike noted another example would be virtual machines that use hugetlbfs
instead of VM_PFNMAP memory and has been thinking about how to do this
by serializing the superblock and inodes.  Matthew reiterated what he has
said before at conferences, which is that we need to get filesystem
experts involved when designing filesystems :)

----->o-----
James observed that we should continue the discussion about when
serialization happens: when we freeze things, what it means to become
immutable, what point in the kexec process we do this.

----->o-----
My takeaway:

 - we likely want to consider reboot performance as a key input into
   design decisions

 - we should determine whether persistent memory pools, used for
   allocations that indicate the require persistence across kexec, will
   be out of scope for the initial landing of KHO upstream

   + if outside of scope for the initial landing of KHO, we could discuss
     a layer on top of KHO that could be used for allocations that want
     to indicate their need for persistence at the time of allocation

 - we need to decide if DT recreation can happen as part of kexec execute
   instead of kexec load and how to avoid having kexec load as part of
   the critical path; Mike agreed this should be decoupled from kexec
   load

 - we should explore loading the kexec kernel, like for crash kernels,
   in memory whenever we want, which has some advantages noted above

 - we need to decide if the sizing of the scratch area should be done
   automatically based on memblock allocations or if it should be
   explicitly carved out by the kernel command line, including adding
   more buffer room if declared that will be needed for future kexec
   kernels

 - we need to decide what the minimal feature set required for the
   initial upstream landing would be and we brainstormed this as
   extending the scratch phase until the buddy allocator is up and
   running, adding KHO support for reserve_mem, NUMA support, and
   multiple scratch regions

 - we need to decide on the initial set of use cases for KHO, Mike noted
   that reserve_mem is likely the best fit here given its straight
   forward; we should also discuss if hugetlbfs is a likely candidate as
   well

Mike also noted that he is planning on sending out the next verison of
KHO based upon the original work from Alex by the end of this year.

We'll be looking to continue the discussion on this topic, as well as
guestmemfs as an in-memory persistent file system, to accelerate progress
and land foundational support in the kernel.  For this, we'd like to fork
off a biweekly series focused exclusively on persistent guest memory and
live updates through kexec.

If you are interested in participating in this series of discussions,
please let me know in email.  Everybody is welcome to participate and
we'll have summary email threads such as this one to follow-up on the
mailing lists.

Thanks!

[1] https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com/
[2] https://lore.kernel.org/lkml/cover.1372582754.git.vdavydov@parallels.com/
[3] https://lore.kernel.org/kexec/1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com/
[4] https://lore.kernel.org/all/169645773092.11424.7258549771090599226.stgit@skinsburskii./
[5] https://lore.kernel.org/linux-mm/20231016233215.13090-1-madvenka@linux.microsoft.com/
[6] https://lore.kernel.org/all/20240805093245.889357-1-jgowans@amazon.com

Also interesting, pkernfs: https://lpc.events/event/17/contributions/1485/

