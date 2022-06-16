Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0005C433EF
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 02:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0vmSQu58tWlTQYn1qgqS0lCC1Hw464jG5fpMSugYucs=; b=G2kV7R89uJjU9X
	AkdZcSzKelpLp1TNcoY/tXIJ9eYtaTkVDqGY02T0n3BT+4P8t0DWmaDKStnxFiTzDVIpdKeWbU8Fr
	4TO89OfjHzdn0BbH29vJbaEz2fhXkyOWYLOn34kmRXpriWwkI69X9xUmZ2YqkDUPf+zhjmiAhMdzJ
	ewfC1i/khqG257W0bD6GF7O+8q96zhy93aedmubOdFHr6xtToAtqO01QF+jJYZnkq25NVJdpjkvrB
	Tg3LOA+0lpe+ZR1hsjEAiVLeJaTT9gNyL1qDYUTfK63sitnU5a02gcj3nkmy6d3vORhD7xDrnYH+3
	c8AQxw75S6Dy/7AOvBqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1faB-0008Px-GZ; Thu, 16 Jun 2022 02:50:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1fa7-0008NH-MB
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 02:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655347801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nm47lN81/en9RFa7PC7KN5HytoLN2v81StHx1wCGkys=;
	b=Jm0KRbOtO1YQmtqsrG1n8YDueB1OspRCjl/ekxOy5PlRv99U36nQq6ndO57OweOj91WqpB
	hN59zCaDG7wey69McjjnHE0omH24WJy2PnMnLaVd0QeydNRRutxlKhqglHsHBWD9VOcSe7
	nM+6fqrn8z+Ugc6sNtEdcgz869JeGUg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-Ek1MVKBSOq6VdBLpxFIjRg-1; Wed, 15 Jun 2022 22:48:13 -0400
X-MC-Unique: Ek1MVKBSOq6VdBLpxFIjRg-1
Received: by mail-pf1-f197.google.com with SMTP id c191-20020a621cc8000000b0051bd765ffc5so168121pfc.21
        for <kexec@lists.infradead.org>; Wed, 15 Jun 2022 19:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nm47lN81/en9RFa7PC7KN5HytoLN2v81StHx1wCGkys=;
        b=ZfPtOhxyEzxaVKIaubZTn6GiveJRxf2ZVwl1WOvAVrQtbVA5cerJzzHTByvL49qEaK
         cec6tAf6CHbxMJNnPXIG59zc8R0aVKAqncN9LaVxcAWfRgFyNlkM8AMVE8iv1kTwfQSN
         DfjHy7wwmpqI6LD9f6qgu/BK+HEgTmx4BQeBGEJMy4SIxcQ7AcsJGPyTFC1MQ50OnDtA
         jBB7f5hco5nHfrTW0kumwNKUPStok1tWVqH8eLFkvKzxGEWrjiHQthSghN251WTa7gWE
         4XvI+/EfmmhESPRZQoYQygaNePy2cQH1yIXu32TS6MVsCpq/GqcxPBDsqPj/oPhq9ISf
         fypA==
X-Gm-Message-State: AJIora+iTkjAjeUtXu0JqlsmIPXWWXu7WsI5kQoXiYNUKzN2xeDgU705
	W1EIuFjtqA5uACT64DmezN8HhlI6Ebk5XRzNqhJpUmGxOwmR8BlVcAb18kLUDk/2+Xz8FMuEZaF
	JkcfMITPz/FO3ao9dp2EU
X-Received: by 2002:a17:90b:3845:b0:1e2:e175:be04 with SMTP id nl5-20020a17090b384500b001e2e175be04mr2713656pjb.50.1655347692640;
        Wed, 15 Jun 2022 19:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vNxKCZA5WfH/QsdIwkuqJGtpe52oai0trhWKfXSevkSeFUljebxiedwE3bOi8tGXLV9uMwZA==
X-Received: by 2002:a17:90b:3845:b0:1e2:e175:be04 with SMTP id nl5-20020a17090b384500b001e2e175be04mr2713631pjb.50.1655347692362;
        Wed, 15 Jun 2022 19:48:12 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001621ce92196sm354573plw.86.2022.06.15.19.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 19:48:11 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Tao Liu <ltao@redhat.com>
Subject: [PATCH] kdump: round up the total memory size to 128M for crashkernel reservation
Date: Thu, 16 Jun 2022 10:48:03 +0800
Message-Id: <20220616024803.5091-1-ltao@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ltao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_195003_840464_073CEA68 
X-CRM114-Status: GOOD (  17.30  )
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

The total memory size we get in kernel is usually slightly less than 2G
with a 2G memory module machine. The main reason is bios/firmware
reserve some area it will not export all memory as usable to Linux.

2G memory X86 kvm guest test result of the total_mem value:
UEFI boot with ovmf: 0x7ef10000
Legacy boot kvm guest: 0x7ff7cc00
This is also a problem on arm64 UEFI booted system according to my test.

Thus for example crashkernel=1G-2G:128M, if we have a 1G memory
machine, we get total size 1023M from firmware then it will not fall
into 1G-2G thus no memory reserved.  User will never know that, it is
hard to let user to know the exact total value we get in kernel

An option is to use dmi/smbios to get physical memory size, but it's not
reliable as well. According to Prarit hardware vendors sometimes screw
this up. Thus round up total size to 128M to workaround this problem.

This patch is a resend of [1] and rebased onto v5.19-rc2, and the
original credit goes to Dave Young <dyoung@redhat.com>.

[1]: http://lists.infradead.org/pipermail/kexec/2018-April/020568.html

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 kernel/crash_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 71122e01623c..f6c1ffce9d5a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/sizes.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -43,6 +44,15 @@ static int __init parse_crashkernel_mem(char *cmdline,
 					unsigned long long *crash_base)
 {
 	char *cur = cmdline, *tmp;
+	unsigned long long total_mem = system_ram;
+
+	/*
+	 * Firmware sometimes reserves some memory regions for it's own use.
+	 * so we get less than actual system memory size.
+	 * Workaround this by round up the total size to 128M which is
+	 * enough for most test cases.
+	 */
+	total_mem = roundup(total_mem, SZ_128M);
 
 	/* for each entry of the comma-separated list */
 	do {
@@ -87,13 +97,13 @@ static int __init parse_crashkernel_mem(char *cmdline,
 			return -EINVAL;
 		}
 		cur = tmp;
-		if (size >= system_ram) {
+		if (size >= total_mem) {
 			pr_warn("crashkernel: invalid size\n");
 			return -EINVAL;
 		}
 
 		/* match ? */
-		if (system_ram >= start && system_ram < end) {
+		if (total_mem >= start && total_mem < end) {
 			*crash_size = size;
 			break;
 		}
-- 
2.33.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
