Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKCtw-0004u2-NV
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 19:50:06 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 8/9] x86: check kexec relocation code fits in a page
Date: Thu, 12 Sep 2013 20:49:06 +0100
Message-ID: <1379015347-21653-9-git-send-email-david.vrabel@citrix.com>
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

The kexec relocation (control) code must fit in a single page so add a
link time check for this.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 xen/arch/x86/xen.lds.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/xen/arch/x86/xen.lds.S b/xen/arch/x86/xen.lds.S
index 9600cdf..078bac6 100644
--- a/xen/arch/x86/xen.lds.S
+++ b/xen/arch/x86/xen.lds.S
@@ -198,3 +198,5 @@ SECTIONS
   .stab.indexstr 0 : { *(.stab.indexstr) }
   .comment 0 : { *(.comment) }
 }
+
+ASSERT(__kexec_reloc_size <= PAGE_SIZE, "kexec control code is too large")
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
