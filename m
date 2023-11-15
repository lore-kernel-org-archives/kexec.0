Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593B7C47076
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 12:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+xQZqNAMh2vGMER2GHPDO270PjBjRW/+kVF12zw3S+A=; b=SPMHW9vs/JbgrG
	mEAwGECjjgbvqHK/4rdPs9Fb5kybR+W+O3oDBwzWg3gGBLZJmBLfj1gbUQ585ob4J64mwEwss37V8
	TvC84G+dQdM/hU/5ZNshk8eYbFuja6uWyq7QvhBVHZvzXZO7It05ifzVUrlE5EtsE7JbSn0ZloDEy
	xeYLsfFWhv5r7vg7DnS/TGxqzFvu3GL5UsoJs5LOWd2N7QmybEcYC+DgSchWbjPSWXNNdE4NGnio9
	fTWYDDeY+Xh68dJ4Ka3EyrCByF3/PCTCmaFcqDZV5u7iXk5wxZo7RoiSnTZqsfOk1USkCnUPIZJmO
	wd5Y/A+bqoC3JNC4ZEHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3EaB-000jJa-1l;
	Wed, 15 Nov 2023 12:01:23 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Ea8-000jGF-1D
	for kexec@lists.infradead.org;
	Wed, 15 Nov 2023 12:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049680; x=1731585680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2EtIF3ixgiNlt80godwBv9gDxaOhRsjIZTUxXE2EFZA=;
  b=hpm67bBmInSe5aEJZtU3gLHArBHB2R/NuVSqFu0CkRk3bBTrkvxIcHUj
   IL0EKINwPbla5fr7OsIpOkj/BiKqQ0T0bNOjDnn8156GZ/KM8S2Uj82jS
   2+3ntF7K//oL6tZtFpii++zZHUyzPdEsAGPzZVFLlolrkSe3q6E2TNsYQ
   ySLLeLworXjbLa7UxbNx1ve6ECFbZOL0o6jNifXhr1toLjeFRoOzEFKW0
   IxSS21EPfzU/8+bqaJLVnnqrCfjGEDO+scLBGnLEAbxlLRIgi65mLa5e5
   yDHsZqLh1jFRJ/U8XFVCody1hFAw3D2N67569l4bgKmEj4NVvdigWWMtr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394780373"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="394780373"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="13160205"
Received: from mituomis-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:12 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8E4C2109F3E; Wed, 15 Nov 2023 15:01:09 +0300 (+03)
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
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 00/14] x86/tdx: Add kexec support
Date: Wed, 15 Nov 2023 15:00:30 +0300
Message-ID: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_040120_474933_113621BE 
X-CRM114-Status: GOOD (  15.65  )
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

The last patch implements CPU offlining according to the approved ACPI
spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
kernel. It requires BIOS-side enabling. If it missing we fallback to booting
2nd kernel with single CPU.

Please review. I would be glad for any feedback.

v3:
  - Rework acpi_mp_crash_stop_other_cpus() to avoid invoking hotplug state
    machine;
  - Free page tables if reset vector setup failed;
  - Change asm_acpi_mp_play_dead() to pass reset vector and PGD as arguments;
  - Mark acpi_mp_* variables as static and __ro_after_init;
  - Use u32 for apicid;
  - Disable CPU offlining if reset vector setup failed;
  - Rename madt.S -> madt_playdead.S;
  - Mark tdx_kexec_unshare_mem() as static;
  - Rebase onto up-to-date tip/master;
  - Whitespace fixes;
  - Reorder patches;
  - Add Reviewed-bys;
  - Update comments and commit messages;
v2:
  - Rework how unsharing hook ups into kexec codepath;
  - Rework kvmclock_disable() fix based on Sean's;
  - s/cpu_hotplug_not_supported()/cpu_hotplug_disable_offlining()/;
  - use play_dead_common() to implement acpi_mp_play_dead();
  - cond_resched() in tdx_shared_memory_show();
  - s/target kernel/second kernel/;
  - Update commit messages and comments;

[1] https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher

Kirill A. Shutemov (14):
  x86/acpi: Extract ACPI MADT wakeup code into a separate file
  x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
  cpu/hotplug: Add support for declaring CPU offlining not supported
  cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
  x86/kvm: Do not try to disable kvmclock if it was not enabled
  x86/kexec: Keep CR4.MCE set during kexec for TDX guest
  x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
  x86/mm: Return correct level from lookup_address() if pte is none
  x86/tdx: Account shared memory
  x86/tdx: Convert shared memory back to private on kexec
  x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
  x86/acpi: Rename fields in acpi_madt_multiproc_wakeup structure
  x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
  x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method

 arch/x86/Kconfig                     |   7 +
 arch/x86/coco/core.c                 |   1 -
 arch/x86/coco/tdx/kexec.c            |   0
 arch/x86/coco/tdx/tdx.c              | 205 +++++++++++++-
 arch/x86/hyperv/ivm.c                |   9 +-
 arch/x86/include/asm/acpi.h          |   5 +
 arch/x86/include/asm/pgtable_types.h |   1 +
 arch/x86/include/asm/x86_init.h      |   5 +-
 arch/x86/kernel/acpi/Makefile        |  11 +-
 arch/x86/kernel/acpi/boot.c          |  88 +-----
 arch/x86/kernel/acpi/madt_playdead.S |  21 ++
 arch/x86/kernel/acpi/madt_wakeup.c   | 400 +++++++++++++++++++++++++++
 arch/x86/kernel/crash.c              |   4 +
 arch/x86/kernel/e820.c               |   9 +-
 arch/x86/kernel/kvmclock.c           |  12 +-
 arch/x86/kernel/reboot.c             |   5 +
 arch/x86/kernel/relocate_kernel_64.S |   5 +
 arch/x86/kernel/x86_init.c           |   4 +-
 arch/x86/mm/mem_encrypt_amd.c        |   8 +-
 arch/x86/mm/pat/set_memory.c         |  17 +-
 include/acpi/actbl2.h                |  19 +-
 include/linux/cc_platform.h          |  10 -
 include/linux/cpu.h                  |   2 +
 kernel/cpu.c                         |  12 +-
 24 files changed, 716 insertions(+), 144 deletions(-)
 create mode 100644 arch/x86/coco/tdx/kexec.c
 create mode 100644 arch/x86/kernel/acpi/madt_playdead.S
 create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
