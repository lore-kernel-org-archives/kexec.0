Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxOQu-0000gE-Ds
 for kexec@lists.infradead.org; Fri, 21 Oct 2016 01:15:41 +0000
Received: by mail-pf0-x242.google.com with SMTP id s8so6972839pfj.2
 for <kexec@lists.infradead.org>; Thu, 20 Oct 2016 18:15:19 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] kexec: Export kexec_in_progress to modules
Date: Thu, 20 Oct 2016 18:15:16 -0700
Message-Id: <1477012516-20470-1-git-send-email-f.fainelli@gmail.com>
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
To: netdev@vger.kernel.org
Cc: sfr@canb.auug.org.au, Florian Fainelli <f.fainelli@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, davem@davemloft.net

The bcm_sf2 driver uses kexec_in_progress to know whether it can power
down an integrated PHY during shutdown, and can be built as a module.
Other modules may be using this in the future, so export it.

Fixes: 2399d6143f85 ("net: dsa: bcm_sf2: Prevent GPHY shutdown for kexec'd kernels")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Eric, David, Stephen,

The offending commit is in David's net.git tree, so it would probably make
sense to route the fix through the same tree.

Thanks!

 kernel/kexec_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 561675589511..786ab85a5452 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -59,6 +59,7 @@ size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
 
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
+EXPORT_SYMBOL_GPL(kexec_in_progress);
 
 
 /* Location of the reserved area for the crash kernel */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
