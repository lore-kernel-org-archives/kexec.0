Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from juliette.telenet-ops.be ([195.130.137.74])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLqnD-00076x-8r
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 08:37:56 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/4] kexec/kexec.c: Prefix hex numbers by 0x
Date: Tue, 17 Sep 2013 10:37:11 +0200
Message-Id: <1379407031-5466-4-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
References: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
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
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, kexec@lists.infradead.org

It's confusing that some pointers are printed as hex numbers prefixed with
0x, while some other values are printed as hex numbers without prefixes.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 kexec/kexec.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 21ff0e7..b863d2a 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -145,11 +145,11 @@ void print_segments(FILE *f, struct kexec_info *info)
 	for (i = 0; i < info->nr_segments; i++) {
 		fprintf(f, "segment[%d].buf   = %p\n",	i,
 			info->segment[i].buf);
-		fprintf(f, "segment[%d].bufsz = %zx\n", i,
+		fprintf(f, "segment[%d].bufsz = 0x%zx\n", i,
 			info->segment[i].bufsz);
 		fprintf(f, "segment[%d].mem   = %p\n",	i,
 			info->segment[i].mem);
-		fprintf(f, "segment[%d].memsz = %zx\n", i,
+		fprintf(f, "segment[%d].memsz = 0x%zx\n", i,
 			info->segment[i].memsz);
 	}
 }
@@ -283,12 +283,12 @@ unsigned long locate_hole(struct kexec_info *info,
 	free(mem_range);
 	if (hole_base == ULONG_MAX) {
 		fprintf(stderr, "Could not find a free area of memory of "
-			"%lx bytes...\n", hole_size);
+			"0x%lx bytes...\n", hole_size);
 		return ULONG_MAX;
 	}
 	if ((hole_base + hole_size)  > hole_max) {
 		fprintf(stderr, "Could not find a free area of memory below: "
-			"%lx...\n", hole_max);
+			"0x%lx...\n", hole_max);
 		return ULONG_MAX;
 	}
 	return hole_base;
@@ -321,7 +321,7 @@ void add_segment_phys_virt(struct kexec_info *info,
 	 * thing.
 	 */
 	if (base & (pagesize -1)) {
-		die("Base address: %lx is not page aligned\n", base);
+		die("Base address: 0x%lx is not page aligned\n", base);
 	}
 
 	if (phys)
@@ -670,7 +670,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	/* slurp in the input kernel */
 	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
 
-	dbgprintf("kernel: %p kernel_size: %lx\n",
+	dbgprintf("kernel: %p kernel_size: 0x%lx\n",
 		  kernel_buf, kernel_size);
 
 	if (get_memory_ranges(&info.memory_range, &info.memory_ranges,
@@ -759,7 +759,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	if (entry)
 		info.entry = entry;
 
-	dbgprintf("kexec_load: entry = %p flags = %lx\n",
+	dbgprintf("kexec_load: entry = %p flags = 0x%lx\n",
 		  info.entry, info.kexec_flags);
 	if (kexec_debug)
 		print_segments(stderr, &info);
@@ -770,7 +770,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 		/* The load failed, print some debugging information */
 		fprintf(stderr, "kexec_load failed: %s\n", 
 			strerror(errno));
-		fprintf(stderr, "entry       = %p flags = %lx\n", 
+		fprintf(stderr, "entry       = %p flags = 0x%lx\n", 
 			info.entry, info.kexec_flags);
 		print_segments(stderr, &info);
 	}
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
