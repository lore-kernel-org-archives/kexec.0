Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80D5CCD184
	for <kexec@archiver.kernel.org>; Sun, 12 Oct 2025 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5nQm7KXYGnqdcO+aK8U+JklMZ1nJvHqyddKFebpClpY=; b=YG1frRolFT/OOy3EfHAy8z5Gcs
	WIQn093GB/cUByJromf099MmEHlhnx7zHltcePkgMjPEqKrpLsxpxl69TgJlac+U7tNMaHnLyZqE8
	cMnZA17/33h9iKg9ubD9YwlgGDCgdq1PP3xMwHdT3XzXe0aBjeswIEkegl1xxt3Q7du3XqjseVaek
	Am2AFUldVnaMdyvNZ+49kwlCgu1Oe50MVfDbp0VBgxK3r7tcDM42Z2sicMwH8cgFbvnk9hZM+HN0/
	sfcbQB4qDCSa+wpZd64w3l64mTlq4SP32CShb9j9XbdMyOHFAzrkhwwE9p7UQIFcLIs9VGeGf0LHY
	vnpT9g/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v85wj-0000000Br3j-01TX;
	Sun, 12 Oct 2025 23:57:49 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v85wc-0000000Br3G-2neq
	for kexec@lists.infradead.org;
	Sun, 12 Oct 2025 23:57:44 +0000
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-27d67abd215so293515ad.0
        for <kexec@lists.infradead.org>; Sun, 12 Oct 2025 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760313461; x=1760918261; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5nQm7KXYGnqdcO+aK8U+JklMZ1nJvHqyddKFebpClpY=;
        b=QDZI77OESm6m0zzz9ZdbreX2nTYoIAv1jpk7XxSXnIwCfqInm9a1xi5a+TAj1Zwat5
         /X0s0lpQ8xaEPzkyfrdl/lksUS3gdW8mDYGItnNnzVD0rltalASM8M/LqiFpLE1ibkoQ
         ufNWGBoLoZtaOwml78/rR1QvHr9LnL9Re9bqGJHpAIZLuBYHvij4bzldQr5MhQ7MlJDR
         1oB5B+DPmP2fPMbCqrb/5tKg8a9jK9TZm2I0+UtepOFS6/RmvXtUXt7owbsbCZe0UvZd
         AVmhKAXWdqX9Ts6154DNoaxFQcjvkyjCmmyuM9DGcz3CLp345ainxb4V2ewwXMBBi78Y
         KarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760313461; x=1760918261;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5nQm7KXYGnqdcO+aK8U+JklMZ1nJvHqyddKFebpClpY=;
        b=oRxIipDiOj6t94/MfxVYfu/TFUMMOsJ9khkeRbnjHad8iJCkANuhyWl4iKKfMtkKh8
         pVqkesK9FQufuHWkLpkkMdOqp1fYfYUsOX15+4dnlR1fFxvpTed6PMhJ50pocPKLRmtu
         RKR1Pc1hc2rmZPwnSHb1ydbCzo2rzXHeAQg9urEr7b578peg6OY3V2pzyu0tYRwexabn
         kv+rPTLrz4fltBMN2gFHFT1IYS8AwBmy/uwCDDB/7rucpa8ieUDymeqx6Qfvw0Wb++tq
         Gcvtb4egEyf4XX0Bd5616I+qZBgH5C/1qx5VshSKd9nlv0g56+cAolt5O8RcYHhdnh6N
         +hhg==
X-Forwarded-Encrypted: i=1; AJvYcCV2to6zyTShOWIOW6SexfWSIccZzik9TycBaJtVFueL1Bd/NFNKiNTPa+F79De5A6k3O1QHtw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx34HABD/LFhjOB7o+q3yU6PX6KElycgzqgh2L2KoBPS6Y7x71B
	ME4uCuBP7f9mJNya6mE57jTfwC96ryxFTWe0bB+cMKeUIWNv09ZB8mnRT4+EIBgc/g==
