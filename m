Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZq0t-0007vy-Vx
 for kexec@lists.infradead.org; Wed, 17 Aug 2016 01:51:29 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v2 2/2] kexec: Consider crashk_low_res in
 sanity_check_segment_list()
Date: Wed, 17 Aug 2016 09:50:57 +0800
Message-Id: <1471398657-20237-2-git-send-email-xlpang@redhat.com>
In-Reply-To: <1471398657-20237-1-git-send-email-xlpang@redhat.com>
References: <1471398657-20237-1-git-send-email-xlpang@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, Xunlei Pang <xlpang@redhat.com>, ebiederm@xmission.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

We have crashk_res only in most cases, but sometimes we have
crashk_low_res.

For example, on 64-bit x86 systems, when "crashkernel=32M,high"
combined with "crashkernel=128M,low" is used, so some segments
may have the chance to be loaded into crashk_low_res area. We
can't fail it as a memory violation in these cases.

Thus, we add the case to regard the segment as valid if it is
within crashk_low_res.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 kernel/kexec_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 707d18e..9012a60 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -248,9 +248,14 @@ int sanity_check_segment_list(struct kimage *image)
 			mstart = image->segment[i].mem;
 			mend = mstart + image->segment[i].memsz - 1;
 			/* Ensure we are within the crash kernel limits */
-			if ((mstart < phys_to_boot_phys(crashk_res.start)) ||
-			    (mend > phys_to_boot_phys(crashk_res.end)))
-				return -EADDRNOTAVAIL;
+			if ((mstart >= phys_to_boot_phys(crashk_res.start)) &&
+			    (mend <= phys_to_boot_phys(crashk_res.end)))
+				continue;
+			if ((mstart >= phys_to_boot_phys(crashk_low_res.start)) &&
+			    (mend <= phys_to_boot_phys(crashk_low_res.end)))
+				continue;
+
+			return -EADDRNOTAVAIL;
 		}
 	}
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
