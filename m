Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D082BCCA465
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=72zF3yLWX3oeYl+y53VRvYROQBmMjAwdTi7nEp+9VUA=; b=JsYziuTETmp4tIbeTh/BM5BYs0
	NCXe9nm26hEiTyxvdTdNfJ2ixyHI9gKSDHYENa3u+Fi7TgDw0v+C+jUz5ZCk3bUkMA4hJPEiLOAsu
	jc4BHPndvsZMcBA/ru/8T5ARPMvPilBp90IzO0UicGOzph4U45H6Qkqd1spkqTqQXlXRSyUEDeXwS
	im6ca6nF55+1LVQ9RBJrNC9px5AJBkdg8RgvFT7zn5DC1tDfc/otPfOOHLDD6Rygnn79DEAJfoyAM
	aaDJ8bhtiszAULXYNPurvOaamSI/irMFNSUCz8qEvINAlvDKmc0rGJ1vyEQjTkTzIPRFaO5yyxVzu
	Ick6FOfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSq-00000000ZZB-2xNt;
	Thu, 15 Oct 2026 15:33:52 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSi-00000000ZTj-2YK0
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:33:48 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-7c6e6822b11so564587137.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792078423; x=1792683223; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=72zF3yLWX3oeYl+y53VRvYROQBmMjAwdTi7nEp+9VUA=;
        b=FQZ5TZojJP6suNR6Ptepv2iDzr17VrMSPPyEbTsimZe41sulbYaLKi1zkRQKXE49Fh
         lqgx5YhV3bvJHsFayzp4o6LiRT92Ie9bzRDa6Z9+EzU9F8EA50NeBB5qsNc3xOJoStUA
         C00f9f86btlj+2MsTxoPeTBKDmrWsvOhUTU0TVOYJbRoRxsPHsC+0aYa+Z+WoulMpeCz
         t8mZBO66D7kY/kc9PhpA/Ac4FGUL1RnPIxUVfFSgQc9xRf4woAeboOQvbPP4B4E1a03M
         W8ioC7cUwoRYsvfNPHwkxIyd6jKoZfSZN0cinI3StLGcHrhyvaLxIkf9iIG0KtGv85Ne
         JqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078423; x=1792683223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=72zF3yLWX3oeYl+y53VRvYROQBmMjAwdTi7nEp+9VUA=;
        b=tT1gO2mPX/xfCSG3itBkP4N3x6yyNWHEFE/ii0NrI95KZTnjzzjmovYE+rPVPFJTzD
         L0EsBrGOuqdqG/grT0fTW5eWiMc7A+2fE9HIaF17SGtS2n+m7Gs0GeZxoq9+HvMdvv19
         lcg7fHCLTn+u8e01Of+cgYV5XAMWxxKK2qVV2BKLTC5q1qW6e6vF8khWmAEJVZXuLXYo
         TTFrblvcKzfbdpI2JITKZyf8wAifkVWTijH9PPujO7flSCox+vQrVamDU7tAuPn7p8L8
         tsDNqiOCGlqc0KFlS+EpdEiHTimZL+UePLfZE9+y9+3omUo4j6ZFPW+mpZiHhzlVygk3
         OQRQ==
X-Forwarded-Encrypted: i=1; AKwUvBykYFbKXPka3Hi00ijdZcS+2GdfE/DgnZ0QBNLcdIwfrh2coRT5YPTtb3jhvwOmUB+e7XXrVA==@lists.infradead.org
X-Gm-Message-State: AFq9FYKnhkRQtwuAOxaRFiE75b+eKpV/mN2llf447rhEM67Tl7DxF41P
	TSxGB1gISIAENQCUYszOPXewCf702vBEo+NVpH2eeF4LzNY/4kRTmj13wE9U5uKv+dk=
