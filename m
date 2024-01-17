Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0BFC47258
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LnCKcFpt1icJCI+58DsWjKi6UDvT3tChyNO8TbYK+Tk=; b=1zrg38juXFvhS+
	WT6GV8YyRX41MhlCsbhon1XFsrdLjac2LfZCE2q0zs/VC8NejMS1ZjdSOW4L6UftTdlxApUYbOyNr
	I2cWgfrjTIMDDU2gndV8mT9X67Et1gLzsfFTySoqF3kSdT+ZJHMv5vqXNwyD5qnxoBiP7pMqSOoOU
	4P9AZahdX/DXNWvidQOGKFA+tPz4TzOOc3hiSxrWiFfjnPWhXKNLNCWVJMiTHC9MBr2mfbEmI8h5b
	y5dzZ/+WQGVv9edLr+V/HLRpsCPb1dfvcgKKrv0FKdDHR9fZy8fACaCB3T9PvKIurb18OZgF250dw
	De8zx+sJXp6ExsZvi40Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7FG-00HJIj-15;
	Wed, 17 Jan 2024 14:50:22 +0000
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7F6-00HJ9N-2b;
	Wed, 17 Jan 2024 14:50:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705503013; x=1737039013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K22H13Upw8ZJvq6V1e5pgkkFku3zAKlZ1ZPbskJJqpo=;
  b=SY/xaT2i20T4hrpzetlE1V0HFVckm5+tLUPrJfEIJk19tXYpiYqwI0iG
   Pfq16mALcaNfH6/ZbPe3RRQkqp+lZpzreg/O9xXNPwyT+Sdx7IJzwVX33
   KxKnXwlXj3bPZPUgR06plYhZ/u1axC+vHRPYYWde5yKuSVUQ7EL09ivoq
   g=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="697789089"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:50:12 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id B58F8100FC5;
	Wed, 17 Jan 2024 14:50:03 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:29526]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.57:2525] with esmtp (Farcaster)
 id bc9be742-cddd-4430-a2bc-c8966b4ce96c; Wed, 17 Jan 2024 14:50:03 +0000 (UTC)
X-Farcaster-Flow-ID: bc9be742-cddd-4430-a2bc-c8966b4ce96c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:50:02 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:58 +0000
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
Subject: [PATCH v3 16/17] tracing: Add config option for kexec handover
Date: Wed, 17 Jan 2024 14:47:03 +0000
Message-ID: <20240117144704.602-17-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_065012_983073_7F2A2C26 
X-CRM114-Status: GOOD (  14.39  )
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

Now that all bits are in place to allow ftrace to pass its trace data
into the next kernel on kexec, let's give users a kconfig option to
enable the functionality.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Select crc32
---
 kernel/trace/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..418a5ae11aac 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1169,6 +1169,20 @@ config HIST_TRIGGERS_DEBUG
 
           If unsure, say N.
 
+config FTRACE_KHO
+	bool "Ftrace Kexec handover support"
+	depends on KEXEC_KHO
+	select CRC32
+	help
+          Enable support for ftrace to pass metadata across kexec so the new
+	  kernel continues to use the previous kernel's trace buffers.
+
+	  This can be useful when debugging kexec performance or correctness
+	  issues: The new kernel can dump the old kernel's trace buffer which
+	  contains all events until reboot.
+
+	  If unsure, say N.
+
 source "kernel/trace/rv/Kconfig"
 
 endif # FTRACE
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
