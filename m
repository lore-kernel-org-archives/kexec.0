Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0AEE9370E
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 13:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1xXNFxx1oQwPn9/sRzxgeeanZwog03482bvsnrJY+zc=; b=TEzwzFiE29+kRz
	0HPBzrC245Wl4tAf1BIPjcpGIDXz+vt47V5NOSnEXVxFiV5jiufnVEO3J2wcwaoWK1sg0vrhEeqBc
	UcV6Xia0G1Drw/Bc1fL6DndJuPQxHvtCW7CRCX9lLnPQLgAgucugQZh3+xK9W/7gCwGG1IRJmv/lk
	WfZl+6zXwggqB+AvDJ9+9vPxMYG8kc0x9oHs+9B3PZ24OZDXQNocNS438IqCvaJrT66yPfdoBHhSc
	L+/qLWIv++wFv28Dl99VcH7xCc0QQtgfrgfW/oOVWpNOMZxzsEli8HPUdwS42+ifo2HpvAlZeaFYy
	vVEx//OQDQlr/moKPwcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoODa-003GcO-1h;
	Thu, 05 Oct 2023 13:16:42 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoODV-003GXo-15
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 13:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696511797; x=1728047797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZXJ1Loo2clcYjSHbu/5/7ENvQ/32ZeG1I2EOrnfZPoM=;
  b=kfbAznYYG67BBf0omnrXb5AcrfQs3uYFb1MzKYwnOhEQ6cB4yJYJ/l2l
   2/BiUy7GVucSh31CKXJvO1Kk8iSBg83cemw3rxH+XFor3ntN6YCDlrn3f
   EVnoX2r6tZcOPTjAVbfR5rd3oD0noREBsA08qa4utkIFVzcIYN5Cv0l8V
   07MorCrYVQm2IKGwgnCxm4jFit5jjEA5JJFpbtVUnu9iAj81IUUt8jtzu
   Id4QN5q3kpBU4UmUMVooPPvo+aZ603J18SYr2Il8Av1W/kxRy7R6uJu2d
   sQf0sOVB/akrd2eAd2JaLp+cwU4vDZUshPfPvXXVCnaUKU7LHZKZLCsaJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380767052"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380767052"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="728449203"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="728449203"
Received: from skwasnia-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.222.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:16 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 0F3D410A12D; Thu,  5 Oct 2023 16:14:14 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 00/13] x86/tdx: Add kexec support
Date: Thu,  5 Oct 2023 16:13:49 +0300
Message-ID: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_061637_552866_3CD4C4D2 
X-CRM114-Status: GOOD (  16.77  )
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

The patchset adds bits and pieces to get kexec (and crashkernel) work on
TDX guest.

They bring kexec support to the point when we can start the new kernel,
but it will only be able to use single CPU. It should be enough to cover
the most common case: crashkernel.

The last patch implements CPU offlining according to the approved ACPI
spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
kernel.

Please review. I would be glad for any feedback.

[1] https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher

Kirill A. Shutemov (13):
  x86/acpi: Extract ACPI MADT wakeup code into a separate file
  kernel/cpu: Add support for declaring CPU hotplug not supported
  cpu/hotplug, x86/acpi: Disable CPU hotplug for ACPI MADT wakeup
  x86/kvm: Do not try to disable kvmclock if it was not enabled
  x86/kexec: Keep CR4.MCE set during kexec for TDX guest
  x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
  x86/mm: Return correct level from lookup_address() if pte is none
  KVM: x86: Add config option to gate emergency virt callback support
  x86/tdx: Account shared memory
  x86/tdx: Convert shared memory back to private on kexec
  x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
  x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
  x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method

 arch/x86/Kconfig                     |   8 +
 arch/x86/coco/core.c                 |   1 -
 arch/x86/coco/tdx/kexec.c            |   0
 arch/x86/coco/tdx/tdx.c              | 220 +++++++++++++++++++++-
 arch/x86/hyperv/ivm.c                |   9 +-
 arch/x86/include/asm/acpi.h          |   5 +
 arch/x86/include/asm/pgtable_types.h |   1 +
 arch/x86/include/asm/reboot.h        |   4 +-
 arch/x86/include/asm/x86_init.h      |   4 +-
 arch/x86/kernel/acpi/Makefile        |  11 +-
 arch/x86/kernel/acpi/boot.c          |  88 +--------
 arch/x86/kernel/acpi/madt.S          |  28 +++
 arch/x86/kernel/acpi/madt_wakeup.c   | 262 +++++++++++++++++++++++++++
 arch/x86/kernel/e820.c               |   9 +-
 arch/x86/kernel/kvmclock.c           |   9 +-
 arch/x86/kernel/reboot.c             |   4 +-
 arch/x86/kernel/relocate_kernel_64.S |   5 +
 arch/x86/kernel/x86_init.c           |   4 +-
 arch/x86/kvm/Kconfig                 |   5 +
 arch/x86/mm/mem_encrypt_amd.c        |   8 +-
 arch/x86/mm/pat/set_memory.c         |  17 +-
 include/acpi/actbl2.h                |  19 +-
 include/linux/cc_platform.h          |  10 -
 include/linux/cpu.h                  |   2 +
 kernel/cpu.c                         |  17 +-
 25 files changed, 604 insertions(+), 146 deletions(-)
 create mode 100644 arch/x86/coco/tdx/kexec.c
 create mode 100644 arch/x86/kernel/acpi/madt.S
 create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