X-Gm-Gg: AYBFou3REPEoTFupGclNUQIID81Pznh3ZBS/8X/ORZYr+rU/36vhd3idLiG4qjMk29O
	eKYN52cF0Gsp0U15kc1wtuAoEdnfEVgpIlfUQ50G9OxuQqQvhvC44cJ3iHaSe/mXUTpVP1Q6nXn
	+AwkxaP3WXaynV/GeQ/aoR4U6WFngYrynsQiKcMjZrpdYUC7dBHrJZIXKd40ABPXlBCIWjZjubW
	DJs0YR2H9JrB9Ruo0uG6ILciSER4IMOPsjybzRbpj2WC4RxbxMkDzB5Q30ukmtyK8oEdauEz6/x
	M2ovOaPkxpYwz8txL0gQAvc2pJ502BpO6tBcgxbsRcxRWbp0dC5X+R7VqMRIUGwcDnWMS1KIRbk
	laMCvGNjV/U06SAv9nFfOM7fU0jczB4jZ8vs9poIrwEpkKSuaxiOsZi2dP9GxHmJtniAoaW1LnC
	PcYdvs9dDaJU0uc9/z9mQqJMIS+WGcoAYFO0sXg90ApH+/rTobZo4GpZESONVO9D09YQBp9+Bwn
	jUPKByz3ClfjME8cbwUAYY2WwZKbAyZ0/ndQrfdAvli85Lo+JmLQ/SXCvVf1KdESu2ExFsJURz0
	Xxp6orpYp5fVE11F/7g=
X-Received: by 2002:a05:6102:c4a:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7cb37b3015cmr4260402137.37.1792078421907;
        Thu, 15 Oct 2026 08:33:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f66ad9sm12986347241.10.2026.10.15.08.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:33:41 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kees@kernel.org,
	rppt@kernel.org,
	juri.lelli@redhat.com,
	nik.borisov@suse.com,
	tglx@kernel.org,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	vincent.guittot@linaro.org,
	bp@alien8.de,
	thorsten.blum@linux.dev,
	cgroups@vger.kernel.org,
	tony.luck@intel.com,
	david@kernel.org,
	mingo@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	seanjc@google.com,
	ljs@kernel.org,
	zhangguopeng@kylinos.cn,
	dietmar.eggemann@arm.com,
	mhocko@suse.com,
	vinicius.gomes@intel.com,
	tj@kernel.org,
	vbabka@kernel.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	surenb@google.com,
	hpa@zytor.com,
	x86@kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	tim.c.chen@linux.intel.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rostedt@goodmis.org,
	gmonaco@redhat.com,
	jgross@suse.com,
	mgorman@suse.de,
	graf@amazon.com,
	linux-edac@vger.kernel.org,
	liam@infradead.org,
	ridong.chen@linux.dev,
	longman@redhat.com,
	bsegall@google.com
Subject: [PATCH v1 4/8] x86/cacheinfo, mtrr: Skip stop_machine rendezvous in cache_ap_online() when MTRRs match
Date: Thu, 15 Oct 2026 11:33:27 -0400
Message-ID: <20261015153331.1872641-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_083344_704428_E6578C8C 
X-CRM114-Status: GOOD (  16.49  )
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

When a single CPU is brought online at runtime
(cache_aps_delayed_init == false), cache_ap_online() unconditionally
calls stop_machine_from_inactive_cpu() to rendezvous all online CPUs
while the incoming AP runs cache_cpu_init() to disable caches
(CR0.CD = 1, plus wbinvd() when X86_FEATURE_SELFSNOOP is not set),
reprogram MTRRs via mtrr_generic_set_state(), and re-enable caches.

During initial boot (cache_aps_init()) and across warm CPU offline/online
cycles, the AP's hardware MTRR MSRs have already been programmed to match
the saved mtrr_state. Stopping all online CPUs in stop_machine (and
flushing caches on the AP) when the AP's MTRRs already match mtrr_state
is unnecessary.

Add mtrr_generic_state_matches() to compare the local CPU's
MSR_MTRRdefType, variable MTRR ranges, and fixed MTRR ranges against
mtrr_state (including k8_check_syscfg_dram_mod_en() on AMD), and check it
on the AP in cache_ap_online() before invoking
stop_machine_from_inactive_cpu(). If the hardware MTRRs already match
mtrr_state, initialize PAT locally on the AP and return.

2-socket, 480-CPU Intel Xeon 6985P-C (N=479, mean of 10 runs):
  Offline:   9.63 s ->  9.85 s
  Online:   11.11 s ->  8.69 s (-21.8%)
  Total:    20.74 s -> 18.54 s (-10.6%)
  cache_ap_online() (cpu479 online):
    7,704.0 us -> 4.7 us (-99.94%)

