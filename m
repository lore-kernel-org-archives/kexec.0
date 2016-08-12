Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bYDQL-0006eG-Od
 for kexec@lists.infradead.org; Fri, 12 Aug 2016 14:27:02 +0000
Received: by mail-pf0-x241.google.com with SMTP id h186so1628665pfg.2
 for <kexec@lists.infradead.org>; Fri, 12 Aug 2016 07:26:41 -0700 (PDT)
From: Ronit Halder <ronit.crj@gmail.com>
Subject: [RFC 3/4] Adding a new kernel configuration to enable the feature
Date: Fri, 12 Aug 2016 19:55:50 +0530
Message-Id: <20160812142550.6231-1-ronit.crj@gmail.com>
In-Reply-To: <20160812141838.5973-1-ronit.crj@gmail.com>
References: <20160812141838.5973-1-ronit.crj@gmail.com>
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
To: linux-kernel@vger.kernel.org
Cc: vdavydov@parallels.com, jack@suse.cz, linux-mm@kvack.org, krzysiek@podlesie.net, mnfhuang@gmail.com, hpa@zytor.com, Ronit Halder <ronit.crj@gmail.com>, tglx@linutronix.de, aarcange@redhat.com, bhe@redhat.com, mingo@redhat.com, msalter@redhat.com, bp@suse.de, dyoung@redhat.com, vgoyal@redhat.com, jroedel@suse.de, mchehab@osg.samsung.com, dan.j.williams@intel.com, kexec@lists.infradead.org, ebiederm@xmission.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com

Kernel configuration option added to enable run time memory reservation
feature for kexec.

Signed-off-by: Ronit Halder <ronit.crj@gmail.com>

---
 mm/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 97a4e06..8b1533d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -668,3 +668,9 @@ config ZONE_DEVICE
 
 config FRAME_VECTOR
 	bool
+config KEXEC_CMA
+	bool "Use CMA for Kexec crash kernel"
+	depends on CMA
+	help
+	  This configuration option is to use CMA for Kexec.
+	  CMA helps us to allocate memory for crash kernel at runtime.
\ No newline at end of file
-- 
2.9.0.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
