Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TapPO-0007Uh-12
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 15:06:43 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:35419 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1634391Ab2KTPEy
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Tue, 20 Nov 2012 16:04:54 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 11/11] x86: Add Xen kexec control code size check to linker
 script
Date: Tue, 20 Nov 2012 16:04:53 +0100
Message-Id: <1353423893-23125-12-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1353423893-23125-11-git-send-email-daniel.kiper@oracle.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-3-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-4-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-5-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-6-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-7-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-8-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-9-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-10-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-11-git-send-email-daniel.kiper@oracle.com>
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
To: andrew.cooper3@citrix.com, ebiederm@xmission.com, hpa@zytor.com, jbeulich@suse.com, konrad.wilk@oracle.com, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Add Xen kexec control code size check to linker script.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/kernel/vmlinux.lds.S |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 22a1530..f18786a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -360,5 +360,10 @@ INIT_PER_CPU(irq_stack_union);
 
 . = ASSERT(kexec_control_code_size <= KEXEC_CONTROL_CODE_MAX_SIZE,
            "kexec control code size is too big");
-#endif
 
+#ifdef CONFIG_XEN
+. = ASSERT(xen_kexec_control_code_size - xen_relocate_kernel <=
+		KEXEC_CONTROL_CODE_MAX_SIZE,
+		"Xen kexec control code size is too big");
+#endif
+#endif
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
