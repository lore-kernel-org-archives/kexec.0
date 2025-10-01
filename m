Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C0CCCA470
	for <kexec@archiver.kernel.org>; Wed,  1 Oct 2025 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f0vDG4/fq7DZeKUTWI2OCBq7bMjSZJ2K/EiZOAMPt4k=; b=roGlwu2l0rEpfS8oNFMjUimms/
	FAwy4pS1hjOfRgaziIaUXVCqzWOUA/kGFO+RaRxerMbqc3QptclBitfMVPGLhrg6XAChb7VdQI6I4
	OXbCK8/TVkDE9rvUXt/jMIHk+UlAmymNc+j6v+DCMveGNy8GT6HKV7uRQn01nmmdJ8UFsHLdcvHgh
	x/zm8ZA6F0BTWkLIJVGniDqBISEPnRlWG7hmyYVOcR0FFFK4e5hCojcJcEfNASOB2TrE6rzfd5OJQ
	8Xkg7iiQOUsWhGcpGzp1KO2hISw488QUMu2FnJ1Ux3QRhW9MRoPejQKlemyEwJNdB6wcwmV7f5Ckq
	vYSsvcug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3vy5-00000007st4-3AVI;
	Wed, 01 Oct 2025 12:30:01 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3vY1-00000007W7b-0jXR
	for kexec@lists.infradead.org;
	Wed, 01 Oct 2025 12:03:06 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-27eec33b737so77540225ad.1
        for <kexec@lists.infradead.org>; Wed, 01 Oct 2025 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759320184; x=1759924984; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0vDG4/fq7DZeKUTWI2OCBq7bMjSZJ2K/EiZOAMPt4k=;
        b=aLksCv1qE81vgA4MCUBqk51s84gfOHM1Asn7uIHp2fMKJSnAs4t4E6LJcA71ev8L5Q
         YaGk835DTg7mGjfxUwBg4CghHgj3QBEyuTHcvO4ide+GaDG9EVYIvqxWNCzsgnfy4uVB
         I7yDk5XEWttxrUYi+HW+rUxOkx/THW6RHxPZLBNLqk/OfZXNT1KxHbxo1sxjbVhLaIWz
         4wyuHt5ZLRWjTznqch8aHvg109wW50yftz+s8ULYRfXPeXv1bCyUFk8XaqCOOePI1BwB
         Od059v9SvxMcILGfZOfsj1TBH6WczwPisTsk8OkeAV+S8UutbPRWx5168vLF1s8180LE
         kppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320184; x=1759924984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0vDG4/fq7DZeKUTWI2OCBq7bMjSZJ2K/EiZOAMPt4k=;
        b=h9vOjpGCqmfrmgXWnHLWj7GgKVG4aoGzve+JRrFxtw4yWLnK5PTXmbYJH9kuihTI+v
         OoUNsugGpWEZ5ACAJ2d/XKBqPWteGQS84Ul6GX5t5Dw6Y3RiXyTdq1zU5vs0WjKBMEpY
         HKeUEKNTXzWhBd+7LFhyYCPGJmgqSeuuOhzWdwM9b9pVKnTHe0hBdM32II5PBS3v+IQz
         4vmPKyhprx0Mt9vihehxaQSSEX5lflVFclKwGysygUKbVZ+H19U5w3KMyp1jgv6I40I5
         LR5mQQ3NPOhmxOnsEjmXJUj3QlH9bICZ0MtHCoTxhySm0CT/qq7VGl8hnEeDtzaV30rd
         Lt6A==
X-Forwarded-Encrypted: i=1; AJvYcCUTZfgpHMOxHqKeV+Am/6UWbkH6Hh+fsowea9AEI02lXmmnjRZuAV/mVJMv808UhySbnsC90w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxp8mXcof8Lij90NGjIHwjax5UZSEL9hO1n01O4hFRw4ksJqbzs
	LjkWZkzuysiNwJP+Q9Jjmm847qvaH25ZnWQ299jmi73v4ZmB/93tHeIC
X-Gm-Gg: ASbGncst/VBeT6yjynZGfvHt6Ktubk2AIY2Isr7N3GMSka9zcjZyc2RggssI473vDVN
	8iU6O+XONCsFkkBKYUsYSkM9S9nNWchFg3tdDu200h7oqNSza04p0R/w7KgVNPhrHeJwG/qFq0h
	1Dd1ESuvqHcdpDWwbXGagjIIyINlIpDRONEpa+TbLp4q9mBVuKdb6bXPejEP1nckefAoM1n23i3
	yLnXE+Vsck9szK6DYy6HySVmpBK/8VWZFDaz/ITxAQv5uKBhvboWYL73td/Q7jIB78YPwgzIt3J
	HuGshbOzhd67zZIcjznyzdmflYG51KFWFww5qnfQEIICzxL/Iyr4LC29ojKRgptvn3up3Q9tYY0
	oOYU/bQnRkUIll59BppmpkI61C+j19NPLROMfVnFHaAzUM6D7Z63gv1LxqjnK9Exg564=
X-Google-Smtp-Source: AGHT+IE7m8OIwMz2w8M8bP9q+AW7a4srs34CjsmnL8oZDn8XkWOKffvht4XkyftXNcv/2DLikcz+rA==
X-Received: by 2002:a17:903:3201:b0:281:613:8449 with SMTP id d9443c01a7336-28e7f44200amr40785835ad.47.1759320183833;
        Wed, 01 Oct 2025 05:03:03 -0700 (PDT)
Received: from archlinux ([205.254.163.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab67a9sm182986765ad.131.2025.10.01.05.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:03:03 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] dm-crypt: remove ineffective comparison
Date: Wed,  1 Oct 2025 17:32:54 +0530
Message-ID: <20251001120254.24980-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_050305_232034_81041900 
X-CRM114-Status: GOOD (  11.84  )
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

In restore_dm_crypt_keys_to_thread_keyring(), key_count is a global
variable declared as unsigned int. The comparison key_count < 0
is therefore always false and has no effect.
Remove the dead comparison to make the code clearer and
silence static analysis warnings.

Found by Coverity: CID#1649028

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 401423ba477d..39cfc13ff350 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -115,7 +115,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	addr = dm_crypt_keys_addr;
 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
-	if (key_count < 0 || key_count > KEY_NUM_MAX) {
+	if (key_count > KEY_NUM_MAX) {
 		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
 		return -1;
 	}
-- 
2.51.0


