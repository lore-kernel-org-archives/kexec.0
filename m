Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghH2L-00022I-Rm
 for kexec@lists.infradead.org; Wed, 09 Jan 2019 16:49:03 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 0/2] let kexec_file_load use platform keyring to verify
 the kernel image
Date: Thu, 10 Jan 2019 00:48:22 +0800
Message-Id: <20190109164824.19708-1-kasong@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: jwboyer@fedoraproject.org, Kairui Song <kasong@redhat.com>, ebiggers@google.com, dyoung@redhat.com, nayna@linux.ibm.com, kexec@lists.infradead.org, jmorris@namei.org, zohar@linux.ibm.com, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

Hi,

This is a different approach for the previous patch:
[RFC PATCH 0/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
make kexec_file_load be able to verify the kernel image against keys
provided by platform or firmware.

This patch adds a .platform_trusted_keys in system_keyring as the reference
to .platform keyring in integrity subsystem, when platform keyring is
being initialized it will be updated.

Another thing on my mind is that now kexec_file_load will still relay on
CONFIG_INTEGRITY_PLATFORM_KEYRING and all its dependencies to be enabled
to be able to verify the image against firmware keys. I'm thinking about
to have something like CONFIG_PLATFORM_KEYRING and make the .platform
keyring could be enabled for a more wider usage. Not sure if it's a good
idea though.

Tested in a VM with locally signed kernel with pesign and imported the
cert to EFI's MokList variable.

Kairui Song (2):
  integrity, KEYS: add a reference to platform keyring
  kexec, KEYS: Make use of platform keyring for signature verify

 arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
 certs/system_keyring.c            | 10 +++++++++-
 include/keys/system_keyring.h     |  5 +++++
 include/linux/verification.h      |  1 +
 security/integrity/digsig.c       |  4 ++++
 5 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
