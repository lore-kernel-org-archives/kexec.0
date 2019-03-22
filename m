Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h7Py5-0001Yb-S6
 for kexec@lists.infradead.org; Fri, 22 Mar 2019 19:36:43 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2MJYcw9098830
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2019 15:36:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rd46sd1t6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2019 15:36:39 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Fri, 22 Mar 2019 19:36:35 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4a 2/2] selftests/kexec: testing
 CONFIG_KEXEC_BZIMAGE_VERIFY_SIG is not enough
Date: Fri, 22 Mar 2019 15:35:51 -0400
In-Reply-To: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
References: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1553283351-6310-2-git-send-email-zohar@linux.ibm.com>
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

Add support for CONFIG_KEXEC_VERIFY_SIG being enabled, but not
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/kexec/test_kexec_file_load.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index 57b636792086..fa7c24e8eefb 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -102,7 +102,8 @@ kexec_file_load_test()
 			log_fail "$succeed_msg (missing sig)"
 		fi
 
-		if [ $pe_sig_required -eq 1 ] && [ $pe_signed -eq 0 ]; then
+		if [ $kexec_sig_required -eq 1 -o $pe_sig_required -eq 1 ] \
+		     && [ $pe_signed -eq 0 ]; then
 			log_fail "$succeed_msg (missing PE sig)"
 		fi
 
@@ -137,7 +138,8 @@ kexec_file_load_test()
 		fi
 	fi
 
-	if [ $pe_sig_required -eq 1 ] && [ $pe_signed -eq 0 ]; then
+	if [ $kexec_sig_required -eq 1 -o $pe_sig_required -eq 1 ] \
+	     && [ $pe_signed -eq 0 ]; then
 		log_pass "$failed_msg (missing PE sig)"
 	fi
 
@@ -181,6 +183,10 @@ platform_keyring=$?
 kconfig_enabled "CONFIG_IMA_READ_POLICY=y" "reading IMA policy permitted"
 ima_read_policy=$?
 
+kconfig_enabled "CONFIG_KEXEC_SIG_FORCE=y" \
+	"kexec signed kernel image required"
+kexec_sig_required=$?
+
 kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
 	"PE signed kernel image required"
 pe_sig_required=$?
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
