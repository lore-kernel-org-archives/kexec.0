Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sullivan.realtime.net ([205.238.132.226])
	by casper.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1KskUH-0004Pt-Bm
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 20:39:29 +0000
Date: Wed, 22 Oct 2008 15:39:17 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH 2/2 kexec-tools] ppc64: segemments are sorted
Message-id: <kexec-user-2@bga.com>
In-Reply-To: <f90d4d7306443a720ca31adf513faf25@bga.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>

Every time add_segment is called, the segments are sorted.  If the first
hole in memory is not big enough for the kernel then something besides
the kernel may be at 

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Found during custom environment testing with several reserved blocks of
memory, not the usual case.

Index: kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-10-22 06:14:48.000000000 -0500
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-10-22 06:14:54.000000000 -0500
@@ -86,7 +86,7 @@ int elf_ppc64_load(int argc, char **argv
 	size_t size;
 	uint64_t *rsvmap_ptr;
 	struct bootblock *bb_ptr;
-	unsigned int nr_segments, i;
+	unsigned int i;
 	int result, opt;
 	uint64_t my_kernel, my_dt_offset;
 	unsigned int my_panic_kernel;
@@ -187,7 +187,7 @@ int elf_ppc64_load(int argc, char **argv
 	if (size > phdr->p_memsz)
 		size = phdr->p_memsz;
 
-	hole_addr = (uint64_t)locate_hole(info, size, 0, 0,
+	my_kernel = hole_addr = (uint64_t)locate_hole(info, size, 0, 0,
 			max_addr, 1);
 	ehdr.e_phdr[0].p_paddr = hole_addr;
 	result = elf_exec_load(&ehdr, info);
@@ -233,12 +233,10 @@ int elf_ppc64_load(int argc, char **argv
 			return -1;
 		}
 		seg_buf = (unsigned char *)slurp_file(ramdisk, &seg_size);
-		add_buffer(info, seg_buf, seg_size, seg_size, 0, 0, max_addr, 1);
-		hole_addr = (uintptr_t)
-			info->segment[info->nr_segments-1].mem;
+		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
+			0, 0, max_addr, 1);
 		initrd_base = hole_addr;
-		initrd_size = (uint64_t)
-			info->segment[info->nr_segments-1].memsz;
+		initrd_size = seg_size;
 	} /* ramdisk */
 
 	if (devicetreeblob) {
@@ -248,16 +246,18 @@ int elf_ppc64_load(int argc, char **argv
 		/* Grab device tree from buffer */
 		blob_buf =
 			(unsigned char *)slurp_file(devicetreeblob, &blob_size);
-		add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
-				max_addr, -1);
+		my_dt_offset = add_buffer(info, blob_buf, blob_size, blob_size,
+				0, 0, max_addr, -1);
 
+		seg_buf = blob_buf;
+		seg_size = blob_size;
 	} else {
 		/* create from fs2dt */
 		seg_buf = NULL;
 		seg_size = 0;
 		create_flatten_tree(info, (unsigned char **)&seg_buf,
 				(unsigned long *)&seg_size,cmdline);
-		add_buffer(info, seg_buf, seg_size, seg_size,
+		my_dt_offset = add_buffer(info, seg_buf, seg_size, seg_size,
 				0, 0, max_addr, -1);
 	}
 
@@ -265,27 +265,20 @@ int elf_ppc64_load(int argc, char **argv
 	 * find last entry (both 0) in the reserve mem list.  Assume DT
 	 * entry is before this one
 	 */
-	bb_ptr = (struct bootblock *)(
-		(unsigned char *)info->segment[(info->nr_segments)-1].buf);
-	rsvmap_ptr = (uint64_t *)(
-		(unsigned char *)info->segment[(info->nr_segments)-1].buf +
-		bb_ptr->off_mem_rsvmap);
+	bb_ptr = (struct bootblock *)(seg_buf);
+	rsvmap_ptr = (uint64_t *)
+		(((char *)seg_buf) + bb_ptr->off_mem_rsvmap);
 	while (*rsvmap_ptr || *(rsvmap_ptr+1))
 		rsvmap_ptr += 2;
 	rsvmap_ptr -= 2;
-	*rsvmap_ptr = (uintptr_t)(
-		info->segment[(info->nr_segments)-1].mem);
+	*rsvmap_ptr = my_dt_offset;
 	rsvmap_ptr++;
 	*rsvmap_ptr = (uint64_t)bb_ptr->totalsize;
 
-	nr_segments = info->nr_segments;
-
 	/* Set kernel */
-	my_kernel = (uintptr_t)info->segment[0].mem;
 	elf_rel_set_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
 
 	/* Set dt_offset */
-	my_dt_offset = (uintptr_t)info->segment[nr_segments-1].mem;
 	elf_rel_set_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
 				sizeof(my_dt_offset));
 
@@ -293,7 +286,7 @@ int elf_ppc64_load(int argc, char **argv
 	elf_rel_get_symbol(&info->rhdr, "purgatory_start", slave_code,
 			sizeof(slave_code));
 	master_entry = slave_code[0];
-	memcpy(slave_code, info->segment[0].buf, sizeof(slave_code));
+	memcpy(slave_code, phdr->p_data, sizeof(slave_code));
 	slave_code[0] = master_entry;
 	elf_rel_set_symbol(&info->rhdr, "purgatory_start", slave_code,
 				sizeof(slave_code));
@@ -366,7 +359,7 @@ int elf_ppc64_load(int argc, char **argv
 	fprintf(stderr, "purgatory size is %zu\n", purgatory_size);
 #endif
 
-	for (i = 0; i < nr_segments; i++)
+	for (i = 0; i < info->nr_segments; i++)
 		fprintf(stderr, "segment[%d].mem:%p memsz:%zu\n", i,
 			info->segment[i].mem, info->segment[i].memsz);
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
