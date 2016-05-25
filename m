Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5Yfv-0006af-In
 for kexec@lists.infradead.org; Wed, 25 May 2016 13:16:40 +0000
Date: Wed, 25 May 2016 09:16:16 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] MAINTAINERS: Kdump maintainers update
Message-ID: <20160525131616.GB27291@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>

Hi,

I am proposing following updates to kdump maintainership. I have got
busy in other things and not getting time to spend on kdump. 

Removed Haren Myneni as he has not participated in kdump development for
a long time now.

Proposing adding the names of Dave and Baoquan as kdump maintainers as
they have been contributing to kdump for a long time now and they are in
a much better position to spend time on this than me.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c567a4..c030267 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6189,8 +6189,9 @@ F:	Documentation/kbuild/kconfig-language.txt
 F:	scripts/kconfig/
 
 KDUMP
+M:	Dave Young <dyoung@redhat.com>
+M:	Baoquan He <bhe@redhat.com>
 M:	Vivek Goyal <vgoyal@redhat.com>
-M:	Haren Myneni <hbabu@us.ibm.com>
 L:	kexec@lists.infradead.org
 W:	http://lse.sourceforge.net/kdump/
 S:	Maintained
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
