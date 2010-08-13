Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ok2nL-0005S2-A6
	for kexec@lists.infradead.org; Fri, 13 Aug 2010 22:32:14 +0000
Date: Fri, 13 Aug 2010 18:31:59 -0400 (EDT)
From: nhorman@tuxdriver.com
Message-ID: <1177203920.3.1281738720317.JavaMail.javamailuser@localhost>
Subject: Re: [PATCH][EFI] Run EFI in physical mode
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1690319549=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: nhorman@tuxdriver.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

--===============1690319549==
Content-Type: multipart/alternative; 
	boundary="----=_Part_2_1178635264.1281738720241"

------=_Part_2_1178635264.1281738720241
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



Sent from my android device.

-----Original Message-----
From: Takao Indoh <indou.takao@jp.fujitsu.com>
To: linux-kernel@vger.kernel.org; kexec@lists.infradead.org
Cc: ebiederm@xmission.com; tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; vgoyal@redhat.com; nhorman@tuxdriver.com
Sent: Fri, 13 Aug 2010 03:18 PM
Subject: [PATCH][EFI] Run EFI in physical mode

Hi all,

The attached patch enables EFI to run in physical mode.

Basically EFI is in physical mode at first and it's switched to virtual
mode after calling SetVirtualAddressMap. By applying this patch, you can
run EFI always in physical mode. And you can also specify "virtefi" as
kernel boot parameter to run EFI in virtual mode as before. Note that
this patch supports only x86_64.

This is needed to run kexec/kdump in EFI-booted system. The following is
an original discussion. In this thread, I explained that kdump does not
work because EFI system table is modified by SetVirtualAddressMap. And
the idea to run EFI in physical mode was proposed. This patch implements
it.

http://marc.info/?l=linux-kernel&m=128018221820234&w=2
> When the 1st kernel boots, EFI system table(efi_system_table_t) is
> modified by SetVirtualAddressMap, which is one of EFI runtime service.
> This runtime changes physical address in EFI system table to virtual
> address.
> 
> When the 2nd kernel boots, it also receives the same EFI system table,
> and the address included in it is already virtual address(1st kernel
> rewrote it).  But 2nd kernel does not know that, 2nd kernel thinks it is
> a physical address. This causes problems.

Basic idea of this patch is to create EFI own pagetable. This pagetable
maps physical address of EFI runtime to the virtual address which is the
same value so that we can call it directly. For example, physical 
address 0x800000 is mapped to virtual address 0x800000. Before calling
EFI runtime, cr3 register is switched to this pagetable, and restored
when we come back from EFI.

Any comments would be appreciated.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>

Looks good
Acked-by:  Neil Horman <nhorman@tuxdriver.com>


---
 arch/x86/include/asm/efi.h |    3
 arch/x86/kernel/efi.c      |  142 ++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/efi_32.c   |    4
 arch/x86/kernel/efi_64.c   |   92 ++++++++++++++++++++++
 include/linux/efi.h        |    1
 include/linux/init.h       |    1
 init/main.c                |   16 +++
 7 files changed, 254 insertions(+), 5 deletions(-)

diff -Nurp linux-2.6.35.org/arch/x86/include/asm/efi.h linux-2.6.35/arch/x86/include/asm/efi.h
--- linux-2.6.35.org/arch/x86/include/asm/efi.h	2010-08-01 18:11:14.000000000 -0400
+++ linux-2.6.35/arch/x86/include/asm/efi.h	2010-08-13 14:39:25.817104994 -0400
@@ -93,6 +93,9 @@ extern int add_efi_memmap;
 extern void efi_reserve_early(void);
 extern void efi_call_phys_prelog(void);
 extern void efi_call_phys_epilog(void);
