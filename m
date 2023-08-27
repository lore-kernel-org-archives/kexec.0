Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B033FC83F13
	for <kexec@archiver.kernel.org>; Sun, 27 Aug 2023 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tKTNJdIOoHqFB37TDzUHMUsS/udfvLojXY04/6nun5M=; b=FTnyDweed+xPMx
	77BrWIfZNiAnlvg7YkUAQ9u8U6SS0Z2C8lCODNvcgImz71g/wVlLG+2deiDRcNJDEZMHzAUXnqS8o
	1upJBXR+lQlC63RShyDRowSMsiMTMzymI3Xngz8z5aKBA3cMggYkIczMSIDE2cthnquOd09fzbxQr
	OxTbH9X+yGFkTDsqMtIntxCaO03jnF5b3VOEuSlvf09IPreLz35vI1huSC+vHoVKnKsUFL7jFmXSo
	vDYBr+HxDlL8udNKiwz9+cxuiwonR5pfKHY2wD9sdkVPWl76ZFNzhzLvMwVinbaL7b587ZC7PJgeF
	mCWz9+gD0kIn6+Bk8CWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaCkj-007ort-0V;
	Sun, 27 Aug 2023 10:12:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaCkR-007oY6-1U
	for kexec@lists.infradead.org;
	Sun, 27 Aug 2023 10:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693131118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti+FZphx3tTCt2+5tJQ+9yD5S9gf+CV5t2KKqvLpfrs=;
	b=BSbJGcyr37A2LmkmpN0T/4OotRdJvFoox7vvS/p5RZnRZ7Z17PIQudcyGt3hNtbNbz1LMw
	Uf4hIjTZfKJHbLwIskLX30JupbnerTEoadQRT5MM49LxlIBmJGylUAjtVU4rgR8QXthiS3
	7Wj/hCW1BPiDDwX182Xr1TyWllWAUiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-h0NDYsL3PUmeR2mCgbvofA-1; Sun, 27 Aug 2023 06:11:55 -0400
X-MC-Unique: h0NDYsL3PUmeR2mCgbvofA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D6C88D40A0;
	Sun, 27 Aug 2023 10:11:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F41802166B25;
	Sun, 27 Aug 2023 10:11:50 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	thunder.leizhen@huawei.com,
	dyoung@redhat.com,
	prudo@redhat.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 4/8] crash_core: change parse_crashkernel() to support crashkernel=,high|low parsing
Date: Sun, 27 Aug 2023 18:11:23 +0800
Message-ID: <20230827101128.70931-5-bhe@redhat.com>
In-Reply-To: <20230827101128.70931-1-bhe@redhat.com>
References: <20230827101128.70931-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230827_031159_578589_A053A403 
X-CRM114-Status: GOOD (  15.18  )
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
