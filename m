Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVjFX-000284-C0
 for kexec@lists.infradead.org; Sat, 08 Dec 2018 20:30:57 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB8KT3uq130911
 for <kexec@lists.infradead.org>; Sat, 8 Dec 2018 15:30:40 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p8m73s932-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Sat, 08 Dec 2018 15:30:40 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <nayna@linux.ibm.com>;
 Sat, 8 Dec 2018 20:30:38 -0000
From: Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 0/7] add platform/firmware keys support for kernel
 verification by IMA 
Date: Sun,  9 Dec 2018 01:56:58 +0530
Message-Id: <20181208202705.18673-1-nayna@linux.ibm.com>
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
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, vgoyal@redhat.com

On secure boot enabled systems, a verified kernel may need to kexec
additional kernels. For example, it may be used as a bootloader needing
to kexec a target kernel or it may need to kexec a crashdump kernel.
In such cases, it may want to verify the signature of the next kernel
image.

It is possible that the new kernel image is signed with third party keys
which are stored as platform or firmware keys in the 'db' variable. The
kernel, however, can not directly verify these platform keys, and an
administrator may therefore not want to trust them for arbitrary usage.
In order to differentiate platform keys from other keys and provide the
necessary separation of trust the kernel needs an additional keyring to
store platform/firmware keys.

The secure boot key database is expected to store the keys as EFI
Signature List(ESL). The patch set uses David Howells and Josh Boyer's
patch to access and parse the ESL to extract the certificates and load
them onto the platform keyring.

The last patch in this patch set adds support for IMA-appraisal to
verify the kexec'ed kernel image based on keys stored in the platform
keyring.

Changelog:

v0:
- The original patches loaded the certificates onto the secondary
  trusted keyring. This patch set defines a new keyring named
  ".platform" and adds the certificates to this new keyring  
- removed CONFIG EFI_SIGNATURE_LIST_PARSER and LOAD_UEFI_KEYS
- moved files from certs/ to security/integrity/platform_certs/

v2:
- fixed the checkpatch warnings and other formatting as suggested by
  Mimi Zohar 
- fixed coding style as suggested by Serge Hallyn in Patch "ima: Support
  platform keyring for kernel appraisal"

Dave Howells (2):
  efi: Add EFI signature data types
  efi: Add an EFI signature blob parser

Josh Boyer (2):
  efi: Import certificates from UEFI Secure Boot
  efi: Allow the "db" UEFI variable to be suppressed

Nayna Jain (3):
  integrity: Define a trusted platform keyring
  integrity: Load certs to the platform keyring
  ima: Support platform keyring for kernel appraisal

 include/linux/efi.h                                |  34 ++++
 security/integrity/Kconfig                         |  11 ++
 security/integrity/Makefile                        |   5 +
 security/integrity/digsig.c                        | 115 ++++++++----
 security/integrity/ima/ima_appraise.c              |  13 +-
 security/integrity/integrity.h                     |  23 ++-
 security/integrity/platform_certs/efi_parser.c     | 108 ++++++++++++
 security/integrity/platform_certs/load_uefi.c      | 196 +++++++++++++++++++++
 .../integrity/platform_certs/platform_keyring.c    |  62 +++++++
 9 files changed, 528 insertions(+), 39 deletions(-)
 create mode 100644 security/integrity/platform_certs/efi_parser.c
 create mode 100644 security/integrity/platform_certs/load_uefi.c
 create mode 100644 security/integrity/platform_certs/platform_keyring.c

-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
