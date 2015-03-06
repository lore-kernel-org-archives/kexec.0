Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YXQQx-0001Ws-DV
 for kexec@lists.infradead.org; Mon, 16 Mar 2015 08:31:36 +0000
Message-Id: <1395ecaaf5d27a437c9f99cf789a1b0a3090c7e6.1426494404.git.ptesarik@suse.cz>
In-Reply-To: <cover.1426494404.git.ptesarik@suse.cz>
References: <cover.1426494404.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 09:59:11 +0100
Subject: [PATCH v3 3/7] cache: do not allocate from the pending list
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

Since pending entries are under read, they should not be reused. This
change allows recursive use of the cache (reading pages from within
readpage itself). Although this feature is not used by makedumpfile
right now, this was the original intention of the pending list.
The cache_alloc() function may return NULL if and only if the recursion
level is bigger than CACHE_SIZE.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 cache.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/cache.c b/cache.c
index ad9f0f1..344b4f6 100644
--- a/cache.c
+++ b/cache.c
@@ -101,16 +101,13 @@ cache_alloc(unsigned long long paddr)
 
 	if (avail) {
 		entry = pool[--avail];
-		add_entry(&pending, entry);
-	} else if (pending.tail) {
-		entry = pending.tail;
 	} else if (used.tail) {
 		entry = used.tail;
 		remove_entry(&used, entry);
-		add_entry(&pending, entry);
 	} else
 		return NULL;
 
+	add_entry(&pending, entry);
 	entry->paddr = paddr;
 	return entry;
 }
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
