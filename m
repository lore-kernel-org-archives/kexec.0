Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RRTbD-0005zu-29
 for kexec@lists.infradead.org; Fri, 18 Nov 2011 18:55:43 +0000
Received: by iapp10 with SMTP id p10so5460832iap.36
 for <kexec@lists.infradead.org>; Fri, 18 Nov 2011 10:55:41 -0800 (PST)
Date: Fri, 18 Nov 2011 10:55:35 -0800
From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] percpu: fix chunk range calculation
Message-ID: <20111118185535.GA27152@google.com>
References: <4EC31E55.6040809@redhat.com> <1321467647.2137.4.camel@boudreau>
 <4EC47FCA.5090908@redhat.com>
 <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
 <4EC491B3.705@redhat.com>
 <CAMMEr5k_ynqg5-7Looar2DxXTGZcMqi5Lo+jtETn9awO_bsaGg@mail.gmail.com>
 <4EC4B60C.3030706@redhat.com> <1321548033.12208.12.camel@boudreau>
 <4EC61AB6.4090808@redhat.com> <4EC61B2A.7010000@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EC61B2A.7010000@redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, tim@edgecast.com, linux-kernel@vger.kernel.org

Percpu allocator recorded the cpus which map to the first and last
units in pcpu_first/last_unit_cpu respectively and used them to
determine the address range of a chunk - e.g. it assumed that the
first unit has the lowest address in a chunk while the last unit has
the highest address.

This simply isn't true.  Groups in a chunk can have arbitrary positive
or negative offsets from the previous one and there is no guarantee
that the first unit occupies the lowest offset while the last one the
highest.

Fix it by actually comparing unit offsets to determine cpus occupying
the lowest and highest offsets.  Also, rename pcu_first/last_unit_cpu
to pcpu_low/high_unit_cpu to avoid confusion.

The chunk address range is used to flush cache on vmalloc area
map/unmap and decide whether a given address is in the first chunk by
per_cpu_ptr_to_phys() and the bug was discovered by invalid
per_cpu_ptr_to_phys() translation for crash_note.

Kudos to Dave Young for tracking down the problem.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: WANG Cong <xiyou.wangcong@gmail.com>
Reported-by: Dave Young <dyoung@redhat.com>
LKML-Reference: <4EC21F67.10905@redhat.com>
Cc: stable @kernel.org
---
Heh, that's a stupid bug.  Can you please verify this fixes the
problem?

Thank you very much.

 mm/percpu-vm.c |   12 ++++++------
 mm/percpu.c    |   34 ++++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index ea53496..bfad724 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -143,8 +143,8 @@ static void pcpu_pre_unmap_flush(struct pcpu_chunk *chunk,
 				 int page_start, int page_end)
 {
 	flush_cache_vunmap(
-		pcpu_chunk_addr(chunk, pcpu_first_unit_cpu, page_start),
-		pcpu_chunk_addr(chunk, pcpu_last_unit_cpu, page_end));
+		pcpu_chunk_addr(chunk, pcpu_low_unit_cpu, page_start),
+		pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, page_end));
 }
 
 static void __pcpu_unmap_pages(unsigned long addr, int nr_pages)
