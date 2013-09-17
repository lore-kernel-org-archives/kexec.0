Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLonP-0004fN-J1
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 06:30:00 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 20A7F3EE102
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:34 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 13AAF45DEB5
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:34 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id EDB4145DEB7
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:33 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DD097E08004
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:33 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 91E85E08001
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:33 +0900 (JST)
Subject: [PATCH 1/2] cache: allocate buffers at initialization to detect
 malloc() failure
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Tue, 17 Sep 2013 15:29:33 +0900
Message-ID: <20130917062933.4671.99911.stgit@localhost6.localdomain6>
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

malloc() is used in cache_alloc() but there's no check for it. If I
added check in cache_alloc() directly, cache_alloc() needs to return
one more error status and code gets somewhat complicated. Instead, I
move malloc() in initial() to detect allocation failure at
initialization. By this change, 8 buffers are allocated at the same
time, no longer incrementally. However, 8 buffers are almost always
used throughout execution. There's essential differnece from the
incremental one.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 cache.c        |   29 ++++++++++++++++++++++-------
 cache.h        |    1 +
 makedumpfile.c |    3 +++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/cache.c b/cache.c
index 3bea089..dad8d80 100644
--- a/cache.c
+++ b/cache.c
@@ -18,6 +18,7 @@
 
 #include "makedumpfile.h"
 #include "cache.h"
+#include "print_info.h"
 
 struct cache_entry {
 	unsigned long long paddr;
@@ -36,6 +37,25 @@ static int avail = CACHE_SIZE;
 
 static struct cache used, pending;
 
+int
+cache_init(void)
+{
+	void *bufptr;
+	int i;
+
+	for (i = 0; i < CACHE_SIZE; ++i) {
+		bufptr = malloc(info->page_size);
+		if (bufptr == NULL) {
+			ERRMSG("Can't allocate memory for cache. %s\n",
+			       strerror(errno));
+			return FALSE;
+		}
+		pool[i].bufptr = bufptr;
+	}
+
+	return TRUE;
+}
+
 static void
 add_entry(struct cache *cache, struct cache_entry *entry)
 {
@@ -83,13 +103,8 @@ cache_alloc(unsigned long long paddr)
 {
 	struct cache_entry *entry = NULL;
 
-	if (avail) {
-		void *bufptr = malloc(info->page_size);
-		if (bufptr) {
-			entry = &pool[--avail];
-			entry->bufptr = bufptr;
-		}
-	}
+	if (avail)
+		entry = &pool[--avail];
 
 	if (!entry) {
 		if (used.tail) {
diff --git a/cache.h b/cache.h
index f37d883..4730e12 100644
--- a/cache.h
+++ b/cache.h
@@ -19,6 +19,7 @@
 #ifndef _CACHE_H
 #define _CACHE_H
 
+int cache_init(void);
 void *cache_search(unsigned long long paddr);
 void *cache_alloc(unsigned long long paddr);
 void cache_add(unsigned long long paddr);
diff --git a/makedumpfile.c b/makedumpfile.c
index 1718f88..e01ff50 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3017,6 +3017,9 @@ out:
 		DEBUG_MSG("Buffer size for the cyclic mode: %ld\n", info->bufsize_cyclic);
 	}
 
+	if (!cache_init())
+		return FALSE;
+
 	if (debug_info) {
 		if (info->flag_sadump)
 			(void) sadump_virt_phys_base();


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
