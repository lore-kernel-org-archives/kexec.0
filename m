Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <cover.1426719370.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/4] Minor purgatory updates
Date: Wed, 18 Mar 2015 23:04:03 +0000
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hi Simon,

Here are a few minor updates for purgatory.  I think the
no-zero-initialized-in-bss flag and the printf type checking should be
considered seriously.  The symbol and map files less important, but I found
them useful in figuring out problems with purgatory.

-Geoff

The following changes since commit 236e30b2b4dcb3e78c5f5219b66d90c7e9c464fd:

  kexec: iomem: fix callbacks params for sh and x86 archs (2015-02-25 13:41:32 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git for-merge

for you to fetch changes up to 6859689cd7561950eda3a0fef52a2eedd22c14fb:

  purgatory: Add printf type checking (2015-03-18 15:47:25 -0700)

----------------------------------------------------------------
Geoff Levand (4):
      purgatory: Add no-zero-initialized-in-bss flag
      purgatory: Generate symbol file
      purgatory: Generate map file
      purgatory: Add printf type checking

 purgatory/Makefile            | 12 +++++++-----
 purgatory/include/purgatory.h |  5 +++--
 2 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