+extern void efi_call_phys_prelog_in_physmode(void);
+extern void efi_call_phys_epilog_in_physmode(void);
+extern void efi_pagetable_init(void);
 
 #ifndef CONFIG_EFI
 /*
diff -Nurp linux-2.6.35.org/arch/x86/kernel/efi.c linux-2.6.35/arch/x86/kernel/efi.c
--- linux-2.6.35.org/arch/x86/kernel/efi.c	2010-08-01 18:11:14.000000000 -0400
+++ linux-2.6.35/arch/x86/kernel/efi.c	2010-08-13 14:39:25.819105004 -0400
@@ -57,6 +57,7 @@ struct efi_memory_map memmap;
 
 static struct efi efi_phys __initdata;
 static efi_system_table_t efi_systab __initdata;
+static efi_runtime_services_t phys_runtime;
 
 static int __init setup_noefi(char *arg)
 {
@@ -171,7 +172,7 @@ static efi_status_t __init phys_efi_set_
 	return status;
 }
 
-static efi_status_t __init phys_efi_get_time(efi_time_t *tm,
+static efi_status_t __init phys_efi_get_time_early(efi_time_t *tm,
 					     efi_time_cap_t *tc)
 {
 	efi_status_t status;
@@ -182,6 +183,112 @@ static efi_status_t __init phys_efi_get_
 	return status;
 }
 
+static efi_status_t phys_efi_get_time(efi_time_t *tm,
+				      efi_time_cap_t *tc)
+{
+	efi_status_t status;
+
+	efi_call_phys_prelog_in_physmode();
+	status = efi_call_phys2((void*)phys_runtime.get_time, tm, tc);
+	efi_call_phys_epilog_in_physmode();
+	return status;
+}
+
+static efi_status_t __init phys_efi_set_time(efi_time_t *tm)
+{
+	efi_status_t status;
+
+	efi_call_phys_prelog_in_physmode();
+	status = efi_call_phys1((void*)phys_runtime.set_time, tm);
+	efi_call_phys_epilog_in_physmode();
+	return status;
+}
+
+static efi_status_t phys_efi_get_wakeup_time(efi_bool_t *enabled,
+                                             efi_bool_t *pending,
+                                             efi_time_t *tm)
+{
+	efi_status_t status;
+
+	efi_call_phys_prelog_in_physmode();
+	status = efi_call_phys3((void*)phys_runtime.get_wakeup_time, enabled,
+				pending, tm);
+	efi_call_phys_epilog_in_physmode();
+	return status;
+}
+
+static efi_status_t phys_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
+{
+	efi_status_t status;
+	efi_call_phys_prelog_in_physmode();
+	status = efi_call_phys2((void*)phys_runtime.set_wakeup_time, enabled,
+				tm);
+	efi_call_phys_epilog_in_physmode();
+	return status;
+}
+
+static efi_status_t phys_efi_get_variable(efi_char16_t *name,
+					  efi_guid_t *vendor,
+					  u32 *attr,
+					  unsigned long *data_size,
+					  void *data)
+{
+	efi_status_t status;
+	efi_call_phys_prelog_in_physmode();
+	status = efi_call_phys5((void*)phys_runtime.get_variable, name, vendor,
+				attr, data_size, data);
+	efi_call_phys_epilog_in_physmode();
+	return status;
+}
+
+static efi_status_t phys_efi_get_next_variable(unsigned long *name_size,
+					       efi_char16_t *name,
+					       efi_guid_t *vendor)
+{
+	efi_status_t status;
+
+	efi_call_phys_prelog_in_physmode();
+	status = efi_call_phys3((void*)phys_runtime.get_next_variable,
+				name_size, name, vendor);
+	efi_call_phys_epilog_in_physmode();
+	return status;
+}
+
+static efi_status_t phys_efi_set_variable(efi_char16_t *name,
+					  efi_guid_t *vendor,
+					  unsigned long attr,
+					  unsigned long data_size,
+					  void *data)
+{
+	efi_status_t status;
+	efi_call_phys_prelog_in_physmode();
+	status = efi_call_phys5((void*)phys_runtime.set_variable, name,
+				vendor, attr, data_size, data);
+	efi_call_phys_epilog_in_physmode();
+	return status;
+}
+
+static efi_status_t phys_efi_get_next_high_mono_count(u32 *count)
+{
+	efi_status_t status;
+	efi_call_phys_prelog_in_physmode();
+	status = efi_call_phys1((void*)phys_runtime.get_next_high_mono_count,
+				count);
+	efi_call_phys_epilog_in_physmode();
+	return status;
+}
+
+static void phys_efi_reset_system(int reset_type,
+                                  efi_status_t status,
+                                  unsigned long data_size,
+                                  efi_char16_t *data)
+{
+	efi_call_phys_prelog_in_physmode();
+	efi_call_phys4((void*)phys_runtime.reset_system, reset_type, status,
+				data_size, data);
+	efi_call_phys_epilog_in_physmode();
+}
+
 int efi_set_rtc_mmss(unsigned long nowtime)
 {
 	int real_seconds, real_minutes;
@@ -434,7 +541,9 @@ void __init efi_init(void)
 		 * Make efi_get_time can be called before entering
 		 * virtual mode.
 		 */
-		efi.get_time = phys_efi_get_time;
+		efi.get_time = phys_efi_get_time_early;
+
+		memcpy(&phys_runtime, runtime, sizeof(efi_runtime_services_t));
 	} else
 		printk(KERN_ERR "Could not map the EFI runtime service "
 		       "table!\n");
@@ -465,6 +574,14 @@ void __init efi_init(void)
 #if EFI_DEBUG
 	print_efi_memmap();
 #endif
+
+#ifndef CONFIG_X86_64
+	/*
+	 * Only x86_64 supports physical mode as of now. Use virtual mode
+	 * forcibly.
+	 */
+	usevirtefi = 1;
+#endif
 }
 
 static void __init runtime_code_page_mkexec(void)
@@ -578,6 +695,27 @@ void __init efi_enter_virtual_mode(void)
 	memmap.map = NULL;
 }
 
+void __init efi_setup_physical_mode(void)
+{
+#ifdef CONFIG_X86_64
+	efi_pagetable_init();
+#endif
+	efi.get_time = phys_efi_get_time;
+	efi.set_time = phys_efi_set_time;
+	efi.get_wakeup_time = phys_efi_get_wakeup_time;
+	efi.set_wakeup_time = phys_efi_set_wakeup_time;
+	efi.get_variable = phys_efi_get_variable;
+	efi.get_next_variable = phys_efi_get_next_variable;
+	efi.set_variable = phys_efi_set_variable;
+	efi.get_next_high_mono_count =
+		phys_efi_get_next_high_mono_count;
+	efi.reset_system = phys_efi_reset_system;
+	efi.set_virtual_address_map = NULL; /* Not needed */
+
+	early_iounmap(memmap.map, memmap.nr_map * memmap.desc_size);
+	memmap.map = NULL;
+}
+
 /*
  * Convenience functions to obtain memory types and attributes
  */
diff -Nurp linux-2.6.35.org/arch/x86/kernel/efi_32.c linux-2.6.35/arch/x86/kernel/efi_32.c
--- linux-2.6.35.org/arch/x86/kernel/efi_32.c	2010-08-01 18:11:14.000000000 -0400
+++ linux-2.6.35/arch/x86/kernel/efi_32.c	2010-08-13 14:39:25.819105004 -0400
@@ -110,3 +110,7 @@ void efi_call_phys_epilog(void)
 
 	local_irq_restore(efi_rt_eflags);
 }
