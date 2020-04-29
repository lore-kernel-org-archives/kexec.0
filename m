Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTuKd-0003Ct-7h
 for kexec@lists.infradead.org; Wed, 29 Apr 2020 21:33:29 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH 1/1] printk: add support for lockless ringbuffer
Date: Wed, 29 Apr 2020 23:32:56 +0200
Message-Id: <20200429213256.3691-2-john.ogness@linutronix.de>
In-Reply-To: <20200429213256.3691-1-john.ogness@linutronix.de>
References: <20200429213256.3691-1-john.ogness@linutronix.de>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, crash-utility@redhat.com

Linux is moving to a new lockless ringbuffer. The new ringbuffer
is structured completely different to the previous iterations.
Add support for retrieving the ringbuffer from debug information
and/or using vmcoreinfo. The new ringbuffer is detected based on
the availability of the "prb" symbol.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Makefile       |   2 +-
 dwarf_info.c   |  36 +++++++++-
 makedumpfile.c | 101 ++++++++++++++++++++++++++--
 makedumpfile.h |  25 +++++++
 printk.c       | 177 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 333 insertions(+), 8 deletions(-)
 create mode 100644 printk.c

diff --git a/Makefile b/Makefile
index ef20672..dc4ae3e 100644
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
diff --git a/dwarf_info.c b/dwarf_info.c
index e42a9f5..543588b 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -614,6 +614,7 @@ search_structure(Dwarf_Die *die, int *found)
 {
 	int tag;
 	const char *name;
+	Dwarf_Die die_type;
 
 	/*
 	 * If we get to here then we don't have any more
@@ -622,9 +623,31 @@ search_structure(Dwarf_Die *die, int *found)
 	do {
 		tag  = dwarf_tag(die);
 		name = dwarf_diename(die);
-		if ((tag != DW_TAG_structure_type) || (!name)
-		    || strcmp(name, dwarf_info.struct_name))
+		if ((!name) || strcmp(name, dwarf_info.struct_name))
+			continue;
+
+		if (tag == DW_TAG_typedef) {
+			if (!get_die_type(die, &die_type)) {
+				ERRMSG("Can't get CU die of DW_AT_type.\n");
+				break;
+			}
+
+			/* Resolve typedefs of typedefs. */
+			while ((tag = dwarf_tag(&die_type)) == DW_TAG_typedef) {
+				if (!get_die_type(&die_type, &die_type)) {
+					ERRMSG("Can't get CU die of DW_AT_type.\n");
+					return;
+				}
+			}
+
+			if (tag != DW_TAG_structure_type)
+				continue;
+			die = &die_type;
+
+		} else if (tag != DW_TAG_structure_type) {
 			continue;
+		}
+
 		/*
 		 * Skip if DW_AT_byte_size is not included.
 		 */
@@ -740,6 +763,15 @@ search_typedef(Dwarf_Die *die, int *found)
 				ERRMSG("Can't get CU die of DW_AT_type.\n");
 				break;
 			}
+
+			/* Resolve typedefs of typedefs. */
+			while ((tag = dwarf_tag(&die_type)) == DW_TAG_typedef) {
+				if (!get_die_type(&die_type, &die_type)) {
+					ERRMSG("Can't get CU die of DW_AT_type.\n");
+					return;
+				}
+			}
+
 			dwarf_info.struct_size = dwarf_bytesize(&die_type);
 			if (dwarf_info.struct_size <= 0)
 				continue;
diff --git a/makedumpfile.c b/makedumpfile.c
index f5860a1..6192ee7 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1555,6 +1555,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(node_data, "node_data");
 	SYMBOL_INIT(pgdat_list, "pgdat_list");
 	SYMBOL_INIT(contig_page_data, "contig_page_data");
+	SYMBOL_INIT(prb, "prb");
 	SYMBOL_INIT(log_buf, "log_buf");
 	SYMBOL_INIT(log_buf_len, "log_buf_len");
 	SYMBOL_INIT(log_end, "log_end");
@@ -1971,16 +1972,46 @@ get_structure_info(void)
 	OFFSET_INIT(elf64_phdr.p_memsz, "elf64_phdr", "p_memsz");
 
 	SIZE_INIT(printk_log, "printk_log");
