Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yktkc-0006re-5S
 for kexec@lists.infradead.org; Wed, 22 Apr 2015 12:27:34 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3MCRFu9010054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Wed, 22 Apr 2015 08:27:16 -0400
Received: from localhost (vpn-48-34.rdu2.redhat.com [10.10.48.34])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t3MCR8f5011419
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Wed, 22 Apr 2015 08:27:13 -0400
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH] arm64: wait for transmit completion before next character
 transmission
Date: Wed, 22 Apr 2015 17:56:50 +0530
Message-Id: <04c30b253821d34ae1dc16e723dd74b663a64f67.1429705033.git.panand@redhat.com>
In-Reply-To: <770bae1ed7d53e74874f99343070b4c5a69cb9a2.1429704995.git.panand@redhat.com>
References: <770bae1ed7d53e74874f99343070b4c5a69cb9a2.1429704995.git.panand@redhat.com>
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
To: kexec@lists.infradead.org

Previous transmission must be completed before next character to be
transmitted, otherwise TX buffer may saturate and we will not see all
the characters on screen.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 purgatory/arch/arm64/purgatory-arm64.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/purgatory/arch/arm64/purgatory-arm64.c b/purgatory/arch/arm64/purgatory-arm64.c
index 25960c30bd05..3a1c9243bfa2 100644
--- a/purgatory/arch/arm64/purgatory-arm64.c
+++ b/purgatory/arch/arm64/purgatory-arm64.c
@@ -11,15 +11,37 @@ extern uint32_t *arm64_sink;
 extern void (*arm64_kernel_entry)(uint64_t);
 extern uint64_t arm64_dtb_addr;
 
+static void wait_for_xmit_complete(void)
+{
+	volatile uint32_t status;
+	volatile uint32_t *status_reg;
+
+	/*
+	 * Since most of the UART with ARM platform has LSR register at
+	 * offset 0x14 and should have value as 0x60 for TX empty, so we
+	 * have hardcoded these values. Can modify in future if need
+	 * arises.
+	 */
+	status_reg = (volatile uint32_t *)((uint64_t)arm64_sink + 0x14);
+	while (1) {
+		status = *status_reg;
+		if ((status & 0x60) == 0x60)
+			break;
+	}
+}
+
 void putchar(int ch)
 {
 	if (!arm64_sink)
 		return;
 
+	wait_for_xmit_complete();
 	*arm64_sink = ch;
 
-	if (ch == '\n')
+	if (ch == '\n') {
+		wait_for_xmit_complete();
 		*arm64_sink = '\r';
+	}
 }
 
 void setup_arch(void)
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
