Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJMKU-0001XA-Ve
	for kexec@lists.infradead.org; Thu, 27 Oct 2011 09:32:56 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9R9WkTB002887
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 09:32:46 GMT
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9R9Wkm62338862
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 10:32:46 +0100
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9R9WjUj015177
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 03:32:46 -0600
Message-ID: <1319707965.2830.1.camel@br98xy6r>
Subject: [PATCH] kdump: Add udev events for memory online/offline
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 27 Oct 2011 11:32:45 +0200
In-Reply-To: <20111027073058.GA2422@osiris.boeblingen.de.ibm.com>
References: <1319645292.3321.24.camel@br98xy6r>
	<20111026192449.GE355@redhat.com>
	<20111027073058.GA2422@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: akpm@linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently no udev events for memory hotplug "online" and "offline" are
generated:

# udevadm monitor
# echo offline > /sys/devices/system/memory/memory4/state
==> No event

When kdump is loaded, kexec detects the current memory configuration and
stores it in the pre-allocated ELF core header. Therefore, for kdump it is
necessary to reload the kdump kernel with kexec when the memory
configuration changes (e.g. for online/offline hotplug memory).

In order to do this automatically, udev rules should be used. This kernel
patch adds udev events for "online" and "offline". Together with this kernel
patch, the following udev rules for online/offline have to be added to
"/etc/udev/rules.d/98-kexec.rules":

SUBSYSTEM=="memory", ACTION=="online", PROGRAM="/etc/init.d/kdump restart"
SUBSYSTEM=="memory", ACTION=="offline", PROGRAM="/etc/init.d/kdump restart"

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 drivers/base/memory.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -310,11 +310,15 @@ store_mem_state(struct sys_device *dev,
 
 	mem = container_of(dev, struct memory_block, sysdev);
 
-	if (!strncmp(buf, "online", min((int)count, 6)))
+	if (!strncmp(buf, "online", min((int)count, 6))) {
 		ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
-	else if(!strncmp(buf, "offline", min((int)count, 7)))
+		if (ret == 0)
+			kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+	} else if (!strncmp(buf, "offline", min((int)count, 7))) {
 		ret = memory_block_change_state(mem, MEM_OFFLINE, MEM_ONLINE);
-
+		if (ret == 0)
+			kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
+	}
 	if (ret)
 		return ret;
 	return count;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
