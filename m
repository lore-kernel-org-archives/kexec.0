Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f49.google.com ([209.85.215.49])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PHDGW-0008M0-He
	for kexec@lists.infradead.org; Sat, 13 Nov 2010 10:23:25 +0000
Received: by ewy19 with SMTP id 19so2255504ewy.36
	for <kexec@lists.infradead.org>; Sat, 13 Nov 2010 02:23:22 -0800 (PST)
Subject: [PATCH] Patch adds kernel data section to final vmcore. This forces
	gdb read kernel
From: Maxim Uvarov <muvarov@gmail.com>
Date: Sat, 13 Nov 2010 13:23:20 +0300
Message-ID: <20101113102320.3273.3435.stgit@localhost.localdomain>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

From: Maxim Uvarov <muvarov@gmail.com>

static data from dump instead of not initialized values from vmlinux.
Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
---

 kexec/arch/mips/crashdump-mips.c |   49 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 17cf52d..5ea4f4f 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -49,6 +49,49 @@ static struct memory_range crash_reserved_mem;
  */
 unsigned long long saved_max_mem;
 
+/* Read kernel physical load addr from the file returned by proc_iomem()
+ * (Kernel Code) and store in kexec_info */
+static int get_kernel_paddr(struct kexec_info *info)
+{
+	uint64_t start;
+
+	if (xen_present()) /* Kernel not entity mapped under Xen */
+		return 0;
+
+	if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
+		info->kern_paddr_start = start;
+#ifdef DEBUG
+		printf("kernel load physical addr start = 0x%lx\n", start);
+#endif
+		return 0;
+	}
+
+	fprintf(stderr, "Cannot determine kernel physical load addr\n");
+	return -1;
+}
+
+static int get_kernel_vaddr_and_size(struct kexec_info *info)
+{
+	uint64_t end;
+
+	if (!info->kern_paddr_start)
+		return -1;
+
+	info->kern_vaddr_start =  info->kern_paddr_start | 0xffffffff80000000UL;
+	if (parse_iomem_single("Kernel data\n", NULL, &end) == 0) {
+		info->kern_size = end - info->kern_paddr_start;
+#ifdef DEBUG
+		printf("kernel_vaddr= 0x%llx paddr %llx\n",
+				info->kern_vaddr_start,
+				info->kern_paddr_start);
+		printf("kernel size = 0x%llx\n", info->kern_size);
+#endif
+		return 0;
+		}
+	fprintf(stderr, "Cannot determine kernel virtual load addr and  size\n");
+	return -1;
+}
+
 /* Removes crash reserve region from list of memory chunks for whom elf program
  * headers have to be created. Assuming crash reserve region to be a single
  * continuous area fully contained inside one of the memory chunks */
@@ -313,6 +356,12 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	int nr_ranges, align = 1024;
 	struct memory_range *mem_range;
 
+	if (get_kernel_paddr(info))
+		return -1;
+
+	if (get_kernel_vaddr_and_size(info))
+		return -1;
+
 	if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
 		return -1;
 


Best regards,
Maxim Uvarov.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
