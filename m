Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from flmx07.ccur.com ([12.192.68.12])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1N2SIJ-0005L9-Ll
	for kexec@lists.infradead.org; Mon, 26 Oct 2009 16:19:48 +0000
Message-ID: <4AE5CC2B.8070804@ccur.com>
Date: Mon, 26 Oct 2009 11:19:55 -0500
From: John Blackwood <john.blackwood@ccur.com>
MIME-Version: 1.0
Subject: /sys crash_notes provides bad value to kexec
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

When attempting to generate a crash file on a on newer (2.6.31.x) NUMA
x86_64 kernel, the kdump kernel was unable to initialize the /proc/vmcore
file due to a bad physical address specified in the elf header for a
per-cpu crash notes area.

It turns out that the physical address that kexec reads from the output
of the:

   /sys/devices/system/cpu/cpu1/crash_notes

sysfs file is not correct for NUMA x86_64 architecture systems, and this
physical address is used in the elfheader that the kdump kernel attempts
to use to initialize /proc/vmcore.

I believe that this has to do with the new percpu_alloc=lpage and
percpu_alloc=4k per-cpu setups that are now used.

In those cases, the __pa(per_cpu_ptr(crash_notes, cpunum)) does not
return the correct physical address value.

I did a rough stab at getting the correct physical address for the
'lpage' case (which I believe tends to be the default method used),
but I was unable to figure out how to get the correct physical address
for the '4k' page case.

For what ever it's worth, here's a patch of my attempt at the lpage version;
it might or might not be useful.

( This patch really assumes only x86 or x86_64 builds, since
the asm/percpu.h header file is only for x86 arch. )

Thank you.


diff -rup a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
--- a/arch/x86/include/asm/percpu.h	2009-10-26 09:33:37.000000000 -0500
+++ b/arch/x86/include/asm/percpu.h	2009-10-26 09:33:53.000000000 -0500
@@ -165,6 +165,15 @@ static inline void *pcpu_lpage_remapped(
  }
  #endif

+#if defined(CONFIG_NEED_MULTIPLE_NODES) && defined(CONFIG_X86_64)
+unsigned long long pcpul_get_paddr(int cpunum, void *item);
+#else
+static inline unsigned long long pcpul_get_paddr(int cpunum, void *item)
+{
+	return (unsigned long long)NULL;
+}
+#endif
+
  #endif /* !__ASSEMBLY__ */

  #ifdef CONFIG_SMP
diff -rup a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
--- a/arch/x86/kernel/setup_percpu.c	2009-10-26 09:33:37.000000000 -0500
+++ b/arch/x86/kernel/setup_percpu.c	2009-10-26 09:33:53.000000000 -0500
@@ -314,6 +314,35 @@ void *pcpu_lpage_remapped(void *kaddr)

  	return NULL;
  }
+
+#ifdef CONFIG_X86_64
+/*
+ * Return the physical address of the percpu data item for the
+ * specified cpu.
+ *
+ * Returns a physical address or NULL if pcpul_map is not being used.
+ * Currently only called by show_crash_notes().
+ */
+unsigned long long pcpul_get_paddr(int cpunum, void *item)
+{
+	struct pcpul_ent *pmp;
+	void *vaddr, *offset;
+	unsigned long long paddr = (unsigned long long)NULL;
+
+	if (!pcpul_map)
+		return paddr;
+	for (pmp = pcpul_map; pmp->ptr; pmp++) {
+		if ((int)pmp->cpu != cpunum)
+			continue;
+		offset = per_cpu_ptr(item, cpunum) - __per_cpu_offset[cpunum];
+		vaddr = pmp->ptr + (long unsigned int)offset;
+		paddr = __pa(vaddr);
+		return paddr;
+	}
+	return paddr;
+}
+#endif
+
  #else
  static ssize_t __init setup_pcpu_lpage(size_t static_size, bool chosen)
  {
diff -rup a/drivers/base/cpu.c b/drivers/base/cpu.c
--- a/drivers/base/cpu.c	2009-10-26 09:33:37.000000000 -0500
+++ b/drivers/base/cpu.c	2009-10-26 09:33:53.000000000 -0500
@@ -97,6 +97,12 @@ static ssize_t show_crash_notes(struct s
  	 * boot up and this data does not change there after. Hence this
  	 * operation should be safe. No locking required.
  	 */
+	addr = pcpul_get_paddr(cpunum, crash_notes);
+	if (addr) {
+		rc = sprintf(buf, "%Lx\n", addr);
+		return rc;
+	}
+
  	addr = __pa(per_cpu_ptr(crash_notes, cpunum));
  	rc = sprintf(buf, "%Lx\n", addr);
  	return rc;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
