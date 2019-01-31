Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpHVd-0000IF-P8
 for kexec@lists.infradead.org; Thu, 31 Jan 2019 18:56:24 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0VIs79H037184
 for <kexec@lists.infradead.org>; Thu, 31 Jan 2019 13:56:19 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qc67c9k1n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 31 Jan 2019 13:56:18 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Thu, 31 Jan 2019 18:56:16 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 0/3] selftest/ima: add kexec_file_load test
Date: Thu, 31 Jan 2019 13:55:33 -0500
Message-Id: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>

The kernel can be configured to verify PE signed kernel images, IMA
kernel image signatures, both types of signatures, or none.  Verify
only properly signed kernel images are loaded into memory, based on
the kernel configuration and runtime policies.

Mimi Zohar (3):
  selftest/ima: cleanup the kexec selftest
  scripts/ima: define a set of common functions
  selftests/ima: kexec_file_load syscall test

 tools/testing/selftests/ima/Makefile               |   2 +-
 tools/testing/selftests/ima/common_lib.sh          |  20 ++
 .../testing/selftests/ima/test_kexec_file_load.sh  | 250 +++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh     |  31 +--
 4 files changed, 281 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/ima/common_lib.sh
 create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh

-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
