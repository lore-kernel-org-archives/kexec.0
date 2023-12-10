Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D91AC4167B
	for <kexec@archiver.kernel.org>; Sun, 10 Dec 2023 04:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ifVIWKSZvbxCggX22tztw/viOrZjRQJDbx9tFRZWaCE=; b=kqUbjXSSSJKuzb
	7RRauuXEd783OrmenCABjD5Xi7Am+lFZ8TeU1aeE5kzINFkrmxtkEJV0OHLhtpuZ4NLueEbTDnOsx
	eLANR337flLIrj+47z0S9vj/doRos2FF7n7uv5mkbDe20ze9nLYgKyf3gmJgdZ48T2xfzuJAADyAd
	c096rbY56fXBTKmlnn3mboHHcbkjFXbqgUiSiFsqxNn8iSqcY2136H21JEQG0PUL9ioZYR3raIi4R
	qDr54rAe5lq8192puCPvLFKgamgbGZDakPxJ1CgtwNaHjzJEyw6jam9F1VUAYKdNf+0FxaUJEMsvj
	oGcZ1QZ+7G2HfvIdkMpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCB4X-000vhx-21;
	Sun, 10 Dec 2023 04:05:41 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCB4U-000vhU-1x
	for kexec@lists.infradead.org;
	Sun, 10 Dec 2023 04:05:40 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2829282a12.1
        for <kexec@lists.infradead.org>; Sat, 09 Dec 2023 20:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702181132; x=1702785932; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxTgIk35cBEBjNHmGIeLkGBa/rmxEyN1bVKNuPulPrw=;
        b=M0XcEQFiXlWufuPst/LiNz7UjeTkx2ev0kAgmkputFXLpKsDDlvxF3AMp4ObB4wElW
         PfpPUme4nr24dZKYsoIf/bHReRqe2Leu9ohLipF0V/XpuzwwyiF8L5Fxm7seTvjq3+hV
         mlmp6KcRP0eXT4V6lmAoKaN3WqJ/YUn9OzOV27zuHSTkPWciuFgQHIKEWD6rVdzh4vSC
         VmZxA3ByLQF86vQCkPSwjcGPnhQAMgNLIoky0ZglACAYO3fYIVQFFRKbSXSRwWViqA3q
         yMUpd7ToFDf/gsfz1V778lxlqbHVpps4irEmLtsOzEtf0IfXd5Wzj61gPP/ieJpXbFfE
         sBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702181132; x=1702785932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxTgIk35cBEBjNHmGIeLkGBa/rmxEyN1bVKNuPulPrw=;
        b=ovc8CTf/Ta1V5KEqC6i/50CuJdYW0k1JVlt0PXZ050E7esBX/Ts6nuGZtWVha9rMqH
         12/7Ks8JgrBQMTexvyZSFMPTr87eUSrcOuD0b0fnsXNWF6/AKTUZ7mhVtW/cuk1nhieK
         YD9bZwawJBcjqgWL+uzZitH1A2JklbW9A7AABI2kdEBLM5UNfFXENCNw9IsLBEzZ0N3C
         x91J4lx13te+XmYlDi7QcSWi7JOwW/xB5+xFRnlmmgu27WmxMBXW5SUkazNWxrpFelBE
         qly3KoKjaI3G8Qpr8N3WugU8THzqvTe6X+SPcos+T/RvGWyACZgNyA9s1SWzsfiUyUUF
         UQMQ==
X-Gm-Message-State: AOJu0YyENKY4YIDWNAiC9KVetjGvFtbyWhpUrCdOE33+7P39piboYftA
	Zo2f3bEwV6FgHwSJRTXnqZI=
X-Google-Smtp-Source: AGHT+IH0NUo/39sXHfVIC4mD3yLbQPWnO3hPMB22iKCPdmsCkTVV89PNHgoc96UnMjHFEPuey+GWtA==
X-Received: by 2002:a05:6a20:d386:b0:190:1e0c:d29 with SMTP id iq6-20020a056a20d38600b001901e0c0d29mr4155604pzb.4.1702181132480;
        Sat, 09 Dec 2023 20:05:32 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001d1c96a0c66sm4112497plj.130.2023.12.09.20.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 20:05:32 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	thunder.leizhen@huawei.com,
	vgoyal@redhat.com,
	ytcoode@gmail.com
Subject: [PATCH v2] crash_core: Fix the check for whether crashkernel is from high memory
Date: Sun, 10 Dec 2023 12:05:09 +0800
Message-ID: <20231210040509.106292-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
References: <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231209_200538_670532_BD42FD19 
X-CRM114-Status: GOOD (  17.70  )
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

The purpose of the reserve_crashkernel_generic() function is to allocate a
block of memory for crash kernel, and if the block of memory is allocated
from high memory, it will allocate an additional block from low memory.

The method to determine if a block of memory is from high memory is to
check if crash_base is greater than or equal to CRASH_ADDR_LOW_MAX.
However, the current code only considers the case where crash_base is
greater than CRASH_ADDR_LOW_MAX.

This means that if the memory is allocated from high memory and its
starting address is CRASH_ADDR_LOW_MAX, reserve_crashkernel_generic()
will no longer allocate the additional memory from low memory for crash
kernel, even if it is necessary.

In fact, we can also take a look at the code before it was modified in
these commits:

  9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
  fdc268232dbb ("arm64: kdump: use generic interface to simplify crashkernel reservation")
  39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")

They all checked for the case where crash_base is equal to
CRASH_ADDR_LOW_MAX.

This patch also includes some minor cleanups.

Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
v1->v2: Provide a more detailed description.

 kernel/crash_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..d4313b53837e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -199,7 +199,7 @@ static __initdata char *suffix_tbl[] = {
  * It returns 0 on success and -EINVAL on failure.
  */
 static int __init parse_crashkernel_suffix(char *cmdline,
-					   unsigned long long	*crash_size,
+					   unsigned long long *crash_size,
 					   const char *suffix)
 {
 	char *cur = cmdline;
@@ -268,9 +268,9 @@ static int __init __parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_base,
 			     const char *suffix)
 {
-	char	*first_colon, *first_space;
-	char	*ck_cmdline;
-	char	*name = "crashkernel=";
+	char *first_colon, *first_space;
+	char *ck_cmdline;
+	char *name = "crashkernel=";
 
 	BUG_ON(!crash_size || !crash_base);
 	*crash_size = 0;
@@ -440,7 +440,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		return;
 	}
 
-	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
+	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
 	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
