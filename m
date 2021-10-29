Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgMFx-00A1b9-AM
 for kexec@lists.infradead.org; Fri, 29 Oct 2021 07:24:54 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/3] x86/kexec: fix memory leak of elf header buffer
Date: Fri, 29 Oct 2021 15:24:22 +0800
Message-Id: <20211029072424.9109-2-bhe@redhat.com>
In-Reply-To: <20211029072424.9109-1-bhe@redhat.com>
References: <20211029072424.9109-1-bhe@redhat.com>
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
Cc: kexec@lists.infradead.org, dyoung@redhat.com, akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>

This is reported by kmemleak detector:

unreferenced object 0xffffc900002a9000 (size 4096):
  comm "kexec", pid 14950, jiffies 4295110793 (age 373.951s)
  hex dump (first 32 bytes):
    7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00  .ELF............
    04 00 3e 00 01 00 00 00 00 00 00 00 00 00 00 00  ..>.............
  backtrace:
    [<0000000016a8ef9f>] __vmalloc_node_range+0x101/0x170
    [<000000002b66b6c0>] __vmalloc_node+0xb4/0x160
    [<00000000ad40107d>] crash_prepare_elf64_headers+0x8e/0xcd0
    [<0000000019afff23>] crash_load_segments+0x260/0x470
    [<0000000019ebe95c>] bzImage64_load+0x814/0xad0
    [<0000000093e16b05>] arch_kexec_kernel_image_load+0x1be/0x2a0
    [<000000009ef2fc88>] kimage_file_alloc_init+0x2ec/0x5a0
    [<0000000038f5a97a>] __do_sys_kexec_file_load+0x28d/0x530
    [<0000000087c19992>] do_syscall_64+0x3b/0x90
    [<0000000066e063a4>] entry_SYSCALL_64_after_hwframe+0x44/0xae

In crash_prepare_elf64_headers(), a buffer is allocated via vmalloc() to
store elf headers. While it's not freed back to system correctly when
kdump kernel is reloaded or unloaded. Then memory leak is caused.

Fix it by introducing x86 specific function
arch_kimage_file_post_load_cleanup(), and freeing the buffer there.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 131f30fdcfbd..fd8223fa2de5 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -511,6 +511,15 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 	       (int)ELF64_R_TYPE(rel[i].r_info), value);
 	return -ENOEXEC;
 }
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->elf_headers);
+	image->elf_headers = NULL;
+	image->elf_headers_sz = 0;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
 #endif /* CONFIG_KEXEC_FILE */
 
 static int
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
