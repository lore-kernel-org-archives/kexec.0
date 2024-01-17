Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3582C47DA2
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2XE8VcgaHlByHWn6edq1AqptNfYRLgJe58wLuVTfCY0=; b=t9Cw4eKUFPMVT6
	/cOgFRrAOuKh7rGyxEROBJuSKR41vYyaDB6Mrb6RKEIq4gduOz5sZINop6sgp1+tKKvbny7QJjkaH
	y4Y0KND7Yyn0yAz8XJzLIv7Q53EKeoijJ82BqDyvgxBqftbyjK/L+/jbBqb890wB+KEM7Ng00oE3R
	ga4vN6qKMA3Iij1FMIIV9ttqCbwoAr1ejkHf7UtexOE/uAkNAj0NFaFHTSsZ2/TIvhfwvnAfPWFQt
	jfaPShmWrgSvBfBtOaONIohd6pU+SLaN9HBZuHv01migequsItsqt19PbiorlwiGsKNi5DbkzXbVE
	dvAjcY/JxDKq7Uue8ITg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7Dh-00HHvr-1O;
	Wed, 17 Jan 2024 14:48:45 +0000
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7DT-00HHm0-1G;
	Wed, 17 Jan 2024 14:48:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502912; x=1737038912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6zY75UaUomPQ5EhDGeFWm39K87gMNJwzqvhZ/SkIvI=;
  b=d6pico9CYjUTkMi7mPwvid9zpE0XzUdex0M1Gc9wtfetVk+hHK2LJGAL
   PMQQ9gZH1t9KiPBDCC/JNQkfEPAHEnMIruaSmjz4uEMZnjrvOX2gpS/BW
   PxPEKnX7eXZIWH4YTkC++If8NEIvuQUfhaiNesBkukQlf3OAFAvGInGvB
   E=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="697788568"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:48:22 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 37BC9A0A9E;
	Wed, 17 Jan 2024 14:48:18 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:26746]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.181:2525] with esmtp (Farcaster)
 id c922b8c6-218f-4e2e-bfa4-5cd050b28dc6; Wed, 17 Jan 2024 14:48:17 +0000 (UTC)
X-Farcaster-Flow-ID: c922b8c6-218f-4e2e-bfa4-5cd050b28dc6
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:17 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:13 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<madvenka@linux.microsoft.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 06/17] kexec: Add config option for KHO
Date: Wed, 17 Jan 2024 14:46:53 +0000
Message-ID: <20240117144704.602-7-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_064831_489006_F8D076DC 
X-CRM114-Status: GOOD (  14.71  )
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

We have all generic code in place now to support Kexec with KHO. This
patch adds a config option that depends on architecture support to
enable KHO support.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/Kconfig.kexec | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 946dffa048b7..6fb5a6ae9697 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -93,6 +93,19 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
+config KEXEC_KHO
+	bool "kexec handover"
+	depends on ARCH_SUPPORTS_KEXEC_KHO
+	depends on KEXEC
+	select MEMBLOCK_SCRATCH
+	select LIBFDT
+	select CMA
+	help
+	  Allow kexec to hand over state across kernels by generating and
+	  passing additional metadata to the target kernel. This is useful
+	  to keep data or state alive across the kexec. For this to work,
+	  both source and target kernels need to have this option enabled.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on ARCH_SUPPORTS_CRASH_DUMP
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
