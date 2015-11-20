Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZzpXu-0004ls-BR
 for kexec@lists.infradead.org; Fri, 20 Nov 2015 17:32:28 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id BB4C5693
 for <kexec@lists.infradead.org>; Fri, 20 Nov 2015 17:32:07 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH 3/4] kexec/fs2dt: cleanup pathname
Date: Fri, 20 Nov 2015 12:31:53 -0500
Message-Id: <1448040714-19841-4-git-send-email-drjones@redhat.com>
In-Reply-To: <1448040714-19841-1-git-send-email-drjones@redhat.com>
References: <1448040714-19841-1-git-send-email-drjones@redhat.com>
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
To: kexec@lists.infradead.org

putnode() will add the trailing '/', avoid having two. Also
pathstart is unused, get rid of it.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 kexec/fs2dt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 9392e85d6d5f3..affee57b9bb62 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -39,7 +39,7 @@
 #define MEMRESERVE 256		/* max number of reserved memory blocks */
 #define MEM_RANGE_CHUNK_SZ 2048 /* Initial num dwords for mem ranges */
 
-static char pathname[MAXPATH], *pathstart;
+static char pathname[MAXPATH];
 static char propnames[NAMESPACE] = { 0 };
 static unsigned *dt_base, *dt;
 static unsigned int dt_cur_size;
@@ -800,9 +800,7 @@ static void add_boot_block(char **bufp, off_t *sizep)
 
 void create_flatten_tree(char **bufp, off_t *sizep, const char *cmdline)
 {
-	strcpy(pathname, "/proc/device-tree/");
-
-	pathstart = pathname + strlen(pathname);
+	strcpy(pathname, "/proc/device-tree");
 
 	dt_cur_size = INIT_TREE_WORDS;
 	dt_base = malloc(dt_cur_size*4);
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
