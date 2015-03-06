Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YXQRJ-0001Zv-Ta
 for kexec@lists.infradead.org; Mon, 16 Mar 2015 08:31:59 +0000
Message-Id: <0c425d9530f9c37325cc2d9f5b8fb0a1312a3692.1426494404.git.ptesarik@suse.cz>
In-Reply-To: <cover.1426494404.git.ptesarik@suse.cz>
References: <cover.1426494404.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 09:52:07 +0100
Subject: [PATCH v3 2/7] cache: allow to return a page to the pool
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

After a failed read, the page should no longer be pending, but rather
available for future allocation.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 cache.c        | 15 ++++++++++++---
 cache.h        |  1 +
 makedumpfile.c |  8 +++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/cache.c b/cache.c
index 700ba0c..ad9f0f1 100644
--- a/cache.c
+++ b/cache.c
@@ -26,7 +26,8 @@ struct cache {
 
 /* 8 pages covers 4-level paging plus 4 data pages */
 #define CACHE_SIZE	8
-static struct cache_entry pool[CACHE_SIZE];
+static struct cache_entry entries[CACHE_SIZE];
+static struct cache_entry *pool[CACHE_SIZE];
 static int avail = CACHE_SIZE;
 
 static struct cache used, pending;
@@ -44,7 +45,8 @@ cache_init(void)
 			       strerror(errno));
 			return FALSE;
 		}
-		pool[i].bufptr = bufptr;
+		entries[i].bufptr = bufptr;
+		pool[i] = &entries[i];
 	}
 
 	return TRUE;
@@ -98,7 +100,7 @@ cache_alloc(unsigned long long paddr)
 	struct cache_entry *entry = NULL;
 
 	if (avail) {
-		entry = &pool[--avail];
+		entry = pool[--avail];
 		add_entry(&pending, entry);
 	} else if (pending.tail) {
 		entry = pending.tail;
@@ -119,3 +121,10 @@ cache_add(struct cache_entry *entry)
 	remove_entry(&pending, entry);
 	add_entry(&used, entry);
 }
+
+void
+cache_free(struct cache_entry *entry)
+{
+	remove_entry(&pending, entry);
+	pool[avail++] = entry;
+}
diff --git a/cache.h b/cache.h
index dab8eb9..0e65f97 100644
--- a/cache.h
+++ b/cache.h
@@ -29,5 +29,6 @@ int cache_init(void);
 void *cache_search(unsigned long long paddr);
 struct cache_entry *cache_alloc(unsigned long long paddr);
 void cache_add(struct cache_entry *entry);
+void cache_free(struct cache_entry *entry);
 
 #endif	/* _CACHE_H */
diff --git a/makedumpfile.c b/makedumpfile.c
index 828adeb..c62d035 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -652,13 +652,13 @@ next_page:
 
 		if (info->flag_refiltering) {
 			if (!readpage_kdump_compressed(pgaddr, pgbuf))
-				goto error;
+				goto error_cached;
 		} else if (info->flag_sadump) {
 			if (!readpage_sadump(pgaddr, pgbuf))
-				goto error;
+				goto error_cached;
 		} else {
 			if (!readpage_elf(pgaddr, pgbuf))
-				goto error;
+				goto error_cached;
 		}
 		cache_add(cached);
 	}
@@ -674,6 +674,8 @@ next_page:
 
 	return size_orig;
 
+error_cached:
+	cache_free(cached);
 error:
 	ERRMSG("type_addr: %d, addr:%llx, size:%zd\n", type_addr, addr, size_orig);
 	return FALSE;
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
