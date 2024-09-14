Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF316C02190
	for <kexec@archiver.kernel.org>; Sat, 14 Sep 2024 11:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/LQRZa4bbkJCiheMhcJia4S4mulzJ/Tvy4u82mvZvdI=; b=c1SWJ5Ht5hYixN
	1hy+bzsLIk/EYzIwooaDmUW1xCwHBF/OkiJUvff3J98iEE+avJrQxkEz1fQBmNls++yuIHZyZ7fw/
	f0abXaEFF3ySn68mak1E07Il+0Ps9SEn7LxXJ9Tc7L0jzCWjcS/6aqlMjaE5K+sYfpeqFEQK3048i
	o7UdrYebMJDfzwPbYOxMsfpBOvpGv2IUR5buenjiagu2INw/oHFUTfI/XosB5sUdz9UcJDOYpf3l1
	npYfSYLsfLktFiy2DtFHfVeJz74sTxK4ys40ypoQ6NJ5Z2sNjYQ6X3QQU50tF94vF+CPjNfZs0oZg
	fm8U7lF+0cL8v6iQnr7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spQrq-00000000b4k-1YYj;
	Sat, 14 Sep 2024 11:23:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spQrn-00000000b48-1PUj
	for kexec@lists.infradead.org;
	Sat, 14 Sep 2024 11:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726312981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VDcY1DfwhFJthdW3rQWNw4xYgYdrHBOnbtRjNWLoSsU=;
	b=KK/fE5IbZ583HAmeTrrN4XupSNjszTWa2AVemdIqP6ZVSqWPPLAMCG2I5e7Gq4SVVGyU3z
	oSsz8wbuIlhZk8Jsz0hYJk9UkTO6FFqgYg+sJ2ReDnBqd+XDULVqDra9pYJ/7oxTgET56F
	XhIyPrzc9WM1FxiD5NQYK7s+6p9G2RQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-OvZ34fq1OGOVmLTWMt3KOA-1; Sat,
 14 Sep 2024 07:20:43 -0400
X-MC-Unique: OvZ34fq1OGOVmLTWMt3KOA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C3161956096;
	Sat, 14 Sep 2024 11:20:41 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.115])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88D6630001AB;
	Sat, 14 Sep 2024 11:20:37 +0000 (UTC)
Date: Sat, 14 Sep 2024 19:20:52 +0800
From: Dave Young <dyoung@redhat.com>
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: [PATCH] x86/e820: update code comment about e820_table_kexec
Message-ID: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240914_042303_518417_9EA8258A 
X-CRM114-Status: GOOD (  10.90  )
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

The setup_data ranges are not reserved for kexec any more after
commit fc7f27cda843 ("x86/kexec: Do not update E820 kexec table
for setup_data"), so update the code comment here.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/e820.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-x86/arch/x86/kernel/e820.c
===================================================================
--- linux-x86.orig/arch/x86/kernel/e820.c	2024-09-14 10:39:57.423551301 +0800
+++ linux-x86/arch/x86/kernel/e820.c	2024-09-14 18:56:30.158316496 +0800
@@ -36,10 +36,8 @@
  *
  * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
  *   passed to us by the bootloader - the major difference between
- *   e820_table_firmware[] and this one is that, the latter marks the setup_data
- *   list created by the EFI boot stub as reserved, so that kexec can reuse the
- *   setup_data information in the second kernel. Besides, e820_table_kexec[]
- *   might also be modified by the kexec itself to fake a mptable.
+ *   e820_table_firmware[] and this one is that e820_table_kexec[]
+ *   might be modified by the kexec itself to fake a mptable.
  *   We use this to:
  *
  *       - kexec, which is a bootloader in disguise, uses the original E820


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
