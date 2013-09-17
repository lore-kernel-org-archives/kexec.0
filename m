Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLonP-0004fP-O4
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 06:30:02 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id BC6D53EE0C0
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:39 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id AB80445DE59
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:39 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 91F0945DE54
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:39 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 828B0E08005
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:39 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2644BE08002
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:39 +0900 (JST)
Subject: [PATCH 2/2] cache: reuse entry in pending list
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Tue, 17 Sep 2013 15:29:38 +0900
Message-ID: <20130917062938.4671.23642.stgit@localhost6.localdomain6>
In-Reply-To: <20130917062606.4671.40617.stgit@localhost6.localdomain6>
References: <20130917062606.4671.40617.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, ptesarik@suse.cz

Currently, sadump_virt_phys_base() fails to calculate phys_base as
below:

$ /pub/repos/makedumpfile/makedumpfile -f -p -d 31 -x /pub3/vmcores/comparevmcore_data/vmlinux-2.6.18-363.el5 /pub3/vmcores/comparevmcore_data/vmcore-2.6.18-363.el5-sadump /pub3/vmcores/comparevmcore_data/vmcore-pd31
Switched running mode from cyclic to non-cyclic,
because the cyclic mode doesn't support sadump format.
readmem: type_addr: 1, addr:296020, size:13
readmem: type_addr: 1, addr:ffffffffff296020, size:13
readmem: type_addr: 1, addr:ffffffffff396020, size:13
readmem: type_addr: 1, addr:ffffffffff496020, size:13
readmem: type_addr: 1, addr:ffffffffff596020, size:13
readmem: type_addr: 1, addr:ffffffffff696020, size:13
readmem: type_addr: 1, addr:ffffffffff796020, size:13
readmem: type_addr: 1, addr:ffffffffff896020, size:13
readmem: type_addr: 1, addr:ffffffffff996020, size:13
readmem: type_addr: 1, addr:ffffffffffa96020, size:13
readmem: type_addr: 1, addr:ffffffffffb96020, size:13
readmem: type_addr: 1, addr:ffffffffffc96020, size:13
readmem: type_addr: 1, addr:ffffffffffd96020, size:13
readmem: type_addr: 1, addr:ffffffffffe96020, size:13
readmem: type_addr: 1, addr:fffffffffff96020, size:13
readmem: type_addr: 1, addr:96020, size:13
readmem: type_addr: 1, addr:196020, size:13
readmem: type_addr: 1, addr:296020, size:13
readmem: type_addr: 1, addr:396020, size:13
readmem: type_addr: 1, addr:496020, size:13
readmem: type_addr: 1, addr:596020, size:13
readmem: type_addr: 1, addr:696020, size:13
readmem: type_addr: 1, addr:796020, size:13
readmem: type_addr: 1, addr:896020, size:13
readmem: type_addr: 1, addr:996020, size:13
readmem: type_addr: 1, addr:a96020, size:13
readmem: type_addr: 1, addr:b96020, size:13
readmem: type_addr: 1, addr:c96020, size:13
readmem: type_addr: 1, addr:d96020, size:13
readmem: type_addr: 1, addr:e96020, size:13
readmem: type_addr: 1, addr:f96020, size:13
readmem: type_addr: 1, addr:1096020, size:13
readmem: type_addr: 1, addr:1196020, size:13
readmem: type_addr: 1, addr:1296020, size:13
readmem: type_addr: 0, addr:ffffffff8045e260, size:32
cpu_online_mask_init: Can't read cpu_online_mask memory.

makedumpfile Failed.

By git bisect, I found this bug is caused by the following commit:

commit 0aff0e5174d0708bf1bfb039ab863e1fea8a1029
Author: Petr Tesarik <ptesarik@suse.cz>
Date:   Wed Oct 31 16:12:47 2012 +0900

    [PATCH] keep dumpfile pages in a cache.

Then, I found this bug happens in the following senario.

If one of the readpage_xxx() methods fails reading 8 pages in a row, 8
entries in pool are fully contained in pending list. Then,
cache_alloc() returns NULL and this continues forever in the
execution. In other words, there's assumption in cache_alloc() that if
pool is fully used, they are fully in used list, not in pending list
at all. However, the buggy path here breaks the assumption. This patch
changes cache_alloc() so that it first tries to reuse enty in pending
list if exists.

In fact, I found this bug in ad-hoc phys_base calculation performed in
sadump_virt_phys_base(). However, I fixed cache side since this bug
can occur in general on every vmcore format. Crash dump can contain
broken data in any part of vmcore and so requested physical address to
read can be broken likewise.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 cache.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/cache.c b/cache.c
index dad8d80..0dd957c 100644
--- a/cache.c
+++ b/cache.c
@@ -103,19 +103,20 @@ cache_alloc(unsigned long long paddr)
 {
 	struct cache_entry *entry = NULL;
 
-	if (avail)
+	if (avail) {
 		entry = &pool[--avail];
-
-	if (!entry) {
-		if (used.tail) {
-			entry = used.tail;
-			remove_entry(&used, entry);
-		} else
-			return NULL;
-	}
-
-	entry->paddr = paddr;
-	add_entry(&pending, entry);
+		entry->paddr = paddr;
+		add_entry(&pending, entry);
+	} else if (pending.tail) {
+		entry = pending.tail;
+		entry->paddr = paddr;
+	} else if (used.tail) {
+		entry = used.tail;
+		remove_entry(&used, entry);
+		entry->paddr = paddr;
+		add_entry(&pending, entry);
+	} else
+		return NULL;
 
 	return entry->bufptr;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
