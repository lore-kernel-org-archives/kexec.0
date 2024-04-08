Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B2DCD1296
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 07:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pODW13t6Z2/4CzcievDIgWeRljOADNC/Iafhtm17I+Y=; b=dQDkOLSyKhxRMq
	RVCeSPd0ntydYTR9A/uSAYvXXUFzQvk5TSqJMNkIM7DupcHkz9iIp2CbHTzo8IJ1mN9kSJwBc7NmV
	KB0pxwSEdVGgcA5AVnXEJnA3rhQNh3wxeAsLsI1QnEGrljtJ7S/1rC3MhJrdWK6qcOa8rMqPrspnb
	/rV5xzEDxFw5uNJkoVjNejvIFTrC+sfVai9BtzLa2GG3JNGpIpe7xhd6JYGn6mg3bUg3UMrj4bVHL
	E/dyIufPwMT2B4pwDWwyH6RoIjGhv7fG756xbAm2c2C/AFOZ3uB5AXM05XHTAm3GM/B7xxDIYAIiD
	f1JdQv1hyEgdcyJCutaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjdZ-0000000Ehuc-2W0r;
	Mon, 08 Apr 2024 07:41:53 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjd3-0000000EhcB-0jMp
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 07:41:25 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4168a0d113cso673765e9.3
        for <kexec@lists.infradead.org>; Mon, 08 Apr 2024 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562079; x=1713166879; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtkyqKxJvkp9IMsnHYE4l6zbbRyMrAgNbiaeWO9SXiI=;
        b=Bk4ggQRkYl7YKAwO6vmkXOfoTdlZSnvM5Vh40xaYXiVcto++Z6oXRIA2sJsdRr2iYA
         Xd/Ao0pY6tiHDQ6O5+z70+Lwfnr2GsS/BMwcRfwTAQAkuSdz7lzbMAaodpX1hsZCIoHG
         BnpGJKR+NXdGwwUhbe1MToB7CcSv7gYoRVhrE5apwnyeKtnqAnW56QoE1Ej9MjMPCsse
         Sf+g+6mDXr6VZwYmZA+D/7HzSrWAw2UgYSN1w/AellqL94bqujqmd531rE0oUPcKOyuj
         Guy5WA9RhAE51HEihYCgWTd8vsoUCsUvOCdrrTXskYZigPNBwFWgp1khN79t9fWLYAH3
         wvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562079; x=1713166879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtkyqKxJvkp9IMsnHYE4l6zbbRyMrAgNbiaeWO9SXiI=;
        b=ZLgWWK44pcyF7a3EF5esl7Grjq/i8B9KijarNX7q12VXtviQwgjkX9GqDE4SoyD99p
         DS8pGD68AMnigq9kvwsnJPDxjb8N1ophl2/ay9UAUhtNKePQa7Br00XNYHoDRffAWk8K
         GORJ1GlGv/YYMrb0mjl9RuYRlhmK0eWXPmpuDkSHaqy2bOTk6ihxoo/BhOKcV6TKt+uS
         UX1qTtwnUtp3Lq6aCu3BZMPloset5UpuZ8RAruFg2Fzj0dEbpbAOUVt4LD4jweCaXyMf
         ptEWseAYkvdt3vW5lzD15ZsODCxw/ArQJeUNmjSN60ZE3M5yQzKJhydI9zMmzG61apzV
         yRsw==
X-Forwarded-Encrypted: i=1; AJvYcCV7fcx2QYiviXjdmU0gOdSw2lSibtjxON2UcDNhNBaCK7p4xQZdbS3KbnAIlK6kKKVaSxMuDfl3fwKwOCAj6ukXCE9x1O2FhbGz
X-Gm-Message-State: AOJu0YyCgRa6nV73tG01PtDQgox//BKh64zpnqbWCy91VmMY3D8WPF+k
	ToF7Hpbmxc/Pyr2+r+UiX9SZqxtlPyWT+9McFokD1f8qHjiEr//v
X-Google-Smtp-Source: AGHT+IHCtTgtguJAV1/c4MkfZce3ouAm8nkkV1k3lPxle87h5W00nuVVJEZORfw/dl/4V3xbzdiheA==
X-Received: by 2002:a5d:5f46:0:b0:345:bcd4:bc99 with SMTP id cm6-20020a5d5f46000000b00345bcd4bc99mr1264651wrb.11.1712562079618;
        Mon, 08 Apr 2024 00:41:19 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:19 -0700 (PDT)
From: vsntk18@gmail.com
To: x86@kernel.org
Cc: cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jroedel@suse.de,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com
Subject: [PATCH v5 09/10] x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob
Date: Mon,  8 Apr 2024 09:40:48 +0200
Message-Id: <20240408074049.7049-10-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004122_411745_F891D81D 
X-CRM114-Status: GOOD (  15.29  )
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

From: Joerg Roedel <jroedel@suse.de>

When the AP jump table blob is installed the kernel can hand over the
APs from the old to the new kernel. Enable kexec when the AP jump
table blob has been installed.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/sev.h         |  2 ++
 arch/x86/kernel/machine_kexec_64.c |  3 ++-
 arch/x86/kernel/sev.c              | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index dba6cad1f7d3..9c773c272986 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -234,6 +234,7 @@ u64 sev_get_status(void);
 void kdump_sev_callback(void);
 void sev_show_status(void);
 void sev_es_stop_this_cpu(void);
+bool sev_kexec_supported(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -265,6 +266,7 @@ static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
 static inline void sev_show_status(void) { }
 static inline void sev_es_stop_this_cpu(void) { }
+static inline bool sev_kexec_supported(void) { return true; }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4696e149d70d..558266d9bf1d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -269,7 +270,7 @@ static void load_segments(void)
 
 static bool machine_kexec_supported(void)
 {
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (!sev_kexec_supported())
 		return false;
 
 	return true;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 36181bb26e25..aa53e8eb4cd5 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1463,6 +1463,21 @@ static void __init sev_es_setup_play_dead(void)
 static inline void sev_es_setup_play_dead(void) { }
 #endif
 
+bool sev_kexec_supported(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return true;
+
+	/*
+	 * KEXEC with SEV-ES and more than one CPU is only supported
+	 * when the AP jump table is installed.
+	 */
+	if (num_possible_cpus() > 1)
+		return sev_ap_jumptable_blob_installed;
+	else
+		return true;
+}
+
 static void __init alloc_runtime_data(int cpu)
 {
 	struct sev_es_runtime_data *data;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
