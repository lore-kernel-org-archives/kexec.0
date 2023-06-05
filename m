Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D54C7EE2C
	for <kexec@archiver.kernel.org>; Mon,  5 Jun 2023 02:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fuce7QQc4Z4jjLaaL6EUi175FOFYHO1egTM8Ao7CX98=; b=5A0ZGGz/0OLipaMGaE2RRVs/HT
	oyiaOuDVSt37J39TaMkm8NC3QinwvrN/UgR1lhv1mWAJTn/+3uvKISjEvtWKd1STswVLXHNWK1oY2
	bJIwRgU6PCW8P5ojKhhoBlKEYqdYeMLMdpVtcaEq0x0uo67stS3HeVOSj0GZ1EMwz9JRMUUpywXp0
	aLthydhMgAbsj6HyJklWkQwFPO8hg4JmxsGJ5xGd5jwbs2CceA4/bhL+gyCB9jMNpYTdVi5ytp12B
	/Z5dnQGviIyRP1qMHlbINJIYTI5brcDyFXhGJFiHtQ/SJrAZ70S7xFdH4VDDJ/WvU0tATfBddwSAY
	MdiveUjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q60EE-00DoJW-2p;
	Mon, 05 Jun 2023 02:45:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q60E9-00DoHg-1E
	for kexec@lists.infradead.org;
	Mon, 05 Jun 2023 02:45:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685933148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlwl2BIm+peoNeTUMCVWAtru/pvJMSDZiLA+UJX1Gw4=;
	b=iHk98osV2bdPVx4NLLkEEzyBWsB7MMZ0mwrOffRs9XWM1QTZndccf4ywbGCbGeGiu40zgO
	l8dayEBHkiMgYHKKGXwqUV2JPxDdNdkri7WnFYKFjqIi5fGeZ4A8kRVC/0o/ovCDLgWe2T
	lRS05cQyPKyfjx+4nFadK3I0yWx7kAs=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-Efry9q0FMkC1Kl1oVvpogg-1; Sun, 04 Jun 2023 22:45:47 -0400
X-MC-Unique: Efry9q0FMkC1Kl1oVvpogg-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-bacfa4eefd2so7238900276.0
        for <kexec@lists.infradead.org>; Sun, 04 Jun 2023 19:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685933147; x=1688525147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlwl2BIm+peoNeTUMCVWAtru/pvJMSDZiLA+UJX1Gw4=;
        b=hXtdLBVT2xPqI61dEb8Nm7cHuBOAul2YMUceE0Px3Q09Mx19n5AusCzwrHDo4MNVxo
         aQ5l9Ec3Ch1+8FU34JW01bYsT0dXfY+CMG+yOq46JfRla4n9ZxOOqriijxkAhGbbghHj
         38BTK2uANQDTSw5XRdR6E6PvekjMVSj9OIhYlARZrwAHxxMUUVfWXUlLeAUq/UWh7xCZ
         7g6/Cf2qBHDFDeJv4f4xs//fAkIAxk96lfvzApgjEdSUS7FCPn/8fGvJQXf6lfdk6F6q
         XZz4ZXgjEIvAaRxVunh59LnuSZhl7Ve0zLpsVCbp2SLXyIIfPIhbSGNQuS8o/nrgqrN0
         +eeg==
X-Gm-Message-State: AC+VfDz4oJaef1gbvDTVQRYLg/NWrfEs9vqfGMo97dZOJgNbfaM92Eg3
	kQZahzn4AUIVsAJ/XINJyOff+AjImdrrY6XT4QEz88mRLIqad5AY93Q8SjJQangvmby+h59aEux
	J/80y7HLiSCPdTW1uume3
X-Received: by 2002:a25:ab61:0:b0:bab:af52:7482 with SMTP id u88-20020a25ab61000000b00babaf527482mr13858124ybi.34.1685933146709;
        Sun, 04 Jun 2023 19:45:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4DZ9gNAc8/q12HbeOnPdcqtS8oXkx5kC683CduHv/BdkqjLzn5lvuc+mzhWnbsn/xLeoCPUQ==
