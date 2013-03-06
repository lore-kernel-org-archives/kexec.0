Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UD9rA-0006Kn-8U
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 08:37:49 +0000
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 6 Mar 2013 14:04:46 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7FA8FE002D
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 14:08:50 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r268bXTK24838228
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 14:07:33 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r268baKE027058
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 19:37:36 +1100
Subject: [PATCH v2 0/4] kexec: Support for uImage RAMDISK
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Wed, 06 Mar 2013 14:07:35 +0530
Message-ID: <20130306083331.18627.82812.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: msm@freescale.com, bigeasy@linutronix.de, lethal@linux-sh.org, kexec@lists.infradead.org

The following series adds support and APIs for 
handling uImage formatted RAMDISK. The support for PPC
has been implemented.

Changes since V1:
  * Do not uncompress RAMDISK uImage (Pointed by Sebastian)
  * Introduce new APIs uImage_probe_kernel/uImage_probe_ramdisk to be
    used by the arch specific code.
  * Fix coding style related issues pointed by Sebastian.
  * Add a new patch for fixing payload length calculation and also
    fix a vulnerability where the image is manipulated.
    (catches only the file size related changes. When
     compiled with zlib, CRC check is enabled by
     default and the contents are verified.)

 TODO: Implement crc check in kexec, if ZLIB is not compiled in

---

Suzuki K. Poulose (4):
      kexec/uImage: Introduce uImage_probe_kernel
      kexec/uImage: Fix the payload length in uImage_load
      kexec/uImage: Recognize uImage RAM Disks
      ppc/uImage: Add support for RAM Disks


 include/kexec-uImage.h            |    2 ++
 kexec/arch/arm/kexec-uImage-arm.c |    2 +-
 kexec/arch/ppc/kexec-uImage-ppc.c |   29 +++++++++++++++++++++-
 kexec/arch/sh/kexec-uImage-sh.c   |    2 +-
 kexec/kexec-uImage.c              |   48 ++++++++++++++++++++++++++++++++++---
 5 files changed, 75 insertions(+), 8 deletions(-)

-- 
Suzuki


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
