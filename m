Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1beri7-0000OH-B0
 for kexec@lists.infradead.org; Tue, 30 Aug 2016 22:40:52 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7UMXG28017354
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 18:40:29 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 255365da4h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 18:40:29 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 31 Aug 2016 04:10:25 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C76A73940064
 for <kexec@lists.infradead.org>; Wed, 31 Aug 2016 04:10:22 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7UMeLMX21889266
 for <kexec@lists.infradead.org>; Wed, 31 Aug 2016 04:10:21 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7UMeLBW014357
 for <kexec@lists.infradead.org>; Wed, 31 Aug 2016 04:10:22 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATHC v2 0/9] ima: carry the measurement list across kexec 
Date: Tue, 30 Aug 2016 18:40:02 -0400
Message-Id: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

The TPM PCRs are only reset on a hard reboot.  In order to validate a
TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
of the running kernel must be saved and then restored on the subsequent
boot, possibly of a different architecture.

The existing securityfs binary_runtime_measurements file conveniently
provides a serialized format of the IMA measurement list. This patch
set serializes the measurement list in this format and restores it.

Up to now, the binary_runtime_measurements was defined as architecture
native format.  The assumption being that userspace could and would
handle any architecture conversions.  With the ability of carrying the
measurement list across kexec, possibly from one architecture to a
different one, the per boot architecture information is lost and with it
the ability of recalculating the template digest hash.  To resolve this
problem, without breaking the existing ABI, this patch set introduces
the boot command line option "ima_canonical_fmt", which is arbitrarily
defined as little endian.

The need for this boot command line option will be limited to the
existing version 1 format of the binary_runtime_measurements.
Subsequent formats will be defined as canonical format (eg. TPM 2.0
support for larger digests).

This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
hand-over for the next kernel" patch set. 

These patches can also be found in the next-kexec-restore branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Mimi

Andreas Steffen (1):
  ima: platform-independent hash value

Mimi Zohar (7):
  ima: on soft reboot, restore the measurement list
  ima: permit duplicate measurement list entries
  ima: maintain memory size needed for serializing the measurement list
  ima: serialize the binary_runtime_measurements
  ima: store the builtin/custom template definitions in a list
  ima: support restoring multiple template formats
  ima: define a canonical binary_runtime_measurements list format

Thiago Jung Bauermann (1):
  ima: on soft reboot, save the measurement list

 Documentation/kernel-parameters.txt       |   4 +
 include/linux/ima.h                       |  12 ++
 kernel/kexec_file.c                       |   4 +
 security/integrity/ima/Kconfig            |  12 ++
 security/integrity/ima/Makefile           |   1 +
 security/integrity/ima/ima.h              |  28 +++
 security/integrity/ima/ima_crypto.c       |   6 +-
 security/integrity/ima/ima_fs.c           |  30 +++-
 security/integrity/ima/ima_init.c         |   2 +
 security/integrity/ima/ima_kexec.c        | 201 +++++++++++++++++++++
 security/integrity/ima/ima_main.c         |   1 +
 security/integrity/ima/ima_queue.c        |  72 +++++++-
 security/integrity/ima/ima_template.c     | 289 ++++++++++++++++++++++++++++--
 security/integrity/ima/ima_template_lib.c |   6 +-
 14 files changed, 637 insertions(+), 31 deletions(-)
 create mode 100644 security/integrity/ima/ima_kexec.c

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
