Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFAAC27C5E
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SVjxG1RChiTGWU50AmH3wlROxMa1h2H0Sclru9B5mQw=; b=cdLINz5JrfGSpI
	D5Ywd1cyB+tnjE1vLy9Z697U+zZba35YBcpI/hUAeEDr40KF/WDhYT6RTOkr7pf6EuHE3taJLMuLd
	MdiYSqGCUKxPGv97tBQ6NOqgRXxxQbatnfAHu69XP0slIHZk7Pym356GoKjC2OaOEAAFGzxo6VEv4
	EfEDz4nGYYcnpschkDkEgTLcTZii/8NPfSvWASoKk1QhHQ5EXaOR3QX1mt3adsv2aqf0S0pH5uOvE
	yTqrdma2Ntu9aEs3jnNorW6OKj11KU2cJPbjzklK6nTUwGLN2INxWAb4kYTVPirlCC8neYVURlUoj
	NRd5AniLuBq1iEf/iSWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGcA0-00000004cb5-2dcT;
	Mon, 10 Jun 2024 10:21:56 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9n-00000004cQJ-2rYy
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 10:21:48 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so1658590a12.1
        for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014902; x=1718619702; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tjh976F+w5dkctaCwhyVJIF3AZpvtw+7R+eeFp89bGc=;
        b=GBEmZTsohfTenfDfmcCipYyno2oOjX+gEbeX5u3SrexeYvNrgMjpJVo0z538OTi0t3
         jflEhjZBq3C1EbLS/KWbRmTw/WwDY/1fo9HnAvZIuxSn5t7teaT0vvm6D5w/UyAflH1e
         5wku8K5iymLbifVKR1VTnJwe9MKFaFmzcFvlqCPkN+/dqtOPu0u1jX8p0eXPGaYgqunA
         yL/qUhzMH0ZW5iHWEkky/aL7y+hs5cVmeMgfX5Gj10ARjg5dQqms/U+H7FI/G+yOwnfS
         WlFjBtUNnnh3SWPbruAecAUm3fz52IF/bCYsG3A0JnRVIZyekr9sEzi5Mi96on4hmvmK
         MN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014902; x=1718619702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tjh976F+w5dkctaCwhyVJIF3AZpvtw+7R+eeFp89bGc=;
        b=AwDHuvIM9pFG32kVZkZwEP+48kTDmj9CGFNzKYCgCjWBc0jnWDdsnUS82jqRGWcWKY
         afBIulv0JC4n+tslLUDeE7Kp6oKmMU4aEuirTobLLizgMCf8FwqgvfU+x57B27+XhPhT
         nt20rAzVw0aMMk0JxQo9bo//GWLk1WKdo5phS9/20Ih2hn+hJJPeCyhgep494EBMKPMu
         ErNf02ZsDQ1ysfgT2euLWMTDKGfTPIdTMBm21hw1D1x/DhAPRH8Ub8iZaFPVWFnaehGC
         DwhGE4gYnEo+G3K/6ytKIRbYv+EJyOgGHOQ2+fg+kEcGwdUHkk63qQ00OVDRjSyTJxR6
         rT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcdDF2d3mxWflJYoDfdiMEpXf6O4gKvH6YqAAua7iqlCGN7fCXP9aR3VM6QhBX38ReJA0v5NK0JCdncMMvTWJbGhcooDGMYGrL
X-Gm-Message-State: AOJu0YyWCBvE0oZuTlgayEbaZKz+46/g9TpjCb20BzwQzNPYSxzsvQxC
	Xplb4+ZLTWSzYoIvnZO1jt7RoJA+EMLocmxAgzV/Hhqq21hUjW1Z
X-Google-Smtp-Source: AGHT+IEHe6hQkeUB13VRsNS95Hd5J4lzAWr+VF1fStw/ZH7jO5g8M7PodQMj2dQ17+7klWDhdygebg==
X-Received: by 2002:a17:906:6a0a:b0:a6f:1d19:c0b1 with SMTP id a640c23a62f3a-a6f1d19c496mr194718166b.18.1718014902187;
        Mon, 10 Jun 2024 03:21:42 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:41 -0700 (PDT)
From: vsntk18@gmail.com
To: vsntk18@gmail.com
Cc: x86@kernel.org,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com,
	ashish.kalra@amd.com,
	cfir@google.com,
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
	michael.roth@amd.com,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de
Subject: [PATCH v6 09/10] x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob
Date: Mon, 10 Jun 2024 12:21:12 +0200
Message-Id: <20240610102113.20969-10-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_032143_945145_15C2CFA2 
X-CRM114-Status: GOOD (  15.28  )
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
index 6f681ced6594..e557eadb0ec9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -233,6 +233,7 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void sev_es_stop_this_cpu(void);
+bool sev_kexec_supported(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -263,6 +264,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void sev_es_stop_this_cpu(void) { }
+static inline bool sev_kexec_supported(void) { return true; }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1dfb47df5c01..43f5f7e48cbc 100644
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
index 30ede17b5a04..e64320507da2 100644
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
