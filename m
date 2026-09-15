Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033F2C88E7F
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b40qx/awPhHY3pAbyOLJ2VCQCA5LCLOxDhc9IZ5eVmE=; b=Q5fD9/bylvG2/FtZ3XtAsER7pG
	vGAntWgzLc380O+TEHAI6OfHP2SMZEl7qITEbV8eXD5B15MBiUWgyiG3Ad2wXhNa+pSWe+zagX8Aj
	xWvcqMe638Ec/cjx4YpC5W5itROeSkfmQyQthlw/nGLE8O44YfBphBlGFpYpJc1IveGXRwL0zSLli
	8q4KF8rWoe26fuwfdSCkzzs3Xi5SVu9SCEbJFh0b61yO40VOHzA7u2YWRlRVjv4q7IQJajz+HnINL
	oC52K5UNd2Ji05N8cRFPZkZJk4GW2AhzEVl4lnDko/NLDTA8OH+SpDQ+9mEDxsbI6mMPVa8xAz06N
	0eFWFDOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RT4-00000006DPl-0Wf1;
	Tue, 15 Sep 2026 11:36:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RSA-00000006CUn-3tBJ;
	Tue, 15 Sep 2026 11:35:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95CAD419C6;
	Tue, 15 Sep 2026 11:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B05B1F000FF;
	Tue, 15 Sep 2026 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472158;
	bh=b40qx/awPhHY3pAbyOLJ2VCQCA5LCLOxDhc9IZ5eVmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DP7k+2oYU08PDg3XHLYvBCrc74ArLylq263ZQfhfXbqRVkmDQErCOMCCjVwzRS3TV
	 Y8Y1vhMdhR6mX1rzdLqcAsmQNs12N3hdTVztl8RasOi+yrl66kgtJvAm30HiqkZulb
	 BeZJvaqfhTtzMk7k9vathecezVTk0f7HRyPRJBoxuaSPdxLiJQMLNsbQRaHiPb0ydM
	 Bs/kN8QurhjzxM80pFu9PHszrjXHegO9Dn6LZ3pRg5VWri7b/KneuctABvHx5t6aU8
	 tZLPUAdsUnZNPuONncunNV8jM+2yLhEhGWV0UDmSzPkb9+7dEf6jOyeVoYut8bPYY5
	 6Fs/9ju++IrEA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:22 +0200
Subject: [PATCH RFC POC 36/50] nitro_enclaves: install the enclave
 descriptor when the ioctl returns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2840; i=brauner@kernel.org;
 h=from:subject:message-id; bh=06X+neGC1JeQjfUMZrHZWaV7oELS9OsBJ6UQD7zSi4E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Knzubs1YsvpZZZH3i8+78BV7P4vtpYxKWmuZeMPN
 v7juhcdO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi/YThf2b/jhn+T+e6nmr7
 eXfahbUvovRN4zg2RHUHPFri9vTunR6G/1ElTBHnt53eUxYocDY8j1mnxvWvpfIKaanlW1376r2
 dWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 33 ++++++++++++-------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index c91300a73f50..93c3f00f5443 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1589,7 +1589,7 @@ static const struct file_operations ne_enclave_fops = {
 static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_uid)
 {
 	struct ne_pci_dev_cmd_reply cmd_reply = {};
-	int enclave_fd = -1;
+	const struct fd_slot *enclave_fd = NULL;
 	struct file *enclave_file = NULL;
 	unsigned int i = 0;
 	struct ne_enclave *ne_enclave = NULL;
@@ -1647,9 +1647,9 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_ui
 		goto free_cpumask;
 	}
 
-	enclave_fd = get_unused_fd_flags(O_CLOEXEC);
-	if (enclave_fd < 0) {
-		rc = enclave_fd;
+	enclave_fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(enclave_fd)) {
+		rc = PTR_ERR(enclave_fd);
 
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "Error in getting unused fd [rc=%d]\n", rc);
@@ -1664,7 +1664,7 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_ui
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "Error in anon inode get file [rc=%d]\n", rc);
 
-		goto put_fd;
+		goto free_cpumask;
 	}
 
 	rc = ne_do_request(pdev, SLOT_ALLOC,
@@ -1688,27 +1688,20 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_ui
 
 	list_add(&ne_enclave->enclave_list_entry, &ne_pci_dev->enclaves_list);
 
-	if (copy_to_user(slot_uid, &ne_enclave->slot_uid, sizeof(ne_enclave->slot_uid))) {
-		/*
-		 * As we're holding the only reference to 'enclave_file', fput()
-		 * will call ne_enclave_release() which will do a proper cleanup
-		 * of all so far allocated resources, leaving only the unused fd
-		 * for us to free.
-		 */
-		fput(enclave_file);
-		put_unused_fd(enclave_fd);
+	fd_stage(enclave_fd, enclave_file);
 
+	/*
+	 * The failed ioctl drops the descriptor and with it the only reference
+	 * to 'enclave_file', so ne_enclave_release() does a proper cleanup of
+	 * all so far allocated resources.
+	 */
+	if (copy_to_user(slot_uid, &ne_enclave->slot_uid, sizeof(ne_enclave->slot_uid)))
 		return -EFAULT;
-	}
-
-	fd_install(enclave_fd, enclave_file);
 
-	return enclave_fd;
+	return fd_prepare_fd(enclave_fd);
 
 put_file:
 	fput(enclave_file);
-put_fd:
-	put_unused_fd(enclave_fd);
 free_cpumask:
 	free_cpumask_var(ne_enclave->vcpu_ids);
 	for (i = 0; i < ne_enclave->nr_parent_vm_cores; i++)

-- 
2.53.0


