Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvXgC-0000LV-VU
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 13:35:17 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 2/6] kvm_x86_ops: crash_hardware_disable() operation
Date: Thu, 30 Oct 2008 11:34:42 -0200
Message-Id: <1225373687-6960-3-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
References: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

The vmx hardware_disable() function does too much for the virt_disable
crash handler, so we will have a new operation for the crash-time
virt_disable case.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 09e6c56..002023b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -426,6 +426,7 @@ struct kvm_x86_ops {
 	int (*disabled_by_bios)(void);             /* __init */
 	void (*hardware_enable)(void *dummy);      /* __init */
 	void (*hardware_disable)(void *dummy);
+	void (*crash_hardware_disable)(void *dummy);
 	void (*check_processor_compatibility)(void *rtn);
 	int (*hardware_setup)(void);               /* __init */
 	void (*hardware_unsetup)(void);            /* __exit */
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
