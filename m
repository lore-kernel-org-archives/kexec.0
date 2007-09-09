Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUHoG-0006M9-9f
	for kexec@lists.infradead.org; Sun, 09 Sep 2007 04:06:37 -0400
Message-Id: <20070909080620.899626206@strauss.suse.de>
References: <20070909080620.009772613@strauss.suse.de>
Date: Sun, 09 Sep 2007 10:06:23 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 3/3] Add reset_devices to the recommended parameters
Content-Disposition: inline; filename=crashkernel-reset_devices
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

This patch adds the "reset_devices" option (that's used only by one device
driver for now) to the recommended list of command line parameters for kdump.

Meaning (Documentation/kernel-parameters.txt):
    reset_devices   [KNL] Force drivers to reset the underlying device
                    during initialization.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 Documentation/kdump/kdump.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -292,10 +292,10 @@ Following are the arch specific command 
 loading dump-capture kernel.
 
 For i386, x86_64 and ia64:
-	"1 irqpoll maxcpus=1"
+	"1 irqpoll maxcpus=1 reset_devices"
 
 For ppc64:
-	"1 maxcpus=1 noirqdistrib"
+	"1 maxcpus=1 noirqdistrib reset_devices"
 
 
 Notes on loading the dump-capture kernel:

-- 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
