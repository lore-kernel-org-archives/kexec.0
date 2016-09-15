Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkUoc-0001jX-8u
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 11:26:51 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FBNLNf041074
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 07:26:28 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25fsbhc7dt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 07:26:28 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 21:26:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DC9B52CE8056
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:26:22 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FBQMF142336480
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:26:22 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FBQMM8007941
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:26:22 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 0/9] ima: carry the measurement list across kexec 
Date: Thu, 15 Sep 2016 07:26:02 -0400
Message-Id: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

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

Changelog v4:
- Fixed "spinlock bad magic" BUG - reported by Dmitry Vyukov
- Rebased on Thiago Bauermann's v5 patch set
- Removed the skip_checksum initialization  

Changelog v3:
- Cleaned up the code for calculating the requested kexec segment size
needed for the IMA measurement list, limiting the segment size to half
of the totalram_pages.
- Fixed kernel test robot reports as enumerated in the respective
patch changelog.

Changelog v2:
- Canonical measurement list support added
- Redefined the ima_kexec_hdr struct to use well defined sizes

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
 security/integrity/ima/ima_fs.c           |  30 ++-
 security/integrity/ima/ima_init.c         |   2 +
 security/integrity/ima/ima_kexec.c        | 209 +++++++++++++++++++++
 security/integrity/ima/ima_main.c         |   1 +
 security/integrity/ima/ima_queue.c        |  76 +++++++-
 security/integrity/ima/ima_template.c     | 293 ++++++++++++++++++++++++++++--
 security/integrity/ima/ima_template_lib.c |   7 +-
 14 files changed, 653 insertions(+), 32 deletions(-)
 create mode 100644 security/integrity/ima/ima_kexec.c

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
