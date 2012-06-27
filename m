Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sjo4g-0006R1-0y
 for kexec@lists.infradead.org; Wed, 27 Jun 2012 08:58:10 +0000
Message-ID: <4FEACA5E.4090009@cn.fujitsu.com>
Date: Wed, 27 Jun 2012 16:54:54 +0800
From: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v3 4/5] Sysfs: Export VMCSINFO via sysfs
References: <4FEAC945.50700@cn.fujitsu.com>
In-Reply-To: <4FEAC945.50700@cn.fujitsu.com>
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
To: Avi Kivity <avi@redhat.com>, mtosatti@redhat.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com, Greg KH <gregkh@linuxfoundation.org>

This patch export offsets of fields via /sys/devices/cpu/vmcs/.
Individual offsets are contained in subfiles named by the filed's
encoding, e.g.: /sys/devices/cpu/vmcs/0800

Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
---
 drivers/base/core.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 346be8b..dd05ee7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -26,6 +26,7 @@
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
+#include <asm/vmcsinfo.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -1038,6 +1039,11 @@ int device_add(struct device *dev)
 	error = dpm_sysfs_add(dev);
 	if (error)
 		goto DPMError;
+#if defined(CONFIG_KVM_INTEL) || defined(CONFIG_KVM_INTEL_MODULE)
+	error = vmcs_sysfs_add(dev);
+	if (error)
+		goto VMCSError;
+#endif
 	device_pm_add(dev);
 
 	/* Notify clients of device addition.  This call must come
@@ -1069,6 +1075,10 @@ int device_add(struct device *dev)
 done:
 	put_device(dev);
 	return error;
+#if defined(CONFIG_KVM_INTEL) || defined(CONFIG_KVM_INTEL_MODULE)
+ VMCSError:
+	dpm_sysfs_remove(dev);
+#endif
  DPMError:
 	bus_remove_device(dev);
  BusError:
@@ -1171,6 +1181,9 @@ void device_del(struct device *dev)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
 	device_pm_remove(dev);
+#if defined(CONFIG_KVM_INTEL) || defined(CONFIG_KVM_INTEL_MODULE)
+	vmcs_sysfs_remove(dev);
+#endif
 	dpm_sysfs_remove(dev);
 	if (parent)
 		klist_del(&dev->p->knode_parent);
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