+
+void efi_call_phys_prelog_in_physmode(void) { /* Not supported */ }
+void efi_call_phys_epilog_in_physmode(void) { /* Not supported */ }
+
diff -Nurp linux-2.6.35.org/arch/x86/kernel/efi_64.c linux-2.6.35/arch/x86/kernel/efi_64.c
--- linux-2.6.35.org/arch/x86/kernel/efi_64.c	2010-08-01 18:11:14.000000000 -0400
+++ linux-2.6.35/arch/x86/kernel/efi_64.c	2010-08-13 14:39:25.819105004 -0400
@@ -39,7 +39,9 @@
 #include <asm/fixmap.h>
 
 static pgd_t save_pgd __initdata;
-static unsigned long efi_flags __initdata;
+static unsigned long efi_flags;
+static pgd_t efi_pgd[PTRS_PER_PGD] __page_aligned_bss;
+static unsigned long save_cr3;
 
 static void __init early_mapping_set_exec(unsigned long start,
 					  unsigned long end,
@@ -98,6 +100,19 @@ void __init efi_call_phys_epilog(void)
 	early_runtime_code_mapping_set_exec(0);
 }
 
+void efi_call_phys_prelog_in_physmode(void)
+{
+	local_irq_save(efi_flags);
+	save_cr3 = read_cr3();
+	write_cr3(virt_to_phys(efi_pgd));
+}
+
+void efi_call_phys_epilog_in_physmode(void)
+{
+	write_cr3(save_cr3);
+	local_irq_restore(efi_flags);
+}
+
 void __iomem *__init efi_ioremap(unsigned long phys_addr, unsigned long size,
 				 u32 type)
 {
@@ -112,3 +127,78 @@ void __iomem *__init efi_ioremap(unsigne
 
 	return (void __iomem *)__va(phys_addr);
 }
+
+static pud_t *fill_pud(pgd_t *pgd, unsigned long vaddr)
+{
+	if (pgd_none(*pgd)) {
+		pud_t *pud = (pud_t *)get_zeroed_page(GFP_ATOMIC);
+		set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(pud)));
+		if (pud != pud_offset(pgd, 0))
+			printk(KERN_ERR "EFI PAGETABLE BUG #00! %p <-> %p\n",
+			       pud, pud_offset(pgd, 0));
+	}
+	return pud_offset(pgd, vaddr);
+}
+
+static pmd_t *fill_pmd(pud_t *pud, unsigned long vaddr)
+{
+	if (pud_none(*pud)) {
+		pmd_t *pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
+		set_pud(pud, __pud(_PAGE_TABLE | __pa(pmd)));
+		if (pmd != pmd_offset(pud, 0))
+			printk(KERN_ERR "EFI PAGETABLE BUG #01! %p <-> %p\n",
+			       pmd, pmd_offset(pud, 0));
+	}
+	return pmd_offset(pud, vaddr);
+}
+
+static pte_t *fill_pte(pmd_t *pmd, unsigned long vaddr)
+{
+	if (pmd_none(*pmd)) {
+		pte_t *pte = (pte_t *)get_zeroed_page(GFP_ATOMIC);
+		set_pmd(pmd, __pmd(_PAGE_TABLE | __pa(pte)));
+		if (pte != pte_offset_kernel(pmd, 0))
+			printk(KERN_ERR "EFI PAGETABLE BUG #02!\n");
+	}
+	return pte_offset_kernel(pmd, vaddr);
+}
+
+void __init efi_pagetable_init(void)
+{
+	efi_memory_desc_t *md;
+	unsigned long size;
+	u64 start_pfn, end_pfn, pfn, vaddr;
+	void *p;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	memset(efi_pgd, 0, sizeof(efi_pgd));
+	for (p = memmap.map; p < memmap.map_end; p += memmap.desc_size) {
+		md = p;
+		if (!(md->type & EFI_RUNTIME_SERVICES_CODE) &&
+		    !(md->type & EFI_RUNTIME_SERVICES_DATA))
+			continue;
+
+		start_pfn = md->phys_addr >> PAGE_SHIFT;
+		size = md->num_pages << EFI_PAGE_SHIFT;
+		end_pfn = PFN_UP(md->phys_addr + size);
+
+		for (pfn = start_pfn; pfn <= end_pfn; pfn++) {
+			vaddr = pfn << PAGE_SHIFT;
+			pgd = efi_pgd + pgd_index(vaddr);
+			pud = fill_pud(pgd, vaddr);
+			pmd = fill_pmd(pud, vaddr);
+			pte = fill_pte(pmd, vaddr);
+			if (md->type & EFI_RUNTIME_SERVICES_CODE)
+				set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
+			else
+				set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
+		}
+	}
+	pgd = efi_pgd + pgd_index(PAGE_OFFSET);
+	set_pgd(pgd, *pgd_offset_k(PAGE_OFFSET));
+	pgd = efi_pgd + pgd_index(__START_KERNEL_map);
+	set_pgd(pgd, *pgd_offset_k(__START_KERNEL_map));
+}
diff -Nurp linux-2.6.35.org/include/linux/efi.h linux-2.6.35/include/linux/efi.h
--- linux-2.6.35.org/include/linux/efi.h	2010-08-01 18:11:14.000000000 -0400
+++ linux-2.6.35/include/linux/efi.h	2010-08-13 14:39:25.820105006 -0400
@@ -290,6 +290,7 @@ extern void efi_map_pal_code (void);
 extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec *ts);
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
+extern void efi_setup_physical_mode(void);
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
diff -Nurp linux-2.6.35.org/include/linux/init.h linux-2.6.35/include/linux/init.h
--- linux-2.6.35.org/include/linux/init.h	2010-08-01 18:11:14.000000000 -0400
+++ linux-2.6.35/include/linux/init.h	2010-08-13 14:39:25.820105006 -0400
@@ -142,6 +142,7 @@ extern int do_one_initcall(initcall_t fn
 extern char __initdata boot_command_line[];
 extern char *saved_command_line;
 extern unsigned int reset_devices;
+extern unsigned int usevirtefi;
 
 /* used by init/main.c */
 void setup_arch(char **);
diff -Nurp linux-2.6.35.org/init/main.c linux-2.6.35/init/main.c
--- linux-2.6.35.org/init/main.c	2010-08-01 18:11:14.000000000 -0400
+++ linux-2.6.35/init/main.c	2010-08-13 14:39:25.820105006 -0400
@@ -200,6 +200,14 @@ static int __init set_reset_devices(char
 
 __setup("reset_devices", set_reset_devices);
 
+unsigned int usevirtefi;
+static int __init set_virt_efi(char *str)
+{
+	usevirtefi = 1;
+	return 1;
+}
+__setup("virtefi", set_virt_efi);
+
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 static const char *panic_later, *panic_param;
@@ -676,8 +684,12 @@ asmlinkage void __init start_kernel(void
 	pidmap_init();
 	anon_vma_init();
 #ifdef CONFIG_X86
-	if (efi_enabled)
-		efi_enter_virtual_mode();
+	if (efi_enabled) {
+		if (usevirtefi)
+			efi_enter_virtual_mode();
+		else
+			efi_setup_physical_mode();
+	}
 #endif
 	thread_info_cache_init();
 	cred_init();


------=_Part_2_1178635264.1281738720241
MIME-Version: 1.0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<br/><br/>Sent from my android device.<br/><br/>-----Original Message-----<=
br/>From: Takao Indoh &lt;indou.takao@jp.fujitsu.com&gt;<br/>To: linux-kern=
el@vger.kernel.org; kexec@lists.infradead.org<br/>Cc: ebiederm@xmission.com=
; tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; vgoyal@redhat.com; n=
horman@tuxdriver.com<br/>Sent: Fri, 13 Aug 2010 03:18 PM<br/>Subject: [PATC=
H][EFI] Run EFI in physical mode<br/><br/>Hi all,<br/><br/>The attached pat=
ch enables EFI to run in physical mode.<br/><br/>Basically EFI is in physic=
al mode at first and it&#039;s switched to virtual<br/>mode after calling S=
etVirtualAddressMap. By applying this patch, you can<br/>run EFI always in =
physical mode. And you can also specify &quot;virtefi&quot; as<br/>kernel b=
oot parameter to run EFI in virtual mode as before. Note that<br/>this patc=
h supports only x86_64.<br/><br/>This is needed to run kexec/kdump in EFI-b=
ooted system. The following is<br/>an original discussion. In this thread, =
I explained that kdump does not<br/>work because EFI system table is modifi=
ed by SetVirtualAddressMap. And<br/>the idea to run EFI in physical mode wa=
s proposed. This patch implements<br/>it.<br/><br/>http://marc.info/?l=3Dli=
nux-kernel&amp;m=3D128018221820234&amp;w=3D2<br/>&gt; When the 1st kernel b=
oots, EFI system table(efi_system_table_t) is<br/>&gt; modified by SetVirtu=
alAddressMap, which is one of EFI runtime service.<br/>&gt; This runtime ch=
anges physical address in EFI system table to virtual<br/>&gt; address.<br/=
>&gt; <br/>&gt; When the 2nd kernel boots, it also receives the same EFI sy=
stem table,<br/>&gt; and the address included in it is already virtual addr=
ess(1st kernel<br/>&gt; rewrote it).  But 2nd kernel does not know that, 2n=
d kernel thinks it is<br/>&gt; a physical address. This causes problems.<br=
/><br/>Basic idea of this patch is to create EFI own pagetable. This pageta=
ble<br/>maps physical address of EFI runtime to the virtual address which i=
s the<br/>same value so that we can call it directly. For example, physical=
 <br/>address 0x800000 is mapped to virtual address 0x800000. Before callin=
g<br/>EFI runtime, cr3 register is switched to this pagetable, and restored=
<br/>when we come back from EFI.<br/><br/>Any comments would be appreciated=
.<br/><br/>Signed-off-by: Takao Indoh &lt;indou.takao@jp.fujitsu.com&gt;<br=
/><br/>Looks good<br/>Acked-by:  Neil Horman &lt;nhorman@tuxdriver.com&gt;<=
br/><br/><br/>---<br/> arch/x86/include/asm/efi.h |    3<br/> arch/x86/kern=
el/efi.c      |  142 ++++++++++++++++++++++++++++++++++-<br/> arch/x86/kern=
el/efi_32.c   |    4<br/> arch/x86/kernel/efi_64.c   |   92 +++++++++++++++=
+++++++<br/> include/linux/efi.h        |    1<br/> include/linux/init.h   =
    |    1<br/> init/main.c                |   16 +++<br/> 7 files changed,=
 254 insertions(+), 5 deletions(-)<br/><br/>diff -Nurp linux-2.6.35.org/arc=
h/x86/include/asm/efi.h linux-2.6.35/arch/x86/include/asm/efi.h<br/>--- lin=
ux-2.6.35.org/arch/x86/include/asm/efi.h=092010-08-01 18:11:14.000000000 -0=
400<br/>+++ linux-2.6.35/arch/x86/include/asm/efi.h=092010-08-13 14:39:25.8=
17104994 -0400<br/>@@ -93,6 +93,9 @@ extern int add_efi_memmap;<br/> extern=
 void efi_reserve_early(void);<br/> extern void efi_call_phys_prelog(void);=
<br/> extern void efi_call_phys_epilog(void);<br/>+extern void efi_call_phy=
s_prelog_in_physmode(void);<br/>+extern void efi_call_phys_epilog_in_physmo=
de(void);<br/>+extern void efi_pagetable_init(void);<br/> <br/> #ifndef CON=
FIG_EFI<br/> /*<br/>diff -Nurp linux-2.6.35.org/arch/x86/kernel/efi.c linux=
-2.6.35/arch/x86/kernel/efi.c<br/>--- linux-2.6.35.org/arch/x86/kernel/efi.=
c=092010-08-01 18:11:14.000000000 -0400<br/>+++ linux-2.6.35/arch/x86/kerne=
l/efi.c=092010-08-13 14:39:25.819105004 -0400<br/>@@ -57,6 +57,7 @@ struct =
efi_memory_map memmap;<br/> <br/> static struct efi efi_phys __initdata;<br=
/> static efi_system_table_t efi_systab __initdata;<br/>+static efi_runtime=
_services_t phys_runtime;<br/> <br/> static int __init setup_noefi(char *ar=
g)<br/> {<br/>@@ -171,7 +172,7 @@ static efi_status_t __init phys_efi_set_<=
br/> =09return status;<br/> }<br/> <br/>-static efi_status_t __init phys_ef=
i_get_time(efi_time_t *tm,<br/>+static efi_status_t __init phys_efi_get_tim=
e_early(efi_time_t *tm,<br/> =09=09=09=09=09     efi_time_cap_t *tc)<br/> {=
<br/> =09efi_status_t status;<br/>@@ -182,6 +183,112 @@ static efi_status_t=
 __init phys_efi_get_<br/> =09return status;<br/> }<br/> <br/>+static efi_s=
tatus_t phys_efi_get_time(efi_time_t *tm,<br/>+=09=09=09=09      efi_time_c=
ap_t *tc)<br/>+{<br/>+=09efi_status_t status;<br/>+<br/>+=09efi_call_phys_p=
relog_in_physmode();<br/>+=09status =3D efi_call_phys2((void*)phys_runtime.=
get_time, tm, tc);<br/>+=09efi_call_phys_epilog_in_physmode();<br/>+=09retu=
rn status;<br/>+}<br/>+<br/>+static efi_status_t __init phys_efi_set_time(e=
fi_time_t *tm)<br/>+{<br/>+=09efi_status_t status;<br/>+<br/>+=09efi_call_p=
hys_prelog_in_physmode();<br/>+=09status =3D efi_call_phys1((void*)phys_run=
time.set_time, tm);<br/>+=09efi_call_phys_epilog_in_physmode();<br/>+=09ret=
urn status;<br/>+}<br/>+<br/>+static efi_status_t phys_efi_get_wakeup_time(=
efi_bool_t *enabled,<br/>+                                             efi_=
bool_t *pending,<br/>+                                             efi_time=
_t *tm)<br/>+{<br/>+=09efi_status_t status;<br/>+<br/>+=09efi_call_phys_pre=
log_in_physmode();<br/>+=09status =3D efi_call_phys3((void*)phys_runtime.ge=
t_wakeup_time, enabled,<br/>+=09=09=09=09pending, tm);<br/>+=09efi_call_phy=
s_epilog_in_physmode();<br/>+=09return status;<br/>+}<br/>+<br/>+static efi=
_status_t phys_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)<br/>=
+{<br/>+=09efi_status_t status;<br/>+=09efi_call_phys_prelog_in_physmode();=
<br/>+=09status =3D efi_call_phys2((void*)phys_runtime.set_wakeup_time, ena=
bled,<br/>+=09=09=09=09tm);<br/>+=09efi_call_phys_epilog_in_physmode();<br/=
>+=09return status;<br/>+}<br/>+<br/>+static efi_status_t phys_efi_get_vari=
able(efi_char16_t *name,<br/>+=09=09=09=09=09  efi_guid_t *vendor,<br/>+=09=
=09=09=09=09  u32 *attr,<br/>+=09=09=09=09=09  unsigned long *data_size,<br=
/>+=09=09=09=09=09  void *data)<br/>+{<br/>+=09efi_status_t status;<br/>+=
=09efi_call_phys_prelog_in_physmode();<br/>+=09status =3D efi_call_phys5((v=
oid*)phys_runtime.get_variable, name, vendor,<br/>+=09=09=09=09attr, data_s=
ize, data);<br/>+=09efi_call_phys_epilog_in_physmode();<br/>+=09return stat=
us;<br/>+}<br/>+<br/>+static efi_status_t phys_efi_get_next_variable(unsign=
ed long *name_size,<br/>+=09=09=09=09=09       efi_char16_t *name,<br/>+=09=
=09=09=09=09       efi_guid_t *vendor)<br/>+{<br/>+=09efi_status_t status;<=
br/>+<br/>+=09efi_call_phys_prelog_in_physmode();<br/>+=09status =3D efi_ca=
ll_phys3((void*)phys_runtime.get_next_variable,<br/>+=09=09=09=09name_size,=
 name, vendor);<br/>+=09efi_call_phys_epilog_in_physmode();<br/>+=09return =
status;<br/>+}<br/>+<br/>+static efi_status_t phys_efi_set_variable(efi_cha=
r16_t *name,<br/>+=09=09=09=09=09  efi_guid_t *vendor,<br/>+=09=09=09=09=09=
  unsigned long attr,<br/>+=09=09=09=09=09  unsigned long data_size,<br/>+=
=09=09=09=09=09  void *data)<br/>+{<br/>+=09efi_status_t status;<br/>+=09ef=
i_call_phys_prelog_in_physmode();<br/>+=09status =3D efi_call_phys5((void*)=
phys_runtime.set_variable, name,<br/>+=09=09=09=09vendor, attr, data_size, =
data);<br/>+=09efi_call_phys_epilog_in_physmode();<br/>+=09return status;<b=
r/>+}<br/>+<br/>+static efi_status_t phys_efi_get_next_high_mono_count(u32 =
*count)<br/>+{<br/>+=09efi_status_t status;<br/>+=09efi_call_phys_prelog_in=
_physmode();<br/>+=09status =3D efi_call_phys1((void*)phys_runtime.get_next=
_high_mono_count,<br/>+=09=09=09=09count);<br/>+=09efi_call_phys_epilog_in_=
physmode();<br/>+=09return status;<br/>+}<br/>+<br/>+static void phys_efi_r=
eset_system(int reset_type,<br/>+                                  efi_stat=
us_t status,<br/>+                                  unsigned long data_size=
,<br/>+                                  efi_char16_t *data)<br/>+{<br/>+=
=09efi_call_phys_prelog_in_physmode();<br/>+=09efi_call_phys4((void*)phys_r=
untime.reset_system, reset_type, status,<br/>+=09=09=09=09data_size, data);=
<br/>+=09efi_call_phys_epilog_in_physmode();<br/>+}<br/>+<br/> int efi_set_=
rtc_mmss(unsigned long nowtime)<br/> {<br/> =09int real_seconds, real_minut=
es;<br/>@@ -434,7 +541,9 @@ void __init efi_init(void)<br/> =09=09 * Make e=
fi_get_time can be called before entering<br/> =09=09 * virtual mode.<br/> =
=09=09 */<br/>-=09=09efi.get_time =3D phys_efi_get_time;<br/>+=09=09efi.get=
_time =3D phys_efi_get_time_early;<br/>+<br/>+=09=09memcpy(&amp;phys_runtim=
e, runtime, sizeof(efi_runtime_services_t));<br/> =09} else<br/> =09=09prin=
tk(KERN_ERR &quot;Could not map the EFI runtime service &quot;<br/> =09=09 =
      &quot;table!&#092;n&quot;);<br/>@@ -465,6 +574,14 @@ void __init efi_=
init(void)<br/> #if EFI_DEBUG<br/> =09print_efi_memmap();<br/> #endif<br/>+=
<br/>+#ifndef CONFIG_X86_64<br/>+=09/*<br/>+=09 * Only x86_64 supports phys=
ical mode as of now. Use virtual mode<br/>+=09 * forcibly.<br/>+=09 */<br/>=
+=09usevirtefi =3D 1;<br/>+#endif<br/> }<br/> <br/> static void __init runt=
ime_code_page_mkexec(void)<br/>@@ -578,6 +695,27 @@ void __init efi_enter_v=
irtual_mode(void)<br/> =09memmap.map =3D NULL;<br/> }<br/> <br/>+void __ini=
t efi_setup_physical_mode(void)<br/>+{<br/>+#ifdef CONFIG_X86_64<br/>+=09ef=
i_pagetable_init();<br/>+#endif<br/>+=09efi.get_time =3D phys_efi_get_time;=
<br/>+=09efi.set_time =3D phys_efi_set_time;<br/>+=09efi.get_wakeup_time =
=3D phys_efi_get_wakeup_time;<br/>+=09efi.set_wakeup_time =3D phys_efi_set_=
wakeup_time;<br/>+=09efi.get_variable =3D phys_efi_get_variable;<br/>+=09ef=
i.get_next_variable =3D phys_efi_get_next_variable;<br/>+=09efi.set_variabl=
e =3D phys_efi_set_variable;<br/>+=09efi.get_next_high_mono_count =3D<br/>+=
=09=09phys_efi_get_next_high_mono_count;<br/>+=09efi.reset_system =3D phys_=
efi_reset_system;<br/>+=09efi.set_virtual_address_map =3D NULL; /* Not need=
ed */<br/>+<br/>+=09early_iounmap(memmap.map, memmap.nr_map * memmap.desc_s=
ize);<br/>+=09memmap.map =3D NULL;<br/>+}<br/>+<br/> /*<br/>  * Convenience=
 functions to obtain memory types and attributes<br/>  */<br/>diff -Nurp li=
nux-2.6.35.org/arch/x86/kernel/efi_32.c linux-2.6.35/arch/x86/kernel/efi_32=
.c<br/>--- linux-2.6.35.org/arch/x86/kernel/efi_32.c=092010-08-01 18:11:14.=
000000000 -0400<br/>+++ linux-2.6.35/arch/x86/kernel/efi_32.c=092010-08-13 =
14:39:25.819105004 -0400<br/>@@ -110,3 +110,7 @@ void efi_call_phys_epilog(=
void)<br/> <br/> =09local_irq_restore(efi_rt_eflags);<br/> }<br/>+<br/>+voi=
d efi_call_phys_prelog_in_physmode(void) { /* Not supported */ }<br/>+void =
efi_call_phys_epilog_in_physmode(void) { /* Not supported */ }<br/>+<br/>di=
ff -Nurp linux-2.6.35.org/arch/x86/kernel/efi_64.c linux-2.6.35/arch/x86/ke=
rnel/efi_64.c<br/>--- linux-2.6.35.org/arch/x86/kernel/efi_64.c=092010-08-0=
1 18:11:14.000000000 -0400<br/>+++ linux-2.6.35/arch/x86/kernel/efi_64.c=09=
2010-08-13 14:39:25.819105004 -0400<br/>@@ -39,7 +39,9 @@<br/> #include &lt=
;asm/fixmap.h&gt;<br/> <br/> static pgd_t save_pgd __initdata;<br/>-static =
unsigned long efi_flags __initdata;<br/>+static unsigned long efi_flags;<br=
/>+static pgd_t efi_pgd[PTRS_PER_PGD] __page_aligned_bss;<br/>+static unsig=
ned long save_cr3;<br/> <br/> static void __init early_mapping_set_exec(uns=
igned long start,<br/> =09=09=09=09=09  unsigned long end,<br/>@@ -98,6 +10=
0,19 @@ void __init efi_call_phys_epilog(void)<br/> =09early_runtime_code_m=
apping_set_exec(0);<br/> }<br/> <br/>+void efi_call_phys_prelog_in_physmode=
(void)<br/>+{<br/>+=09local_irq_save(efi_flags);<br/>+=09save_cr3 =3D read_=
cr3();<br/>+=09write_cr3(virt_to_phys(efi_pgd));<br/>+}<br/>+<br/>+void efi=
_call_phys_epilog_in_physmode(void)<br/>+{<br/>+=09write_cr3(save_cr3);<br/=
>+=09local_irq_restore(efi_flags);<br/>+}<br/>+<br/> void __iomem *__init e=
fi_ioremap(unsigned long phys_addr, unsigned long size,<br/> =09=09=09=09 u=
32 type)<br/> {<br/>@@ -112,3 +127,78 @@ void __iomem *__init efi_ioremap(u=
nsigne<br/> <br/> =09return (void __iomem *)__va(phys_addr);<br/> }<br/>+<b=
r/>+static pud_t *fill_pud(pgd_t *pgd, unsigned long vaddr)<br/>+{<br/>+=09=
if (pgd_none(*pgd)) {<br/>+=09=09pud_t *pud =3D (pud_t *)get_zeroed_page(GF=
P_ATOMIC);<br/>+=09=09set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(pud)));<br/>+=
=09=09if (pud !=3D pud_offset(pgd, 0))<br/>+=09=09=09printk(KERN_ERR &quot;=
EFI PAGETABLE BUG #00! %p &lt;-&gt; %p&#092;n&quot;,<br/>+=09=09=09       p=
ud, pud_offset(pgd, 0));<br/>+=09}<br/>+=09return pud_offset(pgd, vaddr);<b=
r/>+}<br/>+<br/>+static pmd_t *fill_pmd(pud_t *pud, unsigned long vaddr)<br=
/>+{<br/>+=09if (pud_none(*pud)) {<br/>+=09=09pmd_t *pmd =3D (pmd_t *)get_z=
eroed_page(GFP_ATOMIC);<br/>+=09=09set_pud(pud, __pud(_PAGE_TABLE | __pa(pm=
d)));<br/>+=09=09if (pmd !=3D pmd_offset(pud, 0))<br/>+=09=09=09printk(KERN=
_ERR &quot;EFI PAGETABLE BUG #01! %p &lt;-&gt; %p&#092;n&quot;,<br/>+=09=09=
=09       pmd, pmd_offset(pud, 0));<br/>+=09}<br/>+=09return pmd_offset(pud=
, vaddr);<br/>+}<br/>+<br/>+static pte_t *fill_pte(pmd_t *pmd, unsigned lon=
g vaddr)<br/>+{<br/>+=09if (pmd_none(*pmd)) {<br/>+=09=09pte_t *pte =3D (pt=
e_t *)get_zeroed_page(GFP_ATOMIC);<br/>+=09=09set_pmd(pmd, __pmd(_PAGE_TABL=
E | __pa(pte)));<br/>+=09=09if (pte !=3D pte_offset_kernel(pmd, 0))<br/>+=
=09=09=09printk(KERN_ERR &quot;EFI PAGETABLE BUG #02!&#092;n&quot;);<br/>+=
=09}<br/>+=09return pte_offset_kernel(pmd, vaddr);<br/>+}<br/>+<br/>+void _=
_init efi_pagetable_init(void)<br/>+{<br/>+=09efi_memory_desc_t *md;<br/>+=
=09unsigned long size;<br/>+=09u64 start_pfn, end_pfn, pfn, vaddr;<br/>+=09=
void *p;<br/>+=09pgd_t *pgd;<br/>+=09pud_t *pud;<br/>+=09pmd_t *pmd;<br/>+=
=09pte_t *pte;<br/>+<br/>+=09memset(efi_pgd, 0, sizeof(efi_pgd));<br/>+=09f=
or (p =3D memmap.map; p &lt; memmap.map_end; p +=3D memmap.desc_size) {<br/=
>+=09=09md =3D p;<br/>+=09=09if (!(md-&gt;type &amp; EFI_RUNTIME_SERVICES_C=
ODE) &amp;&amp;<br/>+=09=09    !(md-&gt;type &amp; EFI_RUNTIME_SERVICES_DAT=
A))<br/>+=09=09=09continue;<br/>+<br/>+=09=09start_pfn =3D md-&gt;phys_addr=
 &gt;&gt; PAGE_SHIFT;<br/>+=09=09size =3D md-&gt;num_pages &lt;&lt; EFI_PAG=
E_SHIFT;<br/>+=09=09end_pfn =3D PFN_UP(md-&gt;phys_addr + size);<br/>+<br/>=
+=09=09for (pfn =3D start_pfn; pfn &lt;=3D end_pfn; pfn++) {<br/>+=09=09=09=
vaddr =3D pfn &lt;&lt; PAGE_SHIFT;<br/>+=09=09=09pgd =3D efi_pgd + pgd_inde=
x(vaddr);<br/>+=09=09=09pud =3D fill_pud(pgd, vaddr);<br/>+=09=09=09pmd =3D=
 fill_pmd(pud, vaddr);<br/>+=09=09=09pte =3D fill_pte(pmd, vaddr);<br/>+=09=
=09=09if (md-&gt;type &amp; EFI_RUNTIME_SERVICES_CODE)<br/>+=09=09=09=09set=
_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));<br/>+=09=09=09else<br/>+=09=09=
=09=09set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));<br/>+=09=09}<br/>+=09}<br/>+=
=09pgd =3D efi_pgd + pgd_index(PAGE_OFFSET);<br/>+=09set_pgd(pgd, *pgd_offs=
et_k(PAGE_OFFSET));<br/>+=09pgd =3D efi_pgd + pgd_index(__START_KERNEL_map)=
;<br/>+=09set_pgd(pgd, *pgd_offset_k(__START_KERNEL_map));<br/>+}<br/>diff =
-Nurp linux-2.6.35.org/include/linux/efi.h linux-2.6.35/include/linux/efi.h=
<br/>--- linux-2.6.35.org/include/linux/efi.h=092010-08-01 18:11:14.0000000=
00 -0400<br/>+++ linux-2.6.35/include/linux/efi.h=092010-08-13 14:39:25.820=
105006 -0400<br/>@@ -290,6 +290,7 @@ extern void efi_map_pal_code (void);<b=
r/> extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg=
);<br/> extern void efi_gettimeofday (struct timespec *ts);<br/> extern voi=
d efi_enter_virtual_mode (void);=09/* switch EFI to virtual mode, if possib=
le */<br/>+extern void efi_setup_physical_mode(void);<br/> extern u64 efi_g=
et_iobase (void);<br/> extern u32 efi_mem_type (unsigned long phys_addr);<b=
r/> extern u64 efi_mem_attributes (unsigned long phys_addr);<br/>diff -Nurp=
 linux-2.6.35.org/include/linux/init.h linux-2.6.35/include/linux/init.h<br=
