Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YTsul-0005hj-Pi
 for kexec@lists.infradead.org; Fri, 06 Mar 2015 14:07:47 +0000
Message-Id: <7a957af18427b610c80e2c32cc3b44f9f854c953.1425650592.git.ptesarik@suse.cz>
In-Reply-To: <cover.1425650592.git.ptesarik@suse.cz>
References: <cover.1425650592.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 09:23:47 +0100
Subject: [PATCH v2 1/8] cache: get rid of search loop in cache_add()
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

The intention was that cache code is re-entrant, so all cache entries
should go through these states:

  1. free
  2. pending read
  3. used

The cache_add() function is used to move an entry from state 2 to 3, but
since the caller did not know cache entry pointer, it had to search the
pending list for a pending read for the given physical address. This is
not needed if cache_alloc() returns this pointer.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 cache.c        | 26 ++++++--------------------
 cache.h        | 10 ++++++++--
 makedumpfile.c |  8 +++++---
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/cache.c b/cache.c
index 0dd957c..700ba0c 100644
--- a/cache.c
+++ b/cache.c
@@ -20,12 +20,6 @@
 #include "cache.h"
 #include "print_info.h"
 
-struct cache_entry {
-	unsigned long long paddr;
-	void *bufptr;
-	struct cache_entry *next, *prev;
-};
-
 struct cache {
 	struct cache_entry *head, *tail;
 };
@@ -98,38 +92,30 @@ cache_search(unsigned long long paddr)
 	return NULL;		/* cache miss */
 }
 
-void *
+struct cache_entry *
 cache_alloc(unsigned long long paddr)
 {
 	struct cache_entry *entry = NULL;
 
 	if (avail) {
 		entry = &pool[--avail];
-		entry->paddr = paddr;
 		add_entry(&pending, entry);
 	} else if (pending.tail) {
 		entry = pending.tail;
-		entry->paddr = paddr;
 	} else if (used.tail) {
 		entry = used.tail;
 		remove_entry(&used, entry);
-		entry->paddr = paddr;
 		add_entry(&pending, entry);
 	} else
 		return NULL;
 
-	return entry->bufptr;
+	entry->paddr = paddr;
+	return entry;
 }
 
 void
-cache_add(unsigned long long paddr)
+cache_add(struct cache_entry *entry)
 {
-	struct cache_entry *entry;
-	for (entry = pending.head; entry; entry = entry->next) {
-		if (entry->paddr == paddr) {
-			remove_entry(&pending, entry);
-			add_entry(&used, entry);
-			break;
-		}
-	}
+	remove_entry(&pending, entry);
+	add_entry(&used, entry);
 }
diff --git a/cache.h b/cache.h
index 4730e12..dab8eb9 100644
--- a/cache.h
+++ b/cache.h
@@ -19,9 +19,15 @@
 #ifndef _CACHE_H
 #define _CACHE_H
 
+struct cache_entry {
+	unsigned long long paddr;
+	void *bufptr;
+	struct cache_entry *next, *prev;
+};
+
 int cache_init(void);
 void *cache_search(unsigned long long paddr);
-void *cache_alloc(unsigned long long paddr);
-void cache_add(unsigned long long paddr);
+struct cache_entry *cache_alloc(unsigned long long paddr);
+void cache_add(struct cache_entry *entry);
 
 #endif	/* _CACHE_H */
diff --git a/makedumpfile.c b/makedumpfile.c
index 74bc9db..828adeb 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -591,6 +591,7 @@ readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
 	unsigned long long paddr, maddr = NOT_PADDR;
 	unsigned long long pgaddr;
 	void *pgbuf;
+	struct cache_entry *cached;
 
 next_page:
 	switch (type_addr) {
@@ -644,9 +645,10 @@ next_page:
 	pgaddr = PAGEBASE(paddr);
 	pgbuf = cache_search(pgaddr);
 	if (!pgbuf) {
-		pgbuf = cache_alloc(pgaddr);
-		if (!pgbuf)
+		cached = cache_alloc(pgaddr);
+		if (!cached)
 			goto error;
+		pgbuf = cached->bufptr;
 
 		if (info->flag_refiltering) {
 			if (!readpage_kdump_compressed(pgaddr, pgbuf))
@@ -658,7 +660,7 @@ next_page:
 			if (!readpage_elf(pgaddr, pgbuf))
 				goto error;
 		}
-		cache_add(pgaddr);
+		cache_add(cached);
 	}
 
 	memcpy(bufptr, pgbuf + PAGEOFFSET(paddr), read_size);
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