X-Received: by 2002:a25:ab61:0:b0:bab:af52:7482 with SMTP id u88-20020a25ab61000000b00babaf527482mr13858088ybi.34.1685933146392;
        Sun, 04 Jun 2023 19:45:46 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c20200b001a80ad9c599sm5257026pll.294.2023.06.04.19.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 19:45:45 -0700 (PDT)
Date: Mon, 5 Jun 2023 10:40:15 +0800
From: Coiby Xu <coxu@redhat.com>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, 
	akpm@linux-foundation.org, ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com, 
	jason.zeng@intel.com, lei.l.li@intel.com, steven.sistare@oracle.com, 
	fam.zheng@bytedance.com, mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: Re: [RFC v3 07/21] mm: PKRAM: introduce super block
Message-ID: <upgf3qmqxn7xzbnwwt6nxau4ugqkq7szdaheewzbok27xwch4e@6tdnhkqspok4>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <1682554137-13938-8-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1682554137-13938-8-git-send-email-anthony.yznaga@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_194549_496413_E66B5F71 
X-CRM114-Status: GOOD (  28.43  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Anthony,

On Wed, Apr 26, 2023 at 05:08:43PM -0700, Anthony Yznaga wrote:
>The PKRAM super block is the starting point for restoring preserved
>memory. By providing the super block to the new kernel at boot time,
>preserved memory can be reserved and made available to be restored.
>To point the kernel to the location of the super block, one passes
>its pfn via the 'pkram' boot param. 

I'm curious to ask how will the 'pkram' boot param be passed. It seems I
can't find the answer in this patch set.


> For that purpose, the pkram super
>block pfn is exported via /sys/kernel/pkram. If none is passed, any
>preserved memory will not be kept, and a new super block will be
>allocated.
>
>Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>---
> mm/pkram.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 100 insertions(+), 2 deletions(-)
>
>diff --git a/mm/pkram.c b/mm/pkram.c
>index da166cb6afb7..c66b2ae4d520 100644
>--- a/mm/pkram.c
>+++ b/mm/pkram.c
>@@ -5,15 +5,18 @@
> #include <linux/init.h>
> #include <linux/io.h>
> #include <linux/kernel.h>
>+#include <linux/kobject.h>
> #include <linux/list.h>
> #include <linux/mm.h>
> #include <linux/module.h>
> #include <linux/mutex.h>
> #include <linux/notifier.h>
>+#include <linux/pfn.h>
> #include <linux/pkram.h>
> #include <linux/reboot.h>
> #include <linux/sched.h>
> #include <linux/string.h>
>+#include <linux/sysfs.h>
> #include <linux/types.h>
>
> #include "internal.h"
>@@ -82,12 +85,38 @@ struct pkram_node {
> #define PKRAM_ACCMODE_MASK	3
>
> /*
>+ * The PKRAM super block contains data needed to restore the preserved memory
>+ * structure on boot. The pointer to it (pfn) should be passed via the 'pkram'
>+ * boot param if one wants to restore preserved data saved by the previously
>+ * executing kernel. For that purpose the kernel exports the pfn via
>+ * /sys/kernel/pkram. If none is passed, preserved memory if any will not be
>+ * preserved and a new clean page will be allocated for the super block.
>+ *
>+ * The structure occupies a memory page.
>+ */
>+struct pkram_super_block {
>+	__u64	node_pfn;		/* first element of the node list */
>+};
>+
>+static unsigned long pkram_sb_pfn __initdata;
>+static struct pkram_super_block *pkram_sb;
>+
>+/*
>  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
>  * connected through the lru field of the page struct.
>  */
> static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
> static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
>
>+/*
>+ * The PKRAM super block pfn, see above.
>+ */
>+static int __init parse_pkram_sb_pfn(char *arg)
>+{
>+	return kstrtoul(arg, 16, &pkram_sb_pfn);
>+}
>+early_param("pkram", parse_pkram_sb_pfn);
>+
> static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
> {
> 	return alloc_page(gfp_mask);
>@@ -270,6 +299,7 @@ static void pkram_stream_init(struct pkram_stream *ps,
>  * @gfp_mask specifies the memory allocation mask to be used when saving data.
>  *
>  * Error values:
>+ *	%ENODEV: PKRAM not available
>  *	%ENAMETOOLONG: name len >= PKRAM_NAME_MAX
>  *	%ENOMEM: insufficient memory available
>  *	%EEXIST: node with specified name already exists
>@@ -285,6 +315,9 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
> 	struct pkram_node *node;
> 	int err = 0;
>
>+	if (!pkram_sb)
>+		return -ENODEV;
>+
> 	if (strlen(name) >= PKRAM_NAME_MAX)
> 		return -ENAMETOOLONG;
>
>@@ -404,6 +437,7 @@ void pkram_discard_save(struct pkram_stream *ps)
>  * Returns 0 on success, -errno on failure.
>  *
>  * Error values:
>+ *	%ENODEV: PKRAM not available
>  *	%ENOENT: node with specified name does not exist
>  *	%EBUSY: save to required node has not finished yet
>  *
>@@ -414,6 +448,9 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
> 	struct pkram_node *node;
> 	int err = 0;
>
>+	if (!pkram_sb)
>+		return -ENODEV;
>+
> 	mutex_lock(&pkram_mutex);
> 	node = pkram_find_node(name);
> 	if (!node) {
>@@ -825,6 +862,13 @@ static void __pkram_reboot(void)
> 		node->node_pfn = node_pfn;
> 		node_pfn = page_to_pfn(page);
> 	}
>+
>+	/*
>+	 * Zero out pkram_sb completely since it may have been passed from
>+	 * the previous boot.
>+	 */
>+	memset(pkram_sb, 0, PAGE_SIZE);
>+	pkram_sb->node_pfn = node_pfn;
> }
>
> static int pkram_reboot(struct notifier_block *notifier,
>@@ -832,7 +876,8 @@ static int pkram_reboot(struct notifier_block *notifier,
> {
> 	if (val != SYS_RESTART)
> 		return NOTIFY_DONE;
>-	__pkram_reboot();
>+	if (pkram_sb)
>+		__pkram_reboot();
> 	return NOTIFY_OK;
> }
>
>@@ -840,9 +885,62 @@ static int pkram_reboot(struct notifier_block *notifier,
> 	.notifier_call = pkram_reboot,
> };
>
>+static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
>+		struct kobj_attribute *attr, char *buf)
>+{
>+	unsigned long pfn = pkram_sb ? PFN_DOWN(__pa(pkram_sb)) : 0;
>+
>+	return sprintf(buf, "%lx\n", pfn);
>+}
>+
>+static struct kobj_attribute pkram_sb_pfn_attr =
>+	__ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
>+
>+static struct attribute *pkram_attrs[] = {
>+	&pkram_sb_pfn_attr.attr,
>+	NULL,
>+};
>+
>+static struct attribute_group pkram_attr_group = {
>+	.attrs = pkram_attrs,
>+};
>+
>+/* returns non-zero on success */
>+static int __init pkram_init_sb(void)
>+{
>+	unsigned long pfn;
>+	struct pkram_node *node;
>+
>+	if (!pkram_sb) {
>+		struct page *page;
>+
>+		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
>+		if (!page) {
>+			pr_err("PKRAM: Failed to allocate super block\n");
>+			return 0;
>+		}
>+		pkram_sb = page_address(page);
>+	}
>+
>+	/*
>+	 * Build auxiliary doubly-linked list of nodes connected through
>+	 * page::lru for convenience sake.
>+	 */
>+	pfn = pkram_sb->node_pfn;
>+	while (pfn) {
>+		node = pfn_to_kaddr(pfn);
>+		pkram_insert_node(node);
>+		pfn = node->node_pfn;
>+	}
>+	return 1;
>+}
>+
> static int __init pkram_init(void)
> {
>-	register_reboot_notifier(&pkram_reboot_notifier);
>+	if (pkram_init_sb()) {
>+		register_reboot_notifier(&pkram_reboot_notifier);
>+		sysfs_update_group(kernel_kobj, &pkram_attr_group);
>+	}
> 	return 0;
> }
> module_init(pkram_init);
>-- 
>1.9.4
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
