Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WDw4k-0006Zw-CA
 for kexec@lists.infradead.org; Thu, 13 Feb 2014 13:11:39 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH 1/4] add macro dbgprint_mem_range
Date: Thu, 13 Feb 2014 21:10:52 +0800
Message-Id: <1392297055-31934-2-git-send-email-chaowang@redhat.com>
In-Reply-To: <1392297055-31934-1-git-send-email-chaowang@redhat.com>
References: <1392297055-31934-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com
Cc: kexec@lists.infradead.org

dbgprint_mem_range is used for printing the given memory range under
debugging mode.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/kexec-x86-common.c |  6 +-----
 kexec/kexec.h                      | 10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index f55e2c2..e416177 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -374,11 +374,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 			mem_max = end;
 	}
 
-	dbgprintf("MEMORY RANGES\n");
-	for (i = 0; i < *ranges; i++) {
-		dbgprintf("%016Lx-%016Lx (%d)\n", (*range)[i].start,
-			  (*range)[i].end, (*range)[i].type);
-	}
+	dbgprint_mem_range("MEMORY RANGES", *range, *ranges);
 
 	return ret;
 }
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 2bd6e96..753acc5 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -121,6 +121,16 @@ do { \
 		fprintf(stderr, __VA_ARGS__); \
 } while(0)
 
+#define dbgprint_mem_range(prefix, mr, nr_mr) \
+do { \
+	int i; \
+	dbgprintf(prefix "\n"); \
+	for (i = 0; i < nr_mr; i++) { \
+		dbgprintf("%016llx-%016llx (%d)\n", (mr)[i].start, \
+			  (mr)[i].end, (mr)[i].type);                \
+	} \
+} while (0)
+
 struct kexec_segment {
 	const void *buf;
 	size_t bufsz;
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
