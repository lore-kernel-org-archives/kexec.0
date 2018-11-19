Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOpf2-0004Uu-S5
 for kexec@lists.infradead.org; Mon, 19 Nov 2018 19:56:46 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAJJsOtL010961
 for <kexec@lists.infradead.org>; Mon, 19 Nov 2018 14:56:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nv0pmr2kw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 19 Nov 2018 14:56:27 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 19 Nov 2018 19:56:25 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 0/3] selftest/ima: fail kexec_load syscall 
Date: Mon, 19 Nov 2018 14:56:08 -0500
Message-Id: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
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

The "ima: add support for arch specific policies" patch set introduced
architecture specific policies, including an x86 policy which prevents
loading a kernel image via the kexec_load syscall.

This patch set preq's that patch set, adding a missing kexec_load
syscall failure message, extending the existing support for detecting
secureboot mode, and defining a kexec_load syscall selftest to
simplify testing.

To run the kexec_load test requires root privileges.  Execute:
	"sudo make TARGETS=ima kselftest".

With secure boot enabled, the kexec_load fails, but the test
succeeds.

selftests: ima: test_kexec_load.sh
========================================
./test_kexec_load.sh: kexec_load failed [PASS]
ok 1..1 selftests: ima: test_kexec_load.sh [PASS]


Mimi

Mimi Zohar (3):
  ima: add error mesage to kexec_load
  selftests/ima: kexec_load syscall test
  x86/ima: retry detecting secure boot mode

 arch/x86/kernel/Makefile                       |  2 +
 arch/x86/kernel/ima_arch.c                     | 46 +++++++++++++++++++++-
 include/linux/ima.h                            |  2 +-
 security/integrity/ima/ima_main.c              |  4 +-
 tools/testing/selftests/Makefile               |  1 +
 tools/testing/selftests/ima/Makefile           | 11 ++++++
 tools/testing/selftests/ima/config             |  4 ++
 tools/testing/selftests/ima/test_kexec_load.sh | 54 ++++++++++++++++++++++++++
 8 files changed, 120 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/ima/Makefile
 create mode 100644 tools/testing/selftests/ima/config
 create mode 100755 tools/testing/selftests/ima/test_kexec_load.sh

-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
