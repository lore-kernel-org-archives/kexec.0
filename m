Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3JJj-00047E-Mu
 for kexec@lists.infradead.org; Mon, 11 Mar 2019 11:42:06 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2BBeVCE109528
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2019 07:42:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r5m54qby8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2019 07:42:02 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 11 Mar 2019 11:42:00 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 4/7] kselftest/ima: define "require_root_privileges"
Date: Mon, 11 Mar 2019 07:41:10 -0400
In-Reply-To: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1552304473-3966-5-git-send-email-zohar@linux.ibm.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>, linux-kselftest@vger.kernel.org, Dave Young <dyoung@redhat.com>

Many tests require root privileges.  Define a common function.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/ima/ima_common_lib.sh  | 7 +++++++
 tools/testing/selftests/ima/test_kexec_load.sh | 4 +---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ima/ima_common_lib.sh b/tools/testing/selftests/ima/ima_common_lib.sh
index 59482914ac19..8ab7fcc0b221 100755
--- a/tools/testing/selftests/ima/ima_common_lib.sh
+++ b/tools/testing/selftests/ima/ima_common_lib.sh
@@ -65,3 +65,10 @@ get_secureboot_mode()
 	log_info "secure boot mode not enabled"
 	return 0;
 }
+
+require_root_privileges()
+{
+	if [ $(id -ru) -ne 0 ]; then
+		log_skip "requires root privileges"
+	fi
+}
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
index 99ab87b6c681..b2ecd196b382 100755
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -8,9 +8,7 @@ TEST="$0"
 . ./ima_common_lib.sh
 
 # kexec requires root privileges
-if [ $(id -ru) -ne 0 ]; then
-	log_skip "requires root privileges"
-fi
+require_root_privileges
 
 get_secureboot_mode
 secureboot=$?
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
