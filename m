Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MtPS4-0006S7-9l
	for kexec@lists.infradead.org; Thu, 01 Oct 2009 17:28:29 +0000
Date: Fri, 02 Oct 2009 01:28:16 +0800 (CST)
Message-Id: <20091002.012816.266343564.caiqian@redhat.com>
Subject: Can't exclude unnecessary pages for 2.6.31 Kernel
From: CAI Qian <caiqian@redhat.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: oomichi@mxs.nes.nec.co.jp, nhorman@redhat.com, tachibana@mxm.nes.nec.co.jp, caiqian@redhat.com

Hallo!

Met 2 issues with 2.6.31 kernel.

(1) makedumpfile needs to be updated to support 2.6.31 kernel. This looks like 
    an easy fix. In makedumpfile.h,

    #define LATEST_VERSION          (0x0206001d)    /* linux-2.6.29 */

(2) makedumpfile -d 16 failed.

# makedumpfile -D -d 16
  /var/crash/127.0.0.1-2009-10-01-06\:22\:33/vmcore vmcore

LOAD (0)
  phys_start : 1000000
  phys_end   : 2683000
  virt_start : ffffffff81000000
  virt_end   : ffffffff82683000
LOAD (1)
  phys_start : 0
  phys_end   : a0000
  virt_start : ffff810000000000
  virt_end   : ffff8100000a0000
LOAD (2)
  phys_start : 100000
  phys_end   : 3000000
  virt_start : ffff810000100000
  virt_end   : ffff810003000000
LOAD (3)
  phys_start : b000000
  phys_end   : 3ff70000
  virt_start : ffff81000b000000
  virt_end   : ffff81003ff70000
Linux kdump
page_size    : 4096

max_mapnr    : 3ff70
The kernel version is not supported.
The created dumpfile may be incomplete.

num of NODEs : 1


Memory type  : SPARSEMEM

mem_map (0)
  mem_map    : ffff880002664000
  pfn_start  : 0
  pfn_end    : 8000
mem_map (1)
  mem_map    : 0
  pfn_start  : 8000
  pfn_end    : 10000
mem_map (2)
  mem_map    : 0
  pfn_start  : 10000
  pfn_end    : 18000
mem_map (3)
  mem_map    : 0
  pfn_start  : 18000
  pfn_end    : 20000
mem_map (4)
  mem_map    : 0
  pfn_start  : 20000
  pfn_end    : 28000
mem_map (5)
  mem_map    : 0
  pfn_start  : 28000
  pfn_end    : 30000
mem_map (6)
  mem_map    : 0
  pfn_start  : 30000
  pfn_end    : 38000
mem_map (7)
  mem_map    : 0
  pfn_start  : 38000
  pfn_end    : 3ff70
Excluding unnecessary pages        : [100 %] page_to_pfn: Can't convert
the address of page descriptor (ffffea000004e000) to pfn.

create_2nd_bitmap: Can't exclude unnecessary pages.

makedumpfile Failed.

Thanks!
CAI Qian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
