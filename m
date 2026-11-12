Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A50606A887
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VGjQ5lOP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtBMKKln
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1TqLW6TCU0MTFWVnCW5idaNhXosc69J5rCdUkKs0dx8=; b=VGjQ5lOPT5TDBE
	ba5gdJ0J5VEbIts7eLAGlLHk+WmmfhvkWP+NPb4CAAfr6U3Aqy/rggSgkfDOKqhlz9oAlTekcEP/b
	BLsmBIMgMHJTX5Altfb7IXTwIhipTr0TfDHTIyWx36u3UitM5d4WOyK7T4eUPqtPERSwTvSOx1IdC
	3ixUBrJbOVxr65lJxaYx/VaiEShIvlOChs8FxSUak0lJfHhyb86ymSa86MqDyAbKyXvO9YZi1tNXf
	e8WEqruILav6+7wBSzRlcYa8QWCD4VGI+8H+jvWc1UWOz0d/cPStVRwNb5BYVmWtobZ6MOf+/5LAf
	o7k8B5fK02tBisPSG5Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSD0-00000009YHT-1WmG;
	Thu, 12 Nov 2026 10:39:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSCy-00000009YFy-2bxT
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 10:39:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C8DC963A5A;
	Thu, 12 Nov 2026 10:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFBB1F00A06;
	Thu, 12 Nov 2026 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479947;
	bh=1TqLW6TCU0MTFWVnCW5idaNhXosc69J5rCdUkKs0dx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HtBMKKln5m3G2gtNfK/0flI7AP2EvZjQQh5hYJWKwraxNla1MVmVeuJ5Ztyg+zBIZ
	 khUBJZFQXoNuH48GrC/IEX1y076qqsHUPLnW/4knD6ieVh5yD6Ep1U7Xdc+iaqh/G2
	 96RcYCSwBiEKJorecpKBit1DYHC0PUEhaO/VrmvZNvW2Qus0kmmqzCBhxRN3n+4N9V
	 Bha5BKr6vn4GeUGZh6id+YDhH7F8tw8N3nnYso2wo6OayCdV0jehXEereNvQyUXxsm
	 HzOywLMLoNMgZ92M0qDbBL2f1kzB9Z28hN8Y2EKGpXe2m+9zlY3iORBTSvFSdA0iH2
	 0LQsFC3wGTBhw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 12 Nov 2026 12:38:53 +0200
Subject: [PATCH v3 1/5] kho: reject zero bootmem scale
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kho-bootmem-sizing-v3-1-f0c8d00295d5@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>, 
 Kexin Liu <liukexin@kylinos.cn>, Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kho_bootmem=0% sets bootmem_scale to 0, and then the bootmem areas are
sized using the explicit sizes that default to 0. KHO remains enabled,
but there is no usable bootmem to load the next kernel.

Reject zero scale the same way zero explicit sizes are rejected.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe31819..b30ba686cb301 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -703,16 +703,22 @@ static int __init kho_parse_bootmem_size(char *p)
 	if (p[len - 1] == '%') {
 		/* unsigned int max is 4,294,967,295, 10 chars */
 		char s_scale[11] = {};
+		unsigned int scale;
 		int ret = 0;
 
 		if (len > ARRAY_SIZE(s_scale))
 			return -EINVAL;
 
 		memcpy(s_scale, p, len - 1);
-		ret = kstrtouint(s_scale, 10, &bootmem_scale);
-		if (!ret)
-			pr_notice("bootmem scale is %d%%\n", bootmem_scale);
-		return ret;
+		ret = kstrtouint(s_scale, 10, &scale);
+		if (ret)
+			return ret;
+		if (!scale)
+			return -EINVAL;
+
+		bootmem_scale = scale;
+		pr_notice("bootmem scale is %d%%\n", bootmem_scale);
+		return 0;
 	}
 
 	/* parse ll[KMG],mm[KMG],nn[KMG] */

-- 
2.53.0


