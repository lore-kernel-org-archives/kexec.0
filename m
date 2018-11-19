Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOpf0-0005DH-P8
 for kexec@lists.infradead.org; Mon, 19 Nov 2018 19:56:43 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAJJsU5E107694
 for <kexec@lists.infradead.org>; Mon, 19 Nov 2018 14:56:29 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nv0kygh3g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 19 Nov 2018 14:56:29 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 19 Nov 2018 19:56:27 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/3] ima: add error mesage to kexec_load
Date: Mon, 19 Nov 2018 14:56:09 -0500
In-Reply-To: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1542657371-7019-2-git-send-email-zohar@linux.ibm.com>
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
To: linux-integrity@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, jforbes@redhat.com

Reject the kexec_load syscall with some indication of the problem.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 41e4771980d5..df0b2ee49fa2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -513,8 +513,10 @@ int ima_load_data(enum kernel_load_data_id id)
 	switch (id) {
 	case LOADING_KEXEC_IMAGE:
 		if (IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG)
-		    && arch_ima_get_secureboot())
+		    && arch_ima_get_secureboot()) {
+			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;
+		}
 
 		if (ima_enforce && (ima_appraise & IMA_APPRAISE_KEXEC)) {
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
