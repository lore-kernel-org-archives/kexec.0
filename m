Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ve4RM-0002Ip-Mi
 for kexec@lists.infradead.org; Wed, 06 Nov 2013 14:50:41 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 8/9] x86: check kexec relocation code fits in a page
Date: Wed, 6 Nov 2013 14:49:45 +0000
Message-ID: <1383749386-11891-9-git-send-email-david.vrabel@citrix.com>
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

The kexec relocation (control) code must fit in a single page so add a
link time check for this.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
 xen/arch/x86/xen.lds.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/xen/arch/x86/xen.lds.S b/xen/arch/x86/xen.lds.S
index 9600cdf..17db361 100644
--- a/xen/arch/x86/xen.lds.S
+++ b/xen/arch/x86/xen.lds.S
@@ -198,3 +198,5 @@ SECTIONS
   .stab.indexstr 0 : { *(.stab.indexstr) }
   .comment 0 : { *(.comment) }
 }
+
+ASSERT(kexec_reloc_size - kexec_reloc <= PAGE_SIZE, "kexec_reloc is too large")
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
