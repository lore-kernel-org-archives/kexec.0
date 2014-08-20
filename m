Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK3pK-00075L-3i
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:13:14 +0000
Received: from 157.15.12.109.rev.sfr.net ([109.12.15.157]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1XK3ox-0001qN-Lv
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:12:51 +0000
From: Louis Bouchard <louis.bouchard@ubuntu.com>
Subject: [PATCH 9/9] Add check to avoid SSH and NFS being set together
Date: Wed, 20 Aug 2014 13:11:20 +0200
Message-Id: <1408533080-17838-10-git-send-email-louis.bouchard@ubuntu.com>
In-Reply-To: <1408533080-17838-1-git-send-email-louis.bouchard@ubuntu.com>
References: <1408533080-17838-1-git-send-email-louis.bouchard@ubuntu.com>
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
To: kexec@lists.infradead.org

Signed-off-by: Louis Bouchard <louis.bouchard@ubuntu.com>
---
 debian/kdump-config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/debian/kdump-config b/debian/kdump-config
index 37932ac..9ff9892 100755
--- a/debian/kdump-config
+++ b/debian/kdump-config
@@ -152,6 +152,10 @@ function check_kdump_support()
 		log_failure_msg "no crashkernel= parameter in the kernel cmdline"
 		[ ! $DRY_RUN ] && exit 1;
 	fi
+        if [ -n "$NFS" ] && [ -n "$SSH" ];then
+		log_failure_msg "\$SSH and \$NFS cannot be define concurrently"
+		[ ! $DRY_RUN ] && exit 1;
+	fi
 }
 
 # check_relocatable: check if the given kernel config is relocatable
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
