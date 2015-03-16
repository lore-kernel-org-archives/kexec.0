Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YXQQx-0001Wr-DW
 for kexec@lists.infradead.org; Mon, 16 Mar 2015 08:31:36 +0000
Message-Id: <cover.1426494404.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Mon, 16 Mar 2015 09:26:44 +0100
Subject: [PATCH v2 0/7] Handle mmaped regions in cache
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
  v3: do not mmap fractional pages
  v2: add mmapped regions to page cache

Petr Tesarik (7):
  cache: get rid of search loop in cache_add()
  cache: allow to return a page to the pool
  cache: do not allocate from the pending list
  cache: add hit/miss statistics to the final report
  cache: allocate buffers in one big chunk
  cache: allow arbitrary size of cache entries
  cache: store mapped regions directly in the cache

 cache.c        |  81 +++++++++++++++++----------------
 cache.h        |  16 +++++--
 makedumpfile.c | 138 ++++++++++++++++++++++++++++++++++-----------------------
 3 files changed, 138 insertions(+), 97 deletions(-)

-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
