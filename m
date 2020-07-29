Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0kQk-0002UP-JL
 for kexec@lists.infradead.org; Wed, 29 Jul 2020 11:39:31 +0000
Subject: [PATCH v6 01/11] kexec_file: allow archs to handle special regions
 while locating memory hole
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Wed, 29 Jul 2020 17:09:19 +0530
Message-ID: <159602273603.575379.17665852963340380839.stgit@hbathini>
In-Reply-To: <159602259854.575379.16910915605574571585.stgit@hbathini>
References: <159602259854.575379.16910915605574571585.stgit@hbathini>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

Some architectures may have special memory regions, within the given
memory range, which can't be used for the buffer in a kexec segment.
Implement weak arch_kexec_locate_mem_hole() definition which arch code
may override, to take care of special regions, while trying to locate
a memory hole.

Also, add the missing declarations for arch overridable functions and
and drop the __weak descriptors in the declarations to avoid non-weak
definitions from becoming weak.

Reported-by: kernel test robot <lkp@intel.com>
[lkp: In v1, arch_kimage_file_post_load_cleanup() declaration was missing]
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Pingfan Liu <piliu@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---

v5 -> v6:
* Unchanged.

v4 -> v5:
* Unchanged.

v3 -> v4:
* Unchanged. Added Reviewed-by tag from Thiago.

v2 -> v3:
* Unchanged. Added Acked-by & Tested-by tags from Dave & Pingfan.

v1 -> v2:
* Introduced arch_kexec_locate_mem_hole() for override and dropped
  weak arch_kexec_add_buffer().
* Dropped __weak identifier for arch overridable functions.
* Fixed the missing declaration for arch_kimage_file_post_load_cleanup()
  reported by lkp. lkp report for reference:
    - https://lore.kernel.org/patchwork/patch/1264418/


 include/linux/kexec.h |   29 ++++++++++++++++++-----------
 kernel/kexec_file.c   |   16 ++++++++++++++--
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ea67910ae6b7..9e93bef52968 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -183,17 +183,24 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   bool get_value);
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
 
-int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-					 unsigned long buf_len);
-void * __weak arch_kexec_kernel_image_load(struct kimage *image);
-int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
-					    Elf_Shdr *section,
-					    const Elf_Shdr *relsec,
-					    const Elf_Shdr *symtab);
-int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
-					Elf_Shdr *section,
-					const Elf_Shdr *relsec,
-					const Elf_Shdr *symtab);
+/* Architectures may override the below functions */
+int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
+				  unsigned long buf_len);
+void *arch_kexec_kernel_image_load(struct kimage *image);
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section,
+				     const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtab);
+int arch_kexec_apply_relocations(struct purgatory_info *pi,
+				 Elf_Shdr *section,
+				 const Elf_Shdr *relsec,
+				 const Elf_Shdr *symtab);
+int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#ifdef CONFIG_KEXEC_SIG
+int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
+				 unsigned long buf_len);
+#endif
+int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 09cc78df53c6..e89912d33a27 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -635,6 +635,19 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
 
+/**
+ * arch_kexec_locate_mem_hole - Find free memory to place the segments.
+ * @kbuf:                       Parameters for the memory search.
+ *
+ * On success, kbuf->mem will have the start address of the memory region found.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
+{
+	return kexec_locate_mem_hole(kbuf);
+}
+
 /**
  * kexec_add_buffer - place a buffer in a kexec segment
  * @kbuf:	Buffer contents and memory parameters.
@@ -647,7 +660,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
  */
 int kexec_add_buffer(struct kexec_buf *kbuf)
 {
-
 	struct kexec_segment *ksegment;
 	int ret;
 
@@ -675,7 +687,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	ret = kexec_locate_mem_hole(kbuf);
+	ret = arch_kexec_locate_mem_hole(kbuf);
 	if (ret)
 		return ret;
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
