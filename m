Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69723C83F17
	for <kexec@archiver.kernel.org>; Tue, 29 Aug 2023 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tKTNJdIOoHqFB37TDzUHMUsS/udfvLojXY04/6nun5M=; b=IpVSWa5t3d/2kx
	cQlcmxWWOZ2rl6NgS+vXLvExbOAnof6y1++KudN0HIgvdlPoRKfQeWfHzFEE0AN8VJEr45vzlNvn6
	Wc5DPT40zGlAAjIr0rgIrHHmr27lMqFPD6ofCDOXcXpQJ7NOAouhKDrL3PCFkG/JpN+BBfTAZGp0O
	hTmKVOixg7dqb9tr1WHpDBn+OyNamFQV/eIlDnbXO/4V5fSwyCgNIxJvayFU838B5rf50LORUL6q0
	8B2uK+5ogTG93x2o+YA7RKbq/wAKZAfDQ0LcrHXsPd8YNh0M4hQM7rtPOOOrKDVRwTodtXj7zVl6H
	fKCLmOKbNhCpQ3hLn7+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxeD-00BTaC-1j;
	Tue, 29 Aug 2023 12:16:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxe9-00BTXj-28
	for kexec@lists.infradead.org;
	Tue, 29 Aug 2023 12:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693311396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti+FZphx3tTCt2+5tJQ+9yD5S9gf+CV5t2KKqvLpfrs=;
	b=Z7Koo36e6903d2lLJ0oWANmCKcV6ZnDbVGgBWD9e9vSgtwD0FK7fd2+p9B963+O9ib6FOS
	zPcA0ODSI4BnGXf10uFw0z44xB+iIInjDajnSut6APlJkA367l8fewd94m1Y7B2Qps3vKV
	pywbrPYvY3GqHY+yc1qsU5bIGblfiUc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-jJXsGeYGPDecp-p64D2GmQ-1; Tue, 29 Aug 2023 08:16:33 -0400
X-MC-Unique: jJXsGeYGPDecp-p64D2GmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C92D104458F;
	Tue, 29 Aug 2023 12:16:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8F026B2B4;
	Tue, 29 Aug 2023 12:16:28 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	thunder.leizhen@huawei.com,
	dyoung@redhat.com,
	prudo@redhat.com,
	samuel.holland@sifive.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 3/8] crash_core: change parse_crashkernel() to support crashkernel=,high|low parsing
Date: Tue, 29 Aug 2023 20:16:05 +0800
Message-ID: <20230829121610.138107-4-bhe@redhat.com>
In-Reply-To: <20230829121610.138107-1-bhe@redhat.com>
References: <20230829121610.138107-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_051637_769591_3E529DE3 
X-CRM114-Status: GOOD (  15.69  )
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

Now parse_crashkernel() is a real entry point for all kinds of
crahskernel parsing on any architecture.

And wrap the crahskernel=,high|low handling inside
CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |  6 ++++++
 kernel/crash_core.c        | 28 +++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 2e76289699ff..85260bf4a734 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -77,6 +77,12 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
 
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
+#endif
+#endif
+
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
 		unsigned long long *low_size, bool *high);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index f6a5c219e2e1..355b0ab5189c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -276,6 +276,9 @@ static int __init __parse_crashkernel(char *cmdline,
 /*
  * That function is the entry point for command line parsing and should be
  * called from the arch-specific code.
+ *
+ * If crashkernel=,high|low is supported on architecture, non-NULL values
+ * should be passed to parameters 'low_size' and 'high'.
  */
 int __init parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
@@ -291,7 +294,30 @@ int __init parse_crashkernel(char *cmdline,
 				crash_base, NULL);
 	if (!high)
 		return ret;
-
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	else if (ret == -ENOENT) {
+		ret = __parse_crashkernel(cmdline, 0, crash_size,
+				crash_base, suffix_tbl[SUFFIX_HIGH]);
+		if (ret || !*crash_size)
+			return -1;
+
+		/*
+		 * crashkernel=Y,low can be specified or not, but invalid value
+		 * is not allowed.
+		 */
+		ret = __parse_crashkernel(cmdline, 0, low_size,
+				crash_base, suffix_tbl[SUFFIX_LOW]);
+		if (ret == -ENOENT)
+			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		else if (ret)
+			return -1;
+
+		*high = true;
+	} else if (ret || !*crash_size) {
+		/* The specified value is invalid */
+		return -1;
+	}
+#endif
 	return 0;
 }
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
