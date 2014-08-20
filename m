Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK3pK-00075J-3L
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:13:15 +0000
Received: from 157.15.12.109.rev.sfr.net ([109.12.15.157]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1XK3ox-0001qN-B3
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:12:51 +0000
From: Louis Bouchard <louis.bouchard@ubuntu.com>
Subject: [PATCH 8/9] Reformat of the kdump-tools file
Date: Wed, 20 Aug 2014 13:11:19 +0200
Message-Id: <1408533080-17838-9-git-send-email-louis.bouchard@ubuntu.com>
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
 debian/kdump-tools.default | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/debian/kdump-tools.default b/debian/kdump-tools.default
index c391f3c..3da5343 100644
--- a/debian/kdump-tools.default
+++ b/debian/kdump-tools.default
@@ -74,13 +74,15 @@ KDUMP_COREDIR="/var/crash"
 # HOSTTAG - Select if hostname of IP address will be used as a prefix to the
 #           timestamped directory when sending files to the remote server.
 #           'ip' is the default.
+# NFS -     Hostname and mount point of the NFS server configured to receive
+#           the crash dump. The syntax must be {HOSTNAME}:{MOUNTPOINT} 
+#           (e.g. remote:/var/crash)
 #
 # SSH="<user@server>"
 #
+# SSH_KEY="<path>"
+#
 # HOSTTAG="hostname|[ip]"
 # 
 # NFS="<nfs mount>"
 #
-# NFS4="<nfs mount>"
-#
-# SSH_KEY="<path>"
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
