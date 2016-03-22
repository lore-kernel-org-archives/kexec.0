Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aiRDb-0002QJ-Tr
 for kexec@lists.infradead.org; Tue, 22 Mar 2016 18:39:53 +0000
Date: Tue, 22 Mar 2016 11:39:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] kexec: Introduce a protection mechanism for the
 crashkernel reserved memory
Message-Id: <20160322113930.9a72fa3378a71c3e27452cf8@linux-foundation.org>
In-Reply-To: <1450869146-6186-1-git-send-email-xlpang@redhat.com>
References: <1450869146-6186-1-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>

On Wed, 23 Dec 2015 19:12:25 +0800 Xunlei Pang <xlpang@redhat.com> wrote:

> For the cases that some kernel (module) path stamps the crash
> reserved memory(already mapped by the kernel) where has been
> loaded the second kernel data, the kdump kernel will probably
> fail to boot when panic happens (or even not happens) leaving
> the culprit at large, this is unacceptable.
> 
> The patch introduces a mechanism for detecting such cases:
> 1) After each crash kexec loading, it simply marks the reserved
> memory regions readonly since we no longer access it after that.
> When someone stamps the region, the first kernel will panic and
> trigger the kdump. The weak arch_kexec_protect_crashkres() is
> introduced to do the actual protection.
> 
> 2) To allow multiple loading, once 1) was done we also need to
> remark the reserved memory to readwrite each time a system call
> related to kdump is made. The weak arch_kexec_unprotect_crashkres()
> is introduced to do the actual protection.
> 
> The architecture can make its specific implementation by overriding
> arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres().

I'd like to see a bit more review activity on these patches from the
other kexec developers, please.  I'll include both the patches below.


Also I don't have any record of reviews of these two:

http://ozlabs.org/~akpm/mmotm/broken-out/kexec-make-a-pair-of-map-unmap-reserved-pages-in-error-path.patch
http://ozlabs.org/~akpm/mmotm/broken-out/kexec-do-a-cleanup-for-function-kexec_load.patch

Thanks.


From: Xunlei Pang <xlpang@redhat.com>
Subject: kexec: introduce a protection mechanism for the crashkernel reserved memory

For the cases that some kernel (module) path stamps the crash reserved
memory(already mapped by the kernel) where has been loaded the second
kernel data, the kdump kernel will probably fail to boot when panic
happens (or even not happens) leaving the culprit at large, this is
unacceptable.

The patch introduces a mechanism for detecting such cases:

1) After each crash kexec loading, it simply marks the reserved memory
   regions readonly since we no longer access it after that.  When someone
   stamps the region, the first kernel will panic and trigger the kdump. 
   The weak arch_kexec_protect_crashkres() is introduced to do the actual
   protection.

2) To allow multiple loading, once 1) was done we also need to remark
   the reserved memory to readwrite each time a system call related to
   kdump is made.  The weak arch_kexec_unprotect_crashkres() is introduced
   to do the actual protection.

The architecture can make its specific implementation by overriding
arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres().

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Minfei Huang <mhuang@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/kexec.h |    2 ++
 kernel/kexec.c        |    9 ++++++++-
 kernel/kexec_core.c   |    6 ++++++
 kernel/kexec_file.c   |    8 +++++++-
 4 files changed, 23 insertions(+), 2 deletions(-)

diff -puN include/linux/kexec.h~kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory include/linux/kexec.h
--- a/include/linux/kexec.h~kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory
+++ a/include/linux/kexec.h
@@ -317,6 +317,8 @@ int __weak arch_kexec_apply_relocations_
 					Elf_Shdr *sechdrs, unsigned int relsec);
 int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 					unsigned int relsec);
+void arch_kexec_protect_crashkres(void);
+void arch_kexec_unprotect_crashkres(void);
 
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
diff -puN kernel/kexec.c~kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory kernel/kexec.c
--- a/kernel/kexec.c~kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory
+++ a/kernel/kexec.c
@@ -167,8 +167,12 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 		return -EBUSY;
 
 	dest_image = &kexec_image;
