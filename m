Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UWz9l-0007zF-RZ
 for kexec@lists.infradead.org; Tue, 30 Apr 2013 01:14:59 +0000
Message-ID: <517F1A7C.5000305@cn.fujitsu.com>
Date: Tue, 30 Apr 2013 09:12:28 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: Parse percpu note size from kernel
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

We used 1024 as the percpu crash note size. But for new kernel that
exports the real crash note size, we should parse it instead of
using 1024.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/crashdump.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index 70817b8..8d88fdf 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -65,6 +65,7 @@ unsigned long crash_architecture(struct crash_elf_info *elf_info)
 int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 {
 	char crash_notes[PATH_MAX];
+	char crash_notes_size[PATH_MAX];
 	char line[MAX_LINE];
 	FILE *fp;
 	struct stat cpu_stat;
@@ -101,12 +102,27 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 	if (count != 1)
 		die("Cannot parse %s: %s\n", crash_notes, strerror(errno));
 	*addr = (uint64_t) temp;
-	*len = MAX_NOTE_BYTES; /* we should get this from the kernel instead */
+	fclose(fp);
+
+	*len = MAX_NOTE_BYTES;
+	sprintf(crash_notes_size,
+		"/sys/devices/system/cpu/cpu%d/crash_notes_size", cpu);
+	fp = fopen(crash_notes_size, "r");
+	if (fp) {
+		if (!fgets(line, sizeof(line), fp))
+			die("Cannot parse %s: %s\n",
+			    crash_notes_size, strerror(errno));
+		count = sscanf(line, "%Lu", &temp);
+		if (count != 1)
+			die("Cannot parse %s: %s\n",
+			    crash_notes_size, strerror(errno));
+		*len = (uint64_t) temp;
+		fclose(fp);
+	}
 
-	dbgprintf("%s: crash_notes addr = %Lx\n", __FUNCTION__,
-		  (unsigned long long)*addr);
+	dbgprintf("%s: crash_notes addr = %Lx, size = %Lu\n", __FUNCTION__,
+		  (unsigned long long)*addr, (unsigned long long)*len);
 
-	fclose(fp);
 	return 0;
 }
 
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
