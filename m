Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by merlin.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1axXTu-0002jM-F5
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:23:07 +0000
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools 14/32] arm: fix off-by-one on memory end
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1axXT5-0004iJ-VX@e0050434b2927.dyn.arm.linux.org.uk>
Date: Tue, 03 May 2016 11:22:15 +0100
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

The memory range end is inclusive, not exclusive (see x86).  We should
not be adding one to the value parsed from the /proc/iomem resources.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/kexec-arm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 4e90e69..e47fc00 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -51,7 +51,6 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 		if (count != 2)
 			continue;
 		str = line + consumed;
-		end = end + 1;
 
 		if (memcmp(str, "System RAM\n", 11) == 0) {
 			type = RANGE_RAM;
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
