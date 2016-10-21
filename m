Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxhGj-0005CA-Gr
 for kexec@lists.infradead.org; Fri, 21 Oct 2016 21:22:26 +0000
Received: by mail-pf0-x244.google.com with SMTP id i85so9592731pfa.0
 for <kexec@lists.infradead.org>; Fri, 21 Oct 2016 14:22:05 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 1/2] Revert "kexec: Export kexec_in_progress to modules"
Date: Fri, 21 Oct 2016 14:21:55 -0700
Message-Id: <1477084916-26327-2-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1477084916-26327-1-git-send-email-f.fainelli@gmail.com>
References: <1477084916-26327-1-git-send-email-f.fainelli@gmail.com>
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, ebiederm@xmission.com, kexec@lists.infradead.org, davem@davemloft.net, linux-kernel@vger.kernel.org

This reverts commit 97dcaa0fcfd24daa9a36c212c1ad1d5a97759212. Based on
the review discussion with Eric, we will come up with a different fix
for the bcm_sf2 driver which does not make it rely on the
kexec_in_progress value.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 kernel/kexec_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 786ab85a5452..561675589511 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -59,7 +59,6 @@ size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
 
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
-EXPORT_SYMBOL_GPL(kexec_in_progress);
 
 
 /* Location of the reserved area for the crash kernel */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
