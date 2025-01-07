Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12F3E7719F
	for <kexec@archiver.kernel.org>; Tue,  7 Jan 2025 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=; b=gTaB7jw7jc422xRcQZuHrufrhb
	Stcfvj4sqLfCTeIUYyQf+SQRxuxJd2vxDU2N9WNeB16f3eAay74wKatRv9oLH/8Tew11fadRQp4Gk
	4kFvARRojihoTH2UF/2Yi3wjDQ9K/e1PcM8euALvKWcAxi45MHz3x5G1NbWByWkJGDZf9AubHJ/zj
	ysyU2frf9EBFhVe4QZtF7C0C/K8N+SFKboeq18L4Zmua4ealbbFW1N7EeJNy7maLnLJrMMFfN2YRd
	RIkcUZqQ0u/5JrszZWeJN7wztTD8VSVrdQhKsVdFKSPW/qYC1DqlmvL92XYB7RDRNphZ/kP1lv5BJ
	oukppP/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV911-00000004pl2-1u0J;
	Tue, 07 Jan 2025 12:48:59 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV90b-00000004pZ8-0L40
	for kexec@lists.infradead.org;
	Tue, 07 Jan 2025 12:48:34 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2166f1e589cso6813985ad.3
        for <kexec@lists.infradead.org>; Tue, 07 Jan 2025 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254112; x=1736858912; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=NEQb52MPmDYYgJg2TY/O53FePluXCaCeRlELOdZfAlCD0cdVrTzCMG/GaNLGXYt0Na
         xGR78ptquiQTn/Or8UYAt05o44pddMbh9OxK+pHI0eE2Z4o4cqBDT7TUo91RGpze2ljc
         cUzyBtONeFgWmMOwFImPGHGKQvNFaQT3+X84YADwQITYtasAHztPZ1zEAVAyiHgxnmNk
         PvG9o3ywowKcrZlJWJj+yXz2iurrOV+H2o7527eqEz3F4jQ9/McUTiokdBv5+ogCJhUc
         3YMGkFoidJilsD7wqyzo2aZ1NiDxRGpZ0wQcP37parPywjXCIpZ3BvoHeBC9G3IEBMEc
         sRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254112; x=1736858912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=F7ZUaRAOMVBk7LiEY1rwYurkQ1UfZ4ZC+jM2OMo1P6RXYx7+sqRx5879NLs+50rJmW
         tLWJgwLlIqDegtOQU2oL0lkD9RBv2pfzGrr+fdW8SOuGPlFa4bWnKRSViVeQvbFi5t8r
         c76dhuef7Af2TAsYcWI/xeOedltApTjGzOvsHxqW39EIp76mThRR0AO/c6wnt14hRqFB
         N1O+jUlaNYpDtbd1F6YzUJ/POpx17xztjAK79ieLjV91/LQbsvGT94BBvGd9x+eB+vJO
         hZGVFVe5Zl9nnnKrHgv+2Wmz72EHGgZmzsqDNpYBPnAW3KxabBI3XyP5fC9W2RYWukTD
         vk5w==
X-Forwarded-Encrypted: i=1; AJvYcCXLeM/eH7xOxuwOGgPG6qC9QKj58AoChlFzv9iEtlqlGSaSJYzOszIhpe4YCR6i6nn8EORUIw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwV8WJumfx0xsuPbbHHHXmXJCr/93Ylz1zezlhiEAJKefAEPN/E
	nJODzcqcOhAv7HFr4377PWfxV8Th+73+PsYBjKHOiE4HOaDcgAUWJ7nxWnWsH8Q=
X-Gm-Gg: ASbGnctf9qs9CimzjSiIwNAkcmsgtFzPwvvnIwnFLMGU16xE/M/FDRmfw5xMyCjFPe+
	SB2YpmscDoH+7Zrn5g5IzH+n8sT7QLUfPtecNOJSOripxE8wiOiuSbHlGRdRC79xhqAyVQfQ0oh
	+22DWziyvxM5TB9Rg914rP7apnXvySlM2D/3/dCfzKEPOZdQ0hxbsX9aH/5hqOhXToXjFLsZdvr
	ueqcUdaIISLjhgUafmpqURjPyDcQO97gqTBgx0sXsZ934K0pZbsTSPoBLU=
X-Google-Smtp-Source: AGHT+IEgGWm+TwbUeO+9N7FURX28AGtJrPEUj7uS49yO94eCRFf85XIQjkIdMNAyflZYWE42i4plAQ==
X-Received: by 2002:a17:903:22c6:b0:216:2474:3c9f with SMTP id d9443c01a7336-219e6f38177mr919043015ad.52.1736254112256;
        Tue, 07 Jan 2025 04:48:32 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dca02f72sm310596305ad.249.2025.01.07.04.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:57 +0900
Subject: [PATCH v3 6/6] crash: Remove KEXEC_CORE_NOTE_NAME
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-6-99cb505b1ab2@daynix.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
In-Reply-To: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_044833_122492_73D3244D 
X-CRM114-Status: GOOD (  10.78  )
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


