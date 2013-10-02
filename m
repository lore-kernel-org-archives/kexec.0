Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-Id: <cover.1380746425.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/6] kexec-tools fixes
MIME-Version: 1.0
Date: Wed, 02 Oct 2013 20:54:13 +0000
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hi Simon,

Here are a few generic kexec-tools fixups I have.  The last one, 'Update to
automake-1.11', is in preparation for the arm64 support I am working on, but I
don't think it a bad idea to update to newer config files regardless.

Please consider for merge.

-Geoff

The following changes since commit 86b8bf44d27579bc3c90be053f19df17253c69d7:

  kexec/ppc: Check for a uImage initrd with ELF kernel (2013-09-25 16:11:18 +0900)

are available in the git repository at:

  git.linaro.org:public_git/kexec-tools.git for-merge

for you to fetch changes up to 06b9eb7404516d8ec6a97068fef952dd0a27bd11:

  config: Update to automake-1.11 (2013-10-02 12:44:36 -0700)

Geoff Levand (6):
      kexec: Fix the -? option
      kexec: Remove unused -? option handling
      purgatory: Fix out-of-source build error
      kexec: Fix uninitialized build warning
      kexec: Fix return value build warnings
      config: Update to automake-1.11

 config/config.guess                   | 987 ++++++++++++++++++----------------
 config/config.sub                     | 424 +++++++++++----
 config/install-sh                     | 680 ++++++++++++++++-------
 kexec/arch/arm/kexec-zImage-arm.c     |   3 -
 kexec/arch/cris/kexec-elf-cris.c      |   3 -
 kexec/arch/i386/kexec-beoboot-x86.c   |   3 -
 kexec/arch/i386/kexec-bzImage.c       |   4 -
 kexec/arch/i386/kexec-elf-x86.c       |   3 -
 kexec/arch/i386/kexec-multiboot-x86.c |   3 -
 kexec/arch/i386/kexec-nbi.c           |   4 -
 kexec/arch/ia64/kexec-elf-ia64.c      |   3 -
 kexec/arch/mips/kexec-elf-mips.c      |   3 -
 kexec/arch/ppc/kexec-dol-ppc.c        |   3 -
 kexec/arch/ppc/kexec-elf-ppc.c        |   3 -
 kexec/arch/ppc/kexec-uImage-ppc.c     |   3 -
 kexec/arch/ppc64/kexec-elf-ppc64.c    |   3 -
 kexec/arch/s390/kexec-image.c         |   4 -
 kexec/arch/sh/kexec-elf-sh.c          |   3 -
 kexec/arch/sh/kexec-netbsd-sh.c       |   3 -
 kexec/arch/sh/kexec-sh.c              |   3 -
 kexec/arch/sh/kexec-zImage-sh.c       |   3 -
 kexec/arch/x86_64/kexec-bzImage64.c   |   4 -
 kexec/arch/x86_64/kexec-elf-x86_64.c  |   3 -
 kexec/fs2dt.c                         |  12 +-
 kexec/kexec-elf-rel.c                 |   2 +-
 kexec/kexec.h                         |   2 +-
 purgatory/Makefile                    |   1 +
 27 files changed, 1355 insertions(+), 817 deletions(-)

-- 
1.8.1.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
