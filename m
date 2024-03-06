Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06896C5475B
	for <kexec@archiver.kernel.org>; Wed,  6 Mar 2024 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z8kVjqUCHHlhGqK6KEJzrb7OA/LBk2cQXV4PbjlfAbY=; b=dTj/wOeZcOCr8y
	yF5T6t6Ionqn+eRnIFa92cAqvGjQwbK0CG3fKDpXTytavtmTWXWhZNOdccdsNFic39RQIomG6iZ03
	7sjLKqfZY1rjmOHKWRoggb0MKBx3aHeZ3URi3O8C1ZwHy/145O6Hjhdntw1iQX6ZBCZn73/xjvsE6
	7H/n812rlWKneuvI3/XAo0Y52zkNt8mYKTb00kQ66tml2IEcPxbqwejvSH7RVMtpLil0D/k6pmGgk
	u93mRxF/s/Foq8UynSU0PFqT8yR+oOtM7LWwU8V4qgPXMcEo8mpMvGib29e63x2esfjA7pEN867Qd
	FWOvDhGL+gL3qnjALDEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWb-0000000HPWq-1fy4;
	Wed, 06 Mar 2024 10:29:25 +0000
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWT-0000000HPQ9-1zbN
	for kexec@lists.infradead.org;
	Wed, 06 Mar 2024 10:29:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720957; x=1741256957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XdN3aG00u/QsuyGD6b2X8W2/qtDpU1h/uB9UBsmVuQc=;
  b=nwY6sBo259PmxbdPKCPl4zd+AwiUMSoyFlT6vhLMpSQBKxI3fDw7RwXK
   AmHDThatPSwur1dbVH5t0oqou+3Nra10xaILlooA7ukQuuxAqUvfksCp+
   6Hk3PBNfBwWRqSdPZMH1t+sG0fyj9GXlE1B1CBFmpX8cz1ieKEkpwBc2L
   Fn2wIIlkBrmgSHXAV096QdXY1YB7Rn7v2Z8Mx5JIXbOmQWLDClaz184jp
   eoPNHi3Ta5NcZkx7Y5RNaeb6e79vxuut+ZxbjlpwKv2da2sVBy7LBA6NH
   3NAbFg1K1T5bfdOZh8O0hrq/iWwaUUl16pfKQuRuNvSJKj2q4LSLlzMGW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="150857722"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="150857722"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:14 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E2965A345D
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:11 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 19EE7D2BA6
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6ACC52030C7E9
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 782981A006D;
	Wed,  6 Mar 2024 18:29:09 +0800 (CST)
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
Subject: [PATCH v3 5/7] resource: Introduce walk device_backed_vmemmap res() helper
Date: Wed,  6 Mar 2024 18:28:44 +0800
Message-Id: <20240306102846.1020868-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10--2.753200-10.000000
X-TMASE-MatchedRID: VGeBglENKylzKOD0ULzeCRFbgtHjUWLyPeYVUCg2LRwBLwIiWDU8ay15
	IFUNL+ETjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmRcFEiuPxHjsXDCscXmnDN79P7VmP7Drr66us
	OKvlQZawRYCju0yIRX4Ay6p60ZV62Mhe627A+8aHdB/CxWTRRu+rAZ8KTspSzZ9zg/iRwE4LkAQ
	bstzNuLM5Iu+GqAiaI4D/GW2/5ILcxeNB9x03X8fQFNK0GDkNxsoGRy2pyHXLNTBw2qqp0+A7H6
	7Vl1o7oIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_022917_846697_3AAE3281 
X-CRM114-Status: GOOD (  11.27  )
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

It walks resources registered with flags
(IORESOURCE_DEVICE_BACKED_VMEMMAP | IORESOURCE_BUSY), usually used by
device backed vmemmap region. currently, it only sticks to the
persistent memory type since it is only one user.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Baoquan He <bhe@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Alison Schofield <alison.schofield@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 3b59e924f531..10a60227d6c2 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -332,6 +332,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_device_backed_vmemmap_res(u64 start, u64 end, void *arg,
+			       int (*func)(struct resource *, void *));
+extern int
 walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 			int (*func)(struct resource *, void *));
 extern int
diff --git a/kernel/resource.c b/kernel/resource.c
index fcbca39dbc45..5f484266af07 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -431,6 +431,19 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 				     func);
 }
 
+/*
+ * This function calls the @func callback against all memory ranges, which
+ * are ranges marked as (IORESOURCE_DEVICE_BACKED_VMEMMAP | IORESOURCE_BUSY)
+ * and IORES_DESC_PERSISTENT_MEMORY.
+ */
+int walk_device_backed_vmemmap_res(u64 start, u64 end, void *arg,
+			int (*func)(struct resource *, void *))
+{
+	return __walk_iomem_res_desc(start, end,
+			IORESOURCE_DEVICE_BACKED_VMEMMAP | IORESOURCE_BUSY,
+			IORES_DESC_PERSISTENT_MEMORY, arg, func);
+}
+
 /*
  * This function, being a variant of walk_system_ram_res(), calls the @func
  * callback against all memory ranges of type System RAM which are marked as
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
