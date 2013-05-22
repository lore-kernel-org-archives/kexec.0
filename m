Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uf4ry-0002ov-H6
 for kexec@lists.infradead.org; Wed, 22 May 2013 08:58:04 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/4] kexec-tools: Fix possible overflows and make use of
 dbg_memrange() macro
Date: Wed, 22 May 2013 10:57:35 +0200
Message-Id: <1369213056-77661-4-git-send-email-trenn@suse.de>
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

add_memmap() will add another memrange, therefore we need an additional
array entry and need to check for
if (nr_entries >= CRASH_MAX_MEMMAP_NR - 1)

Same for delete_memmap: If a region has to be split an additional region is
added first, so we again have to check for:
if (nr_entries >= CRASH_MAX_MEMMAP_NR - 1)

In add_memmap we know the amount of range entries. No need to check for the
ugly:
-               if (mstart == 0 && mend == 0)
-                       break;
condition, just let the loop go until nr_entries.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |   35 ++++++++---------------------------
 1 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 9b5a7cd..7fd1c5b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -545,14 +545,12 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
 		else
 			nr_entries++;
 	}
-	if (nr_entries == CRASH_MAX_MEMMAP_NR)
+	if (nr_entries >= CRASH_MAX_MEMMAP_NR - 1)
 		return -1;
 
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+	for (i = 0; i < nr_entries;  i++) {
 		mstart = memmap_p[i].start;
 		mend = memmap_p[i].end;
-		if (mstart == 0 && mend == 0)
-			break;
 		if (mstart <= (addr+size-1) && mend >=addr)
 			/* Overlapping region. */
 			return -1;
@@ -565,16 +563,8 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
 	memmap_p[tidx].start = addr;
 	memmap_p[tidx].end = addr + size - 1;
 
-	dbgprintf("Memmap after adding segment\n");
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
-		mstart = memmap_p[i].start;
-		mend = memmap_p[i].end;
-		if (mstart == 0 && mend == 0)
-			break;
-		dbgprintf("%016llx - %016llx\n",
-			mstart, mend);
-	}
-
+	nr_entries++;
+	dbg_memrange("Memmap after adding segment", &memmap_p, nr_entries);
 	return 0;
 }
 
@@ -600,8 +590,7 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
 		else
 			nr_entries++;
 	}
-	if (nr_entries == CRASH_MAX_MEMMAP_NR)
-		/* List if full */
+	if (nr_entries >= CRASH_MAX_MEMMAP_NR - 1)
 		return -1;
 
 	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
@@ -643,25 +632,17 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
 		for (j = nr_entries-1; j > tidx; j--)
 			memmap_p[j+1] = memmap_p[j];
 		memmap_p[tidx+1] = temp_region;
+		nr_entries++;
 	}
 	if ((operation == -1) && tidx >=0) {
 		/* Delete the exact match memory region. */
 		for (j = i+1; j < CRASH_MAX_MEMMAP_NR; j++)
 			memmap_p[j-1] = memmap_p[j];
 		memmap_p[j-1].start = memmap_p[j-1].end = 0;
+		nr_entries--;
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
-
+	dbg_memrange("Memmap after deleting segment", &memmap_p, nr_entries);
 	return 0;
 }
 
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
