Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RAd0h-0000im-Un
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 07:32:35 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id p937W641014456
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 13:02:06 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p937W5BV2027754
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 13:02:05 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p937W59c023796
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 18:32:05 +1100
Date: Mon, 3 Oct 2011 13:02:03 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: [Patch 1/4][kernel][slimdump] Add new elf-note of type NT_NOCOREDUMP
	to capture slimdump
Message-ID: <20111003073203.GA22694@in.ibm.com>
References: <20111003070735.GJ2223@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111003070735.GJ2223@in.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, crash-utility@redhat.com, kexec@lists.infradead.org
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

There are certain types of crashes induced by faulty hardware in which
capturing crashing kernel's memory (through kdump) makes no sense (or sometimes
dangerous).

A case in point, is unrecoverable memory errors (resulting in fatal machine
check exceptions) in which reading from the faulty memory location from the
kexec'ed kernel will cause double fault and system reset (leaving no
information for the user).

This patch introduces a framework called 'slimdump' enabled through a new
elf-note NT_NOCOREDUMP. Any error whose cause cannot be attributed to a
software error and cannot be detected by analysing the kernel memory may
decide to add this elf-note to the vmcore and indicate the futility of
such an exercise. Tools such as 'kexec', 'makedumpfile' and 'crash' are
also modified in tandem to recognise this new elf-note and capture
'slimdump'.

The physical address and size of the NT_NOCOREDUMP are made available to the
user-space through a "/sys/kernel/nt_nocoredump" sysfs file (just like other
kexec related files).

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c |   28 ++++++++++++++++++++++++++++
 include/linux/elf.h              |   18 ++++++++++++++++++
 include/linux/kexec.h            |    1 +
 kernel/kexec.c                   |   11 +++++++++++
 kernel/ksysfs.c                  |   10 ++++++++++
 5 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 08363b0..483b2fc 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -238,6 +238,34 @@ static atomic_t mce_paniced;
 static int fake_panic;
 static atomic_t mce_fake_paniced;
 
+void arch_add_nocoredump_note(u32 *buf)
+{
+	struct elf_note note;
+	const char note_name[] = "PANIC_MCE";
+	const char desc_msg[] = "Crash induced due to a fatal machine "
+				"check error";
+
+	/*
+	 * Prevent coredump from being captured if the panic was triggered due
+	 * to a fatal Machine Check Exception (MCE).
+	 */
+	if ((atomic_read(&mce_paniced) == 0) ||
+		(strlen(desc_msg) >= NT_NOCOREDUMP_DESC_BYTES))
+		return;
+
+	note.n_namesz = strlen(note_name) + 1;
+	/* We have no additional description */
+	note.n_descsz = strlen(desc_msg) + 1;
+	note.n_type = NT_NOCOREDUMP;
+
+	memcpy(buf, &note, sizeof(note));
+	buf += (sizeof(note) + 3)/4;
+	memcpy(buf, note_name, note.n_namesz);
+	buf += (note.n_namesz + 3)/4;
+	memcpy(buf, desc_msg, note.n_descsz);
+	buf += (note.n_descsz + 3)/4;
+}
+
 /* Panic in progress. Enable interrupts and wait for final IPI */
 static void wait_for_panic(void)
 {
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 110821c..4be4746 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -381,6 +381,11 @@ typedef struct elf64_shdr {
 #define NT_PRPSINFO	3
 #define NT_TASKSTRUCT	4
 #define NT_AUXV		6
+/*
+ * Note to indicate absence of coredump for crashes initiated due to hardware
+ * errors
+ */
+#define NT_NOCOREDUMP	21
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
 #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
 #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
@@ -435,6 +440,19 @@ extern Elf64_Dyn _DYNAMIC [];
 
 #endif
 
+/* NT_NOCOREDUMP related definitions used while creating an elf-note */
+#define NT_NOCOREDUMP_HEAD_BYTES	ALIGN(sizeof(struct elf_note), 4)
+/*
+ * The creator of NT_NOCOREDUMP will define the name based on the reason for
+ * which dump is not captured. for e.g. "PANIC_MCE"
+ */
+#define NT_NOCOREDUMP_NAME_BYTES	50
+#define NT_NOCOREDUMP_DESC_BYTES	(1024)
+#define NT_NOCOREDUMP_NOTE_BYTES	(NT_NOCOREDUMP_HEAD_BYTES +	\
+					  NT_NOCOREDUMP_NAME_BYTES +	\
+					  NT_NOCOREDUMP_DESC_BYTES)
+extern u32 nt_nocoredump_note[(NT_NOCOREDUMP_NOTE_BYTES + 3)/4];
+
 /* Optional callbacks to write extra ELF notes. */
 #ifndef ARCH_HAVE_EXTRA_ELF_NOTES
 static inline int elf_coredump_extra_notes_size(void) { return 0; }
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c2478a3..84d9b1a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -133,6 +133,7 @@ void arch_crash_save_vmcoreinfo(void);
 void vmcoreinfo_append_str(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 unsigned long paddr_vmcoreinfo_note(void);
+unsigned long paddr_nocoredump_note(void);
 
 #define VMCOREINFO_OSRELEASE(value) \
 	vmcoreinfo_append_str("OSRELEASE=%s\n", value)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 296fbc8..d49456e 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -50,6 +50,9 @@ u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
 size_t vmcoreinfo_size;
 size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
 
+/* NT_NOCOREDUMP related definitions */
+u32 nt_nocoredump_note[(NT_NOCOREDUMP_NOTE_BYTES + 3)/4];
+
 /* Location of the reserved area for the crash kernel */
 struct resource crashk_res = {
 	.name  = "Crash kernel",
@@ -1065,6 +1068,8 @@ asmlinkage long compat_sys_kexec_load(unsigned long entry,
 }
 #endif
 
+__weak void arch_add_nocoredump_note(u32 *buf) {}
+
 void crash_kexec(struct pt_regs *regs)
 {
 	/* Take the kexec_mutex here to prevent sys_kexec_load
@@ -1083,6 +1088,7 @@ void crash_kexec(struct pt_regs *regs)
 
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
+			arch_add_nocoredump_note(nt_nocoredump_note);
 			machine_crash_shutdown(&fixed_regs);
 			machine_kexec(kexec_crash_image);
 		}
@@ -1428,6 +1434,11 @@ unsigned long __attribute__ ((weak)) paddr_vmcoreinfo_note(void)
 	return __pa((unsigned long)(char *)&vmcoreinfo_note);
 }
 
+unsigned long __attribute__ ((weak)) paddr_nocoredump_note(void)
+{
+	return __pa((unsigned long)(char *)&nt_nocoredump_note);
+}
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 3b053c0..ef29ee6 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -130,6 +130,15 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+static ssize_t nt_nocoredump_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lx %x\n",
+		       paddr_nocoredump_note(),
+		       (unsigned int)NT_NOCOREDUMP_NOTE_BYTES);
+}
+KERNEL_ATTR_RO(nt_nocoredump);
+
 #endif /* CONFIG_KEXEC */
 
 /* whether file capabilities are enabled */
@@ -180,6 +189,7 @@ static struct attribute * kernel_attrs[] = {
 	&kexec_crash_loaded_attr.attr,
 	&kexec_crash_size_attr.attr,
 	&vmcoreinfo_attr.attr,
+	&nt_nocoredump_attr.attr,
 #endif
 	NULL
 };
-- 
1.7.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
