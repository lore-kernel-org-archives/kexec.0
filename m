Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250D2E77180
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 09:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NJ3rben+RQ8oyImGV7wZYRl0G6OTWhxJqURb3T1hywY=; b=ASfWi2zMocj7Eef6tsH8gQj3jk
	zTt1430V+Nq2rIIEj0DXvgtaPVNFon2xjc4R9SufKdQPCrpzgkZxiDZft1dIb6U+riUUo9We0YC+O
	7Hq8eZOWP0efpPEkEnjhSzs80AMu7I3MCaJxPkl0FbCl6RfR8dyzb2tHGSmh6Dg9AW2lXmOlSZl3q
	WR9fuBHEcrH+ywDlEn9hsFf/UOhY2kgk17bjzJqWqal4KaNyQE1Kktq3e5+sW2MLYkTBfcoAYv6B9
	cf4K9C3/zvlZdzw6SJOZ71xsaIZhhZJaMKDKCnIdcxYEZyXMdUe/CUHBoj/lG3tPQkpp2a5cHUdR+
	WSVqNRsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM2QY-00000003Lsb-3cXz;
	Fri, 13 Dec 2024 09:57:42 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM2QW-00000003LrH-2i8B
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 09:57:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734083861; x=1765619861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GH1L5UbCox+/l9a3Rv/+h7MmSzvbSrhCbpBcYNUY9OQ=;
  b=cXvSiAeBc8FkP4yM6kQMs3WEiWaux9naHPZsB8vXCSkcHfFFXQyg/5i+
   yqrlfuW6cfBrP7LAATotRq/eFqQ5DHkl4KKv4uDtdFeYMI3EtohRK9b3s
   wgPeiPdImYTynA5+ufI6ebqnuni5qv6Kwx+Ycyj/bZMRxuUoCX0H5obaI
   K1WYgoIt1aAzc+R/CS1YENP6p4tmKeyVkSsX96RIoP+4kmLaWDDQCx8N+
   Fy8SnJEDAhIN7fhgMyE1i7oZ1X/8+LbsWFWZ0WI5qRMxSg6qNDYE3vQ3O
   nfoEN1nP5vY71+qSgHIxSq16WXN1Caz54urSK7FZkbFjTYdTNP5AQyVn5
   w==;
X-CSE-ConnectionGUID: TXdmIqy7Rx2PEkZIBmMt8g==
X-CSE-MsgGUID: 5eMvUs08QyWEatfL/gShcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34666951"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="34666951"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 01:57:40 -0800
X-CSE-ConnectionGUID: CyrDsqVNQpq9aVXhn30Ofw==
X-CSE-MsgGUID: R2kEnO8rTTKX9eAophPF8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96262543"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 01:57:37 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com,
	bhe@redhat.com,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH v2 1/1] kexec_core: Accept unaccepted kexec segments' destination addresses
Date: Fri, 13 Dec 2024 17:54:49 +0800
Message-ID: <20241213095449.881-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241213094930.748-1-yan.y.zhao@intel.com>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_015740_755851_4C01F042 
X-CRM114-Status: GOOD (  23.26  )
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

In TDX, to run a linux guest, TDs (hardware-isolated VMs) must accept
before accessing private memory. Accessing private memory before acceptance
is considered a fatal error and may result in the termination of the TD.

The "accepting memory" operation in guest includes the following steps:
- trigger a VM-exit
- the host OS allocates a physical page and requests hardware to map the
  physical page to the GPA.
- initialize memory content to 0.
- encrypt the memory

For a Linux guest, eagerly accepting all memory during kernel boot can slow
down the boot process and cause unnecessary memory occupation on the host
for pages that may never be accessed. Therefore, Linux guests usually opt
for a lazy mode to delay page acceptance operations by not moving the pages
to the buddy allocator's freelists. Instead, the kernel tracks memory
in 4M units and places them in a zone->unaccepted_pages list if any page in
the entire 4M range is in an unaccepted state (even if part of the memory
range may have been accepted by firmware or the kernel). When the kernel
does not have enough free pages, it will move memory from the
zone->unaccepted_pages list and accept it, ensuring that the memory is
accepted before moving it to the freelists and being available to the buddy
allocator.

The kexec segments' destination addresses are not allocated by the buddy
allocator. Instead, they are searched from normal system RAM (top-down or
bottom-up) and exclude driver-managed memory, ACPI, persistent, and
reserved memory... Although these addresses may fall within the memory
range managed by the buddy allocator (which must be in an accepted state),
they could also be outside that range and in an unaccepted state.

Since the kexec code will access the segments' destination addresses during
the kexec process by swapping their content with the segments' source
pages, it is necessary to accept the memory before performing the swap
operations.

Accept the destination addresses during the kexec load, immediately after
they pass sanity checks. This ensures the code is located in a common place
shared by both the kexec_load and kexec_file_load system calls.

This will not conflict with the accounting in try_to_accept_memory_one()
since the accounting is set during kernel boot and decremented when pages
are moved to the freelists. There is no harm in invoking accept_memory() on
a page before making it available to the buddy allocator.

No need to worry about re-accepting memory since accept_memory() checks the
unaccepted bitmap before accepting a memory page.

Although a user may perform kexec loading without ever triggering the jump,
it doesn't impact much since kexec loading is not in a performance-critical
path. Additionally, the destination addresses are always searched and found
in the same location on a given system.

Changes to the destination address searching logic to locate only memory in
either unaccepted or accepted status are unnecessary and complicated.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3..f8eee0516bd9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -210,6 +210,16 @@ int sanity_check_segment_list(struct kimage *image)
 	}
 #endif
 
+	/*
+	 * The destination addresses are searched from system RAM rather than
+	 * being allocated from the buddy allocator, so they are not guaranteed
+	 * to be accepted by the current kernel.  Accept the destination
+	 * addresses before kexec swaps their content with the segments' source
+	 * pages to avoid accessing memory before it is accepted.
+	 */
+	for (i = 0; i < nr_segments; i++)
+		accept_memory(image->segment[i].mem, image->segment[i].memsz);
+
 	return 0;
 }
 
-- 
2.43.2


