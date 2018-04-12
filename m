Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f6kv7-0008Je-FJ
 for kexec@lists.infradead.org; Thu, 12 Apr 2018 22:42:23 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3CMdFJJ006263
 for <kexec@lists.infradead.org>; Thu, 12 Apr 2018 18:42:10 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hae3tdebp-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 12 Apr 2018 18:42:10 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 12 Apr 2018 23:42:08 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
Date: Thu, 12 Apr 2018 18:41:50 -0400
In-Reply-To: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
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
To: David Howells <dhowells@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>

Allow LSMs and IMA to differentiate between the kexec_load and
kexec_file_load syscalls by adding an "unnecessary" call to
security_kernel_read_file() in kexec_load.  This would be similar to the
existing init_module syscall calling security_kernel_read_file().

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 kernel/kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index aed8fb2564b3..d1386cfc6796 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -11,6 +11,7 @@
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
+#include <linux/security.h>
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -195,11 +196,21 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 static inline int kexec_load_check(unsigned long nr_segments,
 				   unsigned long flags)
 {
+	int result;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
 	/*
+	 * Allow LSMs and IMA to differentiate between kexec_load and
+	 * kexec_file_load syscalls.
+	 */
+	result = security_kernel_read_file(NULL, READING_KEXEC_IMAGE);
+	if (result < 0)
+		return result;
+
+	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
 	 */
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
