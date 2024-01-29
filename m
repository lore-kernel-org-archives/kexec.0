Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05927C47DDB
	for <kexec@archiver.kernel.org>; Mon, 29 Jan 2024 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GpbskaDsIVarkYUmzw9LuVj7mQvyXIy6MNMQgNpOSLU=; b=sjFQoD9M8Bckoq
	FcbtXGSNPlB2xjHDU3qiWcS0YPfXE0Zon9aUz+mkIctHFwLZ7mGHT/YdFhf6O2GG0vFkT0AANZXJ5
	uLjXdocrFA8AXSafMqht1VHEaf+ozu+tAxGrwgTuQilZRGFvR2td23Opr+KWthOMOyqulMyK9RSbk
	+UkKIFD854pupaPTObQOdJgVYIgmL2H3aO3Ldp2mGG7Vds0BvaMYFiVwGVm4/LTIp1hzNNkMWwfqb
	VIArJi2FcFByxjIzvMlD1P/Z3KuTE73nyWyKSbcSzjJwRK4wliRgJTgnBlLWufOC0viUef88suIkM
	EfTbWMY3tDJqoEUm1OLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUS2O-0000000Cwc7-2CiC;
	Mon, 29 Jan 2024 13:51:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUS2F-0000000CwWU-3c4S
	for kexec@lists.infradead.org;
	Mon, 29 Jan 2024 13:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706536249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLP3YBtiGz95VYsxBR+21UP0cxSRcXeV1OGJ7bAOlDk=;
	b=AqItaqaqsQ2ZgkdTuici1i72/nWUqHSc9eM8HDUUCJifGnb1ZJqSdPtoc6bhjWlt8/eIP8
	duMjiZ2LKFkvBtCRth4gw23GbRvAfIv5aG3Kjo/beZ5ArS65miRTJ7+yQAAmqSWoC64uG1
	Z/ToJrK7aQPGTvM7C+E/mvGG5+80Wow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-Rx5uj1wdM5eXqYAKo1NPvw-1; Mon, 29 Jan 2024 08:50:45 -0500
X-MC-Unique: Rx5uj1wdM5eXqYAKo1NPvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D07AD1065223;
	Mon, 29 Jan 2024 13:50:44 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0203B488;
	Mon, 29 Jan 2024 13:50:40 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	nathan@kernel.org,
	mhklinux@outlook.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next 2/3] crash: fix building error in generic codes
Date: Mon, 29 Jan 2024 21:50:32 +0800
Message-ID: <20240129135033.157195-2-bhe@redhat.com>
In-Reply-To: <20240129135033.157195-1-bhe@redhat.com>
References: <20240129135033.157195-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_055052_086194_2BA054C1 
X-CRM114-Status: GOOD (  10.06  )
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

Nathan reported some building errors on arm64 as below:

==========
$ curl -LSso .config https://github.com/archlinuxarm/PKGBUILDs/raw/master/core/linux-aarch64/config
$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- olddefconfig all
...
aarch64-linux-ld: kernel/kexec_file.o: in function `kexec_walk_memblock.constprop.0':
kexec_file.c:(.text+0x314): undefined reference to `crashk_res'
...
aarch64-linux-ld: drivers/of/kexec.o: in function `of_kexec_alloc_and_setup_fdt':
kexec.c:(.text+0x580): undefined reference to `crashk_res'
...
aarch64-linux-ld: kexec.c:(.text+0x5c0): undefined reference to `crashk_low_res'
==========

On the provided config, it has:
===
CONFIG_VMCORE_INFO=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
===

For these crash related code blocks, they need put inside CONFIG_CRASH_DUMP
ifdeffery scope to avoid building erorr when CONFIG_CRASH_DUMP is not
set.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20240126045551.GA126645@dev-arch.thelio-3990X/T/#u
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/of/kexec.c  | 2 ++
 kernel/kexec_file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 68278340cecf..9ccde2fd77cb 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -395,6 +395,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		if (ret)
 			goto out;
 
+#ifdef CONFIG_CRASH_DUMP
 		/* add linux,usable-memory-range */
 		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
 				"linux,usable-memory-range", crashk_res.start,
@@ -410,6 +411,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 			if (ret)
 				goto out;
 		}
+#endif
 	}
 
 	/* add bootargs */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ce7ce2ae27cd..2d1db05fbf04 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -540,8 +540,10 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+#ifdef CONFIG_CRASH_DUMP
 	if (kbuf->image->type == KEXEC_TYPE_CRASH)
 		return func(&crashk_res, kbuf);
+#endif
 
 	/*
 	 * Using MEMBLOCK_NONE will properly skip MEMBLOCK_DRIVER_MANAGED. See
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
