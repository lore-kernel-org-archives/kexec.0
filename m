Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E40CC77B75
	for <kexec@archiver.kernel.org>; Mon, 15 May 2023 06:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NyZuG5LCGrgc/4+d6anXrp7vfdVPrYSBNJ1UvHgMDrI=; b=NX1VzAxt08WRy0
	KwXTlnDDMLN12C6Va8q4bEQgBin/XzlSlG1hpeCTCl/YcQtiHGcyHMlAZz3z5aubWtUDhcQlTi8W8
	yvzggb6YIYixrq3l/1/1kQPL1r1ITQetwejtQXKPjjtXP/YQ4eoYufEGHu2G+PEKrsqlyIeL0A38V
	z2s4V2gE6FXNTQbDSU4KBsqKFAW1ffaSYiKzboZPqNe6gMB3PnminMGao2mGXV5LNQN4UBKdUKNNo
	Hcc2VwWOnxvTaBATXPnS2gdbRvVeAutig/QLBhoh2SXK2YX8rhyC2/BKDTRdejz7fmNsDZI4CnBqR
	GwDwvOT7G/JeSdnVMciQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyRIv-0013GA-2C;
	Mon, 15 May 2023 06:03:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyRIn-0013Cd-1e
	for kexec@lists.infradead.org;
	Mon, 15 May 2023 06:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684130600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/HTD3f0P0/3Vfg2IW/92bJMtlhcGD951h+Pgg59OXQ=;
	b=IdwlBG1acQm5kWI8L8sOOvto8y85toc0IDV/l5SzAbeYnQG/JdtxLcDhBJgTcfDu2bi6ZC
	rjwSfxZtPVEOee3xLoQsSRsFfrNExJ5xVOpITHXZ0KQXXJoAaJpTSpF8x3Frv4dRQ/4PRF
	naX2ZuQFCooKZwM+7Ir5ft0wz2oN16Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-U_SSZYFTOVq2JwICkBmuDg-1; Mon, 15 May 2023 02:03:17 -0400
X-MC-Unique: U_SSZYFTOVq2JwICkBmuDg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1F72101A552;
	Mon, 15 May 2023 06:03:16 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E56140B947;
	Mon, 15 May 2023 06:03:11 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	horms@kernel.org,
	thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 2/2] Documentation: add kdump.rst to present crashkernel reservation on arm64
Date: Mon, 15 May 2023 14:02:59 +0800
Message-Id: <20230515060259.830662-3-bhe@redhat.com>
In-Reply-To: <20230515060259.830662-1-bhe@redhat.com>
References: <20230515060259.830662-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230514_230321_650356_3E57C802 
X-CRM114-Status: GOOD (  22.44  )
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

People complained the crashkernel reservation code flow is hard to
follow, so add this document to explain the background, concepts and
implementation of crashkernel reservation on arm64. Hope this can help
people to understand it more easily.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/arm64/kdump.rst | 103 ++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/arm64/kdump.rst

diff --git a/Documentation/arm64/kdump.rst b/Documentation/arm64/kdump.rst
new file mode 100644
index 000000000000..78b22017c490
--- /dev/null
+++ b/Documentation/arm64/kdump.rst
@@ -0,0 +1,103 @@
+=======================================
+crashkernel memory reservation on arm64
+=======================================
+
+Author: Baoquan He <bhe@redhat.com>
+
+Kdump mechanism is utilized to capture corrupted kernel's vmcore so
+that people can analyze it to get the root cause of corruption. In
+order to do that, a preliminarily reserved memory is needed to load
+in kdump kernel, and switch to kdump kernel to boot up and run if
+corruption happened.
+
+That reserved memory for kdump is adapted to be able to minimally
+accommodate kdump kernel to boot and run, and user space programs
+running to do the vmcore collecting.
+
+Kernel parameter
+================
+Through kernel parameter like below, memory can be reserved
+accordingly during early stage of 1st kernel's bootup so that
+continuous large chunk of memomy can be found and reserved. Meanwhile,
+the need of low memory need be considered if crashkernel is reserved
+in high memory area.
+
+- crashkernel=size@offset
+- crashkernel=size
+- crashkernel=size,high crashkernel=size,low
+
+Low memory and high memory
+===============
+What is low memory and high memory? In kdump reservation, low memory
+means the memory area under a specific limitation, and it's usually
+decided by the lowest addressing bits of PCI devices which kdump kernel
+need rely on to boot up and collect vmcore successfully. Those devices
+not related to vmcore dumping can be ignored, e.g on x86, those i2c may
+only be able to access 24bits addressing area, but kdump kernel still
+take 4G as the limitation because all known devices that kdump kernel
+cares about have 32bits addressing ability. On arm64, the low memory
+upper boundary is not fixed, it's 1G on RPi4 platform, while 4G on normal
+arm64 system. On the special system with CONFIG_ZONE_DMA|DMA32 disabled,
+the whole system RAM is low memory. Except of low memory, all the rest
+of system RAM is high memory which kernel and user space programs can
+require to allocate and use.
+
+Implementation
+==============
+1)crashkernel=size@offset
+-------------------------
+crashkernel memory must be reserved at the user specified region, otherwise
+fail if already occupied.
+
+
+2) crashkernel=size
+-------------------
+crashkernel memory region will be reserved in any available position
+according to searching order.
+
+Firstly, it searches the low memory area for an available region with specified
+size.
+
+Secondly, if searching low memory failed, fallback to search the high memory
+area with the specified size. Meanwhile, if the reservation in high memory
+succeeds, a default reservation in low memory will be done, the current default
+value is 128M which is satisfying the low memory needs, e.g pci device driver
+initialization.
+
+If both the above searching failed, the reservation will fail finally.
+
+Note: crashkernel=size is recommended option among crashkernel kernel
+parameters. With it, user doesn't need to know much about system memory
+information, just need to specify whatever memory kdump kernel needs to
+make vmcore dumping succeed.
+
+3) crashkernel=size,high crashkernel=size,low
+--------------------------------------------
+crashkernel=size,high is an important supplement to crashkernel=size. It
+allows user to precisely specify how much memory need be allocated from
+high memory, and how much memory is needed from low memory. On system
+with large memory, low memory is small and precious since some kernel
+feature and many devices can only request memory from the area, while
+requiring a large chunk of continuous memory from high memory area doesn't
+matter much and can satisfy most of kernel and almost all user space
+programs' requirement. In such case, only a small part of necessary memory
+from low memory area can satisfy needs. With it, the 1st kernel's normal
+running won't be impacted because of limited low memory resource.
+
+To reserve memory for crashkernel=size,high, firstly, searching is tried in
+high memory region. If reservation succeeds, low memory reservaton will be
+done subsequently.
+
+Secondly, if reservation in high memory failed, fallback to search the
+low memory with the specified size in crsahkernel=,high. If succeeds,
+everything is fine since no low memory is needed.
+
+Notes:
+- If crashkernel=,low is not specified, the default low memory reservation
+  will be done automically.
+
+- if crashkernel=0,low is specified, means that low memory reservation is
+  ommited intentionally.
+
+3)
+
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
