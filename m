Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJj3i-0003Ri-CG
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 09:49:08 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DDFA03EE0AE
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:04 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C672145DE58
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:04 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B151A45DE55
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:04 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A3FAE1DB8052
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:04 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 66A071DB8048
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:04 +0900 (JST)
Received: from ml13.css.fujitsu.com (ml13 [127.0.0.1])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id 439DAFD0019
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:04 +0900 (JST)
Received: from localhost6.localdomain6 (unknown [10.124.63.45])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id F08D6FD0010
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:03 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 11/14] Procees CPUs based on online ones
Date: Fri, 28 Oct 2011 18:49:03 +0900
Message-ID: <20111028094903.20940.82939.stgit@localhost6.localdomain6>
In-Reply-To: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
References: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Assign the number of online cpus to nr_cpus member in diskset header,
and create NR_PRSTATUS for each online cpu. This behaviour is sound
with respect to kdump's and crash's on kdump-compressed format.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   27 +++++++++++----
 makedumpfile.h |    3 ++
 sadump_info.c  |  100 +++++++++++++++++++++++++++++++++++++++++++++-----------
 sadump_info.h  |    4 +-
 4 files changed, 106 insertions(+), 28 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 750dcb6..44f6ee6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -826,6 +826,9 @@ get_symbol_info(void)
 	SYMBOL_INIT(crash_notes, "crash_notes");
 	SYMBOL_INIT(__per_cpu_load, "__per_cpu_load");
 	SYMBOL_INIT(__per_cpu_offset, "__per_cpu_offset");
+	SYMBOL_INIT(cpu_online_mask, "cpu_online_mask");
+	if (SYMBOL(cpu_online_mask) == NOT_FOUND_SYMBOL)
+		SYMBOL_INIT(cpu_online_mask, "cpu_online_map");
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_TYPE_INIT(node_data, "node_data");
@@ -962,6 +965,13 @@ get_structure_info(void)
 	OFFSET_INIT(elf_prstatus.pr_reg, "elf_prstatus", "pr_reg");
 
 	/*
+	 * Get size of cpumask and cpumask_t.
+	 */
+	SIZE_INIT(cpumask, "cpumask");
+
+	TYPEDEF_SIZE_INIT(cpumask_t, "cpumask_t");
+
+	/*
 	 * Get offset of the user_regs_struct members.
 	 */
 	SIZE_INIT(user_regs_struct, "user_regs_struct");
