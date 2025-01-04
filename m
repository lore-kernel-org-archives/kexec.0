Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F7FE77188
	for <kexec@archiver.kernel.org>; Sat,  4 Jan 2025 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lItEO8+vDf3ne2QEFaUdlfKMhS1868rwBEwl+2/8wc8=; b=o5FtSuS4STw+jsBpdzC/iWcJEm
	nR8Axv542yJslpF25YLFrhBCBmQ2apfv9fjj4UDksGOeMoUGB6LvqNFW60rIo/HuMTyP23Xqmxnb0
	uON5FLGwCNaHUn8vt74DwY+Y7QCvezKVdlE5Zjw1S+oDuuq6kjNMy/HsJ66U+q+95hoDVorqrhW3p
	LtbSDOAY3C+bEVGlCJ74dXRvWo8VIHY/Rrlv/qaMVt+i/TBOnsojzEx7FbwMofuJvUyHo1F1u/MJl
	mYIEV/ormZm1AXeUynnTVi5l9WV31FeS5bB3YDoGtAsBVZi5u0xcvki+Zkypc1m+7rGhP0jS/jSG+
	jWlG6U1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5J8-0000000F7r4-1Xyi;
	Sat, 04 Jan 2025 14:39:18 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5J5-0000000F7pk-4A7v
	for kexec@lists.infradead.org;
	Sat, 04 Jan 2025 14:39:17 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-216281bc30fso213167885ad.0
        for <kexec@lists.infradead.org>; Sat, 04 Jan 2025 06:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001555; x=1736606355; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lItEO8+vDf3ne2QEFaUdlfKMhS1868rwBEwl+2/8wc8=;
        b=h4PIt1xxp3VziRxNDvXcHvgZYD4KeE4KmbvuRL7jfnZzuRMk0alb/bvecZ6JK4/of9
         JdgQ2VK1ZKp95y7TixnL6Q+RJc4CV0talDyHMnnLNAn+24mSHej4zVVcP3UoIS0tX1eL
         cJHqPR6n0vnoNRxDXdQqpQdO0RYJFNvD1xAm9I07FNri9mDnvHwHzBaNpWV3kkxfkCgn
         FE+qijWUmDlULJJdpfvqcSd5ItTVgWfON9Av83+No13feZDIHn6Nk5/xF8JC6I94bYc2
         YspnptUqjU51YlbiOGpf0K+PM5f6ENzoNXAG5SdLwN3nVXt79SGVRrUPCQFOCMbV/TPn
         HU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001555; x=1736606355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lItEO8+vDf3ne2QEFaUdlfKMhS1868rwBEwl+2/8wc8=;
        b=kwKBmr13ACSJxIJ7HZql9DagaRBl+TQn913ArlrkeZHX+MY5V7xQX42O24XtSZh79N
         ORoJAmbYSn6Pbxy9OG0MjvtXExJgdsEnI0dmBTIUM8YCYGeIuTpetmpx9xL8mi6mosg6
         tmEbrDEVKylUP4JgwvbY3AON2mnlilPkddWW1ewtKoOw9QI4MVpXxd9NMk34BNa3B2ke
         wOKlVaSaw0ZmS+E6iM9RbSH4WBUCx84hOaoVU9m5wjGz6KPo8ehCGGtumouyokxZ2k3l
         224UkN88ZqjeRYTFjbxiyrZUhkWlkb2Kwar3k3Y5HCEcfW1A3J8g7yqUHAPkcps4RLeT
         dgyA==
X-Forwarded-Encrypted: i=1; AJvYcCWDvIwMGoi4BrQ14Gwpiqk2Ugl6RKNx10z0TbkPF/WjhLoiwFAcbKY1CQ02TBjxLuWyH3lUMA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+vMk+AKy0+W++mcfV18YRr9KP5ygjE+m5M50jxN3vJLM51kQ4
	wA61oHaG76froA392jMZYcDEBMiWzl/lHb/sVAGNNtmjlrGPGDKFFV8EXaMWo3M=
X-Gm-Gg: ASbGncuV8lSD30ZbhEPSvPIxtnwbPx83pEcDpZJMFWHYvZSU6fyDEicupVHhQKwZupS
	V370vVHvmnbBFmyxq83M2IbObz09bDRStqRyUFZNTLafHDr4zWn3GTE+SOEz/ftouts75AEwbJt
	qcgiiP6EwQQftiDmQiv7zVf4BZZYz6OggvIxz1OplvYd2/bCcT1rtwtTAM9whz38RTh0SiAwMiP
	4voD8XgpXqkuh4YMKpb7GROLe4sN9TSXbec/B3686VvHNE9DMo4eEOCcxBXCzs=
X-Google-Smtp-Source: AGHT+IE6l143okZ4K2hLdktIIklrvNPqE32MSRd/SLQaBZqLFpJB0ZcbHN/hLV+Lk0+UAUXZGQQd2Q==
X-Received: by 2002:a05:6a00:4098:b0:725:c8ea:b30a with SMTP id d2e1a72fcca58-72abde2ab0emr75955118b3a.14.1736001555483;
        Sat, 04 Jan 2025 06:39:15 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad8f90b9sm28017661b3a.131.2025.01.04.06.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:39:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 23:38:38 +0900
Subject: [PATCH v2 5/5] crash: Remove KEXEC_CORE_NOTE_NAME
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-elf-v2-5-77dc2e06db4e@daynix.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
In-Reply-To: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_063916_045404_C5C6B2DF 
X-CRM114-Status: GOOD (  15.11  )
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

Now KEXEC_CORE_NOTE_NAME is only used at one place and it does not seem
to provide any value anymore. Replace the remaining usage with the
literal and remove the macro.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/s390/kernel/crash_dump.c | 2 +-
 include/linux/kexec.h         | 2 --
 include/linux/vmcore_info.h   | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..4a9817489e35 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -253,7 +253,7 @@ static const char *nt_name(Elf64_Word type)
 	const char *name = "LINUX";
 
 	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
-		name = KEXEC_CORE_NOTE_NAME;
+		name = "CORE";
 	return name;
 }
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..c840431eadda 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -68,8 +68,6 @@ extern note_buf_t __percpu *crash_notes;
 #define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
 #endif
 
-#define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
-
 /*
  * This structure is used to hold the arguments that are used when loading
  * kernel binaries.
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 1672801fd98c..37e003ae5262 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -6,7 +6,6 @@
 #include <linux/elfcore.h>
 #include <linux/elf.h>
 
-#define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
 #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)

-- 
2.47.1


