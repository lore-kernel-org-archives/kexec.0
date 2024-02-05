Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF3CC48295
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ha4fRV4+oP3Rhdp7qmZTPR6tZnR8e38hMwe49KlDuxs=; b=16Nbh6ufbdk6/U
	aVeVR/ALvgPHxU5oo3gba7p780JLISiJcO7Ihw7ecqWvSVDlAL4w63mMvINDKq7X8mTEc88bHGA6r
	as6X1RVoszcRyvSBCZvk0NfoBtJjiOCimp3UipGA26PMHJXkzFmv87tscG2jdmbLs8voIAYQOf7jp
	S2vWuwQygKrQrKB0WjxTHVPyXx9wIlyaElGYNLp2U+ESc5KmaugPL6p0mCKLUTUbjOh/LsbSC0JCi
	TMpUxQhI06BMFrPdE0fbAn/lPYbpeiGWsdxZd8rSXPv+gYxWCQSYO4y2roaOOri9at5YT5P6faJkL
	E7Kzg0OkNnOSZapi/r8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxiy-0000000372Q-3pr0;
	Mon, 05 Feb 2024 12:05:20 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxiw-00000003706-0B7s
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134718; x=1738670718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mVhmItHN9qmSrpLWsRnSDOh51VJYGjIwmSMhmIPWHpo=;
  b=Tpwt34uSXBgwAGElG4iyGBSI7R7ggTDH+cfr4mhjI0GD/mOp6gbtQXG0
   hggpy9hjb2RuMXM19PK8q7Tp0zpAejC0iXvq5+zqs5RFa/imrr3HcSIPO
   BCrkuBTFNwFzIRO5ZWCexm4I+x5kaJiwB0zuOoNfWapjhw0TU27MgLz1Z
   A=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="271102836"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:05:14 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:18332]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id 430958cf-6b4e-40ab-be7a-e53a50074ea7; Mon, 5 Feb 2024 12:05:13 +0000 (UTC)
X-Farcaster-Flow-ID: 430958cf-6b4e-40ab-be7a-e53a50074ea7
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:05:13 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:06 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	<kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Alexander Graf <graf@amazon.com>, David Woodhouse
	<dwmw@amazon.co.uk>, "Jan H . Schoenherr" <jschoenh@amazon.de>, Usama Arif
	<usama.arif@bytedance.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	<madvenka@linux.microsoft.com>, <steven.sistare@oracle.com>,
	<yuleixzhang@tencent.com>
