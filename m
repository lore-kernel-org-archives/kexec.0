Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A070FE936ED
	for <kexec@archiver.kernel.org>; Wed,  4 Oct 2023 22:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:To:From:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zcCE9zH3sZ3JFx9iUIw94INrS/qO2ZrWipfHpzw+0DI=; b=VGHkLduyZ0rZR9
	BIPn0D9am/ILaoRNuuxRjNiVE1oA9EwpmFEdsyUQ164i5Zktfsbncjn1saHQDnxbyoWbFQaKCsm3G
	uI2dHYxegf6f28Sq6DdWVrvCamUTL0aUxsCoyFAwfJ7nqVymkQszlc2yj3wzKdHYx/cQmn1v5N7N3
	3oXYmLjCATWJwyUylo+EzvRjgInGmA8c6lUsDtMWDBEacCYxUB8dCswNUhO4JwaULJ0SVHfmryCfi
	j7nwvM0LstXFXVmDHfd3zJC1oqyUPKCiDBnwZMaSsyfZ/629na/sZbz8fz3i7W09PkjPtuXPRMqZZ
	MVMeKg1K7ja8FG3KP3Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoAH0-0010HX-0m;
	Wed, 04 Oct 2023 22:23:18 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoAGw-0010GF-2C
	for kexec@lists.infradead.org;
	Wed, 04 Oct 2023 22:23:16 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8067C20B74C0;
	Wed,  4 Oct 2023 15:23:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8067C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696458190;
	bh=RprucWY8tQsHaJUqiRTT+mP1XUG4loX41u0apscA6Mo=;
	h=Subject:From:To:Date:From;
	b=QoPtEwhS3DtEb8PND6sDycteemy3JCXPQA1xc99iKd3mtfHfPVtaaOeP9ugOwKQ9/
	 FB5Z4lFJWVVk4mEdno8MdfBdRE6O7nagYIoDNgpKbNw7xeJcFxAfQlyuSqGxiUqUJS
	 uw3x+S02KMeaOxFqsnCOGZxUU90srV00+PP6atF4=
Subject: [RFC PATCH v3 0/3] Introduce persistent memory pool
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com,
 bhe@redhat.com, dave.hansen@intel.com, kirill.shutemov@intel.com
Date: Wed, 04 Oct 2023 15:23:09 -0700
Message-ID: <169645773092.11424.7258549771090599226.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_152314_829441_391CF261 
X-CRM114-Status: GOOD (  13.70  )
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

This patch introduces a memory allocator specifically tailored for
persistent memory within the kernel. The allocator maintains
kernel-specific states like DMA passthrough device states, IOMMU state, and
more across kexec.

The current implementation provides a foundation for custom solutions that
may be developed in the future. Although the design is kept concise and
straightforward to encourage discussion and feedback, it remains fully
functional.

The immediate need for the allocator is in ability to persist the kernel
pages deposited into Microsoft Hypervisor across kexec: these pages must
not be accessed by kernel when deposited, but can be withdrawn and released
back to kernel. Kexec in turn is used for servicing purposes and aimed to
minimize service downtime upon kernel upgrade in a fleet of machines.

The persistent memory pool builds upon the continuous memory allocator
(CMA) and ensures CMA state persistency across kexec by incorporating the
CMA bitmap into the memory region instead of allocation it from kernel
memory.

Persistent memory pool metadata is passed across kexec by using Flattened
Device Tree, which is added as another kexec segment for x86 architecture.

Potential applications include:

  1. Enabling various in-kernel entities to allocate persistent pages from
     a unified memory pool, obviating the need for reserving multiple
     regions.

  2. For in-kernel components that need the allocation address to be
     retained on kernel kexec, this address can be exposed to user space
     and subsequently passed through the command line.

  3. Distinct subsystems or drivers can set aside their region, allocating
     a segment for their persistent memory pool, suitable for uses such as
     file systems, key-value stores, and other applications.

Changes since v2:

  1. Device tree-related change are removed.

  2. Persistent memory pool region is marked as "reserved by kernel" in
     kexec e820 table, which indicates to the new kernel, that the pool
     must restored.

Changes since v1:

  1. Persistent memory pool is now a wrapper on top of CMA instead of being a
     new allocator.

  2. Persistent memory pool metadata doesn't belong to the pool anymore and
     is now passed via Flattened Device Tree instead over kexec to the new
     kernel.

The following series implements...

---

Stanislav Kinsburskii (3):
      x86/boot/e820: Expose kexec range update, remove and table update functions
      pmpool: Introduce persistent memory pool
      pmpool: Mark reserved range as "kernel reserved" in kexec e820 table


 arch/x86/include/asm/e820/api.h |    4 +
 arch/x86/kernel/e820.c          |   21 ++++-
 include/linux/pmpool.h          |   22 +++++
 mm/Kconfig                      |    8 ++
 mm/Makefile                     |    1 
 mm/pmpool.c                     |  159 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 209 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/pmpool.h
 create mode 100644 mm/pmpool.c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
