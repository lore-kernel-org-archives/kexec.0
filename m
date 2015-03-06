Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YXQQx-0001Wq-DU
 for kexec@lists.infradead.org; Mon, 16 Mar 2015 08:31:37 +0000
Message-Id: <c7d9a240cd0d56ec407ed40fc003e49f31865b9b.1426494404.git.ptesarik@suse.cz>
In-Reply-To: <cover.1426494404.git.ptesarik@suse.cz>
References: <cover.1426494404.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 14:10:54 +0100
Subject: [PATCH v3 6/7] cache: allow arbitrary size of cache entries
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

Until this commit the assumed length of all cache entries has been
exactly one page. To make other sizes possible, the length is now
stored in struct cache_entry. Note that cache_search may return a
pointer in the middle of a cache buffer.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 cache.c        | 12 ++++++++----
 cache.h        |  3 ++-
 makedumpfile.c |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/cache.c b/cache.c
index ccd67ca..938eda6 100644
--- a/cache.c
+++ b/cache.c
@@ -79,17 +79,20 @@ remove_entry(struct cache *cache, struct cache_entry *entry)
 }
 
 void *
-cache_search(unsigned long long paddr)
+cache_search(unsigned long long paddr, unsigned long length)
 {
 	struct cache_entry *entry;
-	for (entry = used.head; entry; entry = entry->next)
-		if (entry->paddr == paddr) {
+	for (entry = used.head; entry; entry = entry->next) {
+		size_t off = paddr - entry->paddr;
+		if (off < entry->buflen &&
+		    length <= entry->buflen - off) {
 			if (entry != used.head) {
 				remove_entry(&used, entry);
 				add_entry(&used, entry);
 			}
-			return entry->bufptr;
+			return entry->bufptr + off;
 		}
+	}
 
 	return NULL;		/* cache miss */
 }
@@ -111,6 +114,7 @@ cache_alloc(unsigned long long paddr)
 	idx = entry - entries;
 	entry->paddr = paddr;
 	entry->bufptr = cachebuf + idx * info->page_size;
+	entry->buflen = info->page_size;
 	add_entry(&pending, entry);
 
 	return entry;
diff --git a/cache.h b/cache.h
index 0e65f97..792ba6c 100644
--- a/cache.h
+++ b/cache.h
@@ -22,11 +22,12 @@
 struct cache_entry {
 	unsigned long long paddr;
 	void *bufptr;
+	unsigned long buflen;
 	struct cache_entry *next, *prev;
 };
 
 int cache_init(void);
-void *cache_search(unsigned long long paddr);
+void *cache_search(unsigned long long paddr, unsigned long length);
 struct cache_entry *cache_alloc(unsigned long long paddr);
 void cache_add(struct cache_entry *entry);
 void cache_free(struct cache_entry *entry);
diff --git a/makedumpfile.c b/makedumpfile.c
index d778139..f1aad08 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -647,7 +647,7 @@ next_page:
 	read_size = MIN(info->page_size - PAGEOFFSET(paddr), size);
 
 	pgaddr = PAGEBASE(paddr);
-	pgbuf = cache_search(pgaddr);
+	pgbuf = cache_search(pgaddr, read_size);
 	if (!pgbuf) {
 		++cache_miss;
 		cached = cache_alloc(pgaddr);
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
