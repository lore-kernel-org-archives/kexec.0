Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BD4CD8C80
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xOMLMOamIrP4AmPnp89xZuEIAfolAA15p/WKbW4VGQM=; b=p4O1NZRBHoMkni
	wJ1kCrqJ4a4KUgqntlZx5nXTbglAa4cbSVEZ7bz3f3aGFISPDPtFn8WIQWpi6J6S3VZBsIvrp7smI
	Ssf+pP4Lj8ifuqo3UCN4dxm6/n1g/RilVgQTDhU6MuFIu5K6ict4JNoWv6kR65M/1o2WBUVTkPb2W
	506Kw7ar03hWpjqTyMINhkLjd4wPxuv9gW7pgka0Mh7hxADduH2fxZc0PXIXjDSUVsJ8QuiJkWLv1
	t6ORCKJjBLOYjYf7zdLacfkKM5NLZFPnlWJ9IYFeysyny/Hu5S+Y6PWoG1y8cGf3TZh74jv8Jt2NH
	+OIasU6Rod5J1maMGXZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqDU9-00DXCt-1N;
	Tue, 10 Oct 2023 14:13:21 +0000
Received: from bg4.exmail.qq.com ([43.154.221.58])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqDU4-00DXAc-26
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 14:13:20 +0000
X-QQ-mid: bizesmtp78t1696947178tke6kasn
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Oct 2023 22:12:56 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: LE7C6P2vL8QE2eY8LyspcvTwdgPM8GF7HNkT0XMiowMANBdihRB/HXUhL/bzk
	d4caZsrgHdL/C3Aqxbb7HtxjXTnU0kOPwfcjLXBAYiRZjfl/LC6XzB+fiiR9syIOZrSCmlP
	2hd2qVJlpwQYoVleppVj4Nv8M8yHmiEZA606Lw+kmCTdqK7nRHCMlPrZKBHIxRlOJQ+iYdh
	9IU2QYSij0sKvgo9DFkiVacnk3FxbvGmfFQ1P8/JX6iCEW1MmPwvDrl13baVZxpWpD3Wxh5
	Kf88kkgVEc1TFdblulUD1Rrw0Ndnpy2xRtYdeaLEUQYaRQZuIMpu+QcINto7aAiBFjvNQ5Y
	SgpJT1Isc0EAG0bR0U=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6759393584709778382
From: Song Shuai <songshuaishuai@tinylab.org>
To: k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH makedumpfile V2 0/2] Add riscv64 support for makedumpfile
Date: Tue, 10 Oct 2023 22:12:42 +0800
Message-Id: <20231010141244.2261488-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_071317_048738_788C469A 
X-CRM114-Status: GOOD (  12.13  )
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

Changes since V1:
https://lore.kernel.org/kexec/20230927111822.180630-1-songshuaishuai@tinylab.org/

- fix a typo in Patch2's commit-msg
- adjust some indentions of Patch1


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
  
    To let info->max_mapnr indicate the direct max PFN and then
    make the kdump header's max_mapnr_64 correct, riscv64 port
    didn't define ARCH_PFN_OFFSET.
    
    As for FLATMEM type, the pfn region of mem_map_data should
    be adjusted to start from info->phys_base instead of zero.


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
