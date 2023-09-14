Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF8CCA0ED0
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 03:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NTRzcaU+bzHAuiHOOUF0ez2ZT6o7/T+qJ4fQUbPoDJ8=; b=YnHUQ/GnuxHfxV
	QIBHpdt+b5fi9zXvskM3KUzIVX6DRkWt3SpxbOWp76SfnpRW53Uy+Wu+3sbmC9UyXPFDATLWKXcI0
	Eixct6u5s+FYDhiBxB3+9p6ssOqvTgrNOMcLvPEqoAasBn/hMO7eafr6hUnvqnTI+/8Q36nGPIvv8
	Ix5xLMtxNe/GQaG/NhXXI42NTSlaSA0zEtjnvnOP+AFRefiLNFOFYIQerJ25x3l9tkwfPsQXyykV5
	kKme3GnxCD+bKYkTTMT5CST+nIYKqbc4fpGoQ8GWPIOdV6RJwK/j2rbmeVslZy9tC3Ihl68EayqoF
	1Vo1If80kKMbepsJSwyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd61-007GLj-1P;
	Thu, 14 Sep 2023 03:32:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd5o-007G6N-0G
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 03:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694662355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84e78RW9ozQMqOd2HZjEsxWYJUdZRFgV+7wAdbe6THU=;
	b=IjE+7tJbluJSh7SW6BUAu3Hdl6ATph4iQiN6k1HCgs4DIcSVjoFR9Td6AAojNtSBE8FsT7
	Sg3QPJsXIXF8NC2ZVgkoyG+qCuLGaUAPkgmxqs1sXGG93fxsH8DcnC+bjCJprks92gTfPl
	KwOXR5uW+L8nABUHfNfJYTTvljyLCQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-5gDvrYr_NW2QYV57OjzW7A-1; Wed, 13 Sep 2023 23:32:31 -0400
X-MC-Unique: 5gDvrYr_NW2QYV57OjzW7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43466805B29;
	Thu, 14 Sep 2023 03:32:31 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5E58D10085C0;
	Thu, 14 Sep 2023 03:32:27 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	thunder.leizhen@huawei.com,
	catalin.marinas@arm.com,
	chenjiahao16@huawei.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 9/9] crash_core.c: remove unneeded functions
Date: Thu, 14 Sep 2023 11:31:42 +0800
Message-ID: <20230914033142.676708-10-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_203236_283717_3B7EC4EF 
X-CRM114-Status: UNSURE (   8.48  )
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

So far, nobody calls functions parse_crashkernel_high() and
parse_crashkernel_low(), remove both of them.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/crash_core.h |  4 ----
 kernel/crash_core.c        | 18 ------------------
 2 files changed, 22 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 3c735a7e33fb..3426f6eef60b 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -96,10 +96,6 @@ void final_note(Elf_Word *buf);
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
 		unsigned long long *low_size, bool *high);
-int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
 
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index ad7dc03f3993..1a77d466eaed 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -350,24 +350,6 @@ int __init parse_crashkernel(char *cmdline,
 	return ret;
 }
 
-int __init parse_crashkernel_high(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
-{
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				suffix_tbl[SUFFIX_HIGH]);
-}
-
-int __init parse_crashkernel_low(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
-{
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				suffix_tbl[SUFFIX_LOW]);
-}
-
 /*
  * Add a dummy early_param handler to mark crashkernel= as a known command line
  * parameter and suppress incorrect warnings in init/main.c.
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
