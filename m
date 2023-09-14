Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49739EE021F
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 03:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=th8rfT9I5RVUQYdwJu6+5/TipNnOFZ01VlJ+szwSOAc=; b=sygLPxuK9Axamg
	jTYR9BkuUPa7/4beIMCyI5/+rEtNu1MUKNiamul3lqcyvW66ZqXKvIG8Zb0LdsuK+kkAjtqpKFL6L
	ju0iQkPphNSZGJv8mtTgdTWc+yqXG9gG6+eT0DgdOA4EjsPvy9sYvQTmOLhWMghhVp9wWKuJblnt+
	3G5dv/B68glIDN9AoI63mMgPbbumpvWH8DiwgSBj5Tn6+8q3Iu/E7QmEoVsB4bxM1X1tg3Gz3C12z
	EnUnpqOKilAs4284ycI2Oqca/69XTBW/3TCZjkil2BHRn89+xH/kEAaPUO9BvXAVzM6nJSmuk+miF
	LiA6R9INcxoSoELEI9/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd5X-007FnM-1Q;
	Thu, 14 Sep 2023 03:32:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd5O-007FfD-11
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 03:32:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694662329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LO8iddQy5SUYo0oFdFE0+QnNUGHrkEvy5Cyf9fh/McM=;
	b=CmcRAejF4yRvIVJDpc5m3/gKW1uA9jOwZh5TRMgX4T7Q3dkp3sffFv8/RZyQSGPKGbdiL8
	/l89FgNzIpNneNw19A9vSRGoQd71oGSqkpBHCv2f3jJ6CN9jt9UwgMehbX0J8D9AAu6HND
	FQVQx6VxPyTeFGP5LIH0S5hmUyDoNwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-EMldp75JNTm8H3vUthNEkA-1; Wed, 13 Sep 2023 23:32:04 -0400
X-MC-Unique: EMldp75JNTm8H3vUthNEkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A7FF185A790;
	Thu, 14 Sep 2023 03:32:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B36BA10F1BE7;
	Thu, 14 Sep 2023 03:31:59 +0000 (UTC)
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
Subject: [PATCH v3 3/9] crash_core: change parse_crashkernel() to support crashkernel=,high|low parsing
Date: Thu, 14 Sep 2023 11:31:36 +0800
Message-ID: <20230914033142.676708-4-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_203210_426479_5B387058 
X-CRM114-Status: GOOD (  15.92  )
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
 kernel/crash_core.c        | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 6156355ef831..d8050a7eab01 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -79,6 +79,12 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
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
index cca1d76e8255..dce2f5874fea 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -283,6 +283,9 @@ static int __init __parse_crashkernel(char *cmdline,
 /*
  * That function is the entry point for command line parsing and should be
  * called from the arch-specific code.
+ *
+ * If crashkernel=,high|low is supported on architecture, non-NULL values
+ * should be passed to parameters 'low_size' and 'high'.
  */
 int __init parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
@@ -296,10 +299,37 @@ int __init parse_crashkernel(char *cmdline,
 	/* crashkernel=X[@offset] */
 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
 				crash_base, NULL);
-	if (!high)
-		return ret;
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	/*
+	 * If non-NULL 'high' passed in and no normal crashkernel
+	 * setting detected, try parsing crashkernel=,high|low.
+	 */
+	if (high && ret == -ENOENT) {
+		ret = __parse_crashkernel(cmdline, 0, crash_size,
+				crash_base, suffix_tbl[SUFFIX_HIGH]);
+		if (ret || !*crash_size)
+			return -EINVAL;
 
-	return 0;
+		/*
+		 * crashkernel=Y,low can be specified or not, but invalid value
+		 * is not allowed.
+		 */
+		ret = __parse_crashkernel(cmdline, 0, low_size,
+				crash_base, suffix_tbl[SUFFIX_LOW]);
+		if (ret == -ENOENT) {
+			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+			ret = 0;
+		} else if (ret) {
+			return ret;
+		}
+
+		*high = true;
+	}
+#endif
+	if (!*crash_size)
+		ret = -EINVAL;
+
+	return ret;
 }
 
 int __init parse_crashkernel_high(char *cmdline,
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
