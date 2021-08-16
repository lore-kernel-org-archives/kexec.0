Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx.aristanetworks.com ([162.210.129.12]
 helo=smtp.aristanetworks.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFlQM-000SXy-2m
 for kexec@lists.infradead.org; Mon, 16 Aug 2021 22:49:45 +0000
Date: Mon, 16 Aug 2021 15:49:36 -0700
From: Ivan Delalande <colona@arista.com>
Subject: [PATCH] makedumpfile: support --partial-dmesg on 5.10+ kernels
Message-ID: <YRrrgKjxefeXIb3O@visor>
Content-Disposition: inline
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
To: John Ogness <john.ogness@linutronix.de>, Kazuhito Hagio <k-hagio-ab@nec.com>
Cc: kexec@lists.infradead.org

The new printk ringbuffer implementation added in kernel v5.10 with
commit 896fbe20b4e2 ("printk: use the lockless ringbuffer") also
exported a new vmcore symbol "clear_seq" to keep track where dmesg had
been cleared like "clear_idx" on previous versions. Use it in
dump_lockless_dmesg when --partial-dmesg is passed to find and start
dumping messages only from that index.

Signed-off-by: Ivan Delalande <colona@arista.com>
---
 makedumpfile.c |  3 +++
 makedumpfile.h |  1 +
 printk.c       | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index b1b3b42..caf4d12 100644
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
@@ -2231,6 +2232,7 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("pgdat_list", pgdat_list);
 	WRITE_SYMBOL("contig_page_data", contig_page_data);
 	WRITE_SYMBOL("prb", prb);
+	WRITE_SYMBOL("clear_seq", clear_seq);
 	WRITE_SYMBOL("log_buf", log_buf);
 	WRITE_SYMBOL("log_buf_len", log_buf_len);
 	WRITE_SYMBOL("log_end", log_end);
@@ -2676,6 +2678,7 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("pgdat_list", pgdat_list);
 	READ_SYMBOL("contig_page_data", contig_page_data);
 	READ_SYMBOL("prb", prb);
+	READ_SYMBOL("clear_seq", clear_seq);
 	READ_SYMBOL("log_buf", log_buf);
 	READ_SYMBOL("log_buf_len", log_buf_len);
 	READ_SYMBOL("log_end", log_end);
diff --git a/makedumpfile.h b/makedumpfile.h
index ca50a89..c57ac7a 100644
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
diff --git a/printk.c b/printk.c
index e8501c7..a160a5f 100644
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
@@ -216,6 +217,15 @@ dump_lockless_dmesg(void)
 			OFFSET(atomic_long_t.counter));
 	head_id = ULONG(m.desc_ring + OFFSET(prb_desc_ring.head_id) +
 			OFFSET(atomic_long_t.counter));
+	if (info->flag_partial_dmesg && SYMBOL(clear_seq) != NOT_FOUND_SYMBOL) {
+		if (!readmem(VADDR, SYMBOL(clear_seq), &clear_seq,
+			     sizeof(clear_seq))) {
+			ERRMSG("Can't get clear_seq.\n");
+			goto out_text_data;
+		}
+		tail_id = head_id - head_id % m.desc_ring_count +
+			  clear_seq % m.desc_ring_count;
+	}
 
 	if (!open_dump_file()) {
 		ERRMSG("Can't open output file.\n");
-- 
2.32.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
