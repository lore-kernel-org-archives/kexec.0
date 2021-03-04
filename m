Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHnNR-008emW-1V
 for kexec@lists.infradead.org; Thu, 04 Mar 2021 12:46:51 +0000
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] kexec: Add kexec reboot string
Date: Thu,  4 Mar 2021 13:46:26 +0100
Message-Id: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Guohan Lu <lguohan@gmail.com>, Joe LeVeque <jolevequ@microsoft.com>, Paul Menzel <pmenzel@molgen.mpg.de>

From: Joe LeVeque <jolevequ@microsoft.com>

The purpose is to notify the kernel module for fast reboot.

Upstream a patch from the SONiC network operating system [1].

[1]: https://github.com/Azure/sonic-linux-kernel/pull/46

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a0b6780740c8..f04d04d1b855 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1165,7 +1165,7 @@ int kernel_kexec(void)
 #endif
 	{
 		kexec_in_progress = true;
-		kernel_restart_prepare(NULL);
+		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
 
 		/*
-- 
2.30.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
