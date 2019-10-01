Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.15.19])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFJjK-0008JM-Ko
 for kexec@lists.infradead.org; Tue, 01 Oct 2019 15:06:24 +0000
Date: Tue, 1 Oct 2019 17:06:05 +0200
From: Helge Deller <deller@gmx.de>
Subject: [PATCH]kexec-tools: Fix possible out-of-bounds access in ifdown
Message-ID: <20191001150605.GA25636@ls3530.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org
Cc: Sven Schnelle <svens@stackframe.org>

Fix a possible out-of-bounds access in function ifdown():

ifdown.c: In function 'ifdown':
ifdown.c:56:4: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
   56 |    strncpy(ifr.ifr_name, ifp->if_name, IFNAMSIZ);

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/kexec/ifdown.c b/kexec/ifdown.c
index 9679ad7..3ac19c1 100644
--- a/kexec/ifdown.c
+++ b/kexec/ifdown.c
@@ -53,7 +53,8 @@ int ifdown(void)
 			if (strchr(ifp->if_name, ':') != NULL)
 				continue;

-			strncpy(ifr.ifr_name, ifp->if_name, IFNAMSIZ);
+			strncpy(ifr.ifr_name, ifp->if_name, IFNAMSIZ-1);
+			ifr.ifr_name[IFNAMSIZ-1] = 0;
 			if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0) {
 				fprintf(stderr, "ifdown: shutdown ");
 				perror(ifp->if_name);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
