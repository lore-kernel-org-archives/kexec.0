Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr5Kb-0003Ul-6t
 for kexec@lists.infradead.org; Thu, 02 Jul 2020 19:57:14 +0000
Subject: [PATCH v2 11/12] ppc64/kexec_file: add appropriate regions for
 memory reserve map
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Fri, 03 Jul 2020 01:26:58 +0530
Message-ID: <159371981275.21555.6976349309559084424.stgit@hbathini.in.ibm.com>
In-Reply-To: <159371956443.21555.18251597651350106920.stgit@hbathini.in.ibm.com>
References: <159371956443.21555.18251597651350106920.stgit@hbathini.in.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Mimi Zohar <zohar@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

While initrd, elfcorehdr and backup regions are already added to the
reserve map, there are a few missing regions that need to be added to
the memory reserve map. Add them here. And now that all the changes
to load panic kernel are in place, claim likewise.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
* Updated add_rtas_mem_range() & add_opal_mem_range() callsites based on
  the new prototype for these functions.


 arch/powerpc/kexec/file_load_64.c |   58 ++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 6f895fa..d3b29e0 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -193,6 +193,34 @@ static int get_crash_memory_ranges(struct crash_mem **mem_ranges)
 }
 
 /**
+ * get_reserved_memory_ranges - Get reserve memory ranges. This list includes
+ *                              memory regions that should be added to the
+ *                              memory reserve map to ensure the region is
+ *                              protected from any mischeif.
+ * @mem_ranges:                 Range list to add the memory ranges to.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+static int get_reserved_memory_ranges(struct crash_mem **mem_ranges)
+{
+	int ret;
+
+	ret = add_rtas_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_tce_mem_ranges(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_reserved_ranges(mem_ranges);
+out:
+	if (ret)
+		pr_err("Failed to setup reserved memory ranges\n");
+	return ret;
+}
+
+/**
  * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
  *                              in the memory regions between buf_min & buf_max
  *                              for the buffer. If found, sets kbuf->mem.
@@ -1200,8 +1228,8 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 			unsigned long initrd_load_addr,
 			unsigned long initrd_len, const char *cmdline)
 {
-	struct crash_mem *umem = NULL;
-	int chosen_node, ret;
+	struct crash_mem *umem = NULL, *rmem = NULL;
+	int i, nr_ranges, chosen_node, ret;
 
 	/* Remove memory reservation for the current device tree. */
 	ret = delete_fdt_mem_rsv(fdt, __pa(initial_boot_params),
@@ -1247,6 +1275,25 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 		}
 	}
 
+	/* Update memory reserve map */
+	ret = get_reserved_memory_ranges(&rmem);
+	if (ret)
+		goto out;
+
+	nr_ranges = rmem ? rmem->nr_ranges : 0;
+	for (i = 0; i < nr_ranges; i++) {
+		u64 base, size;
+
+		base = rmem->ranges[i].start;
+		size = rmem->ranges[i].end - base + 1;
+		ret = fdt_add_mem_rsv(fdt, base, size);
+		if (ret) {
+			pr_err("Error updating memory reserve map: %s\n",
+			       fdt_strerror(ret));
+			goto out;
+		}
+	}
+
 	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len,
 			    cmdline, &chosen_node);
 	if (ret)
@@ -1257,6 +1304,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 		pr_err("Failed to update device-tree with linux,booted-from-kexec\n");
 out:
 	kfree(umem);
+	kfree(rmem);
 	return ret;
 }
 
@@ -1434,10 +1482,10 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 
 		/* Get exclude memory ranges needed for setting up kdump segments */
 		ret = get_exclude_memory_ranges(&(image->arch.exclude_ranges));
-		if (ret)
+		if (ret) {
 			pr_err("Failed to setup exclude memory ranges for buffer lookup\n");
-		/* Return this until all changes for panic kernel are in */
-		return -EOPNOTSUPP;
+			return ret;
+		}
 	}
 
 	return kexec_image_probe_default(image, buf, buf_len);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
