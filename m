Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28471C47258
	for <kexec@archiver.kernel.org>; Wed, 31 Jan 2024 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/8yv1Mfo2cYeaKGimDPdYlaP3ZujZHmd35P5UrCye3k=; b=DZhRV5Wv0Xc+Cx
	cFPiWlpi8MyNoss9bhKLrhYoyWeKf2sO4L789v7QQg3ZY9tRI18YEqZgxhXHsEwj5Z3UpMrYD016n
	leuy32h/Yn8L7/ZwDD1tzqXd1KVTnd7wF18SADYbwFGcomv6XPBR+j8iXib2Jo1twk6ufJeE99WAF
	TMg9yxQHZJsfkindyuqKfTfENO1bmbSaJt5ccQm7CxoveHqxPO2i7muWhp0Cb99N3xAcP/DWkoyag
	lv9sZ79Lf9qOKNpS80ll0bD0dS160fuiiNL3XdZ17V2I0T6+d/bflHQE07lm0sF2QIVjRE2/D9O+a
	lp0XjRyngEnQ9TLsmkFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8aD-000000032M9-1z9M;
	Wed, 31 Jan 2024 11:16:45 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV7T2-00000002f2w-2UqR
	for kexec@lists.infradead.org;
	Wed, 31 Jan 2024 10:05:17 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33ae3cc8a70so2870655f8f.0
        for <kexec@lists.infradead.org>; Wed, 31 Jan 2024 02:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706695511; x=1707300311; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LKCGCIZGS69DQDGbZH1g3kweMeDaGAUf4JDS7EAdv/U=;
        b=Ha9RdaCMtOvox2ScOcSN77gDk7DEDlCU7Jfh86BMi6A/lbYuLAwvV/JWp36lnJD91I
         cRPRyKHG2Wd4d3IFuR5W3+HaksXB3C1s14eMRwk1qsUGaN5c3m/WoSgZwFEq9+RfYnpS
         pc5nYzWwB/NGRwH5nBV1UVlHJ36PO6cyWATqV87JaeZQAeh7zHpbhotcbcJ7CqUqWGHU
         AEDy/XTbq9LrTpMLtx8qRIxiQKH2od695+FazcN3ksO87sJJbmgVDru1goaM7jh4Ichx
         d09/gtmqIaL3iNexLnhhY3yEqeqx+MhpE0Wk4zDEF0vaj0Owy2JngLzoefbVKZOHs41u
         WU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706695511; x=1707300311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKCGCIZGS69DQDGbZH1g3kweMeDaGAUf4JDS7EAdv/U=;
        b=T/S6pZeFpCTLaKiyhxFFH7jwMFktG+ky9a0dFudKgOD9IgkoEdBTlnd2RmJq2bRqdy
         svX4hFFAWxB77mrS7aH4+Q6AUUEoE8lsKGnXmnweW+8R97zqJq0b4V9ax4AfnYjNx1gr
         QD80/oOjal0ZwEa9/U+ihX/PY6eZcw/Sz7q+loQuIhgDTgmpNdlDVVoxWb5b9ShPSAcN
         JoIY1/JVXzNKHefyUXfbF4zKRAiYqIxVfv4t5W0poGttZvL9hNAD+KHkXqu+JJkDGuvI
         2xHbsMMvpv6YenNjTHV4dBXUlyUFfVbXEqSdeFO/1d+xNgwBHBDxdu9gRRDJbjx+P2N6
         hdYw==
X-Gm-Message-State: AOJu0YyCGsHgI4RYbMZTfO7bKvJM7q23vA76mOfoYeAxCEipEuAKWIgx
	JRY6MUQqnDdxPSsxDy6TzZMDrVnMYSkoV2C8Y9AkAmcRoJDlbZof
X-Google-Smtp-Source: AGHT+IFW6Tk/ufEHBxc/UXK/pB8MInYlTm26JAjDZH8ZhzmCuCKrykNziK3q5Jzm2qBdbQmzZHvONQ==
X-Received: by 2002:a5d:59a3:0:b0:33b:706:a2a0 with SMTP id p3-20020a5d59a3000000b0033b0706a2a0mr785364wrr.0.1706695510958;
        Wed, 31 Jan 2024 02:05:10 -0800 (PST)
Received: from nz.home (host86-152-202-149.range86-152.btcentralplus.com. [86.152.202.149])
        by smtp.gmail.com with ESMTPSA id d15-20020adfa34f000000b0033ae9f1fb82sm8693774wrb.48.2024.01.31.02.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:05:10 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
	id DD7C315B7A196A; Wed, 31 Jan 2024 10:05:09 +0000 (GMT)
From: Sergei Trofimovich <slyich@gmail.com>
To: kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Sergei Trofimovich <slyich@gmail.com>
Subject: [PATCH] kexec-tools: purgatory: fix build on `binutils-2.42`
Date: Wed, 31 Jan 2024 10:05:08 +0000
Message-ID: <20240131100508.2013016-1-slyich@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_020516_668039_D6370A06 
X-CRM114-Status: GOOD (  11.86  )
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

`binutils-2.42` introduced stricter checks on what `.arch` can be used
in 64-bit mode and started failing the build as:

    $ as-2.42 --64 -o entry32-16-debug.o entry32-16-debug.s
    purgatory/arch/i386/entry32-16-debug.S: Assembler messages:
    purgatory/arch/i386/entry32-16-debug.S:28: Error: 64bit mode not supported on `i386'.

The change moves `.code32` before `.arch 386` as suggested in
https://sourceware.org/PR31319

Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
 purgatory/arch/i386/entry32-16-debug.S | 2 +-
 purgatory/arch/i386/entry32-16.S       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/purgatory/arch/i386/entry32-16-debug.S b/purgatory/arch/i386/entry32-16-debug.S
index 5167944..297d6f5 100644
--- a/purgatory/arch/i386/entry32-16-debug.S
+++ b/purgatory/arch/i386/entry32-16-debug.S
@@ -25,10 +25,10 @@
 	.globl entry16_debug_pre32
 	.globl entry16_debug_first32
 	.globl entry16_debug_old_first32
+	.code32
 	.arch i386
 	.balign 16
 entry16_debug:
-	.code32
 	/* Compute where I am running at (assumes esp valid) */
 	call	1f
 1:	popl	%ebx
diff --git a/purgatory/arch/i386/entry32-16.S b/purgatory/arch/i386/entry32-16.S
index c051aab..7a84565 100644
--- a/purgatory/arch/i386/entry32-16.S
+++ b/purgatory/arch/i386/entry32-16.S
@@ -20,10 +20,10 @@
 #undef i386	
 	.text
 	.globl entry16, entry16_regs
+	.code32
 	.arch i386
 	.balign 16
 entry16:
-	.code32
 	/* Compute where I am running at (assumes esp valid) */
 	call	1f
 1:	popl	%ebx
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
