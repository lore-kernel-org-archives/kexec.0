Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <cover.1424221020.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/2] kexec-tools minor fixes
MIME-Version: 1.0
Date: Wed, 18 Feb 2015 01:00:07 +0000
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
Cc: kexec@lists.infradead.org

Hi Simon,

Here are a two minor fixes for compiler warnings.  Please consider.

-Geoff

The following changes since commit 8e762175d295aad08a1cc62d6394e8285f225a40:

  kexec-tools 2.0.9 (2015-02-09 14:47:41 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git for-merge

for you to fetch changes up to 9343d4063f95f2129bd2ecb5a2d96c169b799904:

  kexec: Fix compiler format warning (2015-02-17 16:43:58 -0800)

----------------------------------------------------------------
Geoff Levand (2):
      kexec: Fix compiler ambiguous else warning
      kexec: Fix compiler format warning

 kexec/fs2dt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
