Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YXQRJ-0001Zw-Tg
 for kexec@lists.infradead.org; Mon, 16 Mar 2015 08:31:59 +0000
Message-Id: <23a49c4e34c7364c97045de2a8f1b73714616ad8.1426494404.git.ptesarik@suse.cz>
In-Reply-To: <cover.1426494404.git.ptesarik@suse.cz>
References: <cover.1426494404.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 14:07:11 +0100
Subject: [PATCH v3 5/7] cache: allocate buffers in one big chunk
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

This allows callers to change the buffer pointer, because it can be
reinitialized to the default value in cache_alloc() before returning
the cache entry.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 cache.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/cache.c b/cache.c
index 344b4f6..ccd67ca 100644
--- a/cache.c
+++ b/cache.c
@@ -32,23 +32,23 @@ static int avail = CACHE_SIZE;
 
 static struct cache used, pending;
 
+static void *cachebuf;
+
 int
 cache_init(void)
 {
-	void *bufptr;
 	int i;
 
-	for (i = 0; i < CACHE_SIZE; ++i) {
-		bufptr = malloc(info->page_size);
-		if (bufptr == NULL) {
-			ERRMSG("Can't allocate memory for cache. %s\n",
-			       strerror(errno));
-			return FALSE;
-		}
-		entries[i].bufptr = bufptr;
-		pool[i] = &entries[i];
+	cachebuf = malloc(info->page_size * CACHE_SIZE);
+	if (cachebuf == NULL) {
+		ERRMSG("Can't allocate memory for cache. %s\n",
+		       strerror(errno));
+		return FALSE;
 	}
 
+	for (i = 0; i < CACHE_SIZE; ++i)
+		pool[i] = &entries[i];
+
 	return TRUE;
 }
 
@@ -98,6 +98,7 @@ struct cache_entry *
 cache_alloc(unsigned long long paddr)
 {
 	struct cache_entry *entry = NULL;
+	int idx;
 
 	if (avail) {
 		entry = pool[--avail];
@@ -107,8 +108,11 @@ cache_alloc(unsigned long long paddr)
 	} else
 		return NULL;
 
-	add_entry(&pending, entry);
+	idx = entry - entries;
 	entry->paddr = paddr;
+	entry->bufptr = cachebuf + idx * info->page_size;
+	add_entry(&pending, entry);
+
 	return entry;
 }
 
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