@@ -206,8 +206,8 @@ static void pcpu_post_unmap_tlb_flush(struct pcpu_chunk *chunk,
 				      int page_start, int page_end)
 {
 	flush_tlb_kernel_range(
-		pcpu_chunk_addr(chunk, pcpu_first_unit_cpu, page_start),
-		pcpu_chunk_addr(chunk, pcpu_last_unit_cpu, page_end));
+		pcpu_chunk_addr(chunk, pcpu_low_unit_cpu, page_start),
+		pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, page_end));
 }
 
 static int __pcpu_map_pages(unsigned long addr, struct page **pages,
@@ -284,8 +284,8 @@ static void pcpu_post_map_flush(struct pcpu_chunk *chunk,
 				int page_start, int page_end)
 {
 	flush_cache_vmap(
-		pcpu_chunk_addr(chunk, pcpu_first_unit_cpu, page_start),
-		pcpu_chunk_addr(chunk, pcpu_last_unit_cpu, page_end));
+		pcpu_chunk_addr(chunk, pcpu_low_unit_cpu, page_start),
+		pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, page_end));
 }
 
 /**
diff --git a/mm/percpu.c b/mm/percpu.c
index bf80e55..93b5a7c 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -116,9 +116,9 @@ static int pcpu_atom_size __read_mostly;
 static int pcpu_nr_slots __read_mostly;
 static size_t pcpu_chunk_struct_size __read_mostly;
 
-/* cpus with the lowest and highest unit numbers */
-static unsigned int pcpu_first_unit_cpu __read_mostly;
-static unsigned int pcpu_last_unit_cpu __read_mostly;
+/* cpus with the lowest and highest unit addresses */
+static unsigned int pcpu_low_unit_cpu __read_mostly;
+static unsigned int pcpu_high_unit_cpu __read_mostly;
 
 /* the address of the first chunk which starts with the kernel static area */
 void *pcpu_base_addr __read_mostly;
@@ -984,19 +984,19 @@ phys_addr_t per_cpu_ptr_to_phys(void *addr)
 {
 	void __percpu *base = __addr_to_pcpu_ptr(pcpu_base_addr);
 	bool in_first_chunk = false;
-	unsigned long first_start, first_end;
+	unsigned long first_low, first_high;
 	unsigned int cpu;
 
 	/*
-	 * The following test on first_start/end isn't strictly
+	 * The following test on unit_low/high isn't strictly
 	 * necessary but will speed up lookups of addresses which
 	 * aren't in the first chunk.
 	 */
-	first_start = pcpu_chunk_addr(pcpu_first_chunk, pcpu_first_unit_cpu, 0);
-	first_end = pcpu_chunk_addr(pcpu_first_chunk, pcpu_last_unit_cpu,
-				    pcpu_unit_pages);
-	if ((unsigned long)addr >= first_start &&
-	    (unsigned long)addr < first_end) {
+	first_low = pcpu_chunk_addr(pcpu_first_chunk, pcpu_low_unit_cpu, 0);
+	first_high = pcpu_chunk_addr(pcpu_first_chunk, pcpu_high_unit_cpu,
+				     pcpu_unit_pages);
+	if ((unsigned long)addr >= first_low &&
+	    (unsigned long)addr < first_high) {
 		for_each_possible_cpu(cpu) {
 			void *start = per_cpu_ptr(base, cpu);
 
@@ -1233,7 +1233,9 @@ int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
 		unit_map[cpu] = UINT_MAX;
-	pcpu_first_unit_cpu = NR_CPUS;
+
+	pcpu_low_unit_cpu = NR_CPUS;
+	pcpu_high_unit_cpu = NR_CPUS;
 
 	for (group = 0, unit = 0; group < ai->nr_groups; group++, unit += i) {
 		const struct pcpu_group_info *gi = &ai->groups[group];
@@ -1253,9 +1255,13 @@ int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 			unit_map[cpu] = unit + i;
 			unit_off[cpu] = gi->base_offset + i * ai->unit_size;
 
-			if (pcpu_first_unit_cpu == NR_CPUS)
-				pcpu_first_unit_cpu = cpu;
-			pcpu_last_unit_cpu = cpu;
+			/* determine low/high unit_cpu */
+			if (pcpu_low_unit_cpu == NR_CPUS ||
+			    unit_off[cpu] < unit_off[pcpu_low_unit_cpu])
+				pcpu_low_unit_cpu = cpu;
+			if (pcpu_high_unit_cpu == NR_CPUS ||
+			    unit_off[cpu] > unit_off[pcpu_high_unit_cpu])
+				pcpu_high_unit_cpu = cpu;
 		}
 	}
 	pcpu_nr_units = unit;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
