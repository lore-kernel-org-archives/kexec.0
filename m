Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by casper.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1axXYx-00020m-QV
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:28:21 +0000
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools 19/32] arm: add memory ranges debug
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1axXTV-0004in-Sw@e0050434b2927.dyn.arm.linux.org.uk>
Date: Tue, 03 May 2016 11:22:41 +0100
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

Add the call to dbgprint_mem_range() into the ARM version of
get_memory_ranges().

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/kexec-arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index e47fc00..eeb27b4 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -70,6 +70,9 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	fclose(fp);
 	*range = memory_range;
 	*ranges = memory_ranges;
+
+	dbgprint_mem_range("MEMORY RANGES", *range, *ranges);
+
 	return 0;
 }
 
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
