Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YY5Rc-0003Zq-W0
 for kexec@lists.infradead.org; Wed, 18 Mar 2015 04:19:01 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v2 0/7] Handle mmaped regions in cache
Date: Wed, 18 Mar 2015 04:17:30 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D993AA@BPXM01GP.gisp.nec.co.jp>
References: <cover.1426494404.git.ptesarik@suse.cz>
In-Reply-To: <cover.1426494404.git.ptesarik@suse.cz>
Content-Language: ja-JP
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "willeke@de.ibm.com" <willeke@de.ibm.com>

Hello Petr,

>Because all pages must go into the cache, data is unnecessarily
>copied from mmapped regions to cache. Avoid this copying by storing
>the mmapped regions directly in the cache.
>
>First, the cache code needs a clean up clarification of the concept,
>especially the meaning of the pending list (allocated cache entries
>whose content is not yet valid).
>
>Second, the cache must be able to handle differently sized objects
>so that it can store individual pages as well as mmapped regions.
>
>Last, the cache eviction code must be extended to allow either
>reusing the read buffer or unmapping the region.
>
>Changelog:
>  v3: do not mmap fractional pages
>  v2: add mmapped regions to page cache

Thanks for your re-posting.
I'm testing with the v3 patch, it works fine so far.
So v1.5.8 can be released next week.


Thanks
Atsushi Kumagai

>Petr Tesarik (7):
>  cache: get rid of search loop in cache_add()
>  cache: allow to return a page to the pool
>  cache: do not allocate from the pending list
>  cache: add hit/miss statistics to the final report
>  cache: allocate buffers in one big chunk
>  cache: allow arbitrary size of cache entries
>  cache: store mapped regions directly in the cache
>
> cache.c        |  81 +++++++++++++++++----------------
> cache.h        |  16 +++++--
> makedumpfile.c | 138 ++++++++++++++++++++++++++++++++++-----------------------
> 3 files changed, 138 insertions(+), 97 deletions(-)
>
>--
>1.8.4.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
