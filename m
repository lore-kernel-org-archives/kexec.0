Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516D3C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 00:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7G9I32DJcHryLIeEWsfixrpBvTkELjcSt/fikRhFOow=; b=a/qsEUjMjKumEQ
	nXMGUwxZbrwA+altDI71HKz89K/ex30+eJv9Px4wEE2CZsuilQ31YBw6TjuhDEX97HIvdfVCmjPi2
	+cdKJ7NUa1vIbyXL00xxQl77nfI9ZZT9b+M/CghLNBt0k+O3XvSXwmtBPOTfyT8xZS/IkTk615mc1
	2DPriWCyYmLR/mLF0Hh35J4EEUcJDoqdKlZGbZe/gYEjqcR6yHTua3q3pJU0ce7j9DUOKe7An3ogU
	Yve2BCSyGNLhtCpPBOk1NnIgnXLbZqvBbir8tr08u4mCrKM0L8QG7lq4eucJLiLWxUNl8/j3dwOgD
	jFCPsyZL4CindXjZcYxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCnM-00D8e9-2B;
	Wed, 13 Dec 2023 00:08:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCnJ-00D8cq-1j;
	Wed, 13 Dec 2023 00:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8E5gYeBn7LzFXeE9t3+WWJhfPWwonViYFj973oiYUIk=; b=GmpDsmGNWfzTgmYJWEqMH+9em1
	YdwfVPuP1OXIggTgIIzlH1415D4pLk/KfG7V4q+oe9ye4AJCkR1iiQVaKejkvCUcMr2jOeCrqKtG0
	iseIX1ih9L3fdredFhMbs8k1ir+GuFh10ugVnXFlo54/2PLOHqLIJB0wHreMZFjEmM7Jv/KfkOdcX
	ksZZnAORzAsdTHl5Sf/qkZZ4zazaM1ad4RIO0B5l2UCqSIlcwOAqQPYbG117f+pZTY9/Jf4NSpovo
	VSeK2wpPjw7CNmIeQP41mbkNJLn5q+ZC9vdZFPnt6jj22UKsn011oSWhclfvTZIEMYN01/IvNVREK
	N86SCEDg==;
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCnF-008sRZ-0C;
	Wed, 13 Dec 2023 00:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426086; x=1733962086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8E5gYeBn7LzFXeE9t3+WWJhfPWwonViYFj973oiYUIk=;
  b=tZWEk/eP1tCVh9F39g1O5VlcUJPscrQIubJViG+m7LjXSIDfy2LGKH46
   G3h/UGlMmwGCT7wo7xxbDj1MzootNi6ZXFPjaGjUI78JDj7M5FV69gFrl
   +Qm9OrfFOz8GeUlRJ03POHt5N4ERQUSVuZF9bmHs46PxvUBot/StUveJi
   w=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="621371857"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:08:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id EF61380632;
	Wed, 13 Dec 2023 00:07:52 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:16104]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 3bda4ab2-5ec6-4d32-90c9-2880fbf14c72; Wed, 13 Dec 2023 00:07:51 +0000 (UTC)
X-Farcaster-Flow-ID: 3bda4ab2-5ec6-4d32-90c9-2880fbf14c72
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:44 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:40 +0000
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
Subject: [PATCH 15/15] tracing: Add config option for kexec handover
Date: Wed, 13 Dec 2023 00:04:52 +0000
Message-ID: <20231213000452.88295-16-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_000805_746233_943D2463 
X-CRM114-Status: GOOD (  13.88  )
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
 kernel/trace/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..af83ee755b9e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1169,6 +1169,19 @@ config HIST_TRIGGERS_DEBUG
 
           If unsure, say N.
 
+config FTRACE_KHO
+	bool "Ftrace Kexec handover support"
+	depends on KEXEC_KHO
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
