Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YV0F2-00034S-Bh
 for kexec@lists.infradead.org; Mon, 09 Mar 2015 16:09:17 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 9 Mar 2015 16:08:51 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B998E17D8059
 for <kexec@lists.infradead.org>; Mon,  9 Mar 2015 16:09:09 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29G8mU59502978
 for <kexec@lists.infradead.org>; Mon, 9 Mar 2015 16:08:48 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29G8kSw019495
 for <kexec@lists.infradead.org>; Mon, 9 Mar 2015 10:08:47 -0600
Date: Mon, 9 Mar 2015 17:08:44 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/8] Handle mmaped regions in cache
Message-ID: <20150309170844.69b6d139@holzheu>
In-Reply-To: <cover.1425650592.git.ptesarik@suse.cz>
References: <cover.1425650592.git.ptesarik@suse.cz>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec mailing list <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Jan Willeke <willeke@de.ibm.com>

Hello Petr,

With your patch we get 5-10 percent performance improvement on s390.

Two examples:

$ time ./makedumpfile  -d 31 /proc/vmcore  /dev/null -f

                  user   sys  = total
=====================================
With patches      0.156  0.248  0.404
Without patches   0.168  0.274  0.442  <- No idea why we save system time?

$ time ./makedumpfile  -d 0 /proc/vmcore  /dev/null -f

                  user   sys  = total
=====================================
With patches      0.683  0.020  0.703
Without patches   0.714  0.019  0.733

Regards
Michael

On Fri, 6 Mar 2015 15:03:12 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> Because all pages must go into the cache, data is unnecessarily
> copied from mmapped regions to cache. Avoid this copying by storing
> the mmapped regions directly in the cache.
> 
> First, the cache code needs a clean up clarification of the concept,
> especially the meaning of the pending list (allocated cache entries
> whose content is not yet valid).
> 
> Second, the cache must be able to handle differently sized objects
> so that it can store individual pages as well as mmapped regions.
> 
> Last, the cache eviction code must be extended to allow either
> reusing the read buffer or unmapping the region.
> 
> Changelog:
>   v2: cache cleanup _and_ actuall mmap implementation
>   v1: only the cache cleanup
> 
> Petr Tesarik (8):
>   cache: get rid of search loop in cache_add()
>   cache: allow to return a page to the pool
>   cache: do not allocate from the pending list
>   cache: add hit/miss statistics to the final report
>   cache: allocate buffers in one big chunk
>   cache: allow arbitrary size of cache entries
>   cache: store mapped regions directly in the cache
>   cleanup: remove unused page_is_fractional
> 
>  cache.c        |  81 +++++++++++++++++----------------
>  cache.h        |  16 +++++--
>  elf_info.c     |  16 -------
>  elf_info.h     |   2 -
>  makedumpfile.c | 138 ++++++++++++++++++++++++++++++++++-----------------------
>  5 files changed, 138 insertions(+), 115 deletions(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
