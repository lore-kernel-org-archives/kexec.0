Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a5Fjg-0002cY-Iz
 for kexec@lists.infradead.org; Sat, 05 Dec 2015 16:31:01 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH 0/4] ARM64: 3 Level page support
Date: Sat,  5 Dec 2015 21:59:59 +0530
Message-Id: <cover.1449332470.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, timur@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org, sgoel@codeaurora.org, dyoung@redhat.com

Hi Atsushi,

ARM64 was supporting only two level page support. These patches add support
for 3 level page table as well.

~Pratyush

Pratyush Anand (3):
  ARM64: Refactor code to support multiple page level
  arm64: Decide VA Bits on the basis of _stext symbol value
  arm64: Fix KVBASE

Sameer Goel (1):
  arm64: Fix for ARM64 3 level translation tables

 arch/arm64.c   | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 makedumpfile.h |  29 +++-------------
 2 files changed, 98 insertions(+), 34 deletions(-)

-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