2-socket, 512-CPU AMD EPYC 9B45 (N=511, mean of 10 runs):
  Offline:   4.53 s ->  4.51 s (-0.4%)
  Online:    3.92 s ->  3.15 s (-19.6%)
  Total:     8.45 s ->  7.66 s (-9.3%)
  cache_ap_online() (cpu511 online):
    1,354.6 us -> 6.4 us (-99.53%)

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/include/asm/mtrr.h        |  2 ++
 arch/x86/kernel/cpu/cacheinfo.c    |  7 +++++
 arch/x86/kernel/cpu/mtrr/generic.c | 49 ++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 76b95bd1a4058..0527e216808c4 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -61,6 +61,7 @@ extern int amd_special_default_mtrr(void);
 void mtrr_disable(void);
 void mtrr_enable(void);
 void mtrr_generic_set_state(void);
+bool mtrr_generic_state_matches(void);
 #  else
 static inline void guest_force_mtrr_state(struct mtrr_var_range *var,
 					  unsigned int num_var,
@@ -106,6 +107,7 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 #define mtrr_disable() do {} while (0)
 #define mtrr_enable() do {} while (0)
 #define mtrr_generic_set_state() do {} while (0)
+static inline bool mtrr_generic_state_matches(void) { return true; }
 #  endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 13ed16527905f..64796d5b34fdc 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -770,6 +770,13 @@ static int cache_ap_online(unsigned int cpu)
 	if (!memory_caching_control || get_cache_aps_delayed_init())
 		return 0;
 
+	if (!(memory_caching_control & CACHE_MTRR) ||
+	    mtrr_generic_state_matches()) {
+		if (memory_caching_control & CACHE_PAT)
+			pat_cpu_init();
+		return 0;
+	}
+
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid MTRR entries
 	 * changed, but this routine will be called in CPU boot time,
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 67cf69f24b005..8760a7b4dc38b 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -981,6 +981,55 @@ void mtrr_generic_set_state(void)
 	}
 }
 
+bool mtrr_generic_state_matches(void)
+{
+	struct msr val;
+	unsigned int i;
+
+	if (!cpu_feature_enabled(X86_FEATURE_MTRR))
+		return true;
+
+	rdmsrq(MSR_MTRRdefType, val.q);
+	if ((val.l & MTRR_DEF_TYPE_TYPE) != mtrr_state.def_type ||
+	    ((val.l & MTRR_DEF_TYPE_ENABLE) >> MTRR_STATE_SHIFT) != mtrr_state.enabled)
+		return false;
+
+	for (i = 0; i < num_var_ranges; i++) {
+		struct mtrr_var_range *vr = &mtrr_state.var_ranges[i];
+
+		rdmsrq(MTRRphysBase_MSR(i), val.q);
+		if ((vr->base_lo & ~MTRR_PHYSBASE_RSVD) != (val.l & ~MTRR_PHYSBASE_RSVD) ||
+		    (vr->base_hi & ~phys_hi_rsvd) != (val.h & ~phys_hi_rsvd))
+			return false;
+
+		rdmsrq(MTRRphysMask_MSR(i), val.q);
+		if ((vr->mask_lo & ~MTRR_PHYSMASK_RSVD) != (val.l & ~MTRR_PHYSMASK_RSVD) ||
+		    (vr->mask_hi & ~phys_hi_rsvd) != (val.h & ~phys_hi_rsvd))
+			return false;
+	}
+
+	if (mtrr_state.have_fixed) {
+		u64 *saved = (u64 *)mtrr_state.fixed_ranges;
+		int block = -1, range;
+
+		/*
+		 * Ensure MtrrFixDramModEn is clear so fixed MTRR reads do not
+		 * expose K8 RdMem/WrMem bits and cause false mismatches.
+		 */
+		k8_check_syscfg_dram_mod_en();
+
+		while (fixed_range_blocks[++block].ranges) {
+			for (range = 0; range < fixed_range_blocks[block].ranges; range++) {
+				rdmsrq(fixed_range_blocks[block].base_msr + range, val.q);
+				if (val.q != *saved++)
+					return false;
+			}
+		}
+	}
+
+	return true;
+}
+
 /**
  * generic_set_mtrr - set variable MTRR register on the local CPU.
  *
-- 
2.56.0.385.gd3acb90ef8-goog


