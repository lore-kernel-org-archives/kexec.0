Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bQVav-0006wA-ML
 for kexec@lists.infradead.org; Fri, 22 Jul 2016 08:14:06 +0000
From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Subject: [PATCH 2/3] x86/apic: Update comment about disabling processor focus
Date: Fri, 22 Jul 2016 16:10:25 +0800
Message-ID: <1469175026-29447-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1469175026-29447-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1469175026-29447-1-git-send-email-weijg.fnst@cn.fujitsu.com>
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
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, xpang@redhat.com, x86@kernel.org, kexec@lists.infradead.org, Cao jin <caoj.fnst@cn.fujitsu.com>, mingo@redhat.com, kernel@kyup.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, Wei Jiangang <weijg.fnst@cn.fujitsu.com>

Fix references to discarded end_level_ioapic_irq().

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/apic/apic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 0273b652c689..8e25b9b2d351 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1346,7 +1346,6 @@ void setup_local_APIC(void)
 	 * Actually disabling the focus CPU check just makes the hang less
 	 * frequent as it makes the interrupt distributon model be more
 	 * like LRU than MRU (the short-term load is more even across CPUs).
-	 * See also the comment in end_level_ioapic_irq().  --macro
 	 */
 
 	/*
-- 
1.9.3




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
