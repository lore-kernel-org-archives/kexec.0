Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACD5CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WXruPKT22GcZoZBEWo9YHDYe3HaziWhcMG5AGyP1PVk=; b=IndmlxSql75r407d70h86v/Yi5
	NMgCnKuOI6E1x5anL/TYQekf0/24iQz8eU86Jtu7eDWSYG4vGWBYnMSzQks80Gvxl9y/q9PgUFZH5
	tK4Oq+oeRw05r88Vm53z3+jzmqjGBsnytKGS1sjb+bMxQ9R/WMrRqReUHuRfRoFkQXsR0C8k7HP/n
	KuhDzwKieQpPuLm/EpB2FLMzKsOQRDy4syliygy9tpjZzxSU7YsXde6AwEpvcZsgtr8n5yeMeU8/k
	yDU9FpM+pH5IzOvedeHqFFbwM4BI0oK0X0KQZzfpKQO2HoeYsWm/VR57KkqXT2ojfg5P1su2JtFlg
	/GEeck9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgrd-00000001lA2-3uVg;
	Wed, 06 May 2026 18:20:53 +0000
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgrc-00000001l9J-3bh1
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 18:20:52 +0000
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-651bc83e74aso6402789d50.2
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778091652; x=1778696452; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXruPKT22GcZoZBEWo9YHDYe3HaziWhcMG5AGyP1PVk=;
        b=YsgIeA5Cn27Hq4VZu+/gIHW/sv6S/ak4BB1w45pvwy4AsFp13l+qPZFWbWnM1db/jC
         CJS+fbe0q6k81i5801ypuK8oDda3azPS3RSylapQ2gdV/SyRgNW/EoKxf03IDXo16sJJ
         hU3SatpBJuFfuBDMBB0VMgPcGkF9tEp7iD9MkOeNvcDcxCM+qsLXjYr7ydws+D683yLe
         SKSc/V4PYiYLIw3puZ4v36XPWvoER/zXUk6RrX3cwpF2iNWiTQfP9RanOJEAqqm5yQ4t
         8t3QenIXHPotG43U7N3bLNhkx+aa28A8egbkFPN/haxro37rBRVcsie049BOuAecLGhf
         2Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091652; x=1778696452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WXruPKT22GcZoZBEWo9YHDYe3HaziWhcMG5AGyP1PVk=;
        b=T+UyX981EqOfXd0c1/Ic4JmQN/I88nMQ1SvNRwjL/mzrmboixAD5dwcoomfUS7r6L8
         EDHDqPdDh3ERLiLQzR/TtI50ZlF728sbvLNqtf3Ad9+zbreHeOFYy/4KfvNcGpOvsbvH
         lyRT7cf4HketodgUBUC93J3r0KyJ77yZm151s8F/l7FPyQmxpuj9gp/7Gtdn1fib0/bs
         qbuuYQgrP0k4wE8MUjMKSLwWHq/5gn20hLiE6KzpKPi21sAsHJPpN1hAFBYz5infoHdb
         t+5/jm25PISdoyTpgS4GdF2MxtuWkSFFG9OoS2zqZqYhSDEs+IXy5t4XucgoAf4nzRz/
         YXoA==
X-Forwarded-Encrypted: i=1; AFNElJ/Bec40RpGYn16WD9hK1E0aHVj9GNRxUHRE/2fpv37DzpF8NvqnPilm8egS8U/Vg6C/VXVIeA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxhsmFyp5mHpyXg1TKlGrd23fM2C4QOKow1q0f+ZABmBnSY95KS
	Zgoas/MIDCFL+DquiM98TPDUV7sb/TjAtYTsvceOg1G92z01xrJb7WH+N18yrdF/+s8=
