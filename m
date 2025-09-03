Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A64CCA1010
	for <kexec@archiver.kernel.org>; Thu,  4 Sep 2025 02:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Lrj5WyDJlM3QjEB4CLjU92Xa44MZNaI8IfgP6RBOMAw=; b=PPA8ZGST1KeT1DaN4cX5fwQyvq
	M5NV3MX7smDV72+ypTYcTv6+zJaS/HS67G6q9tFqwAZppb70LwDBwgYE5mPa0ULaT8Vnmmzx7+ONs
	IYmBKFSmcqHinnTV4ZUOiYlLQR8O7VhdPitii9WfYqOgFa7d/XKK93q3dtEK7nACuYYeiL6eZhpF8
	90rZPJnLcFhK9wNymdnFNS+mFFDjmGDkDO8ua0UFc7VYAA5dtQJRVe4urSjExMCMMjTxlefKdgJny
	cXTXMhBXyEg4IY9q0ad6PDKajjXfpKfCYDjQE9vLaVBIRp4t0g/oH4o/Ww2TDGvO9qrn1RTX9rbDH
	5bY0fpLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utzQx-00000008EyF-0ith;
	Thu, 04 Sep 2025 02:10:43 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utuCp-00000007aHl-1knV
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 20:35:48 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so331994b3a.3
        for <kexec@lists.infradead.org>; Wed, 03 Sep 2025 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756931746; x=1757536546; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lrj5WyDJlM3QjEB4CLjU92Xa44MZNaI8IfgP6RBOMAw=;
        b=h38fsP/F2Ty9/StTg+xfYv2LjjxUZh9rlsoFwr6xGiFHnUFgNRLnJH8mmF9lNSoBAB
         KyRGKLl5LSSKQgGFMpxap8aaa8SWl/NEXua+PKDeQItbRlCKBeWL+oom5hGBtdAa7RO/
         mXLV0B0k/VR4BLZWw8g8Me9pfvGflXHGqscwzZVvcnrbBt8401CYZKKafYkFctBMbwhz
         U18yHbpPb0H3HmdTbdbxpep84Shkpi1Fd9aazx/aWE6YDmSW5bRnV7NhuJ6JFrjgKOX9
         rxy73Rpzzh+1rXNwCob6DipZuZobz0qXX4HWwlWHLoY8fzx6CSNV0oh6SolJ2O3EYeFK
         wM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931746; x=1757536546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lrj5WyDJlM3QjEB4CLjU92Xa44MZNaI8IfgP6RBOMAw=;
        b=mEyi3aujNJuB3zPAlkW4bpg77RczizcK+WKQ9yPeYNuTzhwh4vIRLjgWklcuUjxK2A
         /2o3B/vrtCvdBCxSkutquwmRT6m75Th4S42jd3Nr11NmgeYOOI4+2HaRwlZBlg/yLDU5
         0Ak8qvXjm6jEnr4Qm1NLHCdT50XA1/c25R8kW0vrzxk+fdMdNFAKzRAyeaI2WN0LKp1K
         4DF+5ZahMrq3C7QxGM0ncZ3Wa4/0bB6ER+uo3PSbzUMJdchNN7sPDQ2VyPJl6Me8/HWM
         Au7mmlOJWqGQ5zZ7c2jrDA5ArtayWhkmNeylbTMO5m9aovBxAgdgEfXC7N/ZwJQ/BOyE
         /E+A==
X-Gm-Message-State: AOJu0Yw2+dUECK5f+gD6Vx6yFe3/7IVytQ5dah0BOpHmCDDDMIVWGtcX
	QLso/qlnuO9U55/+jJDLwloTs2Yz5o2t9ygKlps8ZE7UAXtBzxFkw+3HcynYmCVK
X-Gm-Gg: ASbGncvsJzoFkfwdgDuHvqbPpdE/kV+0CFzRBFO2VYb/42ybA+Npq+Vnx25R/1RbpuQ
	JdfxGLVMM/sCvsEVJv8BL8MdK+FdXL9Xi3gG+6CaK4m54EB+oB4lG197UxZ6sfMJIedLngNb+Wv
	GXQH0cB+DMKEj8f94BEkqMHdohQ8nhU4aTYj+G0yi4w2r8goqlXLAOEtEIy7BXItkS6d62c3n/b
	DJ7I0qQNG2rceK6fLiUR45vf9x5tGGHGd+K011+30sfEuZot+1EPKk0+AJ6ZDztstxkXi4ruBFa
	HzLJzt3vH4hXBmsWWMyM1FO896L8nxxVXE2OJIceKZd01aNu5gy0nvMVMDuUsknQv5EMouWO61R
	/3FmsCoPXDmCGPmWYfUTYWPx+8hh3S3nlGkm01pexJ/qhq+YdsEgACLwxTMXR9UXR2EXrAIq6RR
	zBHgLpMhzysyUxhNQDmhrJXSkitbnYp1o0XjtLNG22nvQWWEXyAcs=
X-Google-Smtp-Source: AGHT+IEZehukpjoevuMaLz8EDsWevujbF5fGHk9BuV0SD0L4/E4ZIz5x0LYg4NZdHg58QV4bxf+EfQ==
X-Received: by 2002:a05:6a20:430c:b0:243:a5be:c4a8 with SMTP id adf61e73a8af0-243d6e00ba5mr21396016637.22.1756931745918;
        Wed, 03 Sep 2025 13:35:45 -0700 (PDT)
Received: from apollo.tail3ccdd3.ts.net ([2601:646:8201:fd20::ecee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26adf7sm17525311b3a.15.2025.09.03.13.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:35:45 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: kexec@lists.infradead.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] Make the segment base match pinned section address
Date: Wed,  3 Sep 2025 13:35:42 -0700
Message-ID: <20250903203543.556750-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_133547_455328_7AE90D49 
X-CRM114-Status: GOOD (  10.13  )
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

ET_EXEC uses image base of 0x400000, but the build forces
section VMAs like .text = 0x10000. LLD now errors when any
section address is below the image base unless you explicitly
set the base. (Older LLD tolerated it.)

To fix this, set the image base to match forced section addresses

Fixes
| x86_64-yoe-linux-ld.lld: error: section '.text' address (0x10000) is smaller than image base (0x400000); specify --image-base
| x86_64-yoe-linux-ld.lld: error: section '.bss' address (0x12000) is smaller than image base (0x400000); specify --image-base

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 kexec_test/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec_test/Makefile b/kexec_test/Makefile
index fec6210..f9fa92c 100644
--- a/kexec_test/Makefile
+++ b/kexec_test/Makefile
@@ -31,7 +31,7 @@ $(KEXEC_TEST): CPPFLAGS+=-DRELOC=$(RELOC)
 $(KEXEC_TEST): ASFLAGS+=-m32
 #$(KEXEC_TEST): LDFLAGS=-m32 -Wl,-e -Wl,_start -Wl,-Ttext -Wl,$(RELOC) \
 #		       -nostartfiles
-$(KEXEC_TEST): LDFLAGS=-melf_i386 -e _start -Ttext $(RELOC)
+$(KEXEC_TEST): LDFLAGS=-melf_i386 -e _start --image-base=$(RELOC) -Ttext $(RELOC)
 
 $(KEXEC_TEST): $(KEXEC_TEST_OBJS)
 	mkdir -p $(@D)