@@ -2489,8 +2499,6 @@ initial(void)
 			return FALSE;
 
 	} else if (info->flag_sadump) {
-		int nr_cpus;
-
 		if (info->flag_elf_dumpfile) {
 			MSG("'-E' option is disable, ");
 			MSG("because %s is sadump %s format.\n",
@@ -2503,11 +2511,6 @@ initial(void)
 		if (!sadump_initialize_bitmap_memory())
 			return FALSE;
 
-		if (!sadump_get_nr_cpus(&nr_cpus))
-			return FALSE;
-
-		set_nr_cpus(nr_cpus);
-
 		(void) sadump_set_timestamp(&info->timestamp);
 
 		/*
@@ -2600,6 +2603,16 @@ out:
 		if (!get_machdep_info())
 			return FALSE;
 
+		if (info->flag_sadump) {
+			int online_cpus;
+
+			online_cpus = sadump_num_online_cpus();
+			if (!online_cpus)
+				return FALSE;
+
+			set_nr_cpus(online_cpus);
+		}
+
 		if (!check_release())
 			return FALSE;
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 67a6b4f..020d99c 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -995,6 +995,7 @@ struct symbol_table {
 	unsigned long long	crash_notes;
 	unsigned long long	__per_cpu_offset;
 	unsigned long long	__per_cpu_load;
+	unsigned long long	cpu_online_mask;
 };
 
 struct size_table {
@@ -1024,6 +1025,8 @@ struct size_table {
 	long	percpu_data;
 	long	elf_prstatus;
 	long	user_regs_struct;
+	long	cpumask;
+	long	cpumask_t;
 };
 
 struct offset_table {
diff --git a/sadump_info.c b/sadump_info.c
index 0b9c524..2538da6 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -46,6 +46,14 @@
 			  KEXEC_CORE_NOTE_NAME_BYTES +		       \
 			  KEXEC_CORE_NOTE_DESC_BYTES )
 
+#define for_each_online_cpu(cpu)					\
+	for (cpu = 0; cpu < BITPERBYTE * si->cpumask_size; ++cpu)	\
+		if (is_online_cpu(cpu))
+
+enum {
+	BITPERWORD = BITPERBYTE * sizeof(unsigned long)
+};
+
 struct sadump_diskset_info {
 	char *name_memory;
 	int fd_memory;
@@ -67,7 +75,8 @@ struct sadump_info {
 	unsigned long *__per_cpu_offset;
 	unsigned long __per_cpu_load;
 	FILE *file_elf_note;
-
+	char *cpu_online_mask_buf;
+	size_t cpumask_size;
 };
 
 static char *guid_to_str(efi_guid_t *guid, char *buf, size_t buflen);
@@ -81,6 +90,7 @@ static int read_sadump_header_diskset(int diskid, struct sadump_diskset_info *sd
 static unsigned long long pfn_to_block(unsigned long long pfn);
 static int lookup_diskset(unsigned long long whole_offset, int *diskid,
 			  unsigned long long *disk_offset);
+static int cpu_online_mask_init(void);
 static int per_cpu_init(void);
 static int get_data_from_elf_note_desc(const char *note_buf, uint32_t n_descsz,
 				       char *name, uint32_t n_type, char **data);
@@ -88,6 +98,7 @@ static int alignfile(unsigned long *offset);
 static int
 write_elf_note_header(char *name, void *data, size_t descsz, uint32_t type,
 		      unsigned long *offset, unsigned long *desc_offset);
+static int is_online_cpu(int cpu);
 static unsigned long legacy_per_cpu_ptr(unsigned long ptr, int cpu);
 static unsigned long per_cpu_ptr(unsigned long ptr, int cpu);
 static int get_prstatus_from_crash_notes(int cpu, char *prstatus_buf);
@@ -250,8 +261,10 @@ sadump_generate_elf_note_from_dumpfile(void)
 		       strerror(errno));
 		goto cleanup;
 	}
+	if (!cpu_online_mask_init())
+		goto cleanup;
 	offset = 0;
-	for (x_cpu = 0; x_cpu < get_nr_cpus(); ++x_cpu) {
+	for_each_online_cpu(x_cpu) {
 		struct elf_prstatus prstatus;
 
 		memset(&prstatus, 0, sizeof(prstatus));
@@ -756,35 +769,71 @@ sadump_initialize_bitmap_memory(void)
 	return TRUE;
 }
 
-int
-sadump_get_nr_cpus(int *nr_cpus)
+static int
+cpu_online_mask_init(void)
 {
-	unsigned long offset;
-	struct sadump_smram_cpu_state scs, zero;
-	uint32_t x_cpu;
-	int count;
+	ulong cpu_online_mask_addr;
 
-	memset(&zero, 0, sizeof(zero));
+	if (si->cpu_online_mask_buf && si->cpumask_size)
+		return TRUE;
 
-	offset = si->sub_hdr_offset + sizeof(uint32_t) +
-		si->sh_memory->nr_cpus * sizeof(struct sadump_apic_state);
+	if (SYMBOL(cpu_online_mask) == NOT_FOUND_SYMBOL ||
+	    (SIZE(cpumask) == NOT_FOUND_STRUCTURE &&
+	     SIZE(cpumask_t) == NOT_FOUND_STRUCTURE))
+		return FALSE;
 
-	count = 0;
-	for (x_cpu = 0; x_cpu < si->sh_memory->nr_cpus; ++x_cpu) {
-		if (!read_device(&scs, sizeof(scs), &offset))
-			return FALSE;
-		if (memcmp(&scs, &zero, sizeof(scs)) != 0)
-			count++;
+	si->cpumask_size = SIZE(cpumask) == NOT_FOUND_STRUCTURE
+		? SIZE(cpumask_t)
+		: SIZE(cpumask);
+
+	if (!(si->cpu_online_mask_buf = calloc(1, si->cpumask_size))) {
+		ERRMSG("Can't allocate cpu_online_mask buffer. %s\n",
+		       strerror(errno));
+		return FALSE;
 	}
 
-	*nr_cpus = count;
+	if (SIZE(cpumask) == NOT_FOUND_STRUCTURE)
+		cpu_online_mask_addr = SYMBOL(cpu_online_mask);
+
+	else {
+		if (!readmem(VADDR, SYMBOL(cpu_online_mask),
+			     &cpu_online_mask_addr, sizeof(unsigned long))) {
+			ERRMSG("Can't read cpu_online_mask pointer.\n");
+			return FALSE;
+		}
+
+	}
 
-	DEBUG_MSG("sadump: nr_cpus: %d\n", *nr_cpus);
+	if (!readmem(VADDR, cpu_online_mask_addr, si->cpu_online_mask_buf,
+		     si->cpumask_size)) {
+		ERRMSG("Can't read cpu_online_mask memory.\n");
+		return FALSE;
+	}
 
 	return TRUE;
 }
 
 int
+sadump_num_online_cpus(void)
+{
+	int cpu, count = 0;
+
+	if (!cpu_online_mask_init())
+		return FALSE;
+
+	DEBUG_MSG("sadump: online cpus:");
+
+	for_each_online_cpu(cpu) {
+		count++;
+		DEBUG_MSG(" %d", cpu);
+	}
+
+	DEBUG_MSG("\nsadump: nr_cpus: %d\n", count);
+
+	return count;
+}
+
+int
 sadump_set_timestamp(struct timeval *ts)
 {
 	static struct tm t;
@@ -1201,6 +1250,17 @@ write_elf_note_header(char *name, void *data, size_t descsz, uint32_t type,
 	return TRUE;
 }
 
+static int
+is_online_cpu(int cpu)
+{
+	unsigned long mask;
+
+	mask = ULONG(si->cpu_online_mask_buf +
+		     (cpu / BITPERWORD) * sizeof(unsigned long));
+
+	return (mask & (1UL << (cpu % BITPERWORD))) ? TRUE : FALSE;
+}
+
 static unsigned long
 legacy_per_cpu_ptr(unsigned long ptr, int cpu)
 {
@@ -1710,6 +1770,8 @@ free_sadump_info(void)
 		free(si->block_table);
 	if (si->file_elf_note)
 		fclose(si->file_elf_note);
+	if (si->cpu_online_mask_buf)
+		free(si->cpu_online_mask_buf);
 }
 
 #endif /* defined(__x86__) && defined(__x86_64__) */
diff --git a/sadump_info.h b/sadump_info.h
index c1f948f..f90ea5a 100644
--- a/sadump_info.h
+++ b/sadump_info.h
@@ -40,7 +40,7 @@ static inline int sadump_virt_phys_base(void)
 int check_and_get_sadump_header_info(char *filename);
 int sadump_copy_1st_bitmap_from_memory(void);
 int sadump_initialize_bitmap_memory(void);
-int sadump_get_nr_cpus(int *nr_cpus);
+int sadump_num_online_cpus(void);
 int sadump_set_timestamp(struct timeval *ts);
 unsigned long long sadump_get_max_mapnr(void);
 int readpmem_sadump(unsigned long long paddr, void *bufptr, size_t size);
@@ -81,7 +81,7 @@ static inline int sadump_initialize_bitmap_memory(void)
 	return FALSE;
 }
 
-static inline int sadump_get_nr_cpus(int *nr_cpus)
+static inline int sadump_num_online_cpus(void);
 {
 	return 0;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
