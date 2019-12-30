Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1im1Qp-00062m-NJ
 for kexec@lists.infradead.org; Mon, 30 Dec 2019 20:14:29 +0000
Subject: [PATCH] efi: Fix handling of multiple contiguous efi_fake_mem= entries
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Dec 2019 11:58:23 -0800
Message-ID: <157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com>
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
To: mingo@redhat.com
Cc: Michael Weiser <michael@weiser.dinsnail.net>, linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Taku Izumi <izumi.taku@jp.fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>

A recent test of efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000 crashed with
a signature of:

    BUG: unable to handle page fault for address: ffffffffff281000
    [..]
    RIP: 0010:efi_memmap_insert+0x11d/0x191
    [..]
    Call Trace:
     ? bgrt_init+0xbe/0xbe
     ? efi_arch_mem_reserve+0x1cb/0x228
     ? acpi_parse_bgrt+0xa/0xd
     ? acpi_table_parse+0x86/0xb8
     ? acpi_boot_init+0x494/0x4e3
     ? acpi_parse_x2apic+0x87/0x87
     ? setup_acpi_sci+0xa2/0xa2
     ? setup_arch+0x8db/0x9e1
     ? start_kernel+0x6a/0x547
     ? secondary_startup_64+0xb6/0xc0

efi_memmap_insert() is attempting to insert entries past the end of the
new map. This condition is setup by efi_fake_mem() leaking empty entries
to the end of memory map, and then efi_arch_mem_reserve() trips over the
bad entry when attempting an additional efi_memmap_insert(). The empty
entry causes efi_memmap_insert() to attempt more memmap splits / copies
than efi_memmap_split_count() accounted for when sizing the new map.

Update efi_fake_memmap() to cleanup lagging empty entries.

This change is related to commit af1648984828 "x86/efi: Update e820 with
reserved EFI boot services data to fix kexec breakage" since that
introduces more occurrences where efi_memmap_insert() is invoked after
an efi_fake_mem= configuration has been parsed. Previously the side
effects of vestigial empty entries were benign, but with commit
af1648984828 that follow-on efi_memmap_insert() invocation triggers the
above crash signature.

Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Michael Weiser <michael@weiser.dinsnail.net>
Cc: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/fake_mem.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index bb9fc70d0cfa..6df51ba93ae8 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -67,13 +67,33 @@ void __init efi_fake_memmap(void)
 		return;
 	}
 
+	memset(new_memmap, 0, efi.memmap.desc_size * new_nr_map);
 	for (i = 0; i < nr_fake_mem; i++)
 		efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
 
+	/*
+	 * efi_memmap_split_count() may over count the number of
+	 * required splits in the case when contiguous fake entries are
+	 * specified. Check that all new_nr_map entries were consumed.
+	 */
+	for (i = new_nr_map; i > 0; i--) {
+		efi_memory_desc_t *md;
+		u64 start, end;
+
+		md = new_memmap + efi.memmap.desc_size * (new_nr_map - i - 1);
+		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+		start = md->phys_addr;
+
+		if (start == 0 && end + 1 == 0)
+			continue;
+		break;
+	}
+
 	/* swap into new EFI memmap */
 	early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
 
-	efi_memmap_install(new_memmap_phy, new_nr_map);
+	/* install only the valid entries */
+	efi_memmap_install(new_memmap_phy, i);
 
 	/* print new EFI memmap */
 	efi_print_memmap();


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