-	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
+	SIZE_INIT(printk_ringbuffer, "printk_ringbuffer");
+	if ((SIZE(printk_ringbuffer) != NOT_FOUND_STRUCTURE)) {
+		info->flag_use_printk_ringbuffer = TRUE;
+		info->flag_use_printk_log = FALSE;
+
+		OFFSET_INIT(printk_log.desc_ring, "printk_ringbuffer", "desc_ring");
+		OFFSET_INIT(printk_log.text_data_ring, "printk_ringbuffer",  "text_data_ring");
+
+		OFFSET_INIT(printk_log.count_bits, "prb_desc_ring", "count_bits");
+		OFFSET_INIT(printk_log.descs, "prb_desc_ring", "descs");
+		OFFSET_INIT(printk_log.head_id, "prb_desc_ring", "head_id");
+		OFFSET_INIT(printk_log.tail_id, "prb_desc_ring", "tail_id");
+
+		SIZE_INIT(prb_desc, "prb_desc");
+		OFFSET_INIT(printk_log.info, "prb_desc", "info");
+		OFFSET_INIT(printk_log.state_var, "prb_desc", "state_var");
+		OFFSET_INIT(printk_log.text_blk_lpos, "prb_desc", "text_blk_lpos");
+
+		OFFSET_INIT(printk_log.begin, "prb_data_blk_lpos", "begin");
+		OFFSET_INIT(printk_log.next, "prb_data_blk_lpos", "next");
+
+		OFFSET_INIT(printk_log.size_bits, "prb_data_ring", "size_bits");
+		OFFSET_INIT(printk_log.data, "prb_data_ring", "data");
+
+		OFFSET_INIT(printk_log.ts_nsec, "printk_info", "ts_nsec");
+		OFFSET_INIT(printk_log.text_len, "printk_info", "text_len");
+
+		OFFSET_INIT(printk_log.counter, "atomic_long_t", "counter");
+	} else if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
 		/*
 		 * In kernel 3.11-rc4 the log structure name was renamed
 		 * to "printk_log".
 		 */
