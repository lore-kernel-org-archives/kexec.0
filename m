Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECBCE9B25A
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 06:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ijh1gRZ/vz98nkJ2ibune9S4XQ/SnjSEuxpGe+HaeR0=; b=tIGJkjRINRPQPs7Y9gqc7VUdKc
	EyAKXPAM2lnvSwrCztoRN3Xoe1ex/psR2CpKKvhJCw5LIDA9u54y93ei8d5XudQliMleVfAWjS6HB
	VIT+KWtvTaazLG+n7vduojhkU87EhIH95aaLDfGIhdMqVrN7qNZOKUmP2FQv7LWkl7ZUYEM32Fn4t
	cMoAU7dXyZYj/1WY+ABFwwLyD6fW+lKozSecg+KtN1uRzE6KIiBY59cSRHMdocYG7DESDNv+n5Urc
	gtDNZtJLeFGNijzNLtyCd71nAcZJDS7R04LFQr2i8N8LqinIhE+dU6DNuT0DPsgsZuqZzrJUwYoff
	4jGrX6lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv80G-00000003H7U-3o2o;
	Wed, 25 Feb 2026 06:04:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv80E-00000003H62-2ZIg
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 06:04:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771999445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ijh1gRZ/vz98nkJ2ibune9S4XQ/SnjSEuxpGe+HaeR0=;
	b=DSiEHwEgSpg+NZ3/tjJe/1Vs355QfowRJDnfbzbVwwAwxOnS134LWtf+K3wTCsAANq7Yb8
	RV3brwQaWKJTx3puQTjI4i5vvZAmwEsPz2Ax++9CLcgKtAfsmvWFf5RMPwkU+BxieKcf77
	v4NsY8VigCItSZdtUuqDuX5/vof9tuk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-CSezC_DYP9Cy50YLDxpT-A-1; Wed, 25 Feb 2026 01:04:03 -0500
X-MC-Unique: CSezC_DYP9Cy50YLDxpT-A-1
X-Mimecast-MFC-AGG-ID: CSezC_DYP9Cy50YLDxpT-A_1771999443
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adb085735bso14300545ad.1
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 22:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771999443; x=1772604243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ijh1gRZ/vz98nkJ2ibune9S4XQ/SnjSEuxpGe+HaeR0=;
        b=KlJ4qeq0eDVq8idMWks5UBWyttwKWyrAY5+Atq86StZr76/mdtfOq7WqiFFZxKPLvn
         SUSyR0mN/HO9AyrxmY+Kw6HBAo7T+Zm8RpN9+1kSK4m0/kfQMWrb4loFH6Um1pZYY3mn
         FLM6vQaH6+/IzsBILwKhgEDGNInK7gEQYoDUkgOpMoFmoKYhxkJ/67Dv5WkCj7we1rXD
         YGL0qpVy29BpjCMdUkA/U7ZIvcFf7rk4r/NfhBDgOxr8+vmMPYJwCGHcT1zQZVL32cXo
         JyEFsdNJOtB+KBNe2qxjlfVHefb3tPh06aDQSn3egEz43LcctpNDWqmxj2uMAR4mkle2
         eZlA==
X-Gm-Message-State: AOJu0Yyty4LkxOAnkZmSjpAk+PATsIy+MuPOtpyFi0ZxrZq6ygO+c8OO
	Lcjhtg3SEY+8IJSD6njea4CFr2XGMfTfiSyrBG9XdUB7Yv2m0pPQ4Y9ArmFGyV0c+V4Ctivg1tg
	/m3orkF9+lOLaTqaHVe5RGRWY9KV+1iHoqznIvlqU3i5mJlVcZiQUg2C77CZomiP7pVBcZmDgb7
	yIGI2qKaZkkVrhAi/RVfFydt4q7ZwFb+nXopLH3WAudIY=
X-Gm-Gg: ATEYQzwpHjWhR3Bewyu5/KALSf2XM6hC3gksthjo/py31beDuT6w6ydyCWcNElcEp9F
	qnEM6UbCbog02a0Jk3ZlQzeHBU9sw0TlrvOiVci0OGroBLLZyMP2CZOsoEwst8KuA9ynSeoV3N3
	+iV3jmegFvs+dNN57m+xCn3SHT5oZS+GV+Eh6waz60o9nAffSuwPG9Xt87gLzOZnNHaCke1b1Fk
	RczODDF0KoswoiFhx9aaakalU4iTSlzOPrWE4BLNom17KbSOAVag+DSkITaoUovulh+QMS2PkVU
	mnLmaxfhVBZN6CXN/+vhSxpZy+6AkFJiiSrW6iwv9Cn0afPvtpD4NxLbi91W5LQq2YZ0wYtasCs
	UftK7OAYHQ56h
X-Received: by 2002:a17:902:e787:b0:29b:e512:752e with SMTP id d9443c01a7336-2ad74556edbmr127353935ad.47.1771999442450;
        Tue, 24 Feb 2026 22:04:02 -0800 (PST)
X-Received: by 2002:a17:902:e787:b0:29b:e512:752e with SMTP id d9443c01a7336-2ad74556edbmr127353515ad.47.1771999441818;
        Tue, 24 Feb 2026 22:04:01 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3507csm127703285ad.8.2026.02.24.22.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 22:04:01 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/3] crash: Align the declaration of crash_load_dm_crypt_keys with CONFIG_CRASH_DM_CRYPT
Date: Wed, 25 Feb 2026 14:03:45 +0800
Message-ID: <20260225060347.718905-3-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225060347.718905-1-coxu@redhat.com>
References: <20260225060347.718905-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vs7NHNGYGVVTSuYge_fxRAE6pcGCEpHxGoLO_5e6vBs_1771999443
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_220406_727825_18999B41 
X-CRM114-Status: GOOD (  11.44  )
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

This will prevent a compiling failure when CONFIG_CRASH_DUMP is enabled
but CONFIG_CRASH_DM_CRYPT is disabled,

       arch/powerpc/kexec/elf_64.c: In function 'elf64_load':
    >> arch/powerpc/kexec/elf_64.c:82:23: error: implicit declaration of function 'crash_load_dm_crypt_keys' [-Werror=implicit-function-declaration]
          82 |                 ret = crash_load_dm_crypt_keys(image);
             |                       ^~~~~~~~~~~~~~~~~~~~~~~~
       cc1: some warnings being treated as errors

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602120648.RgQALnnI-lkp@intel.com/
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index d35726d6a415..c1dee3f971a9 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -34,13 +34,6 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
-#ifdef CONFIG_CRASH_DM_CRYPT
-int crash_load_dm_crypt_keys(struct kimage *image);
-ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
-#else
-static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
-#endif
-
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
@@ -96,4 +89,11 @@ static inline void crash_save_cpu(struct pt_regs *regs, int cpu) {};
 static inline int kimage_crash_copy_vmcoreinfo(struct kimage *image) { return 0; };
 #endif /* CONFIG_CRASH_DUMP*/
 
+#ifdef CONFIG_CRASH_DM_CRYPT
+int crash_load_dm_crypt_keys(struct kimage *image);
+ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
+#else
+static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
+#endif
+
 #endif /* LINUX_CRASH_CORE_H */
-- 
2.53.0


