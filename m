Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cb0ol-0003FU-F1
 for kexec@lists.infradead.org; Tue, 07 Feb 2017 08:08:05 +0000
Received: by mail-pg0-f50.google.com with SMTP id 204so36720202pge.0
 for <kexec@lists.infradead.org>; Tue, 07 Feb 2017 00:07:43 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v32 01/13] memblock: add memblock_clear_nomap()
Date: Tue,  7 Feb 2017 17:08:09 +0900
Message-Id: <20170207080810.5890-1-takahiro.akashi@linaro.org>
In-Reply-To: <20170207080601.5816-1-takahiro.akashi@linaro.org>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org
Cc: mark.rutland@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, geoff@infradead.org, kexec@lists.infradead.org, linux-mm@kvack.org, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

This function, with a combination of memblock_mark_nomap(), will be used
in a later kdump patch for arm64 when it temporarily isolates some range
of memory from the other memory blocks in order to create a specific
kernel mapping at boot time.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5b759c9acf97..5f7825752b15 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -92,6 +92,7 @@ int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 ulong choose_memblock_flags(void);
 
 /* Low level functions */
diff --git a/mm/memblock.c b/mm/memblock.c
index 7608bc305936..07c85ec2c035 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -814,6 +814,18 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 }
 
 /**
+ * memblock_clear_nomap - Clear flag MEMBLOCK_NOMAP for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
+}
+
+/**
  * __next_reserved_mem_region - next function for for_each_reserved_region()
  * @idx: pointer to u64 loop variable
  * @out_start: ptr to phys_addr_t for start address of the region, can be %NULL
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
