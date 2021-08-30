Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-x361.google.com ([2607:f8b0:4864:20::361])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKqht-000pCi-ES
 for kexec@lists.infradead.org; Mon, 30 Aug 2021 23:28:53 +0000
Received: by mail-ot1-x361.google.com with SMTP id
 c42-20020a05683034aa00b0051f4b99c40cso10283231otu.0
 for <kexec@lists.infradead.org>; Mon, 30 Aug 2021 16:28:47 -0700 (PDT)
Date: Mon, 30 Aug 2021 16:28:44 -0700
From: Ivan Delalande <colona@arista.com>
Subject: [PATCH v2] makedumpfile: support --partial-dmesg on 5.10+ kernels
Message-ID: <YS1prC+k23E964Qz@visor>
References: <YRrrgKjxefeXIb3O@visor>
 <TYYPR01MB677762D7B0E7850537CDF61BDDFF9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <TYYPR01MB677762D7B0E7850537CDF61BDDFF9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
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
To: HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, John Ogness <john.ogness@linutronix.de>

The new printk ringbuffer implementation added in kernel v5.10 with
commit 896fbe20b4e2 ("printk: use the lockless ringbuffer") also
exported a new vmcore symbol "clear_seq" to keep track where dmesg had
been cleared like "clear_idx" on previous versions. Use it in
dump_lockless_dmesg when --partial-dmesg is passed to find and start
dumping messages only from that index.

On v5.13, commit 7d7a23a91c91 ("printk: use seqcount_latch for
clear_seq") converted it from a simple value, and so an additional step
is required to find and retrieve the sequence at the right offset in the
latched_seq structure it now uses.

Signed-off-by: Ivan Delalande <colona@arista.com>
---
 makedumpfile.c | 12 ++++++++++++
 makedumpfile.h |  6 ++++++
 printk.c       | 19 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index b1b3b42..ac17f19 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1555,6 +1555,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(pgdat_list, "pgdat_list");
 	SYMBOL_INIT(contig_page_data, "contig_page_data");
 	SYMBOL_INIT(prb, "prb");
+	SYMBOL_INIT(clear_seq, "clear_seq");
 	SYMBOL_INIT(log_buf, "log_buf");
 	SYMBOL_INIT(log_buf_len, "log_buf_len");
 	SYMBOL_INIT(log_end, "log_end");
@@ -2000,6 +2001,9 @@ get_structure_info(void)
 		OFFSET_INIT(printk_info.text_len, "printk_info", "text_len");
 
 		OFFSET_INIT(atomic_long_t.counter, "atomic_long_t", "counter");
+
+		SIZE_INIT(latched_seq, "latched_seq");
+		OFFSET_INIT(latched_seq.val, "latched_seq", "val");
 	} else if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
 		/*
 		 * In kernel 3.11-rc4 the log structure name was renamed
@@ -2231,6 +2235,7 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("pgdat_list", pgdat_list);
 	WRITE_SYMBOL("contig_page_data", contig_page_data);
 	WRITE_SYMBOL("prb", prb);
+	WRITE_SYMBOL("clear_seq", clear_seq);
 	WRITE_SYMBOL("log_buf", log_buf);
 	WRITE_SYMBOL("log_buf_len", log_buf_len);
 	WRITE_SYMBOL("log_end", log_end);
@@ -2266,6 +2271,7 @@ write_vmcoreinfo_data(void)
 		WRITE_STRUCTURE_SIZE("printk_ringbuffer", printk_ringbuffer);
 		WRITE_STRUCTURE_SIZE("prb_desc", prb_desc);
 		WRITE_STRUCTURE_SIZE("printk_info", printk_info);
+		WRITE_STRUCTURE_SIZE("latched_seq", latched_seq);
 	} else if (info->flag_use_printk_log)
 		WRITE_STRUCTURE_SIZE("printk_log", printk_log);
 	else
@@ -2335,6 +2341,8 @@ write_vmcoreinfo_data(void)
 		WRITE_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
 
 		WRITE_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
+
+		WRITE_MEMBER_OFFSET("latched_seq.val", latched_seq.val);
 	} else if (info->flag_use_printk_log) {
 		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
 		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
@@ -2676,6 +2684,7 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("pgdat_list", pgdat_list);
 	READ_SYMBOL("contig_page_data", contig_page_data);
 	READ_SYMBOL("prb", prb);
+	READ_SYMBOL("clear_seq", clear_seq);
 	READ_SYMBOL("log_buf", log_buf);
 	READ_SYMBOL("log_buf_len", log_buf_len);
 	READ_SYMBOL("log_end", log_end);
@@ -2784,6 +2793,9 @@ read_vmcoreinfo(void)
 		READ_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
 
 		READ_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
+
+		READ_STRUCTURE_SIZE("latched_seq", latched_seq);
+		READ_MEMBER_OFFSET("latched_seq.val", latched_seq.val);
 	} else if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
 		info->flag_use_printk_ringbuffer = FALSE;
 		info->flag_use_printk_log = TRUE;
diff --git a/makedumpfile.h b/makedumpfile.h
index ca50a89..bd9e2f6 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1656,6 +1656,7 @@ struct symbol_table {
 	unsigned long long	pgdat_list;
 	unsigned long long	contig_page_data;
 	unsigned long long	prb;
+	unsigned long long	clear_seq;
 	unsigned long long	log_buf;
 	unsigned long long	log_buf_len;
 	unsigned long long	log_end;
@@ -1749,6 +1750,7 @@ struct size_table {
 	long	printk_ringbuffer;
 	long	prb_desc;
 	long	printk_info;
+	long	latched_seq;
 
 	/*
 	 * for Xen extraction
@@ -1973,6 +1975,10 @@ struct offset_table {
 		long counter;
 	} atomic_long_t;
 
+	struct latched_seq_s {
+		long val;
+	} latched_seq;
+
 	/*
 	 * symbols on ppc64 arch
 	 */
diff --git a/printk.c b/printk.c
index e8501c7..61e0b26 100644
--- a/printk.c
+++ b/printk.c
@@ -145,6 +145,7 @@ dump_record(struct prb_map *m, unsigned long id)
 int
 dump_lockless_dmesg(void)
 {
+	unsigned long long clear_seq;
 	unsigned long head_id;
 	unsigned long tail_id;
 	unsigned long kaddr;
@@ -216,6 +217,24 @@ dump_lockless_dmesg(void)
 			OFFSET(atomic_long_t.counter));
 	head_id = ULONG(m.desc_ring + OFFSET(prb_desc_ring.head_id) +
 			OFFSET(atomic_long_t.counter));
+	if (info->flag_partial_dmesg && SYMBOL(clear_seq) != NOT_FOUND_SYMBOL) {
+		if (!readmem(VADDR, SYMBOL(clear_seq), &clear_seq,
+			     sizeof(clear_seq))) {
+			ERRMSG("Can't get clear_seq.\n");
+			goto out_text_data;
+		}
+		if (SIZE(latched_seq) != NOT_FOUND_STRUCTURE) {
+			kaddr = SYMBOL(clear_seq) + OFFSET(latched_seq.val) +
+				(clear_seq & 0x1) * sizeof(clear_seq);
+			if (!readmem(VADDR, kaddr, &clear_seq,
+				     sizeof(clear_seq))) {
+				ERRMSG("Can't get latched clear_seq.\n");
+				goto out_text_data;
+			}
+		}
+		tail_id = head_id - head_id % m.desc_ring_count +
+			  clear_seq % m.desc_ring_count;
+	}
 
 	if (!open_dump_file()) {
 		ERRMSG("Can't open output file.\n");
-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
