Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cpqBd-0003E4-5S
 for kexec@lists.infradead.org; Mon, 20 Mar 2017 05:48:59 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v3 3/3] kdump: Relocate vmcoreinfo to the crash memory range
Date: Mon, 20 Mar 2017 13:50:33 +0800
Message-Id: <1489989033-1179-3-git-send-email-xlpang@redhat.com>
In-Reply-To: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
References: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Xunlei Pang <xlpang@redhat.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

Currently vmcoreinfo data is updated at boot time subsys_initcall(),
it has the risk of being modified by some wrong code during system
is running.

As a result, vmcore dumped may contain the wrong vmcoreinfo. Later on,
when using "crash", "makedumpfile", etc utility to parse this vmcore,
we probably will get "Segmentation fault" or other unexpected errors.

E.g. 1) wrong code overwrites vmcoreinfo_data; 2) further crashes the
system; 3) trigger kdump, then we obviously will fail to recognize the
crash context correctly due to the corrupted vmcoreinfo.

Now except for vmcoreinfo, all the crash data is well protected(including
the cpu note which is fully updated in the crash path, thus its correctness
is guaranteed). Given that vmcoreinfo data is a large chunk, we better
protect it as well.

To solve this, we relocate and copy vmcoreinfo_data to the crash memory
when kdump is loading via kexec syscalls. Because the whole crash memory
will be protected by existing arch_kexec_protect_crashkres() mechanism,
we naturally protect vmcoreinfo_data from write(even read) access under
kernel direct mapping after kdump is loaded.

Since kdump is usually loaded at the very early stage after boot, we can
trust the correctness of the vmcoreinfo data copied.

On the other hand, we still need to operate the vmcoreinfo safe copy when
crash happens to generate vmcoreinfo_note again, we rely on vmap() to map
out a new kernel virtual address and update to use this new one instead in
the following crash_save_vmcoreinfo().

BTW, we do not touch vmcoreinfo_note, because it will be fully updated
using the protected vmcoreinfo_data after crash which is surely correct
just like the cpu crash note.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 include/linux/kexec.h |  3 +++
 kernel/kexec.c        |  3 +++
 kernel/kexec_core.c   | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   |  3 +++
 4 files changed, 61 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6918fda..fae2fc6 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -187,6 +187,8 @@ struct kimage {
 	unsigned long start;
 	struct page *control_code_page;
 	struct page *swap_page;
+	void *vmcoreinfo_data_copy; /* locates in the crash memory */
+	size_t vmcoreinfo_size_copy;
 
 	unsigned long nr_segments;
 	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
@@ -243,6 +245,7 @@ extern asmlinkage long sys_kexec_load(unsigned long entry,
 extern int kernel_kexec(void);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
+extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern int kexec_load_purgatory(struct kimage *image, unsigned long min,
 				unsigned long max, int top_down,
 				unsigned long *load_addr);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 980936a..e0c4dea 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -93,6 +93,9 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 			pr_err("Could not allocate swap buffer\n");
 			goto out_free_control_pages;
 		}
+	} else {
+		if (kimage_crash_copy_vmcoreinfo(image) < 0)
+			goto out_free_image;
 	}
 
 	*rimage = image;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e503b48..7fad9f6 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -486,6 +486,45 @@ struct page *kimage_alloc_control_pages(struct kimage *image,
 	return pages;
 }
 
+int kimage_crash_copy_vmcoreinfo(struct kimage *image)
+{
+	struct page *vmcoreinfo_page;
+	void *safecopy;
+
+	WARN_ON(image->type != KEXEC_TYPE_CRASH);
+
+	if (!vmcoreinfo_size) {
+		pr_err("empty vmcoreinfo data\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * For kdump, allocate one vmcoreinfo safe copy from the
+	 * crash memory. as we have arch_kexec_protect_crashkres()
+	 * after kexec syscall, we naturally protect it from write
+	 * (even read) access under kernel direct mapping. But on
+	 * the other hand, we still need to operate it when crash
+	 * happens to generate vmcoreinfo note, hereby we rely on
+	 * vmap for this purpose.
+	 */
+	vmcoreinfo_page = kimage_alloc_control_pages(image, 0);
+	if (!vmcoreinfo_page) {
+		pr_err("could not allocate vmcoreinfo buffer\n");
+		return -ENOMEM;
+	}
+	safecopy = vmap(&vmcoreinfo_page, 1, VM_MAP, PAGE_KERNEL);
+	if (!safecopy) {
+		pr_err("cound not vmap vmcoreinfo buffer\n");
+		return -ENOMEM;
+	}
+
+	memcpy(safecopy, vmcoreinfo_data, vmcoreinfo_size);
+	image->vmcoreinfo_data_copy = safecopy;
+	image->vmcoreinfo_size_copy = vmcoreinfo_size;
+
+	return 0;
+}
+
 static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
 {
 	if (*image->entry != 0)
@@ -603,6 +642,9 @@ void kimage_free(struct kimage *image)
 	if (image->file_mode)
 		kimage_file_post_load_cleanup(image);
 
+	if (image->vmcoreinfo_data_copy)
+		vunmap(image->vmcoreinfo_data_copy);
+
 	kfree(image);
 }
 
@@ -1370,6 +1412,16 @@ void crash_save_vmcoreinfo(void)
 {
 	if (!vmcoreinfo_note)
 		return;
+	/*
+	 * Always use the safe copy to generate vmcoreinfo note.
+	 * Check kexec_crash_image, fadump does not use kexec.
+	 */
+	if (kexec_crash_image &&
+	    kexec_crash_image->vmcoreinfo_data_copy &&
+	    kexec_crash_image->vmcoreinfo_size_copy) {
+		vmcoreinfo_data = kexec_crash_image->vmcoreinfo_data_copy;
+		vmcoreinfo_size = kexec_crash_image->vmcoreinfo_size_copy;
+	}
 
 	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
 	update_vmcoreinfo_note();
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b56a558..6bb3e4d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -244,6 +244,9 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 			pr_err("Could not allocate swap buffer\n");
 			goto out_free_control_pages;
 		}
+	} else {
+		if (kimage_crash_copy_vmcoreinfo(image) < 0)
+			goto out_free_post_load_bufs;
 	}
 
 	*rimage = image;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
