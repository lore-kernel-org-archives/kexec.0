From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Mon, 24 Jan 2022 16:47:04 +0800
Subject: [PATCH v20 1/5] arm64: Use insert_resource() to simplify code
In-Reply-To: <20220124084708.683-1-thunder.leizhen@huawei.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
Message-ID: <20220124084708.683-2-thunder.leizhen@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

insert_resource() traverses the subtree layer by layer from the root node
until a proper location is found. Compared with request_resource(), the
parent node does not need to be determined in advance.

In addition, move the insertion of node 'crashk_res' into function
reserve_crashkernel() to make the associated code close together.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/setup.c | 17 +++--------------
 arch/arm64/mm/init.c      |  1 +
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f70573928f1bff0..a81efcc359e4e78 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -225,6 +225,8 @@ static void __init request_standard_resources(void)
 	kernel_code.end     = __pa_symbol(__init_begin - 1);
 	kernel_data.start   = __pa_symbol(_sdata);
 	kernel_data.end     = __pa_symbol(_end - 1);
+	insert_resource(&iomem_resource, &kernel_code);
+	insert_resource(&iomem_resource, &kernel_data);
 
 	num_standard_resources = memblock.memory.cnt;
 	res_size = num_standard_resources * sizeof(*standard_resources);
@@ -246,20 +248,7 @@ static void __init request_standard_resources(void)
 			res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
 		}
 
-		request_resource(&iomem_resource, res);
-
-		if (kernel_code.start >= res->start &&
-		    kernel_code.end <= res->end)
-			request_resource(res, &kernel_code);
-		if (kernel_data.start >= res->start &&
-		    kernel_data.end <= res->end)
-			request_resource(res, &kernel_data);
-#ifdef CONFIG_KEXEC_CORE
-		/* Userspace will find "Crash kernel" region in /proc/iomem. */
-		if (crashk_res.end && crashk_res.start >= res->start &&
-		    crashk_res.end <= res->end)
-			request_resource(res, &crashk_res);
-#endif
+		insert_resource(&iomem_resource, res);
 	}
 }
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index db63cc885771a52..90f276d46b93bc6 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -109,6 +109,7 @@ static void __init reserve_crashkernel(void)
 	kmemleak_ignore_phys(crash_base);
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
+	insert_resource(&iomem_resource, &crashk_res);
 }
 #else
 static void __init reserve_crashkernel(void)
-- 
2.25.1


