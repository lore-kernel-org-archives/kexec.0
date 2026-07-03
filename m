Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D45FC43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tQvjlOiW+cm83l6iL+N3Ll3Wujm0kHNaCoPYlrf/mUE=; b=ZTqdzKY161urTh/j9kLn6Rh2I2
	dd4sVAB0A0rMalgdHf10sZ6gQgC0YIr5C9gywlee5VerpIc9RGTeASoIpt8PjX/iCEt+Ww9R4qS0M
	0q/YumJYA6hTZ2SuV5JVtqrG934Tgz+w+PYNiKeQYNqkwdhOsmGsXz1ApiYls9SF//pMRVzYOkWYE
	EUc3tEuqoWUvzlBDKRrZ8ZYGqsk0CdPhfXcdtaTBL4RYd9LkZ7awTequK2BJa+7OpCvItWUoFvzmV
	ww5bx/u6jQ5usEwMgf6RRS16jQ/fNdSbkwUy7QsJxYowPeiDE1/sJb+yWsHjMPagA7HI6TZNriNVW
	MmBx/AHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfc39-00000006nze-0Q6r;
	Fri, 03 Jul 2026 11:27:15 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfc36-00000006nyN-07Dy
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 11:27:13 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so482689a12.2
        for <kexec@lists.infradead.org>; Fri, 03 Jul 2026 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783078030; x=1783682830; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQvjlOiW+cm83l6iL+N3Ll3Wujm0kHNaCoPYlrf/mUE=;
        b=mdrJwnAMjBj1HZ7gdVk4t8PM8Fj6I2R0kmQn61y+jgU9cG4wUB0wzbKt0DzMdrb8mn
         iaDVapCsGK6aF+Mo3jRBJ4weW/pwzltlMBVgse7hB2wLI7QdNe6DN4/u9C2sDWuEEni+
         /gYuStUbCF+1bOXRGMlHxFqnrlokqse0XqbjlJKYeLEi3swjt6Xe9ymLJ16FBYeq2FAk
         YpDcgmBk0FHQUM+NiAXGDU11W27gxjAkbw+L7yklzLEFFYqc0wYWUWtdoErC24oNHEhf
         HgUnvsHx5Z0AaYFjKiRx2XLvCt74VfxNtVPK9C3tgZHiTkeVCET7K00Igoy6Vvgb1Byc
         etNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783078030; x=1783682830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQvjlOiW+cm83l6iL+N3Ll3Wujm0kHNaCoPYlrf/mUE=;
        b=Y/dXfsFzlYnOmCRpDOoH0iSTcYV2BZgAe3yiccBzYFtZJwBV2xp91mgLjWBcvWnh5c
         aF4Sfw0UlZFi2A/1C2b+HBESCgPpEt2chZQ+n5Emz7CsB2jjnUknbsrJ85Y5YOWqCcR2
         RhS98N1sR1kqko17bGkMi3WD1cwIJ9Fic3aWhQBMBb3r2lAfNN7vZxLBTyMKawwQUfeZ
         QAyVIqIUDz2ZtXRLeaLPHG8c0AlYnhzyEmj5ZSA3xaZr/Bt+4Kacb6vOeA9BagUNaDcJ
         nvUakGsK+nc7UZEtoYJMlJFKoH+F8O5WNPvAJEmlyB+is5v4vH6XY7SQzg/DSbtRAHjW
         gjZA==
X-Forwarded-Encrypted: i=1; AFNElJ+weyGmD9DBCpj/WOliZbxHAbcV4s/3Rq76AyeRl4gtXrQXLc3s1noxxf/zfcaGqv0UCwYmoA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyvnKXTTA25FBEeCoKB+qUqaUa5/anYQK0N7DRnmWu7cs7M9vSH
	E7QsAStyEItGbY/2e2N+MD0VtWn2dx18BRklkQN0QO92eRTZFshgZsrQ
X-Gm-Gg: AfdE7clKyv+gw+i+VHjRglaph/YJovYqd+qx+tYLbmzUxEu8htr1bARQ/UDu0hIlAhj
	CEEfhmE4TrQvadqn2rhgcVSpRq5ZpGyS7LCRG/cmlSR9tR1lQjdeOH3zggwBeo7YW63xhw7VQ9O
	QJ7YUevuEC5R3lb/qNtEWm4gUotioS0aaWvQ8WhKd3HQvwS/cXF3abRRMqCYSUse+dVgoppZKX6
	E5Sssz5hkYsIizTRB0UKeZkrA8K7+axtBin7oh3mKYEZPnfEdV0aY7+5QtYIRdNJtiWrlokuQsr
	pl4NkA/NOwe9S3KYY5SryyLlBayra9poCsdzpa9dhHKZLX87PJcxqaI6BPkjbygV0cf+/+r6NuI
	MR9lGgk7KQ96ivShsSZJ1ec2px4j1sFj3OaUUzrwCQEycwUnQDUcDcxuWbIRJVhkDgF4aEy+sex
	Yi0iamVYqtmUg=
X-Received: by 2002:a05:6a21:9f07:b0:3bf:6c08:2847 with SMTP id adf61e73a8af0-3bff42f825bmr11648934637.54.1783078030485;
        Fri, 03 Jul 2026 04:27:10 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:185d:def2:c823:8e8c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c876ea9sm17263039c88.13.2026.07.03.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:27:09 -0700 (PDT)
From: mdshahid03@gmail.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] dm: crash dump: remove redundant NULL check before kvfree()
Date: Fri,  3 Jul 2026 16:56:42 +0530
Message-ID: <20260703112642.65498-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_042712_068561_6F66FF98 
X-CRM114-Status: UNSURE (   8.86  )
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

From: Mohammad Shahid <mdshahid03@gmail.com>

kvfree() safely handles NULL pointers, so the explicit NULL check
before calling kvfree() is unnecessary.

This issue was reported by ifnullfree.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index cb875ddb6ba6..cf4d41fd4d5e 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -364,8 +364,7 @@ static int build_keys_header(void)
 	struct config_key *key;
 	int i, r;
 
-	if (keys_header != NULL)
-		kvfree(keys_header);
+	kvfree(keys_header);
 
 	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
 	if (!keys_header)
-- 
2.43.0


