Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2167C02180
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 05:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88SqYtXaTV08jsATT/J9IavghVGb0T0MbX3fafAbdCI=; b=uvkS5vsPJZFbz13YQ3+RuJ/1aw
	SH4sq5TnTK4cft3sgsbGcapPQBydlVsUb2NGSHzbCW6tVDqN7l6j7YCdfPQp5xiqvInwFfEokyfSw
	rIyrpeDVTpGJNUBraT5BOdAKa+xAH5VP48VVZhh9tFaKMdiC804syyo/Toq3itLJ31qJobLudekEY
	PX7OTQIixQ4q5j8/jJeLbBTYsP57NV5dcuQLVP/+vyOxYGJiAf8zztB22R6TL/l9CHx6e6z4qHMeY
	u2ZCDBPVQiE4REmNjAzZoMCGoxvdMOkioVZLAgYHvIwFEIkSSBb8JH58uOP8ENitAFzo5gvUR/WO9
	0BeqdO6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwHI-0000000AjLx-2XH5;
	Wed, 15 Jan 2025 05:49:20 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwHF-0000000AjK9-2qpE
	for kexec@lists.infradead.org;
	Wed, 15 Jan 2025 05:49:19 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-21670dce0a7so137018975ad.1
        for <kexec@lists.infradead.org>; Tue, 14 Jan 2025 21:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920157; x=1737524957; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88SqYtXaTV08jsATT/J9IavghVGb0T0MbX3fafAbdCI=;
        b=sMHgi+n6ZKJI+ywkMCuWowzg6vKPtia7AknYUAblfWFMG0UlmxAg5T2/oPhGIQmVyt
         p8LoXf6v80gG3lcPpgoXBERZ6G5gIo45LowtVxzZZoT8WH9kTTAtl12PcBnaiRCKNIgF
         7MNZ1ZKRbXF9Vcsrj9Nl2WLVzc/AQlyws+p9xU+jsAOo0Vlj8ZZb2QXcpmKli+sTdKW1
         TCjtPeLnkA2Drp7c7aU4zkptB36ICPMD9UogcUCrbvz2rJs4BId4XaZDbyFX84bMfxhH
         aEHk7TwF/dNSri2w9suuSQCpEceHokWuzCY19Y7YZycVJrxE3v3jwtKcM0+aUURImweX
         K9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920157; x=1737524957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88SqYtXaTV08jsATT/J9IavghVGb0T0MbX3fafAbdCI=;
        b=j7vMis0Ead6TF1xgC/MC4W5u0sKWjG1LM+W5U6Tg0JH4fhrzcbIe5nLbzIRcr8SqD1
         XkbnPGE37exW6R7KAkTHGD2MYOwsid/Nx+NleZpLqtdrTvArsiB6bvNVzz/Xtuf3EH6n
         BlLjgpVHnC6Jbq9JOmg50Q5so9ilvH2uGc/RFU0C+hdjWLhLbGgEUEYdmYw0VQlnR48G
         B+KKTDj65loZc0mBl8bWEkqt58yFaaitHENDhTjWSGd+rNHVBrudkTswBwEpm1eTq3EW
         ZxGQymPj6IFQPwFpUlwmCZRhPvAKro5BUcxraesSKFI12LMBauort+guD5tdLt7vwc4n
         cC/w==
X-Forwarded-Encrypted: i=1; AJvYcCVhjV/rhQ2wsRaVPoQOCWPF9iFnmRjazppOKiQ422a/zYOG4zU5V4RVp8vTQ3Y7y8N5cL20Ag==@lists.infradead.org
X-Gm-Message-State: AOJu0YyVioQUFo+ABCU/ASpB2E/s55KYATaXREjFJ52S4Bhstkhw8qxa
	CgxJI7vlzmKPMlPTn9WV+UnlFd2GGRmQ/u46OOu3SbcovAByMnlXaOegaG3o6mucgfy061AeT5H
	sQrA=
X-Gm-Gg: ASbGncsK7JBtsljM5F4w7L/EKgxr/yMjxKWUoDf1vnHacemAh4vTG7X1Z/8bHR+pewO
	IOM30O5+LGMRgZFtwvk55uTI9JXr1hGVumTSkud2AsHmlO0UFngHV9CRUV/MVObkzfbhaMI3Yij
	p/Or1unK2vNZZwsvv3KOarhlGElHCNV781JfX1h+oN98PmL5BGYWqPS95Chs5/0CzN1/pjaG5fI
	z3ZJ0OfUlcTf1WrDta8GCVEvrCipYCiMdw5dAggRln03n7VGYBqGqA3w8c=
X-Google-Smtp-Source: AGHT+IE7CP/5jGWZAR0IrIqQIqvoQb7g5wi9hxFsU0CFVXu0dR68h2h3F8IAezzLwnE0Rlv/Ybh8/Q==
X-Received: by 2002:a17:902:d48a:b0:216:4064:53ad with SMTP id d9443c01a7336-21a840109d2mr433462125ad.48.1736920157113;
        Tue, 14 Jan 2025 21:49:17 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f22e591sm76124125ad.180.2025.01.14.21.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:49:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:48:03 +0900
Subject: [PATCH v5 6/6] crash: Remove KEXEC_CORE_NOTE_NAME
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-6-0f9e55bbb2fc@daynix.com>
References: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
In-Reply-To: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_214917_722300_236D58F5 
X-CRM114-Status: GOOD (  10.62  )
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

KEXEC_CORE_NOTE_NAME is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 include/linux/kexec.h       | 2 --
 include/linux/vmcore_info.h | 1 -
 2 files changed, 3 deletions(-)

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


