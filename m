From: Frank van der Linden <fllinden@amazon.com>
Date: Mon, 10 Jan 2022 21:08:09 +0000
Subject: [PATCH 3/3] efi: enforce usable memory range after reserving regions
In-Reply-To: <20220110210809.3528-1-fllinden@amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
Message-ID: <20220110210809.3528-4-fllinden@amazon.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The usable memory range may be restricted through parameters that
did not come from EFI, like the FDT "linux,usable-memory-range"
property.

Enforce this range after the EFI memory map regions have been
processed.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 drivers/firmware/efi/efi-init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index b19ce1a83f91..280e9178c7df 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -204,6 +204,13 @@ static __init void reserve_regions(void)
 				memblock_reserve(paddr, size);
 		}
 	}
+
+	/*
+	 * Done, filter !nomap memory we just added so that the
+	 * usable range is enforced. This is normally only set
+	 * for crash kernels on some architectures.
+	 */
+	memblock_enforce_usable_range();
 }
 
 void __init efi_init(void)
-- 
2.32.0


