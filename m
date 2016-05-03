Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by casper.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1axXUn-0001us-90
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:24:02 +0000
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools 29/32] arm: add debug of reserved and coredump
 memory ranges
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1axXUL-0004jm-W0@e0050434b2927.dyn.arm.linux.org.uk>
Date: Tue, 03 May 2016 11:23:33 +0100
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
Cc: Pratyush Anand <panand@redhat.com>

Add debug of the reserved and coredump memory ranges for validation.

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
