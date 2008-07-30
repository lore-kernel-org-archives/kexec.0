Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KOCQr-00053X-6c
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 14:13:37 +0000
Date: Wed, 30 Jul 2008 16:14:16 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: makedumpfile fails on SGI machine
Message-ID: <20080730161416.47605c30@halley.suse.de>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

Hi,

makedumpfile 1.2.7 fails on a SGI machine with following error:

readmem: Can't convert a virtual address(a0007fff8f900000) to offset.

The debug output is

--------------------------------------- 8< --------------------------
LOAD (0)
  phys_start : 3014000000
  phys_end   : 301466d660
  virt_start : a000000100000000
  virt_end   : a00000010066d660
LOAD (1)
  phys_start : 3000080000
  phys_end   : 3000400000
  virt_start : e000003000080000
  virt_end   : e000003000400000
LOAD (2)
  phys_start : 3003000000
  phys_end   : 3006000000
  virt_start : e000003003000000
  virt_end   : e000003006000000
LOAD (3)
  phys_start : 3006000000
  phys_end   : 3014000000
  virt_start : e000003006000000
  virt_end   : e000003014000000
LOAD (4)
  phys_start : 3014000000
  phys_end   : 3014f0b000
  virt_start : e000003014000000
  virt_end   : e000003014f0b000
LOAD (5)
  phys_start : 3014f0b000
  phys_end   : 3018000000
  virt_start : e000003014f0b000
  virt_end   : e000003018000000
LOAD (6)
  phys_start : 3038000000
  phys_end   : 307bffe000
  virt_start : e000003038000000
  virt_end   : e00000307bffe000
LOAD (7)
  phys_start : b000080000
  phys_end   : b000400000
  virt_start : e00000b000080000
  virt_end   : e00000b000400000
LOAD (8)
  phys_start : b003000000
  phys_end   : b006000000
  virt_start : e00000b003000000
  virt_end   : e00000b006000000
LOAD (9)
  phys_start : b006000000
  phys_end   : b079e8c000
  virt_start : e00000b006000000
  virt_end   : e00000b079e8c000
LOAD (10)
  phys_start : b079e8c000
  phys_end   : b079e92000
  virt_start : e00000b079e8c000
  virt_end   : e00000b079e92000
LOAD (11)
  phys_start : b079e92000
  phys_end   : b079e93000
  virt_start : e00000b079e92000
  virt_end   : e00000b079e93000
LOAD (12)
  phys_start : b079e93000
  phys_end   : b07a3f2000
  virt_start : e00000b079e93000
  virt_end   : e00000b07a3f2000
LOAD (13)
  phys_start : b07a3f2000
  phys_end   : b07a452000
  virt_start : e00000b07a3f2000
  virt_end   : e00000b07a452000
LOAD (14)
  phys_start : b07a452000
  phys_end   : b07a7fe000
  virt_start : e00000b07a452000
  virt_end   : e00000b07a7fe000
LOAD (15)
  phys_start : b07b800000
  phys_end   : b07b801000
  virt_start : e00000b07b800000
  virt_end   : e00000b07b801000
LOAD (16)
  phys_start : b07b801000
  phys_end   : b07b88c000
  virt_start : e00000b07b801000
  virt_end   : e00000b07b88c000
LOAD (17)
  phys_start : b07b88c000
  phys_end   : b07b894000
  virt_start : e00000b07b88c000
  virt_end   : e00000b07b894000
LOAD (18)
  phys_start : b07b894000
  phys_end   : b07b896000
  virt_start : e00000b07b894000
  virt_end   : e00000b07b896000
LOAD (19)
  phys_start : b07b896000
  phys_end   : b07b89e000
  virt_start : e00000b07b896000
  virt_end   : e00000b07b89e000
LOAD (20)
  phys_start : b07b89e000
  phys_end   : b07b89f000
  virt_start : e00000b07b89e000
  virt_end   : e00000b07b89f000
LOAD (21)
  phys_start : b07b89f000
  phys_end   : b07ba00000
  virt_start : e00000b07b89f000
  virt_end   : e00000b07ba00000
LOAD (22)
  phys_start : b07ba00000
  phys_end   : b07bd5a000
  virt_start : e00000b07ba00000
  virt_end   : e00000b07bd5a000
LOAD (23)
  phys_start : b07bd94000
  phys_end   : b07be00000
  virt_start : e00000b07bd94000
  virt_end   : e00000b07be00000
LOAD (24)
  phys_start : b07be00000
  phys_end   : b07be12000
  virt_start : e00000b07be00000
  virt_end   : e00000b07be12000
LOAD (25)
  phys_start : b07be80000
  phys_end   : b07be8e000
  virt_start : e00000b07be80000
  virt_end   : e00000b07be8e000
Linux kdump

max_mapnr    : 2c1efa3

num of NODEs : 2


Memory type  : DISCONTIGMEM

mem_map (0)
  mem_map    : 0
  pfn_start  : 0
  pfn_end    : c00c00
mem_map (1)
  mem_map    : a0007fff8f900000
  pfn_start  : c00c00
  pfn_end    : c1efff
mem_map (2)
  mem_map    : 0
  pfn_start  : c1efff
  pfn_end    : 2c00c00
