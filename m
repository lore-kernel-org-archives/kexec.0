Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uf4ry-0002ou-H4
 for kexec@lists.infradead.org; Wed, 22 May 2013 08:58:04 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/4] kexec-tools: Introduce dbg_memrange() macro and make use
 of it
Date: Wed, 22 May 2013 10:57:34 +0200
Message-Id: <1369213056-77661-3-git-send-email-trenn@suse.de>
In-Reply-To: <1369213056-77661-1-git-send-email-trenn@suse.de>
References: <1369213056-77661-1-git-send-email-trenn@suse.de>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, yinghai@kernel.org, ebiederm@xmission.com, vgoyal@redhat.com, Thomas Renninger <trenn@suse.de>

There are several places where memory range arrays are printed for debug
reasons. In load_crashdump_segments() the memory type is missing.

Unify printing memory ranges in --debug case in a macro and add the first
users.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 kexec/arch/i386/crashdump-x86.c    |    5 +----
 kexec/arch/i386/kexec-x86-common.c |    6 +-----
 kexec/arch/ppc/crashdump-powerpc.c |    8 +-------
 kexec/kexec.h                      |   11 +++++++++++
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 17c8744..9b5a7cd 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -959,10 +959,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 
 	get_backup_area(info, mem_range, nr_ranges);
 
-	dbgprintf("CRASH MEMORY RANGES\n");
-
-	for(i = 0; i < nr_ranges; ++i)
-		dbgprintf("%016Lx-%016Lx\n", mem_range[i].start, mem_range[i].end);
+	dbg_memrange("CRASH MEMORY RANGES", &mem_range, nr_ranges);
 
 	/*
 	 * if the core type has not been set on command line, set it here
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index ed6c950..015dcb6 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -477,11 +477,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 			mem_max = end;
 	}
 
-	dbgprintf("MEMORY RANGES\n");
-	for (i = 0; i < *ranges; i++) {
-		dbgprintf("%016Lx-%016Lx (%d)\n", (*range)[i].start,
-			  (*range)[i].end, (*range)[i].type);
-	}
+	dbg_memrange("MEMORY RANGES", range, *ranges);
 
 	return ret;
 }
diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index eee5b37..feb3cfd 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -236,13 +236,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	*ranges = memory_ranges;
 
 	int j;
-	dbgprintf("CRASH MEMORY RANGES\n");
-	for (j = 0; j < *ranges; j++) {
-		start = crash_memory_range[j].start;
-		end = crash_memory_range[j].end;
-		dbgprintf("%016Lx-%016Lx\n", start, end);
-	}
-
+	dbg_memrange("MEMORY RANGES", &crash_memory_range, *ranges);
 	return 0;
 
 err:
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 715b568..eea8c50 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -121,6 +121,17 @@ do { \
 		fprintf(stderr, __VA_ARGS__); \
 } while(0)
 
+#define dbg_memrange(title, range, nr) \
+do { \
+ int i; \
+ dbgprintf(title "\n"); \
+ for (i = 0; i < nr; i++) { \
+	 dbgprintf("%016Lx-%016Lx (%d)\n", (*range)[i].start,	\
+		   (*range)[i].end, (*range)[i].type);		\
+ } \
+ } while (0)
+
+
 struct kexec_segment {
 	const void *buf;
 	size_t bufsz;
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
