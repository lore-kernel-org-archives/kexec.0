Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKCtw-0004sy-Az
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 19:50:04 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 9/9] MAINTAINERS: Add KEXEC maintainer
Date: Thu, 12 Sep 2013 20:49:07 +0100
Message-ID: <1379015347-21653-10-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1379015347-21653-1-git-send-email-david.vrabel@citrix.com>
References: <1379015347-21653-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
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
To: xen-devel@lists.xen.org
Cc: kexec@lists.infradead.org, Daniel Kiper <daniel.kiper@oracle.com>, Keir Fraser <keir@xen.org>, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <jbeulich@suse.com>

From: David Vrabel <david.vrabel@citrix.com>

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 843f9e3..0082792 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -190,6 +190,14 @@ X:	xen/drivers/passthrough/amd/
 X:	xen/drivers/passthrough/vtd/
 F:	xen/include/xen/iommu.h
 
+KEXEC
+M:      David Vrabel <david.vrabel@citrix.com>
+S:      Supported
+F:      xen/common/{kexec,kimage}.c
+F:      xen/include/{kexec,kimage}.h
+F:      xen/arch/x86/machine_kexec.c
+F:      xen/arch/x86/x86_64/kexec_reloc.S
+
 LINUX (PV_OPS)
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 S:	Supported
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
