Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89080CCF2DB
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 01:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5LyhpH+32vicnnX5+Nfrq1TH+85hwwraSFoho5291M=; b=njIO0U+bnoww7VPWBrrCmpTl0H
	vBh64b/1H3Mc5MTJ4l3alcpEP5HsYEkWoBTvo4kR7GY09DZ8Su1lVkdgfF79ZD/bhLSmrlEiOMHiO
	ruUvvtNA0Y2V//ns3NM/U30SbkFeBRnAjV1ZqyzGCIpeJx8jDOB4kEBZfLtLwCkSFT6SMT9i3AgWh
	B69hq9UOSneEMEOOGjKta+0buWJMLGrAEtnOpLJ9/O95qfgcpFiFySE4NJdi0FgP/RXAFy5itCK2X
	sk7QorCGENH7V8hswraVhEIPG/StDmbc1ctJXq8K2ZzJJPV3Go6MCjUxWn1zGLlaLTCqHXDjD4FKM
	vPTeH3yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxx-00000006NAC-3eAT;
	Mon, 19 Oct 2026 01:15:05 +0000
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxt-00000006N5e-1Sqq
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 01:15:04 +0000
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so477516137.1
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 18:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792372500; x=1792977300; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z5LyhpH+32vicnnX5+Nfrq1TH+85hwwraSFoho5291M=;
        b=anPwUH/qwRwQ1s+EUjFJpCak9zs7gHdWctk4BssyQkim+D4/OKsWgWeCZbhzDx6q1X
         qJ873/DgkAuCu0TDQhIC7D+V7mq1ybTxZy5Fm3dpbnW41nOY5vNg0QiF6Rcvc59kckTh
         bd506NCKo8ndDNDhokXsARcKR/iM9ztuR3tVdRMOWeM7mbdrjM9QiaUcI6DVjfb7DkUC
         56nvq5Idf+oZ3b9tJ3hmc1lw8g7i4QPX4T7ptBjYUUVxBj7aFf4pIrIKh46Jf0y27rlM
         F0EM0+7GyggKImI6iuGFbWOLvTjjQ+E09U7wOwxTEcXqI6Y0WZzLvlGtsNiL9oSQcSLB
         OpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372500; x=1792977300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z5LyhpH+32vicnnX5+Nfrq1TH+85hwwraSFoho5291M=;
        b=VU/PXTrZtyB5rh37ieuDdyGUqXu7HNbsrRxSgGtYXhbd68V03kSj1QXUWX1RgiZP4z
         U56/PYYEUCUNU1JkhEMsXXn/2z6fGHwLSA4n/gTibZm3phGgf+vuKMpfRWVLU1vGerOr
         u3o/z7qZjemsyy9U1EIvwzdW46LOLR2NSSeCTNl2KC2AHgitZOS+PoHKHs4Zy0/aGRMB
         BgIQIpyhTOcak5ziCzNY+KuOkv/LctjxmJnefDSe58aHA55I9Ybjtk/KMLVkqFwisbAN
         q2GtjatoT4veYm3UX1CSYEvKdxzrIji6m3JEz1uIgaSHrZLDUfNX9T38ZK0h4AHX0Vxv
         qB/A==
X-Forwarded-Encrypted: i=1; AKwUvBw7mKWdebJRRV8KdLELC9wecUH1mzJ4jLU+R+4LvFglSl5DUwgw40fkxHqZsj9mCGQjkWJhJw==@lists.infradead.org
X-Gm-Message-State: AFq9FYLechO5W+wed76h4E0JY9FgEtPe/v8nUNMovMatIKlwhBwOpKKW
	L3XfevV/iUVAMvQoehjkFPndCCSltwS78RqH/jxaan91Z/pLYnLq8LKHuG91ZjlQB3k=
X-Gm-Gg: AYBFou3Mxate1KzY8Y+2UBOA5qpKu452bQ4YHNjs+FjQQxMnR1t1d6596RMgXp4ZDIi
	ueqddMzadbMZyXre7SVbWTMCgGNqB+jAvzJ78FAueyk3vGQ0AuH64M8W+ck10xENdBm33CbcznQ
	+4IKjijFZaEh96zn2qZl2xnAan7wCz7SVKwREnJt2/8ou7dgTQGhY05b1QK5LLiARcV36Rt/spc
	gUqSB4pdMAOlviFcBiGSiWudrI8IsfIzI9DgKCMQn8/5M6uzT7LsxHDnu61JwixLJXTdKuBH3qF
	kjoTH8gVKAWGKi2HHROUAPd5cglK35bWRXk9t8CMx54Keuw+yQoD1r/bE0TCIV8+ufuAFNLfHzf
	9bjQZc8SwE8COmN9jHGF2rxXeCwbUeF7EI0Lme91DWAIU91YGCUmx4vaQut7V+blmhyJpfKJdjy
	WPv75UijcP8sGMmoex/KNcB1jlk2zKj/9oTR2tQIf4qLUifgri3rgG0tryZwBk12PSRmosrWjX+
	klwOYb8nWMyPEndG4j69zgKuNiNdMicyn/j+Yqus5fJUO0HlNyfuh55M2cMjhYPareNnprP2hS5
	cpjuDlEDm5yGF1UzJClIKIbIOVX46g==
X-Received: by 2002:a05:6102:419e:b0:7c3:6466:3155 with SMTP id ada2fe7eead31-7cc36aa4af1mr1518608137.33.1792372499968;
        Sun, 18 Oct 2026 18:14:59 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b474b2asm8039142e0c.4.2026.10.18.18.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:14:58 -0700 (PDT)
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
	jpoimboe@kernel.org,
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
	blum@kernel.org,
	longman@redhat.com,
	bsegall@google.com
Subject: [PATCH v2 4/8] x86/cacheinfo, mtrr: Skip stop_machine rendezvous in cache_ap_online() when MTRRs match
Date: Sun, 18 Oct 2026 21:14:42 -0400
Message-ID: <20261019011446.834487-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019011446.834487-1-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_181501_409267_D60EC24C 
X-CRM114-Status: GOOD (  16.48  )
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
index 76b95bd1a405..0527e216808c 100644
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
index 13ed16527905..64796d5b34fd 100644
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
index 67cf69f24b00..8760a7b4dc38 100644
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
2.56.0.176.g3575e65682-goog


