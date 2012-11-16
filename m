Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE3f-00065V-00
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:01:41 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E3B783EE0B6
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:31 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id CBF3745DEBC
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:31 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id B2B5E45DEB7
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:31 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A79E51DB803B
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:31 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 600491DB803C
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:31 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 00/10] Support free page filtering looking up mem_map array
Date: Fri, 16 Nov 2012 14:01:30 +0900
Message-ID: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

This patch set implements filtering free pages looking up mem_map
array instead of free lists. This is compatible for cyclic mode
because looking up mem_map can be divided into cycles. On the other
hand, dividing free pages contaiend in free lists is difficult since
they are not sorted in physical-address order.

* Changes

v1 => v2:
  - If debuginfo is not available enough, switch logic to freelist
    one. On v1, free page filtering was disabled in this case.
  - Add hard-coded values in wider kernel versions.
  - If some free pages possibly fail to be filtered, try to correct
    cyclic buffer size appropreately.
  - Correct the comment explaining the cyclic buffer overrun, which
    was broken on v1.

RFC => v1:
  - Logic is automatically selected at runtime according to the
    current mode. In cyclic mode, mem_map array logic is used. In
    non-cyclic mode, free list logic is used.
  - The RFC version is:
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
      Warn cyclic buffer overrun and correct it if possible
      Add page_is_buddy for old kernels
      Add page_is_buddy for PG_buddy
      Add page_is_buddy for recent kernels
      Exclude free pages by looking up mem_map array
      Add hardcoded page flag values
      Add debuginfo-related processing for VMCOREINFO/VMLINUX
      Add new parameters to various tables
      Add debuginfo interface for enum type size
      Move page flags setup for old kernels after debuginfo initialization


 dwarf_info.c   |   18 ++++
 dwarf_info.h   |    1 
 makedumpfile.c |  226 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 makedumpfile.h |   35 ++++++++-
 4 files changed, 269 insertions(+), 11 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
