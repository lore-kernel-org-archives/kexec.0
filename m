Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED367C6FD1F
	for <kexec@archiver.kernel.org>; Fri, 29 Mar 2024 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dVoDOcwyuW003JC6lfI913m7XgP3/pS+6sK/ueAKL1c=; b=Zjbch6thqjRtTT
	/uwFPi05iSIktSgUajTxiSPcjbQoD8G2SmBHnwUd17LNBuqHjfXx+qiNDtvXXRqWGf5S6DAW+kWsX
	+p8qOmiha/tjBc16j3djISd1/zkFeXneRo0zhL87873COHQO1w1I3+66tCJXlwEbjTKFl+vPWSEaO
	A/RyOC2V8r+rpuL5dy5LCLvofwkBCxf6J9w/razMIXUkl9bx9mROSlCTflT2JtDX+o4USVds5ek6O
	sihUYLqEiPw9G7R2RXjKwJn1u/BLIsy2CXXaZxYMcgM242Xuc02EHbeFo2tqB7lkwm4t5GIQpyBNB
	TUpAuUT5BZaC/RFFDhSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqCI3-00000000f1X-1HDb;
	Fri, 29 Mar 2024 13:29:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqCI0-00000000ezT-3G4L
	for kexec@lists.infradead.org;
	Fri, 29 Mar 2024 13:29:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711718939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vu3HiU58Dw80kabS3QBMxjcxeWQKlJYr1jCBy9fsfY=;
	b=Aohgnbk372p9YV2VhXoQiqpKHAL9aikVVERTt/ct8PG2B64t9UPIShOfIawsZfY5ssqA3e
	ntBnqJydWUlL1qiaTRN8T8/sx0EAPqB5JPhJLLPkguU+iiVIrbYlbRBKFmX/s/wVcPY5kv
	ukaBm/biHOJSeqOCJtgBAHtFhLkhGXU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-8XcBOoJiOU-9eZsH4ZWrrA-1; Fri,
 29 Mar 2024 09:28:52 -0400
X-MC-Unique: 8XcBOoJiOU-9eZsH4ZWrrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49D2D382613D;
	Fri, 29 Mar 2024 13:28:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 916671C06541;
	Fri, 29 Mar 2024 13:28:40 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: akpm@linux-foundation.org,
	geert@linux-m68k.org,
	chenhuacai@kernel.org,
	Baoquan He <bhe@redhat.com>,
	corbet@lwn.net
Subject: [PATCH 2/2] Documentation: kdump: clean up the outdated description
Date: Fri, 29 Mar 2024 21:28:25 +0800
Message-ID: <20240329132825.1102459-3-bhe@redhat.com>
In-Reply-To: <20240329132825.1102459-1-bhe@redhat.com>
References: <20240329132825.1102459-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_062900_925705_035F0137 
X-CRM114-Status: UNSURE (   8.22  )
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

After commit 443cbaf9e2fd ("crash: split vmcoreinfo exporting code out
from crash_core.c"), Kconfig item CRASH_CORE has gone away in kernel.
Items VMCORE_INFO and CRASH_RESERVE are used instead.

So clean up the outdated description about CRASH_CORE and update it
accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: corbet@lwn.net
---
 Documentation/admin-guide/kdump/kdump.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 0302a93b1d40..5376890adbeb 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -136,10 +136,6 @@ System kernel config options
 
 	CONFIG_KEXEC_CORE=y
 
-   Subsequently, CRASH_CORE is selected by KEXEC_CORE::
-
-	CONFIG_CRASH_CORE=y
-
 2) Enable "sysfs file system support" in "Filesystem" -> "Pseudo
    filesystems." This is usually enabled by default::
 
@@ -168,6 +164,10 @@ Dump-capture kernel config options (Arch Independent)
 
 	CONFIG_CRASH_DUMP=y
 
+   And this will select VMCORE_INFO and CRASH_RESERVE::
+	CONFIG_VMCORE_INFO=y
+	CONFIG_CRASH_RESERVE=y
+
 2) Enable "/proc/vmcore support" under "Filesystems" -> "Pseudo filesystems"::
 
 	CONFIG_PROC_VMCORE=y
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