-	if (flags & KEXEC_ON_CRASH)
+	if (flags & KEXEC_ON_CRASH) {
 		dest_image = &kexec_crash_image;
+		if (kexec_crash_image)
+			arch_kexec_unprotect_crashkres();
+	}
+
 	if (nr_segments > 0) {
 		unsigned long i;
 
@@ -211,6 +215,9 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 	image = xchg(dest_image, image);
 
 out:
+	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
+		arch_kexec_protect_crashkres();
+
 	mutex_unlock(&kexec_mutex);
 	kimage_free(image);
 
diff -puN kernel/kexec_core.c~kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory kernel/kexec_core.c
--- a/kernel/kexec_core.c~kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory
+++ a/kernel/kexec_core.c
@@ -1559,3 +1559,9 @@ void __weak crash_map_reserved_pages(voi
 
 void __weak crash_unmap_reserved_pages(void)
 {}
+
+void __weak arch_kexec_protect_crashkres(void)
+{}
+
+void __weak arch_kexec_unprotect_crashkres(void)
+{}
diff -puN kernel/kexec_file.c~kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory kernel/kexec_file.c
--- a/kernel/kexec_file.c~kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory
+++ a/kernel/kexec_file.c
@@ -274,8 +274,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, ke
 		return -EBUSY;
 
 	dest_image = &kexec_image;
-	if (flags & KEXEC_FILE_ON_CRASH)
+	if (flags & KEXEC_FILE_ON_CRASH) {
 		dest_image = &kexec_crash_image;
+		if (kexec_crash_image)
+			arch_kexec_unprotect_crashkres();
+	}
 
 	if (flags & KEXEC_FILE_UNLOAD)
 		goto exchange;
@@ -324,6 +327,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, ke
 exchange:
 	image = xchg(dest_image, image);
 out:
+	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
+		arch_kexec_protect_crashkres();
+
 	mutex_unlock(&kexec_mutex);
 	kimage_free(image);
 	return ret;
_


From: Xunlei Pang <xlpang@redhat.com>
Subject: kexec: provide arch_kexec_protect(unprotect)_crashkres()

Implement the protection method for the crash kernel memory reservation
for the 64-bit x86 kdump.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Minfei Huang <mhuang@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/kernel/machine_kexec_64.c |   45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff -puN arch/x86/kernel/machine_kexec_64.c~kexec-provide-arch_kexec_protectunprotect_crashkres arch/x86/kernel/machine_kexec_64.c
--- a/arch/x86/kernel/machine_kexec_64.c~kexec-provide-arch_kexec_protectunprotect_crashkres
+++ a/arch/x86/kernel/machine_kexec_64.c
@@ -538,3 +538,48 @@ overflow:
 	return -ENOEXEC;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+static int
+kexec_mark_range(unsigned long start, unsigned long end, bool protect)
+{
+	struct page *page;
+	unsigned int nr_pages;
+
+	/*
+	 * For physical range: [start, end]. We must skip the unassigned
+	 * crashk resource with zero-valued "end" member.
+	 */
+	if (!end || start > end)
+		return 0;
+
+	page = pfn_to_page(start >> PAGE_SHIFT);
+	nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
+	if (protect)
+		return set_pages_ro(page, nr_pages);
+	else
+		return set_pages_rw(page, nr_pages);
+}
+
+static void kexec_mark_crashkres(bool protect)
+{
+	unsigned long control;
+
+	kexec_mark_range(crashk_low_res.start, crashk_low_res.end, protect);
+
+	/* Don't touch the control code page used in crash_kexec().*/
+	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
+	/* Control code page is located in the 2nd page. */
+	kexec_mark_range(crashk_res.start, control + PAGE_SIZE - 1, protect);
+	control += KEXEC_CONTROL_PAGE_SIZE;
+	kexec_mark_range(control, crashk_res.end, protect);
+}
+
+void arch_kexec_protect_crashkres(void)
+{
+	kexec_mark_crashkres(true);
+}
+
+void arch_kexec_unprotect_crashkres(void)
+{
+	kexec_mark_crashkres(false);
+}
_


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
