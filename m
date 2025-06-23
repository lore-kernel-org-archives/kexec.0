Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6840C77B7C
	for <kexec@archiver.kernel.org>; Tue, 24 Jun 2025 01:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5kQvwr4znaeekKGqGYywHoRh23O0X8q6/s8R+gkVfv0=; b=19uvG8uVT46kzaZpF565oD70d9
	ynyJQp7dErXR2yV3zCqIB1vGI+8voLkfPPpFmYMZjQwvdDGmW4Mlsa4yUHFgBKmUAm7LTPEZtp9AA
	QSNuuVEauzvfI2Rh7XASaQXbom+HBFgpMTIcz5faFCFPgvLmYGPxnEJoh1pun2ibJpCLqRZiAw1U+
	sDrLBDrvi3k0vro0mV3wJYCqV6qDLFb75jxndBHSvscikV47VXAr40Qp/T9SHk4jgOZ2C2uXqawhP
	YfWuqDouI60+IHkJmeH5X5lxN0YQwQS4Uku7Y8eoK4H9apZRuZWuBdF03GRb1ARVTUobDBFUlUWoI
	os3pp9WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTscn-00000004OUN-37cQ;
	Tue, 24 Jun 2025 01:39:01 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTqYP-00000004Ad3-02uH
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 23:26:22 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so17309f8f.2
        for <kexec@lists.infradead.org>; Mon, 23 Jun 2025 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750721179; x=1751325979; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kQvwr4znaeekKGqGYywHoRh23O0X8q6/s8R+gkVfv0=;
        b=HsyXKJggrDuujS6pakBh90/ZdZL2qv0aax7X4WztMd56t+lAlm9OQDsJ12yK9Gy2O8
         n6Qe4GGc3HewDw+RTk7puyUWnz+td3/apsRY2RsNKuJ2Mm3HaoaUwvJ5Z9zss/jMVEci
         SSqu1ECAMO72Qh8qRRMvv2f3iy/UeARLxXiLyjegxCyNTXwA+L/Hc6Uk2BbDpuG8yUxk
         OtEuyWxaRJpx4oOUra6jbekDGMN1N7PvwsKXdLgXYZvrI7gi5uABvdpbtD3Rzbwg0pV6
         DCiA3+3L6hgJ1KTvgBF+YCM6HWZ+tKNOqhl1DssQyH040cJk9PZ3CR0bWAnPCO3gFAbk
         X+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750721179; x=1751325979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kQvwr4znaeekKGqGYywHoRh23O0X8q6/s8R+gkVfv0=;
        b=B5DVQGn1Ck4lI7R9gKp3QV6Pdk+ZQq2t7K2PHAbDY0yNUBPgrR6vNyIGpFZI+sIq5M
         w7fjtDJwpM1/IBj0/EvLKbPfi5ftVkp9/lJHHHmgUqlFqrmlI65+3nz8M9oiAPyAzJLj
         kYTgltlgdXHv31fzqQWH/CUeR3WZDL/frKyZKQu6UduZZ79auB/EzZcIEA8DTpnpEskV
         aMLTdzw13WkFHCNvgd1F35g8t4WTS2nhg3cHWc2Y+Xfup6Wpvjjvb0Rya45LY5/gk5Yo
         h0EbrjyaVGl93hdJhaK7yFuIyfflCo8anEAqpzQ4ZC8DbHw483cXHfWm9YIMtntRSEvk
         Lbpw==
X-Gm-Message-State: AOJu0YyhUnLwvGm0uFPjbm1vhjEwGYzA0/PO7WjjpmSsqiy93inxcKdq
	GqSwKjyuMkMm1bGnMviglgND8wFc6qZQ87v2+d6tQ6CBXHiz3d86q+K8cHZokKAw
X-Gm-Gg: ASbGncv+dnhA1qeYUWS4Vny+E1LguvQaycXE/zpURGMmihyp7qEZhEBNWeQ1J8Jw59m
	iR57Zzfnp9g0sx3qsOvvj+jF28h0BDUrskAr5BaConqcv0YDvpzrl+2u/OdexBiHSExIi7CqLKu
	Epc9J1hMvaFUzrf+3hKhdy2OmjviwB7FVP+yzL46FHUUfj8eWzsjND6zMjONwVf56PB3wkmLGUE
	YLHPGp7i5nTxrqf2uQJunwU3J0dmx5danObJUlG9L7KD36mHmlDuS3UDxZ/pn97rQHf6zx8IauG
	dG3GM8LmzVmgRDuj4ZonYAZL9JInRYMNKH8647ghEEHi95LcAc7RpGk1UMzh5yUdT+Agv968BYI
	RytF0REsqvEpLcFkJ/Gv3/OQbmkdPJQfkGR3tA7tDPQ==
X-Google-Smtp-Source: AGHT+IGHE8/XYXDoWv1edDBgdZXp7khQRu3HaEVJ14KJWrycHHoziA88Dx83XySgUoVmVMLW4aUYDw==
X-Received: by 2002:a05:6000:280d:b0:3a5:51a3:2ef5 with SMTP id ffacd0b85a97d-3a6d132ca1emr7782200f8f.58.1750721178663;
        Mon, 23 Jun 2025 16:26:18 -0700 (PDT)
Received: from puck.. (watf-12-b2-v4wan-169542-cust1006.vm45.cable.virginm.net. [81.98.219.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810b140sm342384f8f.80.2025.06.23.16.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:26:17 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: kexec@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH] selftests/kexec: ignore selftest binary
Date: Tue, 24 Jun 2025 00:25:49 +0100
Message-ID: <20250623232549.3263273-1-dyudaken@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_162621_055224_2C6A1856 
X-CRM114-Status: GOOD (  10.81  )
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

Add a .gitignore for the test case build object.

Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
---

Hi,

I noticed this was causing some noise in my git checkout, but perhaps I was
doing something odd that it has not been noticed before?

Regards,
Dylan

 tools/testing/selftests/kexec/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/kexec/.gitignore

diff --git a/tools/testing/selftests/kexec/.gitignore b/tools/testing/selftests/kexec/.gitignore
new file mode 100644
index 000000000000..5f3d9e089ae8
--- /dev/null
+++ b/tools/testing/selftests/kexec/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+test_kexec_jump

base-commit: 86731a2a651e58953fc949573895f2fa6d456841
-- 
2.49.0