+		info->flag_use_printk_ringbuffer = FALSE;
 		info->flag_use_printk_log = TRUE;
 		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
 		OFFSET_INIT(printk_log.len, "printk_log", "len");
 		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
 	} else {
+		info->flag_use_printk_ringbuffer = FALSE;
 		info->flag_use_printk_log = FALSE;
 		SIZE_INIT(printk_log, "log");
 		OFFSET_INIT(printk_log.ts_nsec, "log", "ts_nsec");
@@ -2191,6 +2222,7 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("node_data", node_data);
 	WRITE_SYMBOL("pgdat_list", pgdat_list);
 	WRITE_SYMBOL("contig_page_data", contig_page_data);
+	WRITE_SYMBOL("prb", prb);
 	WRITE_SYMBOL("log_buf", log_buf);
 	WRITE_SYMBOL("log_buf_len", log_buf_len);
 	WRITE_SYMBOL("log_end", log_end);
@@ -2222,7 +2254,10 @@ write_vmcoreinfo_data(void)
 	WRITE_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
 	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
 	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
-	if (info->flag_use_printk_log)
+	if (info->flag_use_printk_ringbuffer) {
+		WRITE_STRUCTURE_SIZE("printk_ringbuffer", printk_ringbuffer);
+		WRITE_STRUCTURE_SIZE("prb_desc", prb_desc);
+	} else if (info->flag_use_printk_log)
 		WRITE_STRUCTURE_SIZE("printk_log", printk_log);
 	else
 		WRITE_STRUCTURE_SIZE("log", printk_log);
@@ -2268,7 +2303,30 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
 	WRITE_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
 	WRITE_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
-	if (info->flag_use_printk_log) {
+	if (info->flag_use_printk_ringbuffer) {
+		WRITE_MEMBER_OFFSET("printk_ringbuffer.desc_ring", printk_log.desc_ring);
+		WRITE_MEMBER_OFFSET("printk_ringbuffer.text_data_ring", printk_log.text_data_ring);
+
+		WRITE_MEMBER_OFFSET("prb_desc_ring.count_bits", printk_log.count_bits);
+		WRITE_MEMBER_OFFSET("prb_desc_ring.descs", printk_log.descs);
+		WRITE_MEMBER_OFFSET("prb_desc_ring.head_id", printk_log.head_id);
+		WRITE_MEMBER_OFFSET("prb_desc_ring.tail_id", printk_log.tail_id);
+
+		WRITE_MEMBER_OFFSET("prb_desc.info", printk_log.info);
+		WRITE_MEMBER_OFFSET("prb_desc.state_var", printk_log.state_var);
+		WRITE_MEMBER_OFFSET("prb_desc.text_blk_lpos", printk_log.text_blk_lpos);
+
+		WRITE_MEMBER_OFFSET("prb_data_blk_lpos.begin", printk_log.begin);
+		WRITE_MEMBER_OFFSET("prb_data_blk_lpos.next", printk_log.next);
+
+		WRITE_MEMBER_OFFSET("prb_data_ring.size_bits", printk_log.size_bits);
+		WRITE_MEMBER_OFFSET("prb_data_ring.data", printk_log.data);
+
+		WRITE_MEMBER_OFFSET("printk_info.ts_nsec", printk_log.ts_nsec);
+		WRITE_MEMBER_OFFSET("printk_info.text_len", printk_log.text_len);
+
+		WRITE_MEMBER_OFFSET("atomic_long_t.counter", printk_log.counter);
+	} else if (info->flag_use_printk_log) {
 		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
 		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
 		WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
@@ -2606,6 +2664,7 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("node_data", node_data);
 	READ_SYMBOL("pgdat_list", pgdat_list);
 	READ_SYMBOL("contig_page_data", contig_page_data);
+	READ_SYMBOL("prb", prb);
 	READ_SYMBOL("log_buf", log_buf);
 	READ_SYMBOL("log_buf_len", log_buf_len);
 	READ_SYMBOL("log_end", log_end);
@@ -2684,12 +2743,42 @@ read_vmcoreinfo(void)
 	READ_MEMBER_OFFSET("cpu_spec.mmu_features", cpu_spec.mmu_features);
 
 	READ_STRUCTURE_SIZE("printk_log", printk_log);
-	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
+	READ_STRUCTURE_SIZE("printk_ringbuffer", printk_ringbuffer);
+	if (SIZE(printk_ringbuffer) != NOT_FOUND_STRUCTURE) {
+		info->flag_use_printk_ringbuffer = TRUE;
+		info->flag_use_printk_log = FALSE;
+
+		READ_MEMBER_OFFSET("printk_ringbuffer.desc_ring", printk_log.desc_ring);
+		READ_MEMBER_OFFSET("printk_ringbuffer.text_data_ring", printk_log.text_data_ring);
+
+		READ_MEMBER_OFFSET("prb_desc_ring.count_bits", printk_log.count_bits);
+		READ_MEMBER_OFFSET("prb_desc_ring.descs", printk_log.descs);
+		READ_MEMBER_OFFSET("prb_desc_ring.head_id", printk_log.head_id);
+		READ_MEMBER_OFFSET("prb_desc_ring.tail_id", printk_log.tail_id);
+
+		READ_STRUCTURE_SIZE("prb_desc", prb_desc);
+		READ_MEMBER_OFFSET("prb_desc.info", printk_log.info);
+		READ_MEMBER_OFFSET("prb_desc.state_var", printk_log.state_var);
+		READ_MEMBER_OFFSET("prb_desc.text_blk_lpos", printk_log.text_blk_lpos);
+
+		READ_MEMBER_OFFSET("prb_data_blk_lpos.begin", printk_log.begin);
+		READ_MEMBER_OFFSET("prb_data_blk_lpos.next", printk_log.next);
+
+		READ_MEMBER_OFFSET("prb_data_ring.size_bits", printk_log.size_bits);
+		READ_MEMBER_OFFSET("prb_data_ring.data", printk_log.data);
+
+		READ_MEMBER_OFFSET("printk_info.ts_nsec", printk_log.ts_nsec);
+		READ_MEMBER_OFFSET("printk_info.text_len", printk_log.text_len);
+
+		READ_MEMBER_OFFSET("atomic_long_t.counter", printk_log.counter);
+	} else if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
+		info->flag_use_printk_ringbuffer = FALSE;
 		info->flag_use_printk_log = TRUE;
 		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
 		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
 		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
 	} else {
+		info->flag_use_printk_ringbuffer = FALSE;
 		info->flag_use_printk_log = FALSE;
 		READ_STRUCTURE_SIZE("log", printk_log);
 		READ_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
@@ -5303,6 +5392,9 @@ dump_dmesg()
 	if (!initial())
 		return FALSE;
 
+	if ((SYMBOL(prb) != NOT_FOUND_SYMBOL))
+		return dump_lockless_dmesg();
+
 	if ((SYMBOL(log_buf) == NOT_FOUND_SYMBOL)
 	    || (SYMBOL(log_buf_len) == NOT_FOUND_SYMBOL)) {
 		ERRMSG("Can't find some symbols for log_buf.\n");
@@ -5447,7 +5539,6 @@ out:
 	return ret;
 }
 
-
 int
 _exclude_free_page(struct cycle *cycle)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 03fb4ce..70bc805 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1317,6 +1317,7 @@ struct DumpInfo {
 	int             flag_partial_dmesg;  /* dmesg dump only from the last cleared index*/
 	int             flag_mem_usage;  /*show the page number of memory in different use*/
 	int		flag_use_printk_log; /* did we read printk_log symbol name? */
+	int		flag_use_printk_ringbuffer; /* using lockless printk ringbuffer? */
 	int		flag_nospace;	     /* the flag of "No space on device" error */
 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
 	int		flag_excludevm;      /* -e - excluding unused vmemmap pages */
@@ -1602,6 +1603,7 @@ struct symbol_table {
 	unsigned long long	node_data;
 	unsigned long long	pgdat_list;
 	unsigned long long	contig_page_data;
+	unsigned long long	prb;
 	unsigned long long	log_buf;
 	unsigned long long	log_buf_len;
 	unsigned long long	log_end;
@@ -1689,6 +1691,12 @@ struct size_table {
 	long	nodemask_t;
 	long	printk_log;
 
+	/*
+	 * for lockless printk
+	 */
+	long	printk_ringbuffer;
+	long	prb_desc;
+
 	/*
 	 * for Xen extraction
 	 */
@@ -1862,6 +1870,20 @@ struct offset_table {
 		long ts_nsec;
 		long len;
 		long text_len;
+		long desc_ring;
+		long text_data_ring;
+		long count_bits;
+		long descs;
+		long head_id;
+		long tail_id;
+		long info;
+		long state_var;
+		long text_blk_lpos;
+		long begin;
+		long next;
+		long size_bits;
+		long data;
+		long counter;
 	} printk_log;
 
 	/*
@@ -2390,4 +2412,7 @@ int hexadecimal(char *s, int count);
 int decimal(char *s, int count);
 int file_exists(char *file);
 
+int open_dump_file(void);
+int dump_lockless_dmesg(void);
+
 #endif /* MAKEDUMPFILE_H */
diff --git a/printk.c b/printk.c
new file mode 100644
index 0000000..a7239b2
--- /dev/null
+++ b/printk.c
@@ -0,0 +1,177 @@
+#include "makedumpfile.h"
+#include <ctype.h>
+
+#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
+#define DESC_COMMITTED_MASK	(1UL << (DESC_SV_BITS - 1))
+#define DESC_REUSE_MASK		(1UL << (DESC_SV_BITS - 2))
+#define DESC_FLAGS_MASK		(DESC_COMMITTED_MASK | DESC_REUSE_MASK)
+#define DESC_ID_MASK		(~DESC_FLAGS_MASK)
+
+/* convenience struct for passing many values to helper functions */
+struct prb_map {
+	char		*prb;
+
+	char		*desc_ring;
+	unsigned long	desc_ring_count;
+	char		*descs;
+
+	char		*text_data_ring;
+	unsigned long	text_data_ring_size;
+	char		*text_data;
+};
+
+static void
+dump_record(struct prb_map *m, unsigned long id)
+{
+	unsigned long long ts_nsec;
+	unsigned long state_var;
+	unsigned short text_len;
+	unsigned long begin;
+	unsigned long next;
+	char buf[BUFSIZE];
+	ulonglong nanos;
+	int indent_len;
+	int buf_need;
+	char *bufp;
+	char *text;
+	char *desc;
+	char *inf;
+	ulong rem;
+	char *p;
+	int i;
+
+	desc = m->descs + ((id % m->desc_ring_count) * SIZE(prb_desc));
+
+	/* skip non-committed record */
+	state_var = ULONG(desc + OFFSET(printk_log.state_var) +
+			  OFFSET(printk_log.counter));
+	if ((state_var & DESC_FLAGS_MASK) != DESC_COMMITTED_MASK)
+		return;
+
+	inf = desc + OFFSET(printk_log.info);
+
+	begin = ULONG(desc + OFFSET(printk_log.text_blk_lpos) +
+		      OFFSET(printk_log.begin)) %
+		m->text_data_ring_size;
+	next = ULONG(desc + OFFSET(printk_log.text_blk_lpos) +
+		     OFFSET(printk_log.next)) %
+	       m->text_data_ring_size;
+
+	/* skip data-less text blocks */
+	if (begin == next)
+		return;
+
+	text_len = USHORT(inf + OFFSET(printk_log.text_len));
+
+	/* handle wrapping data block */
+	if (begin > next)
+		begin = 0;
+
+	/* skip over descriptor ID */
+	begin += sizeof(unsigned long);
+
+	/* handle truncated messages */
+	if (next - begin < text_len)
+		text_len = next - begin;
+
+	text = m->text_data + begin;
+
+	ts_nsec = ULONGLONG(inf + OFFSET(printk_log.ts_nsec));
+	nanos = (ulonglong)ts_nsec / (ulonglong)1000000000;
+	rem = (ulonglong)ts_nsec % (ulonglong)1000000000;
+
+	bufp = buf;
+	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
+	indent_len = strlen(buf);
+
+	/* How much buffer space is needed in the worst case */
+	buf_need = MAX(sizeof("\\xXX\n"), sizeof("\n") + indent_len);
+
+	for (i = 0, p = text; i < text_len; i++, p++) {
+		if (bufp - buf >= sizeof(buf) - buf_need) {
+			if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
+				return;
+			bufp = buf;
+		}
+
+		if (*p == '\n')
+			bufp += sprintf(bufp, "\n%-*s", indent_len, "");
+		else if (isprint(*p) || isspace(*p))
+			*bufp++ = *p;
+		else
+			bufp += sprintf(bufp, "\\x%02x", *p);
+	}
+
+	*bufp++ = '\n';
+
+	write(info->fd_dumpfile, buf, bufp - buf);
+}
+
+int
+dump_lockless_dmesg(void)
+{
+	unsigned long head_id;
+	unsigned long tail_id;
+	unsigned long kaddr;
+	unsigned long id;
+	struct prb_map m;
+	int ret = FALSE;
+
+	/* setup printk_ringbuffer */
+	readmem(VADDR, SYMBOL(prb), &kaddr, sizeof(kaddr));
+	m.prb = malloc(SIZE(printk_ringbuffer));
+	if (!readmem(VADDR, kaddr, m.prb, SIZE(printk_ringbuffer))) {
+		ERRMSG("Can't get prb.\n");
+		goto out_prb;
+	}
+
+	/* setup descriptor ring */
+	m.desc_ring = m.prb + OFFSET(printk_log.desc_ring);
+	m.desc_ring_count = 1 << UINT(m.desc_ring +
+				      OFFSET(printk_log.count_bits));
+	kaddr = ULONG(m.desc_ring + OFFSET(printk_log.descs));
+	m.descs = malloc(SIZE(prb_desc) * m.desc_ring_count);
+	if (!readmem(VADDR, kaddr, m.descs,
+		     SIZE(prb_desc) * m.desc_ring_count)) {
+		ERRMSG("Can't get prb.desc_ring.\n");
+		goto out_descs;
+	}
+
+	/* setup text data ring */
+	m.text_data_ring = m.prb + OFFSET(printk_log.text_data_ring);
+	m.text_data_ring_size = 1 << UINT(m.text_data_ring +
+					  OFFSET(printk_log.size_bits));
+	kaddr = ULONG(m.text_data_ring + OFFSET(printk_log.data));
+	m.text_data = malloc(m.text_data_ring_size);
+	if (!readmem(VADDR, kaddr, m.text_data, m.text_data_ring_size)) {
+		ERRMSG("Can't get prb.text_data_ring.\n");
+		goto out_text_data;
+	}
+
+	/* ready to go */
+
+	tail_id = ULONG(m.desc_ring + OFFSET(printk_log.tail_id) +
+			OFFSET(printk_log.counter));
+	head_id = ULONG(m.desc_ring + OFFSET(printk_log.head_id) +
+			OFFSET(printk_log.counter));
+
+	if (!open_dump_file()) {
+		ERRMSG("Can't open output file.\n");
+		goto out_text_data;
+	}
+
+	for (id = tail_id; id != head_id; id = (id + 1) & DESC_ID_MASK)
+		dump_record(&m, id);
+
+	if (!close_files_for_creating_dumpfile())
+		goto out_text_data;
+
+	ret = TRUE;
+out_text_data:
+	free(m.text_data);
+out_descs:
+	free(m.descs);
+out_prb:
+	free(m.prb);
+	return ret;
+}
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
