Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ve4RN-0002Ip-FH
 for kexec@lists.infradead.org; Wed, 06 Nov 2013 14:50:42 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 9/9] MAINTAINERS: Add KEXEC maintainer
Date: Wed, 6 Nov 2013 14:49:46 +0000
Message-ID: <1383749386-11891-10-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
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
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <jbeulich@suse.com>

From: David Vrabel <david.vrabel@citrix.com>

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index adacac2..4aac28c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -197,6 +197,14 @@ X:	xen/drivers/passthrough/amd/
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
