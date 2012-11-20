Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TapPR-0007Uh-On
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 15:06:47 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:35419 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1634384Ab2KTPEy
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Tue, 20 Nov 2012 16:04:54 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 10/11] drivers/xen: Export vmcoreinfo through sysfs
Date: Tue, 20 Nov 2012 16:04:52 +0100
Message-Id: <1353423893-23125-11-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1353423893-23125-10-git-send-email-daniel.kiper@oracle.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-3-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-4-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-5-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-6-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-7-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-8-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-9-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-10-git-send-email-daniel.kiper@oracle.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, ebiederm@xmission.com, hpa@zytor.com, jbeulich@suse.com, konrad.wilk@oracle.com, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Export vmcoreinfo through sysfs.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 drivers/xen/sys-hypervisor.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 96453f8..6edc289 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -368,6 +368,41 @@ static void xen_properties_destroy(void)
 	sysfs_remove_group(hypervisor_kobj, &xen_properties_group);
 }
 
+#ifdef CONFIG_KEXEC
+static ssize_t vmcoreinfo_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	return sprintf(buffer, "%lx %lx\n", xen_vmcoreinfo_maddr,
+						xen_vmcoreinfo_max_size);
+}
+
+HYPERVISOR_ATTR_RO(vmcoreinfo);
+
+static int __init xen_vmcoreinfo_init(void)
+{
+	if (!xen_vmcoreinfo_max_size)
+		return 0;
+
+	return sysfs_create_file(hypervisor_kobj, &vmcoreinfo_attr.attr);
+}
+
+static void xen_vmcoreinfo_destroy(void)
+{
+	if (!xen_vmcoreinfo_max_size)
+		return;
+
+	sysfs_remove_file(hypervisor_kobj, &vmcoreinfo_attr.attr);
+}
+#else
+static int __init xen_vmcoreinfo_init(void)
+{
+	return 0;
+}
+
+static void xen_vmcoreinfo_destroy(void)
+{
+}
+#endif
+
 static int __init hyper_sysfs_init(void)
 {
 	int ret;
@@ -390,9 +425,14 @@ static int __init hyper_sysfs_init(void)
 	ret = xen_properties_init();
 	if (ret)
 		goto prop_out;
+	ret = xen_vmcoreinfo_init();
+	if (ret)
+		goto vmcoreinfo_out;
 
 	goto out;
 
+vmcoreinfo_out:
+	xen_properties_destroy();
 prop_out:
 	xen_sysfs_uuid_destroy();
 uuid_out:
@@ -407,12 +447,12 @@ out:
 
 static void __exit hyper_sysfs_exit(void)
 {
+	xen_vmcoreinfo_destroy();
 	xen_properties_destroy();
 	xen_compilation_destroy();
 	xen_sysfs_uuid_destroy();
 	xen_sysfs_version_destroy();
 	xen_sysfs_type_destroy();
-
 }
 module_init(hyper_sysfs_init);
 module_exit(hyper_sysfs_exit);
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
