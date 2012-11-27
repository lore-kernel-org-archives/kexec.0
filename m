Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Td9GB-0004NO-8c
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 00:42:48 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id D7AD93EE0BD
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:45 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B998E45DE54
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id A129E45DE4E
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 922521DB803F
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:45 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 45D9B1DB803B
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:45 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Message-Id: <20121127004203.3604.75204.sendpatchset@tindoh.g01.fujitsu.local>
In-Reply-To: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
Subject: [PATCH v7 2/5] PCI: Define the maximum number of PCI function
Date: Tue, 27 Nov 2012 09:42:44 +0900 (JST)
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, kexec@lists.infradead.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

Define the maximum number of PCI function so that PCI functions can be
enumerated without using "8".

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 include/linux/pci.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index ee21795..eca3231 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -35,6 +35,8 @@
 /* Include the ID list */
 #include <linux/pci_ids.h>
 
+#define PCI_MAX_FUNCTIONS 8
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus *bus;		/* The bus this slot is on */
-- 
1.7.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
