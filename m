Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from leibniz.telenet-ops.be ([195.130.137.77])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3eLu-00HUF1-0W
 for kexec@lists.infradead.org; Wed, 14 Jul 2021 12:51:05 +0000
Received: from andre.telenet-ops.be (andre.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:15])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4GPy6M5JQ5zMqfPY
 for <kexec@lists.infradead.org>; Wed, 14 Jul 2021 14:50:51 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 02/10] memblock: Add variables for usable memory limitation
Date: Wed, 14 Jul 2021 14:50:12 +0200
Message-Id: <04c4d231fb03a3810d72a45c8a5bc2272c5975f3.1626266516.git.geert+renesas@glider.be>
In-Reply-To: <cover.1626266516.git.geert+renesas@glider.be>
References: <cover.1626266516.git.geert+renesas@glider.be>
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
To: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, linux-mm@kvack.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add two global variables (cap_mem_addr and cap_mem_size) for storing a
base address and size, describing a limited region in which memory may
be considered available for use by the kernel.  If enabled, memory
outside of this range is not available for use.

These variables can by filled by firmware-specific code, and used in
calls to memblock_cap_memory_range() by architecture-specific code.
An example user is the parser of the "linux,usable-memory-range"
property in the DT "/chosen" node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is similar to how the initial ramdisk (phys_initrd_{start,size})
and ELF core headers (elfcorehdr_{addr,size})) are handled.

Does there exist a suitable place in the common memblock code to call
"memblock_cap_memory_range(cap_mem_addr, cap_mem_size)", or does this
have to be done in architecture-specific code?

v4:
  - New.
---
 include/linux/memblock.h | 6 ++++++
 mm/memblock.c            | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index cbf46f56d1053b68..07e2474c4c3901e9 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -25,6 +25,12 @@ extern unsigned long max_pfn;
  */
 extern unsigned long long max_possible_pfn;
 
+/*
+ * limited region in which memory may be considered usable by the kernel
+ */
+extern phys_addr_t cap_mem_addr;
+extern phys_addr_t cap_mem_size;
+
 /**
  * enum memblock_flags - definition of memory region attributes
  * @MEMBLOCK_NONE: no special request
diff --git a/mm/memblock.c b/mm/memblock.c
index 0041ff62c584e7e1..66659f2b10ed40ff 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -101,6 +101,8 @@ unsigned long max_low_pfn;
 unsigned long min_low_pfn;
 unsigned long max_pfn;
 unsigned long long max_possible_pfn;
+phys_addr_t cap_mem_addr;
+phys_addr_t cap_mem_size;
 
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
