Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384BBCD5BD1
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D1eYeJpEHCAPY9Qi4Hjh6YOaoS1rocMPAJ4EFRgZ7L8=; b=2KvSSNAabRTTTk4LyaTtbS+JP1
	mhJ8Vln9KNjjH1kVtA77T9eZhdHYXW//EeZ3TelTBig6MBHvL5GNvOnjxYXKNzNkICxK8r9Pn/oJS
	CZ8gX8TOnJf+zRHy2u5/MIu/4l4TtbqkST2JJvlK7yxutof/2A8imz8MnBssajZBAQhzCoyzN53ZR
	3NS9Aknh3TUt4buXF5CnLfvElg/A0Zl757ppjOl/zPp1uNyT5vwsqFuwGqbv9KG/DOeRswE3fyurT
	F7WoS3PatOUl+lLGI8jDupcXkT8Nt8WUAS8a5bwauRBBK33ta2RdUYF+8whsFCMD+hIALGaUUSxaj
	DE+6T9FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4xu-00000003EY9-1Xdm;
	Wed, 27 May 2026 03:29:54 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4xr-00000003EVv-1O7j
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:29:52 +0000
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-841513664bbso3083510b3a.1
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852591; x=1780457391; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1eYeJpEHCAPY9Qi4Hjh6YOaoS1rocMPAJ4EFRgZ7L8=;
        b=njw45fy92ZiCRoVDIOGyWIE8L7TZlg4oajZAiHz59EY3D8No8sf6wOrW+F1EAsQt9y
         jKyvszQCDK7uqs/0MkMXdZCaEyQ95upL16WJfqPV/HCodFXK8rzMAdKcqz4fAPZA5tNI
         IkNKPOIhqMOBNTO4OaprYhxpVVbEWiHtRjgDz4R/J3ihyJcccskGOtt3GP4p2YdaCmYM
         KI5u3CyTzEztUFbh0pFgTonINAnsXuFXtVIzXDejEhf0i8Yw6vzP3AkywDaYE167OoDg
         4H8oNqij5p98iLHY0IhxtJblkwFOGpsh/DLG0GxtWjzev3NUfY6Dj4w2831BeQt5BFH3
         uYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852591; x=1780457391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D1eYeJpEHCAPY9Qi4Hjh6YOaoS1rocMPAJ4EFRgZ7L8=;
        b=XkEwXBC1/MGDTWnb61QFrhCjf+lCR3z8C9TTjkc4ZMx3R11kjL4J/aqfq1bhCNQbEM
         H9+DewYVLLVFfl4hGy3bVSwzske5VoFvBLtqPcEtTp5KFrUx0gUJnm51NPTUWKxjm/ZU
         vaX3DZ1JuVAR12Y2B3aKlLShuePmI0KZ82E1BCq4rOxjiLqqAK1QMsY5gjAvqXX0pfFf
         NSckQCI4eotrIBGiIy/9tpbC+jsjsjH8kvv4oXslrmJNDnsryPnRXfHfLdv7w4vaaxCM
         7iQG73nWf7zhxuMU5h+eSM/YF5hH6dAd585GyP2nLXaqvHjLpodJa0OidNemmdJGpr8Q
         hwpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/AiM1XHDS2ZUFToJfQ3+XZZCcUTTx4WiOYKVYXYdFfyA7h/L110h9AGZJpEY/PHd6c0NYaHg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzh6ediqemZG0Ux9uFXYItlFJS7lAHZkCNJuyTO26CG/fTY4Q3T
	fKUhS2Yq/gmXbJFFAB3rX7iqly1yZmOH8BBpZ5Nab68IvpSpM9kKcwje
X-Gm-Gg: Acq92OF8cOSez2i8VZS0MYqNoutrY8dhHyt5i2F94Eru2a76BfkonKqGDADt7wj4/9K
	EA5ohW1owP86lROMphv3H6LcgglNVcYoLXy9JdRFLkKJDnY23Up+k+iFetLIlKImhBFMbWZwpNB
	a0cxianPKrayeEL7OMaJJ58nWblXPDopJyaxbkjMCibY2WOmFZpxH53A4TlZZXCxVVAZ3x5DSHT
	qN1FUJimY9IUtuQJhPPTPBHER3bqTWH8OrieAOqZx16yiOndZHGHoPuYZTlua8bbvgNDRRkXYlB
	j252TumucEAMlx0SADzKRsTDg87uW6OsL2uV6YcMxOiMBe2IDj7ld/K2tLhGUnoEp71dRjAtifa
	DmolEDpyxJ3Zmj33bRnXpi2LDRJflwkmQNG0xsLjqiHa4YQeVAQStvw9w60WmfXojIH9XM8JooC
	LAAoE1SDdGbT1G8rmFYPwbvBks15bWD/b39Lew
X-Received: by 2002:a05:6a00:b483:b0:82f:6de5:90e1 with SMTP id d2e1a72fcca58-841611e8e64mr16309875b3a.24.1779852590643;
        Tue, 26 May 2026 20:29:50 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:29:50 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 02/11] kexec/crash: provide crash_exclude_mem_range() stub when CONFIG_CRASH_DUMP=n
Date: Wed, 27 May 2026 11:29:08 +0800
Message-ID: <20260527032917.3385849-3-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_202951_370868_E0DD76B1 
X-CRM114-Status: UNSURE (   9.33  )
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

From: Wandun Chen <chenwandun@lixiang.com>

Prepare for an upcoming change that excludes non-dumpable reserved
regions from the kdump vmcore and will call crash_exclude_mem_range()
from generic, non-arch code.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 include/linux/crash_core.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index c1dee3f971a9..0033d4777648 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -87,6 +87,12 @@ static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
 static inline void crash_save_cpu(struct pt_regs *regs, int cpu) {};
 static inline int kimage_crash_copy_vmcoreinfo(struct kimage *image) { return 0; };
+static inline int crash_exclude_mem_range(struct crash_mem *mem,
+					  unsigned long long mstart,
+					  unsigned long long mend)
+{
+	return 0;
+}
 #endif /* CONFIG_CRASH_DUMP*/
 
 #ifdef CONFIG_CRASH_DM_CRYPT
-- 
2.43.0


