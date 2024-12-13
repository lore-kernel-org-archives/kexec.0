Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34121E7717F
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BBR1B87usRIUDaVEporfDZt2rFFwqwL5FJmFnOaQGVQ=; b=OKY5xbLxqN1Ekf2INtMGP7i5Sl
	xqd2aK+GKdxVjI8gUZcUJ3T2HKBY9qG7ghV4lpaKijMJ1m8PVfhr4G4ZDCtDCh7rfECp2fSQTE+nk
	8zHomRZlfjSl+MqzLARDx/jNdOkUC0bZ7mWMN/FyPjy2jwOYUd2K/PXIp31kRa9+iq2ltKAJcDPdD
	TwW/qY9AQd3Jq2VKq6/CZVtb4AtjZsq4w334Lgm9Y4K2iLqP2Z2aEyATYQyLvIRaRssuomurdASEE
	A1NAwTkpVWcWZO1q/0IBHG0GC9swGPIZiLuzFV3G+esnjtuDq0ZZx5K590Vvyzm9bUAc95dswESKe
	90ADl0AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM2On-00000003LDc-3GiE;
	Fri, 13 Dec 2024 09:55:53 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM2LT-00000003KIZ-02Br
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 09:52:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734083548; x=1765619548;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xwlk6T0nmyV++vOWX/z4H8mtusZ/0NhrBUoKvYKhCZM=;
  b=B6L2UyeoQHzd0PqM5dd+SkWXwCJZWP4Bz9Oru7hSWzvuPkDOy7Bxc/hn
   sQUGv5bHhuPW1hfAh2xtxfxySuNoFuMv2duK5fSxecvvaUFbEQ7vmzxdB
   AMwn1203meEwiBytvOHzxFEc5NJ6CIG+Aw3DV+I/HdVnhvLtx+aqf0odn
   tZ4v1aOEOobI6o6a3f7KT0D0GWaJ6bq+cXNHSdgQXFSB4MFqo+ETZXc9m
   luNFII1UzpLw3faicpJSBmqFyAzLV+0uKHBLF5P7ta/z1ttsFnoNA5GMI
   nBnZ6Vwi3mN/GngjW1mXHi1qC8d+2FDNEtKn55G2FfDN0S5SHs21mrxLC
   A==;
X-CSE-ConnectionGUID: Oit6HvJeRqqT1zGgIN0gjg==
X-CSE-MsgGUID: /Q2ays8cQOK00F6oAfsRmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="38208348"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="38208348"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 01:52:23 -0800
X-CSE-ConnectionGUID: RbaQtVoiRRCjzNuo9wo9dw==
X-CSE-MsgGUID: xampagART3u7nhSiZyDG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96394961"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 01:52:19 -0800
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
Subject: [PATCH v2 0/1] Accept unaccepted kexec segments' destination addresses
Date: Fri, 13 Dec 2024 17:49:30 +0800
Message-ID: <20241213094930.748-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_015227_109631_F7822FE3 
X-CRM114-Status: GOOD (  21.82  )
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

Hi Eric,

This is a repost of the patch "kexec_core: Accept unaccepted kexec
destination addresses" [1], rebased to v6.13-rc2.

The code implementation remains unchanged, but the patch message now
includes more background and explanations to address previous concerns from
you and Baoquan.

Additionally, below is a more detailed explanation of unaccepted memory in
TDX. Please let me know if it is still not clear enough.


== UnAccepted memory in TDX ==

Intel TDX (Trusted Domain Extension) provides a hardware-based trusted
execution environment for TDs (hardware-isolated VMs). The host OS is not
trusted. Although it allocates physical pages for TDs, it does not and
cannot know the content of TD's pages.

TD's memory is added via two methods by invoking different instructions in
the host:
1. For TD's initial private memory, such as for firmware HOBs:
   - This type of memory is added without requiring the TD's acceptance.
   - The TD will perform attestation of the page GPA and content later.

2. For TD's runtime private memory:
   - After the host adds memory, it is pending for the TD's acceptance.

Memory added by method 1 is not relevant to the unaccepted memory we will
discuss.

For memory added by method 2, the TD's acceptance can occur before or after
the TD's memory access:
(a) Access first:
    - TD accesses a private GPA,
    - Host OS allocates physical memory,
    - Host OS requests hardware to map the physical page to the GPA,
    - TD accepts the GPA.

