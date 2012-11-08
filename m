Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOie-00065j-G2
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:18 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B6C203EE0AE
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:08 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9D8CC45DE4E
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:08 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 84B1945DE50
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:08 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 70D0A1DB8037
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:08 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 27FE61DB803B
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:08 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 00/10] Support free page filtering looking up mem_map array
Date: Thu, 08 Nov 2012 18:48:07 +0900
Message-ID: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
MIME-Version: 1.0
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

This patch set implements filtering free pages looking up mem_map
array instead of free lists. This is compatible for cyclic mode
because looking up mem_map can be divided into cycles. On the other
hand, dividing free pages contaiend in free lists is difficult since
they are not sorted in physical-address order.

Unlike RFC version, the logic used is automatically selected at
runtime according to the current mode. On cyclic mode, mem_map array
logic is used. On non-cyclic mode, free list logic is used.

The RFC version is:
http://lists.infradead.org/pipermail/kexec/2012-June/006441.html

* TODO

Add the following values in VMCOREINFO on the upstream kernel. These
are used in the mem_map logic.

  - OFFSET(page._mapcount)
  - OFFSET(page.private)
  - SIZE(pageflags)
  - NUMBER(PG_buddy)
  - NUMBER(PG_slab)
  - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)

* Test

I tested this patch set on the following kernel versions.

- 3.4
- 3.1
- 2.6.38
- 2.6.32
- 2.6.18

On the test, I manually specified VMCOREINFO while extending it with
the following values according to the kernel versions.

- 3.1, 3.4
NUMBER(PG_slab)=7
SIZE(pageflags)=4
OFFSET(page._mapcount)=24
OFFSET(page.private)=48
NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-128

- 2.6.38
SIZE(pageflags)=4
OFFSET(page._mapcount)=12
OFFSET(page.private)=16
NUMBER(PG_slab)=7
NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-2

- 2.6.32
NUMBER(PG_slab)=7
NUMBER(PG_buddy)=19
OFFSET(page._mapcount)=12
OFFSET(page.private)=16
SIZE(pageflags)=4

- 2.6.18
NUMBER(PG_slab)=7
NUMBER(PG_buddy)=19
OFFSET(page._mapcount)=12
OFFSET(page.private)=16

---

HATAYAMA Daisuke (10):
      Print warning about cyclic buffer overrun if it can happen
      Add page_is_buddy for old kernels
      Add page_is_buddy for PG_buddy
      Add page_is_buddy for recent kernels
      Exclude free pages by looking up mem_map array
      Add hardcoded page flag values
      Add debuginfo-related processing for VMCOREINFO/VMLINUX
      Add new parameters to various tables
      Add debuginfo interface for enum type size
      Move page flags setup for old kernels after debuginfo initialization


 dwarf_info.c   |   18 ++++++
 dwarf_info.h   |    1 
 makedumpfile.c |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 makedumpfile.h |   29 +++++++++-
 4 files changed, 204 insertions(+), 14 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
