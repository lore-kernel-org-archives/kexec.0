Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5C3CD98F2
	for <kexec@archiver.kernel.org>; Fri, 19 Jun 2026 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=upm7hjjighMX28RxALYlLLqfXqHttETy53AIK73LdCk=; b=LY8C5mVgrPr9WJBvZ+/rzz1yMy
	5FelUQe66b+0VVDflzNM1HdzOlhAxvtYjo2G7xVb6E32tMmFzvlvvRiSsGaUSatvv2TT2neNS4e7t
	6qb7vSNzn4j2s/2PIpXn3X0xHsKB7xOBWR6pijXfdpaEZLNjn7RKblmU5D4cJbHtvBMoVp4KE6ZjB
	lvSWiINkkS7oEgLztVsLgOWBW7qvjY8WHueJmpoXuTWmJQAer4Dfuc2RMx82sFIbJvq57ApIGCMum
	5IYCSOgjI5uvlirLRWta0g3Y8OWxgmBW2SuDMaWc1OmLu8zVWF1hA4Nkbky0Kq43I8amkGNF43AaK
	IH/yALEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wabkM-00000002kob-1ws3;
	Fri, 19 Jun 2026 16:07:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wabkG-00000002ko8-3gXC
	for kexec@lists.infradead.org;
	Fri, 19 Jun 2026 16:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781885223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=upm7hjjighMX28RxALYlLLqfXqHttETy53AIK73LdCk=;
	b=XUPCEX6eXjrPceLpFz1QRbX4T5VHFUxb/+f2mGQKSBshNh1CwoXza6Y+Ird3oiSdTL/Y0l
	NVZecEwVoSg+7yo/c2nApls9rwx6jKbZRMmIFlseqnHu1z3D+od+rG5W0UUaGqxigzYQsr
	J5crVENjfDD5/qh6MKLjwb5kWfkH7+0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-p01PRTQeNjiOZ9xLcfZq5g-1; Fri,
 19 Jun 2026 12:07:00 -0400
X-MC-Unique: p01PRTQeNjiOZ9xLcfZq5g-1
X-Mimecast-MFC-AGG-ID: p01PRTQeNjiOZ9xLcfZq5g_1781885219
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF661180AD54;
	Fri, 19 Jun 2026 16:06:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7D56195419D;
	Fri, 19 Jun 2026 16:06:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: Replace __ASSEMBLY__ with __ASSEMBLER__ in header file
Date: Fri, 19 Jun 2026 18:06:54 +0200
Message-ID: <20260619160654.75980-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: EnUzsSZbrRrXgdWV_Nu4muve8vDsprAmGn2U3pdyxAo_1781885219
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_090704_995475_44504F05 
X-CRM114-Status: GOOD (  11.93  )
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

From: Thomas Huth <thuth@redhat.com>

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize now
on the __ASSEMBLER__ macro that is provided by the compilers.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: This patch has been split from an earlier bigger patch of
 mine to ease reviewing.

 include/linux/kexec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8a22bc9b8c6c8..0af8ae4fdd087 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -13,7 +13,7 @@
 #define IND_SOURCE       (1 << IND_SOURCE_BIT)
 #define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 #include <linux/vmcore_info.h>
 #include <linux/crash_reserve.h>
-- 
2.54.0


