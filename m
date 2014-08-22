Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <cover.1408731991.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/5] kexec: minor fixups and enhancements
Date: Fri, 22 Aug 2014 18:39:47 +0000
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hi,

Here are a few minor fixups and enhancements for kexec support. 

Patch 3 and 4 that add preprocessor macros for the kimage list flags are
ones that I use in the arm64 kexec support I am working on, so it would
be nice for those to go in.

Please consider.

-Geoff
    
The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git for-kexec

for you to fetch changes up to dc3c63e69815e00dce5454bd50e2991e9ea33f64:

  powerpc/kexec: Use global IND_FLAGS macro (2014-08-22 11:15:18 -0700)

----------------------------------------------------------------
Geoff Levand (5):
      kexec: Fix make headers_check
      kexec: Simplify conditional
      kexec: Add bit definitions for kimage entry flags
      kexec: Add IND_FLAGS macro
      powerpc/kexec: Use global IND_FLAGS macro

 arch/powerpc/kernel/machine_kexec_64.c |  2 --
 include/linux/kexec.h                  | 20 ++++++++++++++++----
 include/uapi/linux/kexec.h             |  6 ------
 kernel/kexec.c                         | 17 ++++++++++-------
 4 files changed, 26 insertions(+), 19 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
