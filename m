Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3JJc-00044p-54
 for kexec@lists.infradead.org; Mon, 11 Mar 2019 11:41:57 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2BBdiVb040591
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2019 07:41:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r5pg49ghf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2019 07:41:53 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 11 Mar 2019 11:41:51 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 0/7] selftests/ima: add kexec and kernel module tests
Date: Mon, 11 Mar 2019 07:41:06 -0400
Message-Id: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
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

The kernel can be configured to require kexec kernel images and kernel
modules are signed.  An IMA policy can be specified on the boot command
line or a custom IMA policy loaded requiring the kexec kernel image and
kernel modules be signed.  In addition, systems booted in secure boot
mode with the IMA architecture specific policy enabled, require validly
signed kexec kernel images and kernel modules.

In addition to two methods of signing kernel images and two methods of
signing kernel modules, there are two syscalls for each.

kernel image:  PE signature, IMA signature
kexec syscalls: kexec_load, kexec_file_load

Both the PE and IMA kernel image signature can only be verified when
loaded via the kexec_file_load syscall.

kernel moodule: appended signature, IMA signature
kernel module syscalls: init_module, finit_module

The appended kernel module signature can be verified when the kernel
module is loaded via either syscall.  The IMA kernel module signature
can only be verified when the kernel module is loaded via the
finit_module syscall.

The selftests in this patch set verify that only signed kernel images
and kernel modules are loaded as required, based on the kernel config,
the secure boot mode, and the IMA runtime policy.

Loading a kernel image or kernel module requires root privileges.  To
run just the IMA selftests: sudo make TARGETS=ima kselftest

Changelog:
- Updated tests based on Petr's review, including the defining a common
  test to check for root privileges.
- Modified config, removing the CONFIG_KEXEC_VERIFY_SIG requirement.
- Updated the SPDX license to GPL-2.0 based on Shuah's review.
- Updated the secureboot mode test to check the SetupMode as well, based
  on David Young's review.


Mimi Zohar (6):
  selftests/ima: cleanup the kexec selftest
  selftests/ima: define a set of common functions
  selftests/ima: define common logging functions
  kselftest/ima: define "require_root_privileges"
  selftests/ima: kexec_file_load syscall test
  selftests/ima: loading kernel modules

Petr Vorel (1):
  selftests/ima: Add missing '=y' to config options

 tools/testing/selftests/ima/Makefile               |   3 +-
 tools/testing/selftests/ima/config                 |   7 +-
 tools/testing/selftests/ima/ima_common_lib.sh      | 173 +++++++++++++++++++
 tools/testing/selftests/ima/test_kernel_module.sh  |  93 ++++++++++
 .../testing/selftests/ima/test_kexec_file_load.sh  | 190 +++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh     |  53 ++----
 6 files changed, 476 insertions(+), 43 deletions(-)
 create mode 100755 tools/testing/selftests/ima/ima_common_lib.sh
 create mode 100755 tools/testing/selftests/ima/test_kernel_module.sh
 create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh

-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
