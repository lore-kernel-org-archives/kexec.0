Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0762C47073
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 20:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A83XlxdnVonB+ajzSwmrJ/aDcmxDxTSmkYr8y7K5tZM=; b=xK/ZuyEcNu41QK
	y2h6BrY+BM/RwHHNFl9v4niApIzIYZYidCQIRzZJW6+AJYt/S2y15o1M2WGBgojfCGT7vA/6apMqy
	VyXoqBAT74fEExrpDi/97lRhJR29JzELV8CNi0PXJAIWIl3gtuXEfj4zCwKiUoH/Bs/5Rh1AZVkd+
	xKrYIyE9X36GMg9r2OjI5iGZxEPdwgE+BvcJXrWLx+XDliYpWTZh8BfBRv4Oy31uHVcNpcGg0ULrZ
	E8Bnc7EiWOylq3+Cw6t0gLzM1fnXCYxKbPLYgQbgfD0kVZ/nvbAPIznTppySTUhQYtdJFZL6YeMrv
	68ZqY73zkI/GOyOp8B4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGmQM-006poz-0D;
	Fri, 22 Dec 2023 20:47:14 +0000
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlKu-006iUr-20;
	Fri, 22 Dec 2023 19:37:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703273852; x=1734809852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLYCMQzZdYknax/wRIALOVvHrvD35sO3OPXkV3K/85M=;
  b=QAAmel78WlJ8DEf//6CTx7/t/5cM4CG3F2J+FtrpD0JY2phyGxxP/VZU
   gaQC6dq2UE2Dv4If/9rOCqJ7XZUNZp/0OrffIbpskqncjjWYOup2aHo7M
   GfPrC3+b04gA7RzTqBwYj+5I5SfkkM+HncfiZsqcl/YClOjqAciiCVvv6
   0=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="627319050"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:37:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id C66E4499DC;
	Fri, 22 Dec 2023 19:37:21 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:42367]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.218:2525] with esmtp (Farcaster)
 id 7d43c3c0-a068-40c5-899c-569b1b9ac52f; Fri, 22 Dec 2023 19:37:20 +0000 (UTC)
X-Farcaster-Flow-ID: 7d43c3c0-a068-40c5-899c-569b1b9ac52f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:37:20 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:37:16 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH v2 06/17] kexec: Add config option for KHO
Date: Fri, 22 Dec 2023 19:35:56 +0000
Message-ID: <20231222193607.15474-7-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222193607.15474-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_113732_819656_F3C19660 
X-CRM114-Status: GOOD (  13.86  )
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
index 2fd510256604..909ab28f1341 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -91,6 +91,19 @@ config KEXEC_JUMP
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
