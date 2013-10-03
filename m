Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-Id: <cover.1380830946.git.geoff@infradead.org>
In-Reply-To: <46065cda6087e6c9699f2e06f00d914235740c6c.1380746425.git.geoff@infradead.org>
References: <46065cda6087e6c9699f2e06f00d914235740c6c.1380746425.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/2] V2 kexec: Fix return value build warnings
MIME-Version: 1.0
Date: Thu, 03 Oct 2013 20:19:34 +0000
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

I split patch 5 into two as you suggested.  The first just adds the result
variable, and the second adds the error handling.  I also changed the printed
message as suggested.

Please consider.

-Geoff


The following changes since commit 83911ebb61053b3536a7be20793ec76405c23389:

  kexec: Fix off-by-one errors in locate_hole() (2013-10-03 10:15:23 +0900)

are available in the git repository at:

  git.linaro.org:public_git/kexec-tools.git for-merge

for you to fetch changes up to 08231e47adbe1031fb2e919cce3c7f75b3edfa55:

  kexec: Handle read errors in fs2dt setup (2013-10-03 13:03:12 -0700)

----------------------------------------------------------------
Geoff Levand (2):
      kexec: Fix return value build warnings
      kexec: Handle read errors in fs2dt setup

 kexec/fs2dt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
1.8.1.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