X-Gm-Gg: ASbGnctAfiK69MCXLCCQepwiEGV2zNwBtYKoGGUpwKO09Ds5nDY+xLr7U4PTVIFNXT/
	oCmh++aB5HexRBppzu9Pdmq4vLzkdK6uKtVGzTNh2mErs0MSSUznmbUrNBpuDo+zf+G+EZgOcQK
	pKsG1LL57bAV92KMOjg/YzMGsHPUTNbMlgD/s7+qyD6JkzggXZBf2kYokr15hI/FzgRcuxR4+R/
	aFlDawU2kzEZHlDPUeLWb4OdWbtZdWDiFp4jwUlX6Qh+pQ6zu/xQ5A4D40VvQE1uWq2dDjpy/d3
	3AvofChF5W2axKsWX5LWy1XNJ53s2SUEQpCi4oaUz5juwrFYP+v2Zo2H9YH55u3JjbZKuip4sTD
	KPr7fEXlQF3Ldm+O1t/xL+zfuRIRZFh7nEq6VNil2w1cftFShWANaY57Hx9Ct2+5TFra4+NEvif
	SmVRd3cQJFD07Az9lKZIFQ6OESh4i+up0l5FDkHPjmeri4HMKkHT5oL7ZDEJNUZ8+O9yyB920=
