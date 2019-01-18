Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkS6B-0005Yj-TD
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 11:14:09 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 2/3] acpi: store acpi_rsdp address for later kexec usage
Date: Fri, 18 Jan 2019 19:13:09 +0800
Message-Id: <20190118111310.29589-3-kasong@redhat.com>
In-Reply-To: <20190118111310.29589-1-kasong@redhat.com>
References: <20190118111310.29589-1-kasong@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, Kairui Song <kasong@redhat.com>, bhe@redhat.com, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, fanc.fnst@cn.fujitsu.com, lenb@kernel.org

Currently we have acpi_os_get_root_pointer as the universal function
to get RSDP address. But the function itself and some functions it
depends on are in .init section and make it not easy to retrieve the
RSDP value once kernel is initialized.

And for kexec, it need to retrive RSDP again if EFI is disabled, because
the second kernel will not be able get the RSDP value in such case, so
it expects either the user specify the RSDP value using kernel cmdline,
or kexec could retrive and pass the RSDP value using boot_params.

This patch stores the RSDP address when initialized is done, and
introduce an acpi_os_get_root_pointer_late for later kexec usage.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 drivers/acpi/osl.c   | 10 ++++++++++
 include/linux/acpi.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..6340d34d0df1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -187,6 +187,16 @@ static int __init setup_acpi_rsdp(char *arg)
 	return kstrtoul(arg, 16, &acpi_rsdp);
 }
 early_param("acpi_rsdp", setup_acpi_rsdp);
+
+acpi_physical_address acpi_os_get_root_pointer_late(void) {
+	return acpi_rsdp;
+}
+
+static int __init acpi_store_root_pointer(void) {
+	acpi_rsdp = acpi_os_get_root_pointer();
+	return 0;
+}
+late_initcall(acpi_store_root_pointer);
 #endif
 
 acpi_physical_address __init acpi_os_get_root_pointer(void)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f20b69a..226f2572eb8e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -892,6 +892,9 @@ static inline void arch_reserve_mem_area(acpi_physical_address addr,
 {
 }
 #endif /* CONFIG_X86 */
+#ifdef CONFIG_KEXEC
+acpi_physical_address acpi_os_get_root_pointer_late(void);
+#endif
 #else
 #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
 #endif
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
