Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <cover.1523465700.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/4] Fix ppc build warnings
MIME-Version: 1.0
Date: Wed, 11 Apr 2018 17:03:11 +0000
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Petitboot@lists.ozlabs.org

Hi Simon,

Here are a few fixups for warnings generated when building for 32 bit powerpc
with gcc-7.2.0.

-Geoff

The following changes since commit 090e8eceed79f3973fee600db3a355ce06530e40:

  kexec-tools 2.0.17-rc1 (2018-04-10 11:20:00 +0200)

are available in the git repository at:

  https://github.com/glevand/petitboot--kexec-tools.git for-merge-ppc-warn

for you to fetch changes up to a3c8c1d9fa406ff68484225fd9356ac82f8090b9:

  purgatory/ppc64: Fix uninitialized warning (2018-04-11 09:44:50 -0700)

----------------------------------------------------------------
Geoff Levand (4):
      kexec: Fix printf warning
      crashdump-ppc64: Fix integer truncation warning
      kexec-elf-rel-ppc64: Fix cast from pointer warning
      purgatory/ppc64: Fix uninitialized warning

 kexec/arch/ppc64/crashdump-ppc64.h     | 2 +-
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c | 2 +-
 kexec/kexec.c                          | 3 ++-
 purgatory/arch/ppc64/console-ppc64.c   | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.14.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
