Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK3pK-00075F-3P
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:13:15 +0000
Received: from 157.15.12.109.rev.sfr.net ([109.12.15.157]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1XK3ow-0001qN-9R
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:12:50 +0000
From: Louis Bouchard <louis.bouchard@ubuntu.com>
Subject: [PATCH 5/9] Add remote dump information to kdump-config show
Date: Wed, 20 Aug 2014 13:11:16 +0200
Message-Id: <1408533080-17838-6-git-send-email-louis.bouchard@ubuntu.com>
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
 debian/kdump-config | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/debian/kdump-config b/debian/kdump-config
index d97de02..5913478 100755
--- a/debian/kdump-config
+++ b/debian/kdump-config
@@ -84,6 +84,15 @@ function kdump_show()
 	echo "KDUMP_SYSCTL:     $KDUMP_SYSCTL"
 	echo "KDUMP_COREDIR:    $KDUMP_COREDIR"
 	echo "crashkernel addr: $IOMEM_ADDR"
+	if [ -z $SSH ];then
+		echo "SSH:              local"
+	else
+		echo "SSH:              $SSH"
+	fi
+	HOSTTAG="${HOSTTAG:=ip}"
+	echo "HOSTTAG:          $HOSTTAG"
+	SSH_KEY="${SSH_KEY:=/root/.ssh/kdump_id_rsa}"
+	echo "SSH_KEY:          $SSH_KEY"
 	if [ -e $sys_kexec_crash -a `cat $sys_kexec_crash` -eq 1 ] ; then
 		echo "current state:    ready to kdump";
 	else
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
