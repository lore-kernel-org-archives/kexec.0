Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHhlI-0005nU-NC
 for kexec@lists.infradead.org; Mon, 18 Mar 2013 21:38:33 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: [PATCH 11/12] x86: Require CAP_COMPROMISE_KERNEL for MSR writing
Date: Mon, 18 Mar 2013 17:32:32 -0400
Message-Id: <1363642353-30749-11-git-send-email-matthew.garrett@nebula.com>
In-Reply-To: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
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
To: linux-kernel@vger.kernel.org
Cc: Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-security-module@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Writing to MSRs should not be allowed unless CAP_COMPROMISE_KERNEL is
set since it could lead to execution of arbitrary code in kernel mode.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
---
 arch/x86/kernel/msr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index ce13049..fa4dc6c 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -103,6 +103,9 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	if (!capable(CAP_COMPROMISE_KERNEL))
+		return -EPERM;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -150,6 +153,10 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EBADF;
 			break;
 		}
+		if (!capable(CAP_COMPROMISE_KERNEL)) {
+			err = -EPERM;
+			break;
+		}
 		if (copy_from_user(&regs, uregs, sizeof regs)) {
 			err = -EFAULT;
 			break;
-- 
1.8.1.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