/>--- linux-2.6.35.org/include/linux/init.h=092010-08-01 18:11:14.000000000=
 -0400<br/>+++ linux-2.6.35/include/linux/init.h=092010-08-13 14:39:25.8201=
05006 -0400<br/>@@ -142,6 +142,7 @@ extern int do_one_initcall(initcall_t f=
n<br/> extern char __initdata boot_command_line[];<br/> extern char *saved_=
command_line;<br/> extern unsigned int reset_devices;<br/>+extern unsigned =
int usevirtefi;<br/> <br/> /* used by init/main.c */<br/> void setup_arch(c=
har **);<br/>diff -Nurp linux-2.6.35.org/init/main.c linux-2.6.35/init/main=
.c<br/>--- linux-2.6.35.org/init/main.c=092010-08-01 18:11:14.000000000 -04=
00<br/>+++ linux-2.6.35/init/main.c=092010-08-13 14:39:25.820105006 -0400<b=
r/>@@ -200,6 +200,14 @@ static int __init set_reset_devices(char<br/> <br/>=
 __setup(&quot;reset_devices&quot;, set_reset_devices);<br/> <br/>+unsigned=
 int usevirtefi;<br/>+static int __init set_virt_efi(char *str)<br/>+{<br/>=
+=09usevirtefi =3D 1;<br/>+=09return 1;<br/>+}<br/>+__setup(&quot;virtefi&q=
uot;, set_virt_efi);<br/>+<br/> static char * argv_init[MAX_INIT_ARGS+2] =
=3D { &quot;init&quot;, NULL, };<br/> char * envp_init[MAX_INIT_ENVS+2] =3D=
 { &quot;HOME=3D/&quot;, &quot;TERM=3Dlinux&quot;, NULL, };<br/> static con=
st char *panic_later, *panic_param;<br/>@@ -676,8 +684,12 @@ asmlinkage voi=
d __init start_kernel(void<br/> =09pidmap_init();<br/> =09anon_vma_init();<=
br/> #ifdef CONFIG_X86<br/>-=09if (efi_enabled)<br/>-=09=09efi_enter_virtua=
l_mode();<br/>+=09if (efi_enabled) {<br/>+=09=09if (usevirtefi)<br/>+=09=09=
=09efi_enter_virtual_mode();<br/>+=09=09else<br/>+=09=09=09efi_setup_physic=
al_mode();<br/>+=09}<br/> #endif<br/> =09thread_info_cache_init();<br/> =09=
cred_init();<br/><br/>
------=_Part_2_1178635264.1281738720241--


--===============1690319549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1690319549==--

