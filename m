Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9y35-0005p2-B1
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:10:51 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 29/32] arm: add debug of reserved and coredump
 memory ranges
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xtp-0003uE-KF@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 18:01:13 +0100
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>

Add debug of the reserved and coredump memory ranges for validation.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 25fdbe9..2dc8846 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -158,6 +158,10 @@ static int crash_get_memory_ranges(void)
 		return -1;
 	}
 
+	dbgprint_mem_range("Reserved memory ranges",
+			   crash_reserved_rgns.ranges,
+			   crash_reserved_rgns.size);
+
 	/*
 	 * Exclude all reserved memory from the usable memory regions.
 	 * We want to avoid dumping the crashkernel region itself.  Note
@@ -179,6 +183,9 @@ static int crash_get_memory_ranges(void)
 	 */
 	mem_regions_sort(&usablemem_rgns);
 
+	dbgprint_mem_range("Coredump memory ranges",
+			   usablemem_rgns.ranges, usablemem_rgns.size);
+
 	return 0;
 }
 
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
