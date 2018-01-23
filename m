Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ee3zi-00037V-5l
 for kexec@lists.infradead.org; Tue, 23 Jan 2018 19:12:31 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v2 0/2] kexec-tools: Tweak run-time handling of libxenctrl.so
Date: Tue, 23 Jan 2018 13:12:49 -0600
Message-Id: <1516734771-14795-1-git-send-email-eric.devolder@oracle.com>
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
To: kexec@lists.infradead.org, horms@verge.net.au, andrew.cooper3@citrix.com
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, konrad.wilk@oracle.com

This patch is a follow-on to commit 43d3932e "kexec-tools: Perform
run-time linking of libxenctrl.so". This patch addresses feedback
from Daniel Kiper concerning the lack of a dlclose() and the desire
to make xc_dlhandle static, rather than extern.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
v1: 23jan2018
 - Implemented feedback from Daniel Kiper

v2: 23jan2018
 - Implemented feedback from Daniel Kiper
 - Broke patch into two

Eric DeVolder (2):
  kexec-tools: Call dlclose() from within __xc_interface_close()
  kexec-tools: Make xc_dlhandle static

 kexec/kexec-xen.c | 10 +++++++++-
 kexec/kexec-xen.h |  9 ++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
