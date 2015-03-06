Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YTsul-0005hn-Pl
 for kexec@lists.infradead.org; Fri, 06 Mar 2015 14:07:45 +0000
Message-Id: <cover.1425650592.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 15:03:12 +0100
Subject: [PATCH v2 0/8] Handle mmaped regions in cache
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>

Because all pages must go into the cache, data is unnecessarily
copied from mmapped regions to cache. Avoid this copying by storing
the mmapped regions directly in the cache.

First, the cache code needs a clean up clarification of the concept,
especially the meaning of the pending list (allocated cache entries
whose content is not yet valid).

Second, the cache must be able to handle differently sized objects
so that it can store individual pages as well as mmapped regions.

Last, the cache eviction code must be extended to allow either
reusing the read buffer or unmapping the region.

Changelog:
  v2: cache cleanup _and_ actuall mmap implementation
  v1: only the cache cleanup

Petr Tesarik (8):
  cache: get rid of search loop in cache_add()
  cache: allow to return a page to the pool
  cache: do not allocate from the pending list
  cache: add hit/miss statistics to the final report
  cache: allocate buffers in one big chunk
  cache: allow arbitrary size of cache entries
  cache: store mapped regions directly in the cache
  cleanup: remove unused page_is_fractional

 cache.c        |  81 +++++++++++++++++----------------
 cache.h        |  16 +++++--
 elf_info.c     |  16 -------
 elf_info.h     |   2 -
 makedumpfile.c | 138 ++++++++++++++++++++++++++++++++++-----------------------
 5 files changed, 138 insertions(+), 115 deletions(-)

-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
