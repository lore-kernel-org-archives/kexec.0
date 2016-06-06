Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by merlin.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1b9xxM-0005JV-J7
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:04:53 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 13/32] arm: fix pointer signedness warning in
 kexec-uImage-arm.c
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xsU-0003sg-4H@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 17:59:50 +0100
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

kexec/arch/arm/kexec-uImage-arm.c: In function 'uImage_arm_probe':
kexec/arch/arm/kexec-uImage-arm.c:14:2: warning: pointer targets in passing argument 1 of 'uImage_probe_kernel' differ in signedness [-Wpointer-sign]

Reviewed-by: Pratyush Anand <panand@redhat.com>
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