mem_map (3)
  mem_map    : a0007fffff900000
  pfn_start  : 2c00c00
  pfn_end    : 2c1efa3
Checking for memory holes          : [100 %] readmem: Can't convert a
virtual address(a0007fff8f900000) to offset.
--------------------------------------- >8 --------------------------

After debugging that, I didn't find an error code. That address is in
fact the beginning of the mem_map of that node, and is in fact not
mapped (I verified that in crash).

With an older kernel and an older makedumpfile it succeeds. The
debugging output here is:

---------------------------------------- 8< --------------------------
LOAD (0)
  phys_start : 3014000000
  phys_end   : 30145ac840
  virt_start : a000000100000000
  virt_end   : a0000001005ac840
LOAD (1)
  phys_start : 3000080000
  phys_end   : 3000400000
  virt_start : e000003000080000
  virt_end   : e000003000400000
LOAD (2)
  phys_start : 3003000000
  phys_end   : 3006000000
  virt_start : e000003003000000
  virt_end   : e000003006000000
LOAD (3)
  phys_start : 3006000000
  phys_end   : 3014000000
  virt_start : e000003006000000
  virt_end   : e000003014000000
LOAD (4)
  phys_start : 3014000000
  phys_end   : 3015b9f000
  virt_start : e000003014000000
  virt_end   : e000003015b9f000
LOAD (5)
  phys_start : 3015b9f000
  phys_end   : 3018000000
  virt_start : e000003015b9f000
  virt_end   : e000003018000000
LOAD (6)
  phys_start : 3038000000
  phys_end   : 307bffe000
  virt_start : e000003038000000
  virt_end   : e00000307bffe000
LOAD (7)
  phys_start : b000080000
  phys_end   : b000400000
  virt_start : e00000b000080000
  virt_end   : e00000b000400000
LOAD (8)
  phys_start : b003000000
  phys_end   : b006000000
  virt_start : e00000b003000000
  virt_end   : e00000b006000000
LOAD (9)
  phys_start : b006000000
  phys_end   : b079ea2000
  virt_start : e00000b006000000
  virt_end   : e00000b079ea2000
LOAD (10)
  phys_start : b079ea2000
  phys_end   : b07a3f4000
  virt_start : e00000b079ea2000
  virt_end   : e00000b07a3f4000
LOAD (11)
  phys_start : b07a3f4000
  phys_end   : b07a452000
  virt_start : e00000b07a3f4000
  virt_end   : e00000b07a452000
LOAD (12)
  phys_start : b07a452000
  phys_end   : b07a7fe000
  virt_start : e00000b07a452000
  virt_end   : e00000b07a7fe000
LOAD (13)
  phys_start : b07b800000
  phys_end   : b07b801000
  virt_start : e00000b07b800000
  virt_end   : e00000b07b801000
LOAD (14)
  phys_start : b07b801000
  phys_end   : b07b88c000
  virt_start : e00000b07b801000
  virt_end   : e00000b07b88c000
LOAD (15)
  phys_start : b07b88c000
  phys_end   : b07b894000
  virt_start : e00000b07b88c000
  virt_end   : e00000b07b894000
LOAD (16)
  phys_start : b07b894000
  phys_end   : b07b896000
  virt_start : e00000b07b894000
  virt_end   : e00000b07b896000
LOAD (17)
  phys_start : b07b896000
  phys_end   : b07b89e000
  virt_start : e00000b07b896000
  virt_end   : e00000b07b89e000
LOAD (18)
  phys_start : b07b89e000
  phys_end   : b07b89f000
  virt_start : e00000b07b89e000
  virt_end   : e00000b07b89f000
LOAD (19)
  phys_start : b07b89f000
  phys_end   : b07ba00000
  virt_start : e00000b07b89f000
  virt_end   : e00000b07ba00000
LOAD (20)
  phys_start : b07ba00000
  phys_end   : b07bd5a000
  virt_start : e00000b07ba00000
  virt_end   : e00000b07bd5a000
LOAD (21)
  phys_start : b07bd94000
  phys_end   : b07be00000
  virt_start : e00000b07bd94000
  virt_end   : e00000b07be00000
LOAD (22)
  phys_start : b07be00000
  phys_end   : b07be12000
  virt_start : e00000b07be00000
  virt_end   : e00000b07be12000
LOAD (23)
  phys_start : b07be80000
  phys_end   : b07be8e000
  virt_start : e00000b07be80000
  virt_end   : e00000b07be8e000

max_mapnr    : 2c1efa3

num of NODEs : 2


Memory type  : DISCONTIGMEM

pfn_end of node (1) is over max_mapnr.
  pfn_start: 2c00000
  pfn_end  : 2c1f000
  max_mapnr: 2c1efa3
mem_map (0)
  mem_map    : 0
  pfn_start  : 0
  pfn_end    : c00000
mem_map (1)
  mem_map    : a0007fff8f938000
  pfn_start  : c00000
  pfn_end    : c1f000
mem_map (2)
  mem_map    : 0
  pfn_start  : c1f000
  pfn_end    : 2c00000
mem_map (3)
  mem_map    : a0007fffff938000
  pfn_start  : 2c00000
  pfn_end    : 2c1efa3
--------------------- >8 -----------------------------------------

Can you help here? I'm currently a bit short in time ... :-(



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
