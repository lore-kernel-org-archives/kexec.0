Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127])
	by canuck.infradead.org with smtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PFNKx-0002KK-BR
	for kexec@lists.infradead.org; Mon, 08 Nov 2010 08:44:24 +0000
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9970726C
	for <kexec@lists.infradead.org>; Mon,  8 Nov 2010 08:44:11 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 45BC7CD6
	for <kexec@lists.infradead.org>; Mon,  8 Nov 2010 08:43:01 +0000 (GMT)
Received: from exdcvycastm003.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm003", Issuer "exdcvycastm003" (not verified))
	by relay1.stm.gmessaging.net (Postfix) with ESMTPS id C4D2B24C2F8
	for <kexec@lists.infradead.org>; Mon,  8 Nov 2010 09:42:54 +0100 (CET)
From: Per Fransson <per.xx.fransson@stericsson.com>
Subject: [RFC 1/2] Selective MMU identity mapping for kexec
Date: Mon, 8 Nov 2010 09:42:36 +0100
Message-ID: <1289205757-14620-2-git-send-email-per.xx.fransson@stericsson.com>
In-Reply-To: <1289205757-14620-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1289205757-14620-1-git-send-email-per.xx.fransson@stericsson.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Per Fransson <per.xx.fransson@stericsson.com>

Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
---
 arch/arm/mm/proc-v7.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2b5b20b..b249143 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -61,6 +61,9 @@ ENDPROC(cpu_v7_proc_fin)
  */
 	.align	5
 ENTRY(cpu_v7_reset)
+	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
+	bic	ip, ip, #0x0001			@ ...............m
+	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
 ENDPROC(cpu_v7_reset)
 
-- 
1.7.2.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