X-Google-Smtp-Source: AGHT+IHGA0sKciQs/c5E995rDfiiuhjgfyqwD521DvX0pdBh3UAfB9mcbBQJXpIhM5ZQaBO+Zeo+6Q==
X-Received: by 2002:a17:903:2b0f:b0:266:b8a2:f5d8 with SMTP id d9443c01a7336-290276bc052mr22752615ad.14.1760313460815;
        Sun, 12 Oct 2025 16:57:40 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:d38e:e48:4bd1:f89d] ([2a00:79e0:2eb0:8:d38e:e48:4bd1:f89d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61b12756sm10057775a91.25.2025.10.12.16.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 16:57:40 -0700 (PDT)
Date: Sun, 12 Oct 2025 16:57:39 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    David Matlack <dmatlack@google.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from October 6, 2025
Message-ID: <8d58869a-6587-8106-3518-a8a70784ce11@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251012_165742_891737_E2A3B2DD 
X-CRM114-Status: GOOD (  35.27  )
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
on Monday, October 6.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
Pasha started off with LUO v4 discussion points.  As discovered during 
iommu preservation series review, we needed dependency tracking for 
situations where one fd depends on a resource.  There are two options for 
this dependency tracking:

 - Option 1: when the fd is preserved with a callback, can_preserve(),
   which determines if it can be preserved (and all dependencies are
   already preserved)
 - Option 2: when we go into prepare(), we check the inter dependencies,
   which also allows for cross dependencies (A depending on B, B depending
   on A)

In Option 1, userspace must declare which dependencies must be grabbed in 
which order; this is not a requirement for Option 2.  Pratyush suggested 
to start we could go with Option 1, including for unpreserve.

Pratyush suggested there may be an Option 3 where LUO preserves a group of 
fds, and they get checked as an entire unit (similar to fdbox).  Pasha 
said that grouping restore is not possible, same as session grouping.  
Praveen Kumar suggested that ordering is important; Pasha agreed, but said 
that the question was when this happens: during preserve or during 
prepare.

Jason suggested that preserve would need to know the dependenices at that 
time (Option 1).  He said that we wouldn't be able to allow the memfd to 
become mutable until all the fds are put back on it; the sequencing would 
require the ordering to be establised at the time of preserve.  

Pasha suggested that when we go to prepare phase, it is likely fine to 
have them in a different order as long as we are 100% sure that the memfd 
is going to be serialized.  Jason said when the memfd is frozen, we can't 
have inconsistencies; the iommu can take the page pin but you can still 
ftruncate() the memfd and that will make the memory delay freed by the 
iommu.

The conclusion then was that Option 2 was not possible, we need to know 
the right sequence before prepare.  Prepare would likely need to do its 
work in the same order that can_preserve() was called.  Pratyush said LUO 
v4 already had per-fd freezing so we could force userspace to do it; for 
example, when you preserve iommufd you just force userspace to first 
preserve and prepare the memfd that is dependent on it.  In this case, the 
kernel is just checking and enforcing this.

The consensus was to check the depedencies when you do the ioctl and then 
fail the ioctl if needed; userspace does all the ordering required. 

----->o-----
Pasha asked if we still want userspace to provide tokens, which was 
previously needed because we had global fd preservation; now, each session 
has a token that starts at zero: whatever was preserved first has token 0, 
what was preserved second has token 1, etc.  Jason suggested against the 
kernel issuing tokens again: the token allowed predecessor and successor 
VMMs to have an ABI where they can say this object is this thing with this 
token, and they can then pull it out with that token.

Pratyush asked what we want to solve with kernel issued tokens.  Pasha 
suggested we might be able to use tokens for ordering.  Pratyush said if 
userspace uses tokens then they can use the same scheme.  We decided that 
tokens should be removed from ordering.

----->o-----
There was discussion on whether sessions should be removed entirely or 
not.  Pasha noted that iommu required a subsystem because it requires 
cross file descriptor data during boot.  Jason suggested not expressing it 
as a subsystem with callbacks; the goal is that the first thread that gets 
to serialize the iommu synchronously creates the serialization data under 
a LUO lock, the next thread gets the serial data under a LUO lock and may 
make a little change.  We likely don't want to track this as part of a 
subsystem abstraction.

Pasha said that with no callback, for iommu, what we'd want is a call into 
LUO during boot to ask for the data.  Jason suggested this may be correct 
but was focused more on the suspend side.  He said during probe we'd have 
to ask for the early boot data if it exists.

Pasha was going to propose an RFC discussion usptream on the APIs for 
this.

----->o-----
Andrey discussed the current status of his KSTATE work.  He wanted to 
describe what should be preserved without requiring major subsystem 
changes.  He suggested a description in common code that parses the 
description and saves and restores with versioning.

For example, for struct a, the struct kstate_description would include the 
min_version_id that we can restore from.  It includes a state list and a 
list of fields to preserve.  The KSTATE data format includes a magic 
number, state_id, version_id, instance_id, and then the size of the data 
for preservation.  The states are then repeated.

This includes fields versioning; when data is added, the version is bumped 
for the field.  This allows for making compatible changes for the new 
kernel.  Jason was against the idea of throwing away data; the idea is 
that if the old kernel included data then it would be wrong for the new 
kernel to then throw it away.  Andrey suggested bumping the 
min_version_id.  Ben Chaney suggested it will be useful for adding a new 
field that the old kernel did not support.

Jason said that if data was changed, there would likely need to be a 
significant code flow change associated with it; a recent example is the 
vmalloc patch series that ended up in being a significant change.

----->o-----
Next meeting will be on Monday, October 20 at 8am PDT (UTC-7), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - follow up in fd dependency checking and this happening at the time of
   preserve rather than prepare (Option 1)
 - follow up on not relying on subsystems in LUO and the APIs on both
   sides of the live update for getting data needed
 - update on latest status of LUO and next steps for merge into akpm's
   tree
 - update on the status of stateless KHO RFC patches that should simplify
   LUO support
 - update on memfd preservation, vmalloc support, and 1GB limitation
 - discuss guest_memfd preservation use cases for Confidential Computing
   and any current work happening on it, including overlap with memfd
   preservation being worked on by Pratyush
   + discuss any use cases for Confidential Computing where folios may
     need to be split after being marked as preserved during brown out
 - [15 min] summarize upstream iommu persistence discussion and surface
   any misalignment
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

