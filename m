Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cpqBV-0003Cr-0G
 for kexec@lists.infradead.org; Mon, 20 Mar 2017 05:48:51 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v3 1/3] kexec: Move vmcoreinfo out of the kernel's .bss section
Date: Mon, 20 Mar 2017 13:50:31 +0800
Message-Id: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
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

As Eric said,
"what we need to do is move the variable vmcoreinfo_note out
of the kernel's .bss section.  And modify the code to regenerate
and keep this information in something like the control page.

Definitely something like this needs a page all to itself, and ideally
far away from any other kernel data structures.  I clearly was not
watching closely the data someone decided to keep this silly thing
in the kernel's .bss section."

This patch allocates extra pages for these vmcoreinfo_XXX variables,
one advantage is that it enhances some safety of vmcoreinfo, because
vmcoreinfo now is kept far away from other kernel data structures.

Suggested-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/ia64/kernel/machine_kexec.c |  5 -----
 arch/x86/kernel/crash.c          |  2 +-
 include/linux/kexec.h            |  2 +-
 kernel/kexec_core.c              | 29 ++++++++++++++++++++++++-----
 kernel/ksysfs.c                  |  2 +-
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
index 599507b..c14815d 100644
--- a/arch/ia64/kernel/machine_kexec.c
+++ b/arch/ia64/kernel/machine_kexec.c
@@ -163,8 +163,3 @@ void arch_crash_save_vmcoreinfo(void)
 #endif
 }
 
-phys_addr_t paddr_vmcoreinfo_note(void)
-{
-	return ia64_tpa((unsigned long)(char *)&vmcoreinfo_note);
-}
-
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 3741461..4d35fbb 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -456,7 +456,7 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
 	bufp += sizeof(Elf64_Phdr);
 	phdr->p_type = PT_NOTE;
 	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = sizeof(vmcoreinfo_note);
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
 	(ehdr->e_phnum)++;
 
 #ifdef CONFIG_X86_64
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e98e546..f1c601b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -317,7 +317,7 @@ extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
 extern struct resource crashk_low_res;
 typedef u32 note_buf_t[KEXEC_NOTE_BYTES/4];
 extern note_buf_t __percpu *crash_notes;
-extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
+extern u32 *vmcoreinfo_note;
 extern size_t vmcoreinfo_size;
 extern size_t vmcoreinfo_max_size;
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index bfe62d5..e3a4bda 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -52,10 +52,10 @@
 note_buf_t __percpu *crash_notes;
 
 /* vmcoreinfo stuff */
-static unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
-u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
+static unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
-size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
+size_t vmcoreinfo_max_size = VMCOREINFO_BYTES;
+u32 *vmcoreinfo_note;
 
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
@@ -1369,6 +1369,9 @@ static void update_vmcoreinfo_note(void)
 
 void crash_save_vmcoreinfo(void)
 {
+	if (!vmcoreinfo_note)
+		return;
+
 	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
 	update_vmcoreinfo_note();
 }
@@ -1397,13 +1400,29 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 void __weak arch_crash_save_vmcoreinfo(void)
 {}
 
-phys_addr_t __weak paddr_vmcoreinfo_note(void)
+phys_addr_t paddr_vmcoreinfo_note(void)
 {
-	return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
+	return __pa(vmcoreinfo_note);
 }
 
 static int __init crash_save_vmcoreinfo_init(void)
 {
+	/* One page should be enough for VMCOREINFO_BYTES under all archs */
+	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+	if (!vmcoreinfo_data) {
+		pr_warn("Memory allocation for vmcoreinfo_data failed\n");
+		return -ENOMEM;
+	}
+
+	vmcoreinfo_note = alloc_pages_exact(VMCOREINFO_NOTE_SIZE,
+						GFP_KERNEL | __GFP_ZERO);
+	if (!vmcoreinfo_note) {
+		free_page((unsigned long)vmcoreinfo_data);
+		vmcoreinfo_data = NULL;
+		pr_warn("Memory allocation for vmcoreinfo_note failed\n");
+		return -ENOMEM;
+	}
+
 	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
 	VMCOREINFO_PAGESIZE(PAGE_SIZE);
 
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index ee1bc1b..9de6fcc 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -130,7 +130,7 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 {
 	phys_addr_t vmcore_base = paddr_vmcoreinfo_note();
 	return sprintf(buf, "%pa %x\n", &vmcore_base,
-		       (unsigned int)sizeof(vmcoreinfo_note));
+			(unsigned int)VMCOREINFO_NOTE_SIZE);
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
