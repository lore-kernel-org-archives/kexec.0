Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzIqj-0008AH-F2
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 02:19:35 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 220E33EE0C0
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 11:19:30 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0AE1645DEA6
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 11:19:30 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id E060B45DE7E
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 11:19:29 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D4EDE1DB803B
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 11:19:29 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 851931DB8038
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 11:19:29 +0900 (JST)
Date: Mon, 20 Feb 2012 11:19:15 +0900 (   )
Message-Id: <20120220.111915.28783507.d.hatayama@jp.fujitsu.com>
Subject: [PATCH][makedumpfile] sadump: check if given cpu is online in
 per-cpu related helper functions
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Per-cpu helper functions sanity check given cpu ids if they are
not-minus and less than the maximal but it should have checked if they
are online. By this mistake, one cannot see generated vmcore correctly
if sadump collects vmcore when some cpus are offline e.g. using cpu
hotplug or panic and so all the cpus except for a unique CPU halting.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 sadump_info.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sadump_info.c b/sadump_info.c
index dce0841..69763be 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -46,7 +46,7 @@
 			  KEXEC_CORE_NOTE_DESC_BYTES )
 
 #define for_each_online_cpu(cpu)					\
-	for (cpu = 0; cpu < BITPERBYTE * si->cpumask_size; ++cpu)	\
+	for (cpu = 0; cpu < max_mask_cpu(); ++cpu)	\
 		if (is_online_cpu(cpu))
 
 enum {
@@ -95,6 +95,7 @@ static int read_sadump_header_diskset(int diskid, struct sadump_diskset_info *sd
 static unsigned long long pfn_to_block(unsigned long long pfn);
 static int lookup_diskset(unsigned long long whole_offset, int *diskid,
 			  unsigned long long *disk_offset);
+static int max_mask_cpu(void);
 static int cpu_online_mask_init(void);
 static int per_cpu_init(void);
 static int get_data_from_elf_note_desc(const char *note_buf, uint32_t n_descsz,
@@ -799,6 +800,12 @@ sadump_initialize_bitmap_memory(void)
 }
 
 static int
+max_mask_cpu(void)
+{
+	return BITPERBYTE * si->cpumask_size;
+}
+
+static int
 cpu_online_mask_init(void)
 {
 	ulong cpu_online_mask_addr;
@@ -1289,6 +1296,9 @@ is_online_cpu(int cpu)
 {
 	unsigned long mask;
 
+	if (cpu < 0 || cpu >= max_mask_cpu())
+		return FALSE;
+
 	mask = ULONG(si->cpu_online_mask_buf +
 		     (cpu / BITPERWORD) * sizeof(unsigned long));
 
@@ -1300,7 +1310,7 @@ legacy_per_cpu_ptr(unsigned long ptr, int cpu)
 {
 	unsigned long addr;
 
-	if (cpu < 0 || cpu >= get_nr_cpus())
+	if (!is_online_cpu(cpu))
 		return 0UL;
 
 	if (!readmem(VADDR, ~ptr + cpu*sizeof(unsigned long), &addr,
@@ -1313,7 +1323,7 @@ legacy_per_cpu_ptr(unsigned long ptr, int cpu)
 static unsigned long
 per_cpu_ptr(unsigned long ptr, int cpu)
 {
-	if (cpu < 0 || cpu >= get_nr_cpus())
+	if (!is_online_cpu(cpu))
 		return 0UL;
 
 	if (si->__per_cpu_offset[cpu] == si->__per_cpu_load)
@@ -1329,7 +1339,7 @@ get_prstatus_from_crash_notes(int cpu, char *prstatus_buf)
 	char note_buf[KEXEC_NOTE_BYTES], zero_buf[KEXEC_NOTE_BYTES];
 	char *prstatus_ptr;
 
-	if (cpu < 0 || get_nr_cpus() <= cpu)
+	if (!is_online_cpu(cpu))
 		return FALSE;
 
 	if (SYMBOL(crash_notes) == NOT_FOUND_SYMBOL)
-- 
1.7.4.4



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
