Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A3BCD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wrJ2tQp5HE6LJ4UCkyFG7BUGy7iNPsLoQhjQzM8xHVE=; b=DJm1c8j4W5/1Z62t+y5cv3pCKA
	fluRDOUfBaBCBfDEuxlYQy1j3Pvannrgao3ImAG1rI95+wjHuCPV1jLYu1ryOQf1Z36O7rv98T3L6
	R/5QYmV/4/GN1laYje/hxde7OHskGg0tLAsryoJmEXZPNzzs0DJ7UNO24/RU8BijznlGF6eubYd+r
	kvSb+ctzENzYMTfnWaZ7qC3F/KNLIYQ9EFbOKBOH9Hc93efxc7mdkBx2ImFhM+tCcHV7pRuUGwNJw
	7QnLJ3CF7PVS0BuoLDlNZwnLBFjv2fItCRAKbqSMI1Ch/MXV+It57htXy5ONkwgz649RucxAD/16Z
	4OKwOodg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblye-00000005OM5-1oYO;
	Mon, 22 Jun 2026 21:14:44 +0000
Received: from esa2.hc555-34.eu.iphmx.com ([23.90.104.147])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblyb-00000005OKo-29LL;
	Mon, 22 Jun 2026 21:14:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782162881; x=1813698881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GnAklF3R5+7SV6HzFwpD4jHkQJ4qLIj7qNgFyn8Qlc=;
  b=HKeW2CPmGx6GSWwYojzOQKFjZEGbHNXdwurFflizcYKUeXf+Mn1z6P6P
   digMB9W5i7snfMkTe9phb8Li4ykqNo6zznc6qcTVAoKkqcLD/Khzi2rS8
   2/7xDnQraOeGxr/zu3IluT0FfdpCArn+a/BnfxYUZs63isT/9c3kCboYA
   YV7eBh6UaXhIdUvSaogpu/CTD8WspRqfGQmXDbKS1AW/hT6SfvCSoPSRB
   u14PWGR1qQ6RxVfWyamX4e2pG8J+Q7PWZGSobzFzpg4VB49+qJByJmaeF
   DZ6V19P2fX9qh30zrdrwacLyq3y0r22fAnL6A3oMZDLfGsd3D3eZOO5kW
   g==;
X-CSE-ConnectionGUID: DK8CjaJ8QASegnTdm3zcqQ==
X-CSE-MsgGUID: 7pztyn2zTYS2iRjZSDVQzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 00:14:39 +0300
X-CSE-ConnectionGUID: HH8ymZBcRCKEdbjQP7zapg==
X-CSE-MsgGUID: tUCgX8QNRNGOK4+kB7jsag==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 23 Jun 2026 00:19:48 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 00:14:37 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 1/4] vmcoreinfo: increase vmcoreinfo buffer to 8KB
Date: Tue, 23 Jun 2026 00:14:27 +0300
Message-ID: <20260622211430.4008899-2-pnina.feder@mobileye.com>
In-Reply-To: <20260622211430.4008899-1-pnina.feder@mobileye.com>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_141441_855900_5E149B54 
X-CRM114-Status: GOOD (  11.73  )
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

Additional metadata will be exported to vmcoreinfo, requiring more
buffer space than a single 4KB page provides.

Change VMCOREINFO_BYTES from PAGE_SIZE to a fixed SZ_8K. This
decouples the buffer size from the page size, avoiding waste on
architectures with large pages (e.g. 16KB on MIPS, 64KB on arm64)
while providing enough space on 4KB-page architectures like RISC-V.

The existing allocation in kimage_crash_copy_vmcoreinfo() already
uses get_order() and DIV_ROUND_UP(), so it correctly rounds up to
whole pages regardless of the constant's value.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 include/linux/vmcore_info.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index e71518caacdf..612dcf7b9ecd 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -20,7 +20,8 @@
 				     CRASH_CORE_NOTE_NAME_BYTES +	\
 				     CRASH_CORE_NOTE_DESC_BYTES)
 
-#define VMCOREINFO_BYTES	   PAGE_SIZE
+/* Fixed size independent of PAGE_SIZE to avoid waste on large-page archs */
+#define VMCOREINFO_BYTES	   SZ_8K
 #define VMCOREINFO_NOTE_NAME	   "VMCOREINFO"
 #define VMCOREINFO_NOTE_NAME_BYTES ALIGN(sizeof(VMCOREINFO_NOTE_NAME), 4)
 #define VMCOREINFO_NOTE_SIZE	   ((CRASH_CORE_NOTE_HEAD_BYTES * 2) +	\
-- 
2.43.0


