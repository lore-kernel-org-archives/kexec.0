Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F612E810D0
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oLnPSNebWlhvnmCTiEiKjbeRYtHE9vZdo6OzpYEuKGg=; b=gVb+ZC47FjVVIo
	3qzIiiso+73FDX2/rjZf/efctX8+qdhM5dW87IY6yijUn3iW3QRlcvpRyehG+7Am+7AeesTQlZMKw
	VKq5Z6VtOOrriMDF9cqBlNdi9OY+eB/46UkUuTl6FlmXCIzK28bCZzuW6w8oLXAUERf3TWGnSJwGm
	abskZ3jdGbD4bFJsAopcRxRTIeG8cDbioyLKq82GcpHnVjmyPraUIvPDWCR6bvJAdCHlYR4YQFQMt
	Vpvo4hNKM9F7lSkg9T17viGY/yY3AWh8jc3y2OxVNHfvJ+IWmZrGHo8we3HFiGAv+zt6jiF5pIgJy
	HzACY8+/oJOqyEiGofeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSZ8-000nId-0z;
	Wed, 27 Sep 2023 11:18:50 +0000
Received: from bg4.exmail.qq.com ([43.154.221.58])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSZ5-000nI9-1f
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 11:18:49 +0000
X-QQ-mid: bizesmtp70t1695813516tlqe4s7e
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Sep 2023 19:18:35 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: eSZ1CZgv+JD7iHPpKJQ1UF9UprXxx2GeEwMvzWw3u0An2DkWw0TWzaJw3O514
	ldFCeiVfyKFz52D4Gr8eKNpO8WxCz9JdUkVz+CFdbY+zn29q999zmHRZmEoY6VObhOOzxMg
	3kVuWuPSvmZF1xIAg892HPOzXLkgFQVy70hRENHO8YSTW3XGKBF87ssXxgTM99SUdLqwbEQ
	VbJpof3HvnQlX+myhHmNUnTuzltldRhaxDxBB+ofznVg/JcAtB140vYAbN1KZpn2S8o4S58
	nwfMPEZSG7AWgsGhY7GuuLJEh1NFSXCyuXcnNo2yiqZ4Pxj+0V95GT4Ov7V9Q2713H+XITy
	yy9e+xfH7jZCKLQaNDLOee7LZo0pQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 104629763165474822
From: Song Shuai <songshuaishuai@tinylab.org>
To: kexec@lists.infradead.org
Cc: Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH makedumpfile 0/2] Add riscv64 support for makedumpfile
Date: Wed, 27 Sep 2023 19:18:20 +0800
Message-Id: <20230927111822.180630-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_041847_895904_93EAD0CC 
X-CRM114-Status: GOOD (  11.99  )
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

These 2 patches add riscv64 support for makedumpfile:

Patch1 - Add riscv64 support 
===========================

This patch adds support for riscv64 in makedumpfile.
It implements the "vtop" for kenrel memory regions
and supports Sv39/Sv48/Sv57 page modes for RV64.


Patch2 - riscv64: Correct the pfn_start for flatmem
==================================================

This patch temporarily fixes a issue of the tests about FLATMEM, 
as the commit-msg says:
  
    To let info->max_mapnr indicte the direct max PFN and then
    make the kdump header's max_mapnr_64 correct, riscv64 port
    didn't define ARCH_PFN_OFFSET.
    
    As for FLATMEM type, the pfn region of mem_map_data should
    be adjusted to start from info->phys_base instead of zero.

Not taking other arches into consideration and test, so I simplely
judge the __riscv64__ instead of ARCH_PFN_OFFSET. Maybe we can improve it. 


Tests
=====

With these 2 patches, the following tests had passed in RV64 Qemu virt machine:

Preparation: 
-----------

1. build kernel with FLATMEM and SPARSE memory models 
2. boot kernel with 3 different page-modes by setting nov4l/nov5l in cmdline 
3. panic kernel 

Tests:
-----

1. create kdump-compressed file via this command 
   - `/mnt/mkdf_f -d31 -f -c /proc/vmcore /mnt/dump.file1`
   - or with `--vtop` option to translate some typical addresses (like:
     kernel_link_addr, vmalloc_start, page_offset)

2. start crash with kdump file and do some VTOPs 


A test log: 
-----------

# With the Sv57 and SPARSE_EXTREME kernel  
# vtop the vmalloc start address -- 0xff20000000000000


# /mnt/mkdf_f  --vtop 0xff20000000000000 -d31 -f --non-mmap -c /proc/vmcore /mnt/dump.file1

Translating virtual address ff20000000000000 to physical address.
VIRTUAL           PHYSICAL
ff20000000000000  80087000

Copying data                                      : [100.0 %] |
eta: 0s

The dumpfile is saved to /mnt/dump.file1.

makedumpfile Completed.

# sudo ../crash/crash /home/song/9_linux/linux/00_rv_def/vmlinux /tmp/hello/dump.file1
...
      KERNEL: /home/song/9_linux/linux/00_rv_def/vmlinux
    DUMPFILE: /tmp/hello/dump.file1  [PARTIAL DUMP]
        CPUS: 2
        DATE: Wed Sep 27 18:37:45 CST 2023
      UPTIME: 00:00:18
LOAD AVERAGE: 0.00, 0.00, 0.00
       TASKS: 55
    NODENAME: (none)
     RELEASE: 6.6.0-rc1-00007-g22bfc766389c
     VERSION: #1 SMP Mon Sep 25 19:29:05 CST 2023
     MACHINE: riscv64  (unknown Mhz)
      MEMORY: 511.8 MB
       PANIC: "Kernel panic - not syncing: sysrq triggered crash"
         PID: 1
     COMMAND: "sh"
        TASK: ff600000000e0000  [THREAD_INFO: ff600000000e0000]
         CPU: 1
       STATE: TASK_RUNNING (PANIC)

crash> vtop 0xff20000000000000
VIRTUAL           PHYSICAL        
ff20000000000000  80087000        

  PGD: ffffffff814fa900 => 20010c01
  P4D: 0000000080043000 => 0000000020025401
  PUD: 0000000080095000 => 0000000020025801
  PMD: 0000000080096000 => 0000000020026001
  PTE: 80098000 => 20021ce7
 PAGE: 0000000080087000

  PTE     PHYSICAL  FLAGS
20021ce7  80087000  (PRESENT|READ|WRITE|GLOBAL|ACCESSED|DIRTY)  

      PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
ff1c0000020021c0 80087000                0        0  1 0  // same as the makedumpfile's vtop  


Song Shuai (2):
  Add riscv64 support
  riscv64: Correct the pfn_start for flatmem

 Makefile       |   2 +-
 arch/riscv64.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |  18 ++++
 makedumpfile.h | 107 ++++++++++++++++++++++++
 4 files changed, 345 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv64.c

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