X-Gm-Gg: AeBDietqkFLby6fSP3ajIjMNYolFZrfkLq2VtaQDgrGuUyZY3caCkvbUCFA7bNJHVw6
	GGBSLjCi2u1zqA2kfZLuYFrj4s6cMttWa6Oc1GOFHoDEADh7NyISNkiojJtrqeG7LBsot2UWmuI
	S5jP7k3XJNqbBAO+9jPt4N9EBrTc9JhFaBZWySBqBD517qXb6RN5ej9Q+txnXBjlcK3X+PWhJXT
	ya0+UvfTt5KKDdlIFyLTswndmbpPQQhgTXp09uantgCirNiw4o43KEIjrUExzAK+YaVfIh+O0mR
	U67b9FoBOGAftJoUNawphzJWlwvKGZ523K/pzmVxC5MDV4szrSuWJWqP0NpxqE7KofeBVzVS/Qq
	T+ummMn8XEX9TbPmm64gC4BO52y9I+k2HIxQJadQHfXqNULqmHVGzZ6SbVsVlRAGrLEE+OZjJQt
	LDfzE5QD/v9libehY8eo1/z5q8gqZukkWV1b65D8ZTmazMBbL7BTlHuHCGD5ZXU0hyiX4ARg78W
	qpVe6p47MMSFiEtFC5pLJoMU5dLFKole+6F2ZPX2mM3sbwb5JqS1JyPn7Bh
X-Received: by 2002:a05:690e:1408:b0:65c:468:7b6f with SMTP id 956f58d0204a3-65c79cc750amr4971855d50.25.1778091651551;
        Wed, 06 May 2026 11:20:51 -0700 (PDT)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7af9f8e7sm1389917d50.13.2026.05.06.11.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:20:51 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com,
	changyuanl@google.com,
	mario.limonciello@amd.com
Subject: [PATCH v2 1/3] kho: skip KHO data for context-preserving kexec
Date: Wed,  6 May 2026 14:20:41 -0400
Message-ID: <20260506182039.2623553-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
References: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=pasha.tatashin@soleen.com;
 h=from:subject; bh=r96qoJEtxIi6x6BSFWD6mxFRZtdbqcya9kKoQBtHdO8=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBp+4Z5Tck3diRefZlq1FRnNTXoLp2lad+1ZHT3t
 t9owY4Y1YSJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCafuGeQAKCRC7dyhM23N6
 3iGqD/9IpRjWwY21ghxceNus2gj+Qh4gN4GTyj9FXrFqEmDf1sRQDWgRDX9x9qYdMIbwCE3Am13
 z5xxwWcofya6hV88JipQVuFuQneRFXnpB1YDJv1LNCtHng2Mq0Vg6RFOWgAQr3cn/ns0UcbMoqp
 3h6HidKEwWa2+aIXee1PEQxeSQngYi32xbl1nA4HP2kyNW0696f13sImu6TV+KgeynuuTLxQuRO
 r+AeCUrLqi9yQoCW2+hDYOpVbckwDWpQ9aU+f5JMSVmTNGaxQ4MlSPdu7dluK/sZ7TXHEdlhmC1
 AkfNABwGlJZsLDt+RKr/XLjg4qnSSG2+bYNApI0KFZTsQQdD02KU8Bal6DvyqzD++q/AFHWjClG
 +ca8YvfT9V2bubrk0a/7QVnMOqy+S5Myczv2SE0/mkxBJmoWKDeXv/ondj/RQtSRIxeyIB7Sskm
 59k8x+nOoQEaDeBseXyC7KWfoHLNiLA/BTyj3VSeRLyXqoc6AYKwi00rMU745uAe0+PB1Nnzjqq
 klZSWk4m82q2vY3dXk1IGmuIE6QSmx9RbT7kMgnaI6MTsFC3vx1AJttSXjbZGNgqqm4ag10vnoy
 hZh32dsvRXwJ/O5yeRZ/VEgNPJaiIXpjNljyWKa1zPVroFsHvdGtq6Zd/4eVPdQ2wRiqC1g5iSi lYj8ob7Y4oMrD3w==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp; fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_112052_913786_6D1AA983 
X-CRM114-Status: GOOD (  10.71  )
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

A preserve_context kexec returns to the current kernel, which means the
2nd kernel does not use KHO data (and their memory spaces don't
overlap). Passing KHO data to the 2nd kernel via setup_data or
devicetree is unnecessary.

Add a check in kho_fill_kimage() and return early if preserve_context is
set, to avoid passing KHO state during context-preserving kexecs.

Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4fde8325c49f..2eec2a169c83 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1702,7 +1702,8 @@ int kho_fill_kimage(struct kimage *image)
 	int err = 0;
 	struct kexec_buf scratch;
 
-	if (!kho_enable || image->type == KEXEC_TYPE_CRASH)
+	if (!kho_enable || image->type == KEXEC_TYPE_CRASH ||
+	    image->preserve_context)
 		return 0;
 
 	image->kho.fdt = virt_to_phys(kho_out.fdt);
-- 
2.54.0.545.g6539524ca2-goog


