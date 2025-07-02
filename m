Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17400C83F03
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wcCtm9f7p6jwuZ0do6mGaH16Y08BotVqwa8c/wAtMks=; b=34oGkJApJYdFapCQuWqCoqA8yp
	mfB46h0BHgGG4mtTRwsPDqs6N3hk1N/+3hNZEj3Tlv9bTOjgLWWDrI+zXa1ZzLXhI6DaAdkq+z085
	u/0lrGWt11IO1MZ4Oftt0Cbcepy3QT3bJNkCCpOBi+ht8BQO2jOAMdowCT8CsftccNpomNXDthewL
	yZ+YkHiXQNhSQJ14YHBXg2lc2lOkNvc8JarwICQgXJXmb5wQ3ZBnHKjTYUZYRRVxp8RwW+Z/WPwEo
	5GsAByfYB5hPo/oKFWzjebOu27dH4rw/PWN/iD7xN4f8Tf6QwlgbxtKuyIONSQD5zmfl93HUspRpc
	gh7+HHnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX1ZN-00000009ATb-0KGa;
	Wed, 02 Jul 2025 17:48:29 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX15A-000000096mr-1fFr
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 17:17:17 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-23602481460so74152685ad.0
        for <kexec@lists.infradead.org>; Wed, 02 Jul 2025 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476636; x=1752081436; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcCtm9f7p6jwuZ0do6mGaH16Y08BotVqwa8c/wAtMks=;
        b=cOgEGraQckBrtUzC0jxqT6zazE4p54+KiMCTT4smEpUEbSMZkihqyxqNyIZlPQMa0D
         c4rViHBY7XCzy+4P0SBzUPYs3ilcqaZorOWH35Z9VHyhQ5QqavnT9N9tT19mzxBdP72L
         e0jeQpHCsgCv4pcQ8N67uo3EXz7u+BDpnB/9ExIKHlCI9knM9pCIOQlhRoSzx3NOn3vZ
         Id4abt47OkpX4dN2AQuyxr94hy67szH4+d/tGbMq0K5+xbkQdMSyjXyFWMTh0ATnKEjL
         46oZLudFdL+zOZXmkhIqvOHqBk4+U1scIf0KRA7ce+GXtYti9hZiaaOfKXtr4neXkg/n
         pxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476636; x=1752081436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcCtm9f7p6jwuZ0do6mGaH16Y08BotVqwa8c/wAtMks=;
        b=VQFxA4jNw5aEZ3mRV4h2ztzZZcUrFgtFT47BGAOI23W66MQkhlEmKb67dKBrmpuSu/
         fGRw31FOC799dEgwZjfMj5VNeisKfnWtF9KgHaPVmIx2CjCucdxDnNoAofYzLOHy6Q4H
         zJEBI/psnRV97FsiTkwBjAL9tJnwQI35AHOxfl0JxjYB5vmFgUHoWm9JrxDsaglpncM/
         NHS4Innrp9QEOKy7WTe56wTo9G5IJ6R2GHK+OlrofuIAWrcxKpj6VOIgMv1gcTtFO3yo
         MTnSUE81hbuuei9z32bobfzfDl/ycpbSOLHrHbrPOJkmRBW4xjM1pA9kWFMLEZ4awUoW
         IChQ==
X-Gm-Message-State: AOJu0YyFb4VfizndAOk9FkfzBYTJ/3gmeH0tt5RCaYSdNsRySJSdVT9B
	vaI9snjYZDVKLxQLYQxPC4pymW/Ej3KI0ui9eYSo7D3xUfcaTOa1rBWI
X-Gm-Gg: ASbGncsy8ymvmopo7Y0sgoCt6YgWSlr/9Gfzq0eicrzkxDHFUgMTtejKkscfQrvWRxI
	+3ssgVDpsqNy865B0n/DXLuTEjzx1XfrQr+aCA7Gkd3Y7yKkHPqtB0gRUzaT68mw6ZJIsGVXguE
	dennJmQbIm6xQXNWYdOf4av+F+Fanrlv6Q3ecKCHoNvS4mPeKVdSixyJnofn+bLS1nWd/vP91w+
	IlEksuslZ5rTyJdCtVBlQ/vl4rM1oGLL6sNO47nnygAMD6eWyH29RF14QwxC7smsXz1oXX7tN2N
	gy3GcxX4VfB067Es4ak3BIeF0z5GOwnXC01B2Kl3rZu2saDghFgHFtbVPq5B7Jp2
X-Google-Smtp-Source: AGHT+IGoqFyrVCn6Y1nY8V1kqw3Ktn3Uz+x2Fn28RGNMIDJoOM2Rf1r7mTP7AxkaWXBBJ0Gt2fEGnw==
X-Received: by 2002:a17:903:1b67:b0:236:15b7:62e4 with SMTP id d9443c01a7336-23c6e511dc5mr70706755ad.38.1751476635539;
        Wed, 02 Jul 2025 10:17:15 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:a36d:9d50:6dc7:23e0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7a47sm138699745ad.166.2025.07.02.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:17:15 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: khan@linuxfoundation.org
Cc: kexec@lists.infradead.org,
	dwmw@amazon.co.uk,
	mingo@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2] selftests/kexec: fix test_kexec_jump build
Date: Wed,  2 Jul 2025 10:17:05 -0700
Message-ID: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_101716_434081_C2C9D543 
X-CRM114-Status: GOOD (  11.06  )
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

The test_kexec_jump program builds correctly when invoked from the top-level
selftests/Makefile, which explicitly sets the OUTPUT variable. However,
building directly in tools/testing/selftests/kexec fails with:

  make: *** No rule to make target '/test_kexec_jump', needed by 'test_kexec_jump.sh'.  Stop.

This failure occurs because the Makefile rule relies on $(OUTPUT), which is
undefined in direct builds.

Fix this by listing test_kexec_jump in TEST_GEN_PROGS, the standard way to
declare generated test binaries in the kselftest framework. This ensures the
binary is built regardless of invocation context and properly removed by
make clean.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
Changes in v2:
- Dropped the .gitignore addition, as it is already handled in [1]

[1] https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com


 tools/testing/selftests/kexec/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index e3000ccb9a5d..874cfdd3b75b 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -12,7 +12,7 @@ include ../../../scripts/Makefile.arch
 
 ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
 TEST_PROGS += test_kexec_jump.sh
-test_kexec_jump.sh: $(OUTPUT)/test_kexec_jump
+TEST_GEN_PROGS := test_kexec_jump
 endif
 
 include ../lib.mk
-- 
2.43.0


