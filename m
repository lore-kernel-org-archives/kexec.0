Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f49.google.com ([209.85.213.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PcFmU-0004js-SX
	for kexec@lists.infradead.org; Mon, 10 Jan 2011 11:19:23 +0000
Received: by ywf7 with SMTP id 7so8085156ywf.36
	for <kexec@lists.infradead.org>; Mon, 10 Jan 2011 03:19:21 -0800 (PST)
Date: Mon, 10 Jan 2011 09:19:15 -0200
From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: [PATCH] ifdown: really set down all active interfaces
Message-ID: <20110110111915.GA30397@libre.l.ngdn.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

We've got a bug report of random memory corruption when using kexec.
The test case to reproduce the problem sets up bonding between two
tg3 NICs and transmits some data just before calling kexec to boot
the new kernel. Around one in every one hundred boots would crash
early with different signatures.

We confirmed that the patch below resolves the problem. Please, could
you review and consider it for upstream inclusion?

Thanks,
Leonardo

Before executing the new kernel, kexec disables all network interfaces
to prevent problems like random memory corruption caused by in flight
DMAs.

The current algorithm uses the SIOCGIFCONF to enumerate all interfaces
before shutting them down. However, this ioctl returns only the interfaces
that have an IP address set. This means that in some setups, kexec may
skip interfaces that are up and running. A common example is in bonding,
where the enslaved interfaces are up but may not have an IP address
configured.

This patch replaces SIOCGIFCONF with if_nameindex() to enumerate all
network interfaces available, regardless of having an IP address set
or not.

Signed-off-by: Leonardo Chiquitto <lchiquitto@novell.com>

---
 kexec/ifdown.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

Index: kexec-tools/kexec/ifdown.c
===================================================================
--- kexec-tools.orig/kexec/ifdown.c
+++ kexec-tools/kexec/ifdown.c
@@ -19,8 +19,6 @@ char *v_ifdown = "@(#)ifdown.c  1.11  02
 #include <net/if.h>
 #include <netinet/in.h>
 
-#define MAX_IFS	64
-
 /*
  *	First, we find all shaper devices and down them. Then we
  *	down all real interfaces. This is because the comment in the
@@ -29,43 +27,45 @@ char *v_ifdown = "@(#)ifdown.c  1.11  02
  */
 int ifdown(void)
 {
-	struct ifreq ifr[MAX_IFS];
-	struct ifconf ifc;
-	int i, fd;
-	int numif;
-	int shaper;
+	struct if_nameindex *ifa, *ifp;
+	struct ifreq ifr;
+	int fd, shaper;
 
 	if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
 		fprintf(stderr, "ifdown: ");
 		perror("socket");
 		return -1;
 	}
-	ifc.ifc_len = sizeof(ifr);
-	ifc.ifc_req = ifr;
 
-	if (ioctl(fd, SIOCGIFCONF, &ifc) < 0) {
+	if ((ifa = if_nameindex()) == NULL) {
 		fprintf(stderr, "ifdown: ");
-		perror("SIOCGIFCONF");
-		close(fd);
+		perror("if_nameindex");
 		return -1;
 	}
-	numif = ifc.ifc_len / sizeof(struct ifreq);
 
 	for (shaper = 1; shaper >= 0; shaper--) {
-		for (i = 0; i < numif; i++) {
+		for (ifp = ifa; ifp->if_index; ifp++) {
 
-			if ((strncmp(ifr[i].ifr_name, "shaper", 6) == 0)
+			if ((strncmp(ifp->if_name, "shaper", 6) == 0)
 			    != shaper) continue;
-
-			if (strcmp(ifr[i].ifr_name, "lo") == 0)
+			if (strcmp(ifp->if_name, "lo") == 0)
 				continue;
-			if (strchr(ifr[i].ifr_name, ':') != NULL)
+			if (strchr(ifp->if_name, ':') != NULL)
 				continue;
-			ifr[i].ifr_flags &= ~(IFF_UP);
-			if (ioctl(fd, SIOCSIFFLAGS, &ifr[i]) < 0) {
+
+			strncpy(ifr.ifr_name, ifp->if_name, IFNAMSIZ);
+			if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0) {
 				fprintf(stderr, "ifdown: shutdown ");
-				perror(ifr[i].ifr_name);
+				perror(ifp->if_name);
+				return -1;
 			}
+			ifr.ifr_flags &= ~(IFF_UP);
+			if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0) {
+				fprintf(stderr, "ifdown: shutdown ");
+				perror(ifp->if_name);
+				return -1;
+			}
+
 		}
 	}
 	close(fd);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
