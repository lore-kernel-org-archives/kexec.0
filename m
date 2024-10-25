Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAC5D0BB56
	for <kexec@archiver.kernel.org>; Fri, 25 Oct 2024 15:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8W9FJinAhOzhMxDmMk4QlZHe2QdhhjCW/xbWoyWrqtU=; b=ULUnwW33eh1p1H
	Eejn/zQlUmM8Vkv7Yjz/JU92ZO83zp/5vIdgxr282agTjfSyCLA4QBMIBxuLx1Lqsf9Tw74GoPQbu
	/J81G5cB2sIyLTy6QXNpE3uAx5ZGgYM9WCl7zklQFuczNyPnF3l/bXmPHFHcEEyAgiQuAPHjLQqcC
	71Or8JAQpxRyQ25u2EMK82au6yKi/kg+au7sfY872Bx+v+xbQe1LgQJ95+VWxJt1hO+MDr8h6tYYo
	KEIe5EIQZzdMwudtMr48QjhvxwBiAPXcLP+c7R8jnQygGZkxOSjHbdB/D4t+HPtWBb2yCa5pnlU9q
	MZqrKmNBkcX4KJes0zUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MLb-00000004GXw-0Ley;
	Fri, 25 Oct 2024 15:35:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4M02-00000004B8n-139t
	for kexec@lists.infradead.org;
	Fri, 25 Oct 2024 15:13:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE6UZtvB4UrwqxDxBvXj02Eqawd4qPQUjTyB3c978sA=;
	b=C0GH3MEkilMRvBMAFnW1Bh45TU0I/NqYsUGs4uYd/jvsTqaa8CRF3DrXtmWtQqjuSl8z/Z
	ezDLmv6iZ7I5FtHnmt33OlslhxlSNI7N8u1dApSgHxUB60OjHp+V7siWYLzZjXcUsyJQCg
	exR5FeJI54alCP9Nxrtxre+xhs6oTXg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-3cSc-QklMMuKHb2DIsw0Pg-1; Fri,
 25 Oct 2024 11:13:10 -0400
X-MC-Unique: 3cSc-QklMMuKHb2DIsw0Pg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A10BC1955D4A;
	Fri, 25 Oct 2024 15:13:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86CEF300018D;
	Fri, 25 Oct 2024 15:13:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 10/11] virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
Date: Fri, 25 Oct 2024 17:11:32 +0200
Message-ID: <20241025151134.1275575-11-david@redhat.com>
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
References: <20241025151134.1275575-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_081314_390379_9E38DCB7 
X-CRM114-Status: GOOD (  19.20  )
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

Let's implement the get_device_ram() vmcore callback, so
architectures that select NEED_PROC_VMCORE_NEED_DEVICE_RAM, like s390
soon, can include that memory in a crash dump.

Merge ranges, and process ranges that might contain a mixture of plugged
and unplugged, to reduce the total number of ranges.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/Kconfig      |  1 +
 drivers/virtio/virtio_mem.c | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 2eb747311bfd..60fdaf2c2c49 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -128,6 +128,7 @@ config VIRTIO_MEM
 	depends on MEMORY_HOTREMOVE
 	depends on CONTIG_ALLOC
 	depends on EXCLUSIVE_SYSTEM_RAM
+	select PROVIDE_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
 	help
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 73477d5b79cf..1ae1199a7617 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2728,6 +2728,91 @@ static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 	mutex_unlock(&vm->hotplug_mutex);
 	return is_ram;
 }
+
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+static int virtio_mem_vmcore_add_device_ram(struct virtio_mem *vm,
+		struct list_head *list, uint64_t start, uint64_t end)
+{
+	int rc;
+
+	rc = vmcore_alloc_add_mem_node(list, start, end - start);
+	if (rc)
+		dev_err(&vm->vdev->dev,
+			 "Error adding device RAM range: %d\n", rc);
+	return rc;
+}
+
+static int virtio_mem_vmcore_get_device_ram(struct vmcore_cb *cb,
+		struct list_head *list)
+{
+	struct virtio_mem *vm = container_of(cb, struct virtio_mem,
+					     vmcore_cb);
+	const uint64_t device_start = vm->addr;
+	const uint64_t device_end = vm->addr + vm->usable_region_size;
+	uint64_t chunk_size, cur_start, cur_end, plugged_range_start = 0;
+	LIST_HEAD(tmp_list);
+	int rc;
+
+	if (!vm->plugged_size)
+		return 0;
+
+	/* Process memory sections, unless the device block size is bigger. */
+	chunk_size = max_t(uint64_t, PFN_PHYS(PAGES_PER_SECTION),
+			   vm->device_block_size);
+
+	mutex_lock(&vm->hotplug_mutex);
+
+	/*
+	 * We process larger chunks and indicate the complete chunk if any
+	 * block in there is plugged. This reduces the number of pfn_is_ram()
+	 * callbacks and mimic what is effectively being done when the old
+	 * kernel would add complete memory sections/blocks to the elfcore hdr.
+	 */
+	cur_start = device_start;
+	for (cur_start = device_start; cur_start < device_end; cur_start = cur_end) {
+		cur_end = ALIGN_DOWN(cur_start + chunk_size, chunk_size);
+		cur_end = min_t(uint64_t, cur_end, device_end);
+
+		rc = virtio_mem_send_state_request(vm, cur_start,
+						   cur_end - cur_start);
+
+		if (rc < 0) {
+			dev_err(&vm->vdev->dev,
+				"Error querying block states: %d\n", rc);
+			goto out;
+		} else if (rc != VIRTIO_MEM_STATE_UNPLUGGED) {
+			/* Merge ranges with plugged memory. */
+			if (!plugged_range_start)
+				plugged_range_start = cur_start;
+			continue;
+		}
+
+		/* Flush any plugged range. */
+		if (plugged_range_start) {
+			rc = virtio_mem_vmcore_add_device_ram(vm, &tmp_list,
+							      plugged_range_start,
+							      cur_start);
+			if (rc)
+				goto out;
+			plugged_range_start = 0;
+		}
+	}
+
+	/* Flush any plugged range. */
+	if (plugged_range_start)
+		rc = virtio_mem_vmcore_add_device_ram(vm, &tmp_list,
+						      plugged_range_start,
+						      cur_start);
+out:
+	mutex_unlock(&vm->hotplug_mutex);
+	if (rc < 0) {
+		vmcore_free_mem_nodes(&tmp_list);
+		return rc;
+	}
+	list_splice_tail(&tmp_list, list);
+	return 0;
+}
+#endif /* CONFIG_PROC_VMCORE_DEVICE_RAM */
 #endif /* CONFIG_PROC_VMCORE */
 
 static int virtio_mem_init_kdump(struct virtio_mem *vm)
@@ -2737,6 +2822,9 @@ static int virtio_mem_init_kdump(struct virtio_mem *vm)
 #ifdef CONFIG_PROC_VMCORE
 	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
 	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+	vm->vmcore_cb.get_device_ram = virtio_mem_vmcore_get_device_ram;
+#endif /* CONFIG_PROC_VMCORE_DEVICE_RAM */
 	register_vmcore_cb(&vm->vmcore_cb);
 	return 0;
 #else /* CONFIG_PROC_VMCORE */
-- 
2.46.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
