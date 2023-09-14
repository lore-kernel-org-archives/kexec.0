Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4074CA0ECE
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 03:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7G1BsIX1pbR14ZS+ZwBM3VIP9qZbxyyT4CGC88SPoW4=; b=IPEo8MzL/pN1DN
	ugOyYMWmpVsdlp5tNXdXZNor738v/7wgw0nce75GICkDJ0ZdLTyOhsZsdWQ5Ir+aeIWvU3QHqe/5R
	4xMYN8G4FRmSfJaUXMH0Ol5Cx88N4LQ2pYcckcXrdG9+q1lPQJRt+D4tOdpBhZ/HqK44tt/Cg30jl
	942U10lGMpOfW2XJqEFnpQyVNzI8SLfbV8C0GKCd1aPzsgPuqlWnZGTrAdzcE0DNMVLDyyDgnakS/
	SgFuna/eV7Up87uAuPf4LyOIxaohmofO6mF/g2pdRFiaJ7mfKK/ZfcwnlB3M9hZzEHj15E0CQJMVx
	+9yBQD/MPIEryGyPWpMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd5O-007FgG-2v;
	Thu, 14 Sep 2023 03:32:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd5G-007FYl-3B
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 03:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694662319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjqOcwWBrkh/CdUM/5gfUPqEhH0IYqtSZbAnP+4qzQo=;
	b=ii1FH1uO+Km49c2/02wj6FEQ3n1wQ8C/1dFliDtNXmmPyTJKZcYR1myfKuDxTS+Bd+Y/Ig
	kmrn+6ozGEaRPnWtZZK6UXHptWaEWJY7DPn5t0+kL7/jmJaThGvQ2dE12H9i0NlNab2GLQ
	7gnsjvjDJ0N2n1l4occifrilp/a6ZIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-8r3y9f3cN0Sw9nZr-XdCgw-1; Wed, 13 Sep 2023 23:31:55 -0400
X-MC-Unique: 8r3y9f3cN0Sw9nZr-XdCgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8724B802D38;
	Thu, 14 Sep 2023 03:31:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 773611054FC0;
	Thu, 14 Sep 2023 03:31:50 +0000 (UTC)
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
Subject: [PATCH v3 1/9] crash_core.c: remove unnecessary parameter of function
Date: Thu, 14 Sep 2023 11:31:34 +0800
Message-ID: <20230914033142.676708-2-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_203203_159513_037A94BA 
X-CRM114-Status: GOOD (  10.24  )
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

In all call sites of __parse_crashkernel(), the parameter 'name' is
hardcoded as "crashkernel=". So remove the unnecessary parameter 'name',
add local varibale 'name' inside __parse_crashkernel() instead.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/crash_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..c9695204715d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -248,11 +248,11 @@ static int __init __parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base,
-			     const char *name,
 			     const char *suffix)
 {
 	char	*first_colon, *first_space;
 	char	*ck_cmdline;
+	char	*name = "crashkernel=";
 
 	BUG_ON(!crash_size || !crash_base);
 	*crash_size = 0;
@@ -290,7 +290,7 @@ int __init parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_base)
 {
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-					"crashkernel=", NULL);
+				NULL);
 }
 
 int __init parse_crashkernel_high(char *cmdline,
@@ -299,7 +299,7 @@ int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long *crash_base)
 {
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
+				suffix_tbl[SUFFIX_HIGH]);
 }
 
 int __init parse_crashkernel_low(char *cmdline,
@@ -308,7 +308,7 @@ int __init parse_crashkernel_low(char *cmdline,
 			     unsigned long long *crash_base)
 {
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
+				suffix_tbl[SUFFIX_LOW]);
 }
 
 /*
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
