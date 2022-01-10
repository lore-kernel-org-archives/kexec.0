From: Michal Suchanek <msuchanek@suse.de>
Date: Mon, 10 Jan 2022 14:49:52 +0100
Subject: [PATCH v4 0/6] KEXEC_SIG with appended signature
Message-ID: <cover.1641822505.git.msuchanek@suse.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello,

This is a refresh of the KEXEC_SIG series.

This adds KEXEC_SIG support on powerpc and deduplicates the code dealing
with appended signatures in the kernel.

powerpc supports IMA_KEXEC but that's an exception rather than the norm.
On the other hand, KEXEC_SIG is portable across platforms.

For distributions to have uniform security features across platforms one
option should be used on all platforms.

Thanks

Michal

Previous revision: https://lore.kernel.org/linuxppc-dev/cover.1637862358.git.msuchanek at suse.de/
Patched kernel tree: https://github.com/hramrach/kernel/tree/kexec_sig

Michal Suchanek (6):
  s390/kexec_file: Don't opencode appended signature check.
  powerpc/kexec_file: Add KEXEC_SIG support.
  kexec_file: Don't opencode appended signature verification.
  module: strip the signature marker in the verification function.
  module: Use key_being_used_for for log messages in
    verify_appended_signature
  module: Move duplicate mod_check_sig users code to mod_parse_sig

 arch/powerpc/Kconfig                     | 16 +++++++
 arch/powerpc/kexec/elf_64.c              | 12 +++++
 arch/s390/Kconfig                        |  2 +-
 arch/s390/kernel/machine_kexec_file.c    | 41 +----------------
 crypto/asymmetric_keys/asymmetric_type.c |  1 +
 include/linux/module_signature.h         |  1 +
 include/linux/verification.h             |  5 +++
 kernel/module-internal.h                 |  2 -
 kernel/module.c                          | 12 +++--
 kernel/module_signature.c                | 56 +++++++++++++++++++++++-
 kernel/module_signing.c                  | 34 +++++++-------
 security/integrity/ima/ima_modsig.c      | 22 ++--------
 12 files changed, 116 insertions(+), 88 deletions(-)

-- 
2.31.1


