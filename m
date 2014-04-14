Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZiIy-0001WH-Ri
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 14:56:17 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v6 4/9] x86,
 cleanup: use dbgprint_mem_range for memory range debugging
Date: Mon, 14 Apr 2014 22:55:36 +0800
Message-Id: <1397487341-17287-5-git-send-email-chaowang@redhat.com>
In-Reply-To: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
References: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index f97d79a..39c35ea 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -517,15 +517,7 @@ static int add_memmap(struct memory_range *memmap_p, int *nr_memmap,
 	memmap_p[tidx].type = type;
 	*nr_memmap = nr_entries + 1;
 
-	dbgprintf("Memmap after adding segment\n");
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
-		mstart = memmap_p[i].start;
-		mend = memmap_p[i].end;
-		if (mstart == 0 && mend == 0)
-			break;
-		dbgprintf("%016llx - %016llx\n",
-			mstart, mend);
-	}
+	dbgprint_mem_range("Memmap after adding segment", memmap_p, *nr_memmap);
 
 	return 0;
 }
@@ -605,16 +597,7 @@ static int delete_memmap(struct memory_range *memmap_p, int *nr_memmap,
 		*nr_memmap = nr_entries - 1;
 	}
 
-	dbgprintf("Memmap after deleting segment\n");
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
-		mstart = memmap_p[i].start;
-		mend = memmap_p[i].end;
-		if (mstart == 0 && mend == 0) {
-			break;
-		}
-		dbgprintf("%016llx - %016llx\n",
-			mstart, mend);
-	}
+	dbgprint_mem_range("Memmap after deleting segment", memmap_p, *nr_memmap);
 
 	return 0;
 }
@@ -913,10 +896,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 
 	get_backup_area(info, mem_range, nr_ranges);
 
-	dbgprintf("CRASH MEMORY RANGES\n");
-
-	for(i = 0; i < nr_ranges; ++i)
-		dbgprintf("%016Lx-%016Lx\n", mem_range[i].start, mem_range[i].end);
+	dbgprint_mem_range("CRASH MEMORY RANGES", mem_range, nr_ranges);
 
 	/*
 	 * if the core type has not been set on command line, set it here
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
