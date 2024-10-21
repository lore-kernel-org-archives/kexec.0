Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23341D3C93C
	for <kexec@archiver.kernel.org>; Mon, 21 Oct 2024 03:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=02O09BPAGmLE9xbFNWrZD1Wj7+FcXJbZKR+xY13ir6c=; b=j2yp0QfUO0eD3l
	+3JKilKr8Ft7YW5RfJP2uzP6HWge/L+mJsitAqpYbTX+EyTTk4vTOcZ5BzmP5g2HhvyRNAtkt3xf/
	0g3IT8vYjVKJVptP3Y2UvcPfBlUQBqB0Jk98Qr3gC6fub6023r7SSHr1gY5icu8Npuq/ksptLmbqy
	SFLLNFgeJG5RChgbPeedJM2+EF04Qshb8ek8QJow8uWeCS4/gXmY8uQojbE+dT3O4sg09JHa3n1WL
	6ZRui2NCL44i7ImIL9LxfD/pbaH6AyGqWYzGF2XsXxqTcXFVWAAOnqweOEwKm0RO43PoRb9M/ZK5f
	fc+6XMIdAjSGAt86Yzjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2jPu-00000005ypv-3WFX;
	Mon, 21 Oct 2024 03:49:14 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2jPp-00000005ypK-0YZ7
	for kexec@lists.infradead.org;
	Mon, 21 Oct 2024 03:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729482549; x=1761018549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=31d7ORNUlp0kIwwTotWiGmSTWYon69BtiQ1QjPfL2AA=;
  b=e3Tt8hZOy2iIzi1GeI3Msg0gnoY7MqvKpGOAQTkNbjA7oksP5aYT/nz7
   xaPNiNRlVFzyQHGB33wEVvBl1mPOv1n0OdIW4hJeFT1jiF1KWbWFFD0Kj
   ZyA+EFlp93b33q/ialeeKzNBnLp4mgqV24XlEBkPQXsCIcjjtUNuWK8Pi
   Eiw5nsEoHK5FJFjt6HyqmgFUF8S4hEB0xv/4XMON4opUw1koPxmie6EQD
   aV2fm5m//XFOh3beqPmW3Le2W/usQsvsLqavdoMdnAqbfWUFbjNBbXrFR
   GpiY870W1PTnh2v8xGXDAese1YsFprKTah4hdxSLwOv6b/1dq7vyuVo6i
   w==;
X-CSE-ConnectionGUID: YX/gEimITvmjhsRxVBfw6Q==
X-CSE-MsgGUID: hUJXjRHwSLG1cOxTRZYd1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28900685"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28900685"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 20:49:05 -0700
X-CSE-ConnectionGUID: ICSjrCbYRyeEF9Bfm+9lOw==
X-CSE-MsgGUID: ewORK1SQSKKhH7c4XTA2wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="79740999"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 20:49:03 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Date: Mon, 21 Oct 2024 11:45:53 +0800
Message-ID: <20241021034553.18824-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_204909_244708_BA3B29D0 
X-CRM114-Status: GOOD (  12.69  )
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

The kexec destination addresses (incluing those for purgatory, the new
kernel, boot params/cmdline, and initrd) are searched from the free area of
memblock or RAM resources. Since they are not allocated by the currently
running kernel, it is not guaranteed that they are accepted before
relocating the new kernel.

Accept the destination addresses for the new kernel, as the new kernel may
not be able to or may not accept them by itself.

Place the "accept" code immediately after the destination addresses pass
sanity checks, so the code can be shared by both users of the kexec_load
and kexec_file_load system calls.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 kernel/kexec_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3..d97376eafc1a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -210,6 +210,16 @@ int sanity_check_segment_list(struct kimage *image)
 	}
 #endif
 
+	/*
+	 * The destination addresses are searched from free memory ranges rather
+	 * than being allocated from the current kernel, so they are not
+	 * guaranteed to be accepted by the current kernel.
+	 * Accept those initial pages for the new kernel since it may not be
+	 * able to accept them by itself.
+	 */
+	for (i = 0; i < nr_segments; i++)
+		accept_memory(image->segment[i].mem, image->segment[i].memsz);
+
 	return 0;
 }
 
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.43.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