Subject: [RFC 13/18] vfio: add ioctl to define persistent pgtables on container
Date: Mon, 5 Feb 2024 12:01:58 +0000
Message-ID: <20240205120203.60312-14-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040518_182888_4D72973F 
X-CRM114-Status: GOOD (  26.60  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The previous commits added a file type in pkernfs for IOMMU persistent
page tables. Now support actually setting persistent page tables on an
IOMMU domain. This is done via a VFIO ioctl on a VFIO container.

Userspace needs to create and open a IOMMU persistent page tables file
and then supply that fd to the new VFIO_CONTAINER_SET_PERSISTENT_PGTABLES
ioctl. That ioctl sets the supplied struct file on the
struct vfio_container. Later when the IOMMU domain is allocated by VFIO,
VFIO  will check to see if the persistent pagetables have been defined
and if they have will use the iommu_domain_alloc_persistent API which
was introduced in the previous commit to pass the struct file down to
the IOMMU which will actually use it for page tables.

After kexec userspace needs to open the same IOMMU page table file and
set it again via the same ioctl so that the IOMMU continues to use the
same memory region for its page tables for that domain.
---
 drivers/vfio/container.c        | 27 +++++++++++++++++++++++++++
 drivers/vfio/vfio.h             |  2 ++
 drivers/vfio/vfio_iommu_type1.c | 27 +++++++++++++++++++++++++--
 include/uapi/linux/vfio.h       |  9 +++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
index d53d08f16973..b60fcbf7bad0 100644
--- a/drivers/vfio/container.c
+++ b/drivers/vfio/container.c
@@ -11,6 +11,7 @@
 #include <linux/iommu.h>
 #include <linux/miscdevice.h>
 #include <linux/vfio.h>
+#include <linux/pkernfs.h>
 #include <uapi/linux/vfio.h>
 
 #include "vfio.h"
@@ -21,6 +22,7 @@ struct vfio_container {
 	struct rw_semaphore		group_lock;
 	struct vfio_iommu_driver	*iommu_driver;
 	void				*iommu_data;
+	struct file			*persistent_pgtables;
 	bool				noiommu;
 };
 
@@ -306,6 +308,8 @@ static long vfio_ioctl_set_iommu(struct vfio_container *container,
 			continue;
 		}
 
+		driver->ops->set_persistent_pgtables(data, container->persistent_pgtables);
+
 		ret = __vfio_container_attach_groups(container, driver, data);
 		if (ret) {
 			driver->ops->release(data);
@@ -324,6 +328,26 @@ static long vfio_ioctl_set_iommu(struct vfio_container *container,
 	return ret;
 }
 
+static int vfio_ioctl_set_persistent_pgtables(struct vfio_container *container,
+		unsigned long arg)
+{
+	struct vfio_set_persistent_pgtables set_ppts;
+	struct file *ppts;
+
+	if (copy_from_user(&set_ppts, (void __user *)arg, sizeof(set_ppts)))
+		return -EFAULT;
+
+	ppts = fget(set_ppts.persistent_pgtables_fd);
+	if (!ppts)
+		return -EBADF;
+	if (!pkernfs_is_iommu_domain_pgtables(ppts)) {
+		fput(ppts);
+		return -EBADF;
+	}
+	container->persistent_pgtables = ppts;
+	return 0;
+}
+
 static long vfio_fops_unl_ioctl(struct file *filep,
 				unsigned int cmd, unsigned long arg)
 {
@@ -345,6 +369,9 @@ static long vfio_fops_unl_ioctl(struct file *filep,
 	case VFIO_SET_IOMMU:
 		ret = vfio_ioctl_set_iommu(container, arg);
 		break;
+	case VFIO_CONTAINER_SET_PERSISTENT_PGTABLES:
+		ret = vfio_ioctl_set_persistent_pgtables(container, arg);
+		break;
 	default:
 		driver = container->iommu_driver;
 		data = container->iommu_data;
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 307e3f29b527..6fa301bf6474 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -226,6 +226,8 @@ struct vfio_iommu_driver_ops {
 				  void *data, size_t count, bool write);
 	struct iommu_domain *(*group_iommu_domain)(void *iommu_data,
 						   struct iommu_group *group);
+	int		(*set_persistent_pgtables)(void *iommu_data,
+						   struct file *ppts);
 };
 
 struct vfio_iommu_driver {
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index eacd6ec04de5..b36edfc5c9ef 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -75,6 +75,7 @@ struct vfio_iommu {
 	bool			nesting;
 	bool			dirty_page_tracking;
 	struct list_head	emulated_iommu_groups;
+	struct file		*persistent_pgtables;
 };
 
 struct vfio_domain {
@@ -2143,9 +2144,14 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
 
 static int vfio_iommu_domain_alloc(struct device *dev, void *data)
 {
+	/* data is an in pointer to PPTs, and an out to the new domain. */
+	struct file *ppts = *(struct file **) data;
 	struct iommu_domain **domain = data;
 
-	*domain = iommu_domain_alloc(dev->bus);
+	if (ppts)
+		*domain = iommu_domain_alloc_persistent(dev->bus, ppts);
+	else
+		*domain = iommu_domain_alloc(dev->bus);
 	return 1; /* Don't iterate */
 }
 
@@ -2156,6 +2162,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	struct vfio_iommu_group *group;
 	struct vfio_domain *domain, *d;
 	bool resv_msi;
+	/* In/out ptr to iommu_domain_alloc. */
+	void *domain_alloc_data;
 	phys_addr_t resv_msi_base = 0;
 	struct iommu_domain_geometry *geo;
 	LIST_HEAD(iova_copy);
@@ -2203,8 +2211,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	 * want to iterate beyond the first device (if any).
 	 */
 	ret = -EIO;
-	iommu_group_for_each_dev(iommu_group, &domain->domain,
+	/* Smuggle the PPTs in the data field; it will be clobbered with the new domain */
+	domain_alloc_data = iommu->persistent_pgtables;
+	iommu_group_for_each_dev(iommu_group, &domain_alloc_data,
 				 vfio_iommu_domain_alloc);
+	domain->domain = domain_alloc_data;
+
 	if (!domain->domain)
 		goto out_free_domain;
 
@@ -3165,6 +3177,16 @@ vfio_iommu_type1_group_iommu_domain(void *iommu_data,
 	return domain;
 }
 
+int vfio_iommu_type1_set_persistent_pgtables(void *iommu_data,
+				    struct file *ppts)
+{
+
+	struct vfio_iommu *iommu = iommu_data;
+
+	iommu->persistent_pgtables = ppts;
+	return 0;
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -3179,6 +3201,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.unregister_device	= vfio_iommu_type1_unregister_device,
 	.dma_rw			= vfio_iommu_type1_dma_rw,
 	.group_iommu_domain	= vfio_iommu_type1_group_iommu_domain,
+	.set_persistent_pgtables = vfio_iommu_type1_set_persistent_pgtables,
 };
 
 static int __init vfio_iommu_type1_init(void)
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index afc1369216d9..fa9676bb4b26 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1797,6 +1797,15 @@ struct vfio_iommu_spapr_tce_remove {
 };
 #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+struct vfio_set_persistent_pgtables {
+	/*
+	 * File descriptor for a pkernfs IOMMU pgtables
+	 * file to be used for persistence.
+	 */
+	__u32	persistent_pgtables_fd;
+};
+#define VFIO_CONTAINER_SET_PERSISTENT_PGTABLES	_IO(VFIO_TYPE, VFIO_BASE + 21)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
