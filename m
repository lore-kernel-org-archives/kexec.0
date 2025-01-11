Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBEDE7719C
	for <kexec@archiver.kernel.org>; Sat, 11 Jan 2025 05:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=; b=sJWVEmzcrlJwaeb+P9mKoa9K8P
	xSiy4goChjD2r57m5T0LWEwDRsoLG0Z+aRNYcgPg/xoXBj7t+8qG2IX6BD3ZNnaQzcN/koyGZQmbN
	EODzSSxwTQjkuG6kNtW0YukeDXU2s2FBS//21EEChAE8o9CvOys0nZRMGV5TzOLJYIqL6QoOvKWEi
	0iLqURJ7JX91pYFoEyaYJ66uVZuNgDW8D7A28w9/HeVNs54ueDfEFsxvX+5fe8H2vNi1EjSFDRBK0
	TnpSzODEnkL/CF4Lh9TvxnUApD5OEOs7hBxuO8fUnwtezz6agPQIN2fEeb9R3IAtL7I6EDGkMEOc4
	I5vAr8Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUNP-00000000Ezh-28HH;
	Sat, 11 Jan 2025 05:49:39 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUNN-00000000Exc-1Jb0
	for kexec@lists.infradead.org;
	Sat, 11 Jan 2025 05:49:38 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-216426b0865so46407215ad.0
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 21:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574576; x=1737179376; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=vV6Jwtagkoerayv54uLjvGEHTsau0N4Cj2RkrpyCMZRlZjEcRgRWnIRa8od8r6wdJE
         Pa+qPqbOApDV+GB4KHGntytB1iLeQHWrdGOdDASd4OXbQjPq7y53skugHkMpso/58K1O
         JIjVVhwxD84VsJPwMHzunqBJUpK64QVWvWjq3umt14jHsFKeU7zG2206WlHrlRK/9/Fr
         UYnSlPeMVcbWS6ocPVdfSjD+ij0M4KCQFfCrchpUKnWp67hA+Vt08E40CXF2Mj11uQCX
         jebvsFK680KVBXgQFmRUPIvEWqpq3YKIGarBzapVY5CL88O1malzKfa/czZbXomY8m/J
         JeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574576; x=1737179376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=FJ6AxUeu/r6JpJcsyAZ7xVFc4JaWxW2soegl6K5vdweU8StYUr5KG/aJSEYAdVFBAu
         AYKVoBqKe0YGSHRBayRfa5rKbbbnbIcrT+Ojqubd+uzs4GnHa6FphfssF5qburnFJAiI
         xVONlc97wrZ05owWyrVH6LEBtVUjZ8zm7PmQBDHyrtlMA+DuhYWYXIHALc1/YVm+ZToy
         qptuz2w50zGli6p2gusKDD8+VJRvHC8Vyp+TFQf/Z3H0r89f48kOJPXycXng7rsVr4TY
         uRMnvLSBNXcNBG0UH7GxolgLX4iD5wRM+MZFJ6KoQemBj/XemDblDNNWvfMbeYhybSFi
         sy6w==
X-Forwarded-Encrypted: i=1; AJvYcCX/l8eGuvd2iiWnV4y5W1rEUZ4GvIIh6zMBxJPJPOnEanwTy2TfKxsjo9F2+612aVvW91CcbQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9GnKfo+XnisSTe1VYpHoiliaK7Fkdr8TPMYxq44IwHSt6M81/
	OOLIp9wcN1ow+whWKLRnIcm8EohTDSXOckz4Wl4Dw4WX7YtpQcUKRajyfaM03B0=
X-Gm-Gg: ASbGncsCG30rMJs0WnpT/EwbM4a410F+54JJZgi53vHWlfYuWXBFAKT2c/n/e5+6XLk
	M25bP0XwiYEbafHDMpIMguIRq7/OcHF1viCmkyJtUR+fNpCWa8ubO0FWiStC2lvk9uec/R+p4NG
	EqB0rYadBdmNgo9OgDeoG3mKbSoKH4JBdXyT6poSPizad06uqMQr2uupL/1L1gPzg0Zw4ZS4PsC
	p/UhEcTVJN7eeDV8wH02f0X66z7Ms7jWzeRes4VC3TWgqx33r2z19VfUh8=
X-Google-Smtp-Source: AGHT+IGdQ/W+GdFqyOEQRaBJtYEIC3d/2Cs4dWBSsnFKDdtRyf3/E/GqQ6RNXv61x1Bb9PKDJOpeZw==
X-Received: by 2002:a17:902:e552:b0:216:2426:7666 with SMTP id d9443c01a7336-21a83f36f14mr210827905ad.12.1736574576473;
        Fri, 10 Jan 2025 21:49:36 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f10ddbesm21468195ad.2.2025.01.10.21.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:49:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 14:48:49 +0900
Subject: [PATCH v4 6/6] crash: Remove KEXEC_CORE_NOTE_NAME
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-elf-v4-6-b3841fa0dcd9@daynix.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
In-Reply-To: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
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
X-CRM114-CacheID: sfid-20250110_214937_357124_78E7C74D 
X-CRM114-Status: GOOD (  10.41  )
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


