Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxoVI-0007kC-5q
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 19:57:24 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 13/15] kvm: svm: register virt_disable function on
	hardware_setup
Date: Wed,  5 Nov 2008 17:56:56 -0200
Message-Id: <1225915018-6548-14-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
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
To: Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Call set_virt_disable_func() on hardware_setup, and clear it on
hardware_unsetup.

This way kdump and reboot code will be able to disable svm when needed.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kvm/svm.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 3d330a2..8f9256d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -27,6 +27,7 @@
 #include <linux/sched.h>
 
 #include <asm/desc.h>
+#include <asm/virtext.h>
 
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
@@ -422,10 +423,16 @@ static __init int svm_hardware_setup(void)
 	void *iopm_va;
 	int r;
 
+	r = set_virt_disable_func(__svm_hardware_disable);
+	if (r)
+		goto err;
+
 	iopm_pages = alloc_pages(GFP_KERNEL, IOPM_ALLOC_ORDER);
 
-	if (!iopm_pages)
-		return -ENOMEM;
+	if (!iopm_pages) {
+		r = -ENOMEM;
+		goto err_clear_virt_disable;
+	}
 
 	iopm_va = page_address(iopm_pages);
 	memset(iopm_va, 0xff, PAGE_SIZE * (1 << IOPM_ALLOC_ORDER));
@@ -438,7 +445,7 @@ static __init int svm_hardware_setup(void)
 	for_each_online_cpu(cpu) {
 		r = svm_cpu_init(cpu);
 		if (r)
-			goto err;
+			goto err_free_iopm;
 	}
 
 	svm_features = cpuid_edx(SVM_CPUID_FUNC);
@@ -459,9 +466,12 @@ static __init int svm_hardware_setup(void)
 
 	return 0;
 
-err:
+err_free_iopm:
 	__free_pages(iopm_pages, IOPM_ALLOC_ORDER);
 	iopm_base = 0;
+err_clear_virt_disable:
+	clear_virt_disable_func();
+err:
 	return r;
 }
 
@@ -474,6 +484,7 @@ static __exit void svm_hardware_unsetup(void)
 
 	__free_pages(pfn_to_page(iopm_base >> PAGE_SHIFT), IOPM_ALLOC_ORDER);
 	iopm_base = 0;
+	clear_virt_disable_func();
 }
 
 static void init_seg(struct vmcb_seg *seg)
-- 
1.5.5.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
