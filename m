Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icW12-0006vt-Gb
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 14:52:38 +0000
From: Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/memreserve: register reservations as 'reserved' in
 /proc/iomem
Date: Wed,  4 Dec 2019 14:52:33 +0000
Message-Id: <20191204145233.11962-1-ardb@kernel.org>
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
To: linux-efi@vger.kernel.org
Cc: mark.rutland@arm.com, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, kexec@lists.infradead.org, d.hatayama@fujitsu.com, james.morse@arm.com, Ard Biesheuvel <ardb@kernel.org>

Memory regions that are reserved using efi_mem_reserve_persistent()
are recorded in a special EFI config table which survives kexec,
allowing the incoming kernel to honour them as well. However,
such reservations are not visible in /proc/iomem, and so the kexec
tools that load the incoming kernel and its initrd into memory may
overwrite these reserved regions before the incoming kernel has a
chance to reserve them from further use.

So add these reservations to /proc/iomem as they are created. Note
that reservations that are inherited from a previous kernel are
memblock_reserve()'d early on, so they are already visible in
/proc/iomem.

Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: d.hatayama@fujitsu.com
Cc: kexec@lists.infradead.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 29 ++++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d101f072c8f8..fcd82dde23c8 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -979,6 +979,24 @@ static int __init efi_memreserve_map_root(void)
 	return 0;
 }
 
+static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
+{
+	struct resource *res, *parent;
+
+	res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
+	if (!res)
+		return -ENOMEM;
+
+	res->name	= "reserved";
+	res->flags	= IORESOURCE_MEM;
+	res->start	= addr;
+	res->end	= addr + size - 1;
+
+	/* we expect a conflict with a 'System RAM' region */
+	parent = request_resource_conflict(&iomem_resource, res);
+	return parent ? request_resource(parent, res) : 0;
+}
+
 int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
 	struct linux_efi_memreserve *rsv;
@@ -1001,9 +1019,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 		if (index < rsv->size) {
 			rsv->entry[index].base = addr;
 			rsv->entry[index].size = size;
-
 			memunmap(rsv);
-			return 0;
+			return efi_mem_reserve_iomem(addr, size);
 		}
 		memunmap(rsv);
 	}
@@ -1013,6 +1030,12 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
+	rc = efi_mem_reserve_iomem(__pa(rsv), SZ_4K);
+	if (rc) {
+		free_page(rsv);
+		return rc;
+	}
+
 	/*
 	 * The memremap() call above assumes that a linux_efi_memreserve entry
 	 * never crosses a page boundary, so let's ensure that this remains true
@@ -1029,7 +1052,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	efi_memreserve_root->next = __pa(rsv);
 	spin_unlock(&efi_mem_reserve_persistent_lock);
 
-	return 0;
+	return efi_mem_reserve_iomem(addr, size);
 }
 
 static int __init efi_memreserve_root_init(void)
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
