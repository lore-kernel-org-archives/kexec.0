Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lgemrelse1q.lge.com ([156.147.1.111])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFfFO-0004di-9x
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 06:33:12 +0000
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 0/8] remove vm_struct list management
Date: Wed, 13 Mar 2013 15:32:52 +0900
Message-Id: <1363156381-2881-1-git-send-email-iamjoonsoo.kim@lge.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bob Liu <lliubbo@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vivek Goyal <vgoyal@redhat.com>

This patchset remove vm_struct list management after initializing vmalloc.
Adding and removing an entry to vmlist is linear time complexity, so
it is inefficient. If we maintain this list, overall time complexity of
adding and removing area to vmalloc space is O(N), although we use
rbtree for finding vacant place and it's time complexity is just O(logN).

And vmlist and vmlist_lock is used many places of outside of vmalloc.c.
It is preferable that we hide this raw data structure and provide
well-defined function for supporting them, because it makes that they
cannot mistake when manipulating theses structure and it makes us easily
maintain vmalloc layer.

For kexec and makedumpfile, I export vmap_area_list, instead of vmlist.
This comes from Atsushi's recommendation.
For more information, please refer below link.
https://lkml.org/lkml/2012/12/6/184

These are based on v3.9-rc2.

Changes from v1
5/8: skip areas for lazy_free
6/8: skip areas for lazy_free
7/8: export vmap_area_list for kexec, instead of vmlist

Joonsoo Kim (8):
  mm, vmalloc: change iterating a vmlist to find_vm_area()
  mm, vmalloc: move get_vmalloc_info() to vmalloc.c
  mm, vmalloc: protect va->vm by vmap_area_lock
  mm, vmalloc: iterate vmap_area_list, instead of vmlist in
    vread/vwrite()
  mm, vmalloc: iterate vmap_area_list in get_vmalloc_info()
  mm, vmalloc: iterate vmap_area_list, instead of vmlist, in
    vmallocinfo()
  mm, vmalloc: export vmap_area_list, instead of vmlist
  mm, vmalloc: remove list management of vmlist after initializing
    vmalloc

 arch/tile/mm/pgtable.c      |    7 +-
 arch/unicore32/mm/ioremap.c |   17 ++--
 arch/x86/mm/ioremap.c       |    7 +-
 fs/proc/Makefile            |    2 +-
 fs/proc/internal.h          |   18 ----
 fs/proc/meminfo.c           |    1 +
 fs/proc/mmu.c               |   60 -------------
 include/linux/vmalloc.h     |   21 ++++-
 kernel/kexec.c              |    2 +-
 mm/nommu.c                  |    3 +-
 mm/vmalloc.c                |  207 +++++++++++++++++++++++++++++--------------
 11 files changed, 170 insertions(+), 175 deletions(-)
 delete mode 100644 fs/proc/mmu.c

-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
