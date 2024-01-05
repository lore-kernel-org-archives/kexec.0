Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FF9C46CD2
	for <kexec@archiver.kernel.org>; Fri,  5 Jan 2024 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vN0oTIpms4P8xBAM7Q60g0JRcwnI/kMQ0rlW2QQztIs=; b=vu5LjQ9296q+ku
	2IXjZIYsSlQbAOl0oiq48+KI2Jd6YTFF7Y3RwuptE9L/cceDsCXOI5q6M+/YBZ1y3sy//GFQTpM+t
	RzvBS8dbWh+SW6S4uHzCVJlHW8O5oBEwGwlF1+AatoNGSIVhg2TzjYxFFh3xe9nP4v6Fh2OUXC9st
	vKPJVjPytH9caGTuAG7XjEnKHF8O6NwxBCQS2JA0lxXFKmQMvM1X31fK/HvAPhPdzPlkMBWQJMNRB
	v8bTPWTjcRzYQT+SUi62aTuXeHXCJLUIdkdxgb7gEmVBsRT6d1qdOL/uR/92Bk9WTo+DTejMKPFEM
	KWtOWMvdDLyguKw2cAdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLieF-00GgiC-2Q;
	Fri, 05 Jan 2024 11:45:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLhWX-00GYEK-2A
	for kexec@lists.infradead.org;
	Fri, 05 Jan 2024 10:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704450836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2HBs3OFSUIo1mUaqHX6XKawGogz4cRNe54pAihhNU4=;
	b=KHS+eX9OADFjrHmpxzNCL1CGerch7Ry/HAm/q7Bi8m+g2epyJbXFRndnawmmh3vmhW2/NZ
	VAbPATcVxiWzvF9zsx9zI9sBWpjJWADKQv1R+yV5IGIOfEvmbIA+4g3tlTmM8wXVLrsSdR
	Oyl3zd9sjNmz6tDjUMT0IFf0zkeC1A0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-Rb3lS4pWNTu-90VMiNhIEg-1; Fri,
 05 Jan 2024 05:33:51 -0500
X-MC-Unique: Rb3lS4pWNTu-90VMiNhIEg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED01F3C02786;
	Fri,  5 Jan 2024 10:33:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 40706492BC6;
	Fri,  5 Jan 2024 10:33:43 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	kexec@lists.infradead.org,
	hbathini@linux.ibm.com,
	arnd@arndb.de,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	viro@zeniv.linux.org.uk,
	ebiederm@xmission.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 5/5] crash: clean up CRASH_DUMP
Date: Fri,  5 Jan 2024 18:33:05 +0800
Message-ID: <20240105103305.557273-6-bhe@redhat.com>
In-Reply-To: <20240105103305.557273-1-bhe@redhat.com>
References: <20240105103305.557273-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_023357_838068_518FEEA6 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
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


By splitting CRASH_CORE into CRASH_RESERVE and VMCORE_INFO, and cleaning
up the dependency of FA_DMUMP on CRASH_DUMP, now we can rearrange CRASH_DUMP
to depend on KEXEC_CORE, and select CRASH_RESERVE and VMCORE_INFO.

KEXEC_CORE won't select CRASH_RESERVE and VMCORE_INFO any more because
KEXEC_CORE enables codes which allocate control pages, copy
kexec/kdump segments, and prepare for switching. These codes are shared
by both kexec_load and kexec_file_load, and by both kexec reboot and
kdump.

Doing this to make codes and the corresponding config items more
logical.

PROC_KCORE -----------> VMCORE_INFO

           |----------> VMCORE_INFO
FA_DUMP----|
           |----------> CRASH_RESERVE

                                                ---->VMCORE_INFO
                                               /
                                               |---->CRASH_RESERVE
KEXEC      --|                                /|
             |--> KEXEC_CORE--> CRASH_DUMP-->/-|---->PROC_VMCORE
KEXEC_FILE --|                               \ |
                                               \---->CRASH_HOTPLUG

KEXEC      --|
             |--> KEXEC_CORE--> kexec reboot
KEXEC_FILE --|

Previously, LKP reported a building error. When investigating, it can't
be resolved reasonablly with the present messy kdump config items. With
the prepartory patches and chaneg at above, the LKP reported issue can
be solved now.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312182200.Ka7MzifQ-lkp@intel.com/
---
 kernel/Kconfig.kexec | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 8faf27043432..6c34e63c88ff 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -9,8 +9,6 @@ config VMCORE_INFO
 	bool
 
 config KEXEC_CORE
-	select VMCORE_INFO
-	select CRASH_RESERVE
 	bool
 
 config KEXEC_ELF
@@ -99,8 +97,11 @@ config KEXEC_JUMP
 
 config CRASH_DUMP
 	bool "kernel crash dumps"
+	default y
 	depends on ARCH_SUPPORTS_CRASH_DUMP
-	select KEXEC_CORE
+	depends on KEXEC_CORE
+	select VMCORE_INFO
+	select CRASH_RESERVE
 	help
 	  Generate crash dump after being started by kexec.
 	  This should be normally only set in special crash dump kernels
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
