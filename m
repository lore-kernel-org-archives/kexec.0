Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imPsF-0007ib-Kd
 for kexec@lists.infradead.org; Tue, 31 Dec 2019 22:20:25 +0000
Subject: [PATCH v2 0/4] efi: Fix handling of multiple efi_fake_mem= entries
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Dec 2019 14:04:17 -0800
Message-ID: <157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Michael Weiser <michael@weiser.dinsnail.net>, linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Taku Izumi <izumi.taku@jp.fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>

Changes since v1 [1]:
- Add support for garbage collecting idle efi_memmap_alloc() allocations

- As Dave noticed the same problem of calling efi_memmap_split_count()
  multiple times with the old map also applies to efi_memmap_insert().
  Update efi_fake_memmap() to invoke efi_memmap_install() after every
  efi_memmap_insert() call.

[1]: https://lore.kernel.org/r/157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com/

---

Copied from patch4:

Dave noticed that when specifying multiple efi_fake_mem= entries only
the last entry was successfully being reflected in the efi memory map.
This is due to the fact that the efi_memmap_insert() is being called
multiple times, but on successive invocations the insertion should be
applied to the last new memmap rather than the original map at
efi_fake_memmap() entry.

Rework efi_fake_memmap() to install the new memory map after each
efi_fake_mem= entry is parsed.

This also fixes an issue in efi_fake_memmap() that caused it to litter
emtpy entries into the end of the efi memory map. The empty entry causes
efi_memmap_insert() to attempt more memmap splits / copies than
efi_memmap_split_count() accounted for when sizing the new map.

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

Commit af1648984828 "x86/efi: Update e820 with reserved EFI boot
services data to fix kexec breakage" is listed in Fixes: since it
introduces more occurrences where efi_memmap_insert() is invoked after
an efi_fake_mem= configuration has been parsed. Previously the side
effects of vestigial empty entries were benign, but with commit
af1648984828 that follow-on efi_memmap_insert() invocation triggers the
above crash signature.

---

Dan Williams (4):
      efi: Add a flags parameter to efi_memory_map
      efi: Add tracking for dynamically allocated memmaps
      efi: Fix efi_memmap_alloc() leaks
      efi: Fix handling of multiple efi_fake_mem= entries


 arch/x86/platform/efi/efi.c     |    2 +
 arch/x86/platform/efi/quirks.c  |   11 ++++---
 drivers/firmware/efi/fake_mem.c |   37 +++++++++++++------------
 drivers/firmware/efi/memmap.c   |   58 ++++++++++++++++++++++++++++++---------
 include/linux/efi.h             |   13 +++++++--
 5 files changed, 81 insertions(+), 40 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
