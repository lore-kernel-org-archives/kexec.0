Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110F4CA0EF7
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89agA5xWiMAWpLK8yFciMQUFMmay2fVS5DjjtzDBBkQ=; b=TwW7fb3lXXgvIG6+fkQFcXY/1B
	2431ma4VAL5djaeiFXqFGUCOGebslfnF01CtPvANEUoqRCGgjWKrcO4fKdIDOPLdssFiCsCL9oDy4
	8Ojoq/5DZvTFqfJCHN2b9o0Mxsp9eN5vyro2QIS2z1baYMvm4VawGLtczq+AjmgpjNunU00h8dMgH
	sOpzQk5LDgkzLLe0cEWqGyJuCyy2kwgdGzvSzURbccHnjRREz+vZFeYeA2tD0ggxirXHTtWFsS/2S
	pAkqQtFTX9uSbX9H5eE3MIlF8He0x/bE+K6HWGyJ9SkdXbz67oQd48sL+seI1JFi9TmLnsNKv+Dkf
	CMzc9QrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoVK8-0000000Bo9d-1i3W;
	Tue, 19 Aug 2025 23:01:00 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTvK-0000000Bdsy-2l8S
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 21:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755639042; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XTFflJcTc1XaYZPWf7D3d0kHOvmtvsbkEfFeIMfERdU3+8KlQ4X8pWPSp05eWMdu1zc7jffTo/jHBJuY2sb6ZFcm5mfIjhW7Zh2fr3x7OJKsOngPfP9nudpxAlZc4l10jTkMDt7uHUfP1IowekjYOUVVkpkauyCE6bz1p9o1y+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755639042; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=89agA5xWiMAWpLK8yFciMQUFMmay2fVS5DjjtzDBBkQ=; 
	b=n4RGtn/Y1aY9oYgxseciENAxtxuraAy09So//SW0Z2oL7Z8uqzMIoe6NBQ6RX6Jz3ZDDaq6IyCSBKBkCAa4RLe8O53oh/HDNKEZhLBhoTvB+1xp7JjVCPJfxyLKzFsj9dnD2e4aG0kbT0A56mX2yrmSpi0R3hXvoxURuFRL/AhA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755639042;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=89agA5xWiMAWpLK8yFciMQUFMmay2fVS5DjjtzDBBkQ=;
	b=WYNXFiaP7RQt0IfrYG6Qg4I1hdLAI4E8Wb3jRbIn32Ux80peXGRyoojerXDfH1ki
	Lq45dJxWDeIREgY6SZIg8b1HjA2WsOKabpos3cewYgYvqD/hpwYcVuZfb7wG6sYyc9u
	zan5YPvJAmCg1vdaNtiQz8PqgsMt8FstkIUVgVJw=
Received: by mx.zohomail.com with SMTPS id 1755639039017930.871457675915;
	Tue, 19 Aug 2025 14:30:39 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v4 5/6] kexec/arch/i386/kexec-x86-common.c: remove duplicate <stdio.h>
Date: Tue, 19 Aug 2025 21:30:13 +0000
Message-ID: <20250819213014.908757-6-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819213014.908757-1-safinaskar@zohomail.com>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112277c8b900bf31149205a710c6e0000f0660f7a759b43f0b120d8e0d9d60f8500659b911359f988a5:zu08011227d679227f254e3b297631930100000adc09344bff74f85bae96e66dfd8a73a798fa7663805d32f0:rf0801122cc67e16c86749b4b5fc54b8fb0000ebbc2a89dbfc0525bfb941accc92c7bbf97c93907cf4923dc57e33564513:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_143118_727734_5F31BBE6 
X-CRM114-Status: UNSURE (   7.18  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Remove duplicate <stdio.h>.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 kexec/arch/i386/kexec-x86-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 9ba8b3f..4a67ec8 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -29,7 +29,6 @@
 #include <string.h>
 #include <limits.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <inttypes.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-- 
2.47.2


