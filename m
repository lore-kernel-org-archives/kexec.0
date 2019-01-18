Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQIt-000306-TF
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 09:19:09 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v4 0/2] let kexec_file_load use platform keyring to verify the
 kernel image
Date: Fri, 18 Jan 2019 17:17:31 +0800
Message-Id: <20190118091733.29940-1-kasong@redhat.com>
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

This patch series adds a .platform_trusted_keys in system_keyring as the
reference to .platform keyring in integrity subsystem, when platform
keyring is being initialized it will be updated. So other component could
use this keyring as well.

This patch series also let kexec_file_load use platform keyring as fall
back if it failed to verify the image against secondary keyring, make it
possible to load kernel signed by keys provides by firmware.

After this patch kexec_file_load will be able to verify a signed PE
bzImage using keys in platform keyring.

Tested in a VM with locally signed kernel with pesign and imported the
cert to EFI's MokList variable.

To test this patch series on latest kernel, you need to ensure this commit
is applied as there is an regression bug in sanity_check_segment_list():

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=993a110319a4a60aadbd02f6defdebe048f7773b

Update from V3:
  - Tweak and simplify commit message as suggested by Mimi Zohar

Update from V2:
  - Use IS_ENABLED in kexec_file_load to judge if platform_trusted_keys
    should be used for verifying image as suggested by Mimi Zohar

Update from V1:
  - Make platform_trusted_keys static, and update commit message as suggested
    by Mimi Zohar
  - Always check if platform keyring is initialized before use it

Kairui Song (2):
  integrity, KEYS: add a reference to platform keyring
  kexec, KEYS: Make use of platform keyring for signature verify

 arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
 certs/system_keyring.c            | 22 +++++++++++++++++++++-
 include/keys/system_keyring.h     |  5 +++++
 include/linux/verification.h      |  1 +
 security/integrity/digsig.c       |  6 ++++++
 5 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
