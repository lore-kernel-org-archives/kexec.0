Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1axXTp-0007sy-1k
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:23:12 +0000
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools 13/32] arm: fix pointer signedness warning in
 kexec-uImage-arm.c
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1axXT0-0004i9-Nv@e0050434b2927.dyn.arm.linux.org.uk>
Date: Tue, 03 May 2016 11:22:10 +0100
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

kexec/arch/arm/kexec-uImage-arm.c: In function 'uImage_arm_probe':
kexec/arch/arm/kexec-uImage-arm.c:14:2: warning: pointer targets in passing argument 1 of 'uImage_probe_kernel' differ in signedness [-Wpointer-sign]

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/kexec-uImage-arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
index 03c2f4d..8e0a9ac 100644
--- a/kexec/arch/arm/kexec-uImage-arm.c
+++ b/kexec/arch/arm/kexec-uImage-arm.c
@@ -11,7 +11,8 @@
 
 int uImage_arm_probe(const char *buf, off_t len)
 {
-	return uImage_probe_kernel(buf, len, IH_ARCH_ARM);
+	return uImage_probe_kernel((const unsigned char *)buf, len,
+				   IH_ARCH_ARM);
 }
 
 int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
