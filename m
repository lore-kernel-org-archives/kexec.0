Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgOAH-00AUB1-VO
 for kexec@lists.infradead.org; Fri, 29 Oct 2021 09:27:11 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] s390/kexec: fix memory leak of ipl report buffer
Date: Fri, 29 Oct 2021 17:26:35 +0800
Message-Id: <20211029092635.14804-1-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, dyoung@redhat.com, akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>

A memory leak is reported by kmemleak scanning:

unreferenced object 0x38000195000 (size 4096):
  comm "kexec", pid 8548, jiffies 4294953647 (age 32443.270s)
  hex dump (first 32 bytes):
    00 00 00 c8 20 00 00 00 00 00 00 c0 02 80 00 00  .... ...........
    40 40 40 40 40 40 40 40 00 00 00 00 00 00 00 00  @@@@@@@@........
  backtrace:
    [<0000000011a2f199>] __vmalloc_node_range+0xc0/0x140
    [<0000000081fa2752>] vzalloc+0x5a/0x70
    [<0000000063a4c92d>] ipl_report_finish+0x2c/0x180
    [<00000000553304da>] kexec_file_add_ipl_report+0xf4/0x150
    [<00000000862d033f>] kexec_file_add_components+0x124/0x160
    [<000000000d2717bb>] arch_kexec_kernel_image_load+0x62/0x90
    [<000000002e0373b6>] kimage_file_alloc_init+0x1aa/0x2e0
    [<0000000060f2d14f>] __do_sys_kexec_file_load+0x17c/0x2c0
    [<000000008c86fe5a>] __s390x_sys_kexec_file_load+0x40/0x50
    [<000000001fdb9dac>] __do_syscall+0x1bc/0x1f0
    [<000000003ee4258d>] system_call+0x78/0xa0

The ipl report buffer is allocated via vmalloc, while has no chance to free
if the kexe loading is unloaded. This will cause obvious memory leak
when kexec/kdump kernel is reloaded, manually, or triggered, e.g by
memory hotplug.

Here, add struct kimage_arch to s390 to pass out the ipl report buffer
address, and introduce arch dependent function
arch_kimage_file_post_load_cleanup() to free it when unloaded.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/s390/include/asm/kexec.h         | 7 +++++++
 arch/s390/kernel/machine_kexec_file.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index ea398a05f643..9f16e99fb882 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -74,6 +74,13 @@ void *kexec_file_add_components(struct kimage *image,
 int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
 			 unsigned long addr);
 
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	void *ipl_buf;
+};
+
+
 extern const struct kexec_file_ops s390_kexec_image_ops;
 extern const struct kexec_file_ops s390_kexec_elf_ops;
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index f9e4baa64b67..584c48b631b2 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -202,6 +202,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 	buf.buffer = ipl_report_finish(data->report);
 	buf.bufsz = data->report->size;
 	buf.memsz = buf.bufsz;
+	image->arch.ipl_buf = buf.buffer;
 
 	data->memsz += buf.memsz;
 
@@ -321,3 +322,11 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 
 	return kexec_image_probe_default(image, buf, buf_len);
 }
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	kvfree(image->arch.ipl_buf);
+	image->arch.ipl_buf = NULL;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
