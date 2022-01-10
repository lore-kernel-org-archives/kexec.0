From: Frank van der Linden <fllinden@amazon.com>
Date: Mon, 10 Jan 2022 21:08:06 +0000
Subject: [PATCH 0/3] usable memory range fixes (arm64/fdt/efi)
Message-ID: <20220110210809.3528-1-fllinden@amazon.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
moved capping memory ranges using the FDT-specified linux,usable-memory-range
to the FDT code. This property is used to specify the memory range that
a crash kernel runs in.

While this correctly filters any memory ranges that come from the DT,
this breaks crash kernels on arm64 EFI systems. In these cases, DT is used
for the usable-memory-range property, but the actual memory ranges
come from EFI. Since the call to filter them was moved to the FDT
code, which runs before the EFI init code, the EFI ranges are not
filtered anymore, leading to the crash kernel using memory that
it shouldn't.

This set fixes the the issue by having the EFI code cap its
memory ranges too, and defining a common interface for both the
DT and EFI code to use.

These changes stick to the "firmware code should cap its own memory ranges"
idea, using a common memblock interface. An alternative would be to
use an FDT-specific interface as before, called from arm64_memblock_init,
but having things a little more generalized seemed like a good idea.

This is only a functional change on architectures that have both
DT and EFI, and a usable-memory-range property (which is just arm64).
On any other architecture, usable_size will not be set, leading to a
memblock_cap_memory_range call with 0 size, which is a no-op.

Frank van der Linden (3):
  memblock: define functions to set the usable memory range
  of: fdt: use memblock usable range interface
  efi: enforce usable memory range after reserving regions

 drivers/firmware/efi/efi-init.c |  7 +++++++
 drivers/of/fdt.c                |  3 ++-
 include/linux/memblock.h        |  2 ++
 mm/memblock.c                   | 37 +++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.32.0


