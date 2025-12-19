Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD65D7496F
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nlC4H+HZu5TOOreu4OEbcwwZ6SLR8CCJXl93GTnllT4=; b=TJrp6hxdhRIcbYOwSJLVAqV2+4
	3UYrJJ1Z9H7ZfqS96sOsOyBd1xHOSqSwfR5sZ5HAaU9zoCk7sRz/i2RWG47onstaK5aQS10f/aTtv
	S7tkndMukBVKL05U2tQ0VGWVLO4dlis2IoUXDADqcFR1KIEw/Zln5XuR6rDDNULKJbj9ogQRZXlSA
	4TuDeIPsrme8qmp8CLygD8veBPdI1za6MqQejE6zvyZeIdYY2k7N5ekEthfhHX/zrabzjY5Kal6NV
	3hw8rUVXCk1Zg0ltW/ZTokNj9K7gyDNF+ciKa8ScIHaTW3CWEJE+dO8iEEq/ESpsHR3BZu5Cixmjw
	7E9U/dyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWs4-00000009xZr-1ujy;
	Fri, 19 Dec 2025 09:34:00 +0000
Received: from bg1.exmail.qq.com ([114.132.64.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWs1-00000009xYY-26cG;
	Fri, 19 Dec 2025 09:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1766136800;
	bh=nlC4H+HZu5TOOreu4OEbcwwZ6SLR8CCJXl93GTnllT4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nLG42rS9ot2S/vPASB5sHQSe7L72jYElkg8a2KpJ8sthwhR+ZqaM5TCxbOU5wZ45L
	 +CGVGbM4mD9NJUtmPmcpoBTLiJ/epH1guUAri/jWL+OVVm/gQNZbrXz4k9GdxgFlYM
	 FgJZNfkpy8Ansl6OGCCKVfv+oVp5UFV/xHmz2vX4=
X-QQ-mid: zesmtpsz5t1766136782t6fef4898
X-QQ-Originating-IP: CyZ8LaOM/lGrBRK0Q+OEqnhxmnj2qG0V22yz3yvLa8Q=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Dec 2025 17:32:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12551224944770575030
EX-QQ-RecipientCnt: 8
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 1/4] kexec: Replace the goto out_unlock with out
Date: Fri, 19 Dec 2025 17:31:31 +0800
Message-Id: <20251219093134.2268620-2-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251219093134.2268620-1-maqianga@uniontech.com>
References: <20251219093134.2268620-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nui917t5cXLHNfyvDTrIPEmkIZW9sfhA9mUBI30aPQVhoI01Qq2B9Air
	Xeij0oEQh8GPJivZkbVq9C0L/oIR0ZQNfqPwKlpWsszKu9zeuaKruh2NNPzq2KZa0tiC1vm
	IfZDFbdw42bxyKTrx2/tN38Zmq3i7IRSfuwWIKfB0Ixq9s2MxdTO1CXQlnzq7NKVlak6ygo
	9qRnzJ52TGowz7sfYfUi1Xby4D9l8MbNxMQjggTToGrp6RD1Cs9tqerJwWTSOrld8rMTTLC
	vVBUXrN6pNt3DrAIu3gYv+oRdt5EndyrZ6TaWOxldAW3vi+B9/lMihxQ5aB1aHUHgnujZlv
	J3BNJHcjJolJBH9PatIVL9Z9vz2kXDmmyWpxUzS6X7qWrUtco+Niq6LyktvL8jZwc6lpPEj
	A4lrOIoagfgLLu6/Y299Q2Wj9Yn5nVcQyqF0yu5xDxPBcwczm+9OeRosqVjgKSiI4Wn8GA7
	qszzByYGa3R05R+6FgZaGfvrgSOBNEi/vg6Gio2dXlomxL4zUqp26OlqsgBuXWcJSD8p5+o
	Po8RReKxEb2VKO84AM8tpHGlWQXuY1/6un6b3zCSYZZy4XtKoZz+Mi9A2PtWUlZqx8YJuvX
	4EEoen+gUDCexU9OB3UJUREnImJ+r11lxT/aDmDF3Fu/HKfYKW3vlH39eaDKJ+ilaWwRXXj
	cOzQx7sFmOSxTxZz3VXXyeX8/CbREIsESYTLYl5vXjfZfRs0K16CcKf9OKvvIoD1Bp3F6gB
	PXEzhHcek14Ibc4Cr1Bbu0vBecjK/cNNIeW9sXDUTPN4YBsfSTanqxCi1WX/0vJrqPCcg+F
	XRiUF7BxzlpbwlLy2TuqcC8Xm66CbHzv8oniTvxwiVQzqE9WfT91i12rhV57ONMOqz9IyLN
	hsuDQ3vGFvOglsNahFETEWcjSySLktTG13otKSkwvNkXCoEJLfjFau248z7HlMdyoaEe9go
	ppNfl1Zud1Xp90mxu5kCAk+s93pyTy5DqEjZO0uVHLzVXXLM2iio8p8PEKsi8Ho11ZW7/zT
	/XJYMd3i0KtdfZUZN30C4mdi7Vkdb9kKmHjpQWg+Nv35Vnyh10
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_013357_904886_A3F08E7D 
X-CRM114-Status: GOOD (  11.74  )
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

The image is initialized to NULL. Then, after calling kimage_alloc_init,
we can directly goto 'out' because at this time, the kimage_free will
determine whether image is a NULL pointer.

This will prepare for the subsequent patch to reset the variable in
kimage_free.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kernel/kexec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 28008e3d462e..9bb1f2b6b268 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	unsigned long i;
 	int ret;
 
+	image = NULL;
+
 	/*
 	 * Because we write directly to the reserved memory region when loading
 	 * crash kernels we need a serialization here to prevent multiple crash
@@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
 	if (ret)
-		goto out_unlock;
+		goto out;
 
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
-- 
2.20.1


