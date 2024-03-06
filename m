Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622D0C54E58
	for <kexec@archiver.kernel.org>; Wed,  6 Mar 2024 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tKJKrEdSeJhLik69/t23aaKHjFWc8AnttY/z/E3k//c=; b=wVurjUdZvofYAi
	SpqBx5A1ggjDNxBojfs6MLz7AOcFIF0KNaFiBY8TXuqDFm6Fx8zV5gxGqaw3GIrDHtpAFQDuu5C6B
	F4AwLIJDYghWYoAjWP9rXDQQQ7emlXCYobdVSiX6bnEvoeMYMoL6kewR/29rULVF2ZpC5MuTQpakE
	2AJ5ySh6wwR9U8zJrVT/rqJ3g27HCernJUrcTTvqToxqArjrYef0FXLZ+m8Br+BDEFQ8Gy8e2xfpn
	N8YnyYmQxz5IK61JFXRQE6MwhH9bSxEwLYMXO4yzcbzZCxLt4LOYN5GtuWwDF3ZI4oUUdhw/QAPUD
	Zg+2/OHh10h/jDmHm85w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWg-0000000HPaO-2NdD;
	Wed, 06 Mar 2024 10:29:30 +0000
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWY-0000000HPT8-3MiY
	for kexec@lists.infradead.org;
	Wed, 06 Mar 2024 10:29:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720962; x=1741256962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nq7SMqNBqa42A9Gw9it0V4iEBEk255GCXGK0EU8r0Nc=;
  b=fTkYF3dniIavEeUDdfhW9/jO+Jp0pDR6eTrLmPQBI4jbgcnpa9aL8RC1
   dKNQc8WYx98RsQSJuxdN+rmDlcYD8IlymkVih4X1Af4wAFFzOgL9RGNgs
   ydg6ephD4LA7zKqMKe1NpBesvqmJf9lukCw5G8VhkMy72/UO1XKb3WqtJ
   MFx9Ar/1clkZ7hSY11QBFPlWWmKf+Oi4z5/6/yXN9ASvGBGJZuby9IUTp
   mqH96QjArS0rycfYMQf+WoJou0URXls/NCSwdThnEq9mnKCmCDxJmzBOb
   YDhzlispu6lZDvlTvs6dFz9d0qlRmvs3YBhVJugItyKz7BM0/THlCeqLY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="130208886"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="130208886"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:17 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id BB4B0DD93A
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:12 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id F1A1BD561F
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 39F1920097BE1
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:11 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4A1AE1A006A;
	Wed,  6 Mar 2024 18:29:10 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: y-goto@fujitsu.com,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	hpa@zytor.com,
	Ingo Molnar <mingo@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	x86@kernel.org,
	kexec@lists.infradead.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 6/7] x86/crash: make device backed vmemmap dumpable for kexec_file_load
Date: Wed,  6 Mar 2024 18:28:45 +0800
Message-Id: <20240306102846.1020868-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10--8.255800-10.000000
X-TMASE-MatchedRID: Eprm7pA/VZ5ZxhI5bGrNsjiEPRj9j9rvSdIdCi8Ba4AiqRodPpseIRwE
	EIVsM/kp/lneBjailE5V00+whwxVQy/7QU2czuUNA9lly13c/gH4uJ1REX4MHbs3Yh2IOCYzJti
	zbkLGoS92PULLZTziuytFAV6Sdl32oFf+7ciBzQpYKMMlFh4BncnlJe2gk8vIMzT8XBPSpdajxY
	yRBa/qJXcsDK2xBHh7jaPj0W1qn0Q7AFczfjr/7LEnb/1qBW++QLtrZDNFv46p+VAyfOE7vP5i9
	RGEpFvIT2g+olvABKw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_022923_211128_82D62072 
X-CRM114-Status: GOOD (  12.12  )
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

Add resources with specific flags to PT_LOADs of the elfcorehdr so that
these resources can be dumpable. This change is for kexec_file_load(2)
while kexec_load(2) setups the PT_LOADs according to its parameters
by the callers which usually rely on resources' name from /proc/iomem

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Baoquan He <bhe@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 arch/x86/kernel/crash.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index b6b044356f1b..b8426fedd2cd 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -146,6 +146,8 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	if (!nr_ranges)
 		return NULL;
 
+	walk_device_backed_vmemmap_res(0, -1, &nr_ranges,
+				       get_nr_ram_ranges_callback);
 	/*
 	 * Exclusion of crash region and/or crashk_low_res may cause
 	 * another range split. So add extra two slots here.
@@ -212,6 +214,9 @@ static int prepare_elf_headers(void **addr, unsigned long *sz,
 	if (ret)
 		goto out;
 
+	walk_device_backed_vmemmap_res(0, -1, cmem,
+				       prepare_elf64_ram_headers_callback);
+
 	/* Exclude unwanted mem ranges */
 	ret = elf_header_exclude_ranges(cmem);
 	if (ret)
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
