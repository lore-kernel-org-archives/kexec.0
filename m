From: Frank van der Linden <fllinden@amazon.com>
Date: Mon, 10 Jan 2022 21:08:08 +0000
Subject: [PATCH 2/3] of: fdt: use memblock usable range interface
In-Reply-To: <20220110210809.3528-1-fllinden@amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
Message-ID: <20220110210809.3528-3-fllinden@amazon.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Use the memblock usable range interface to set and enforce the
usable memory range (if any).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 drivers/of/fdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4546572af24b..b3c2a4124518 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1279,7 +1279,8 @@ void __init early_init_dt_scan_nodes(void)
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Handle linux,usable-memory-range property */
-	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
+	memblock_set_usable_range(cap_mem_addr, cap_mem_size);
+	memblock_enforce_usable_range();
 }
 
 bool __init early_init_dt_scan(void *params)
-- 
2.32.0