(b) Accept first:
    - TD accepts a private GPA,
    - Host OS allocates physical memory,
    - Host OS requests hardware to map the physical page to the GPA,
    - TD accesses the GPA.

For "(a) Access first", it is regarded as unsafe for a Linux guest and is
therefore not chosen.
For "(b) Accept first", the TD's "accept" operation includes the following
steps:
- Trigger a VM-exit
- The host OS allocates a physical page and requests hardware to map the
  physical page to the GPA.
- Initialize the physical page with content set to 0.
- Encrypt the memory 


To enable the "Accept first" approach, an "unaccepted memory" mechanism is
used, which requires cooperation from the virtual firmware and the Linux
guest.

1. The host OS adds initial private memory that does not require TD's
   acceptance. The host OS composes EFI_HOB_RESOURCE_DESCRIPTORs and loads
   the virtual firmware first. Guest RAM, excluding that for initial
   memory, is reported as UNACCEPTED in the descriptor.

2. The virtual firmware parses the descriptors and accepts the UNACCEPTED
   memory below 4G. It then excludes the below-4G range from the UNACCEPTED
   range.

3. The virtual firmware loads the Linux guest image (the address to load is
   below 4G).

4. The Linux guest requests the UNACCEPTED bitmap from the virtual
   firmware:
   - Locate EFI_UNACCEPTED_MEMORY entries from the memory map returned by
     the efi_get_memory_map boot service.
   - Request via EFI boot service to allocate an unaccepted_table in memory
     of type EFI_ACPI_RECLAIM_MEMORY (E820_TYPE_ACPI) to hold the
     unaccepted bitmap.
   - Install the unaccepted_table as an EFI configuration table via the
     boot service.
   - Initialize the unaccepted bitmap according to the
     EFI_UNACCEPTED_MEMORY entries.

5. The Linux guest decompresses the kernel image. It accepts the target GPA
   for decompression first in case it is not accepted by the virtual
   firmware.

6. The Linux guest calls memblock_free_all() to put all memory into the
   freelists for the buddy allocator. memblock_free_all() further calls
   down to __free_pages_core() to handle memory in 4M (order 10) units.

  - In eager mode, the Linux guest accepts all memory and appends it to the
    freelists.
  - In lazy mode, the Linux guest checks if the entire 4M memory has been
    accepted by querying the unaccepted bitmap.
    a) If all memory is accepted, it adds the 4M memory to the freelists.
    b) If any memory is unaccepted (even if the range contains accepted
       pages), the Linux guest does not add the 4M memory to the freelists.
       Instead, it queues the first page in the 4M range onto the list
       zone->unaccepted_pages and sets the first page with the Unaccepted
       flag.

7. When there is not enough free memory, cond_accept_memory() in the Linux
   guest calls try_to_accept_memory_one() to dequeue a page from the list
   zone->unaccepted_pages, clear its Unaccepted flag, accept the entire 4M
   memory range represented by the page, and add the 4M memory to the
   freelists.


== Conclusion ==
- The zone->unaccepted_pages is a mechanism to conditionally make accepted
  private memory available to the page allocators.
- The unaccepted bitmap resides in the firmware's reserved memory and
  persists across guest OSs. It records exactly which pages have not been
  accepted.
- Memory ranges represented by zone->unaccepted_pages may contain accepted
  pages.


For kexec in TDs,
- If the segments' destination addresses are within the range managed by
  the buddy allocator, the pages must have been in an accepted state.
  Calling accept_memory() will check the unaccepted bitmap and do nothing.
- If the segments' destination addresses are not yet managed by the buddy
  allocator, the pages may or may not have been accepted.
  Calling accept_memory() will perform the "accept" operation if they are
  not accepted.

For the kexec's second guest kernel, it obtains the unaccepted bitmap by
locating the unaccepted_table in the EFI configuration tables. So, pages
unset in the unaccepted bitmap are not accepted repeatedly.


The unaccepted table/bitmap is only useful for TDs. For a Linux host, it
will detect that the physical firmware does not support the memory
acceptance protocol, and accept_memory() will simply bail out.

Thanks
Yan

[1] https://lore.kernel.org/all/20241021034553.18824-1-yan.y.zhao@intel.com

Yan Zhao (1):
  kexec_core: Accept unaccepted kexec segments' destination addresses

 kernel/kexec_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.43.2


