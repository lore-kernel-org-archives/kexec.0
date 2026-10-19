Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7285BCCA490
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 01:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AG4iCQmCtWMmOqYT8IYP5jpAChTLSZorOObJHVgwpSM=; b=cOq/i4lGkByZBnV6NXgQY/6WYS
	aU7/XR7aT9dFCQV5C1GR+eacVpdTt9qt4549jIdPl8OHsz0+fwti0M70mTWAlMtLZdD+TvK+dK/eN
	aVfTjHbeQt5XKoIsDVYeDjvQCBZyCB7txS8/+WxkIdEFFVOHbrcQU/k+zGzVG2JGRR0EKGxrdaNVP
	pdgekc1Qq9g883ic7GuTeSIVYQMaBVHTMogaow/6+uBATxv8Y08+fEOVybRaACIX7HdDKNLrAg+m0
	dvyawOIiGxQXwkRVIEKmXzTJTaqxiW5Xqfl+uZ5HHcGVPwI+60GjURjnKuuthGc3WYvbszamQMBSg
	pgwSZ7MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxt-00000006N6W-2wTJ;
	Mon, 19 Oct 2026 01:15:01 +0000
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxq-00000006N4e-46uz
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 01:15:00 +0000
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso1054292e0c.1
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 18:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792372498; x=1792977298; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AG4iCQmCtWMmOqYT8IYP5jpAChTLSZorOObJHVgwpSM=;
        b=UxjhHwa75MkqZDjcHRKDULmtg9mh6b+WApjSNDnN95RoZAFMALEJ8du5SrLeMFDwK3
         9Gx6FsCyOUNOg22YA3o67djVHJ++OL2nH1+qtAMlfZAdMJSvD1MNMHx0S2xggIdard5u
         A7be24w1nS8GYag6JwFBdj4KUtQTjsLEfmJiloB30rXEqKZ/kepQAFQNmPxTmhpA4j+r
         j8UjyJoioxEYaV06uY1XbJkRKmgmCZZWu5BwisEWE1w4flz/RX21XXFNsqh574u7ScqX
         dzOmUMKBE/EYRJcobCJSAgSEonIZWlvy86eyZodVKDmZtStDmgNju4qu2BSJeF3L6pM6
         cVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372498; x=1792977298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AG4iCQmCtWMmOqYT8IYP5jpAChTLSZorOObJHVgwpSM=;
        b=YWJQXqY2NZU2/+JnqViPUdkMl50Dvgc2I/agt9Oxo5l0GtFOV12SFnENNFI9L4uQQK
         CJlPWQO+UCU10A+UQTFJfPgpcjMhURXdmpnCgdVUR6WlcY3SUfk3vUnv2iN0kfiCHxNR
         rNNfp7kaRppdMw41p3UDuZUDUFaXlL9vBbo6dGDo+lBVnGCLL3voELgj0mIl/JsJXZzG
         Zt/vPwS4w38rtMvDP90AIgGkwyr46eySTgXxkWxlLMIS33VEiPuQaVn5103l6MYamz3q
         EGoCtfsxaddg1x8hOk5BH8iGuMbN7J67Xx5KB38tc8wxvBH8oYathR12jiRr/eZsR8Ne
         ebdw==
X-Forwarded-Encrypted: i=1; AKwUvBy8ylMIClMZWeBqqRNs4X81J7xvOEVhlfe+khkFugVMao0T4NkPtooYQC1pFqNhZPhsO4P/aA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJE2eL3VVSgV7RwdJAEy9qgycJTMKEnF5rHI1Ry/a2KVqrOSJJs
	zKBM3xoJfpaWx/9GT9QOHQMJZL9UrUf82rGKQY4R0wOcQFB4RKu6sHcr8w79PWg9FaI=
X-Gm-Gg: AYBFou0hO60Y0ovi9FBR9dO46VoMC+jnOKHzyMj5bjDh297oLMARQWpyMioNIk7HgWA
	lt+vB7TXRizaQ1JD7hZKOdQ0L66eta66wwV2awwZyqiRLhabbOtH7ioelm2nLrO0wMzPJc8MrSm
	iOlvilM9Be0l9Ur2x7vvKJC+vK9GZcIY3LWggMgi8jOe9miFhiwJhBMLY8jATmybznEAVEgiJQN
	uHGg2F9KTOSa+lHdE+YACYfo9NGgWpRCWXVoW4C4J18NrLN2Os6OjODE3pMmmnk6U+tPpinaWJ9
	xtsFH1BAw01xbDEdzlP3i4necJ2lbyOz/gTkHg0PUoMUa//rH3QvP82gG6Ks5b75mS7Q8qsaL+v
	bVtsZX2nXLIE7BHbr/bBEvIcm3zTic4xx0n9JIIO9HRpbg5wVU5Y2t/u4AMEDka1ZwuF+sZDVHF
	OGzGiugcN9t8RZ+cHBInop9KS68WXxVntvyOTLIUeNRdRtvrAcY+xxTTpYKcELLLa0th/6bu4Ow
	p+bxAKJEVG2fSfr0HDNuaTka6r7jRdekGVuOmklu9O5IOjLBmtGkN3Gnd1WqGxJGl+G9sA5faG5
	Gq9rAgwcXy7RgLCTUbg=
X-Received: by 2002:a05:6122:d19:b0:5ea:c90d:d1b2 with SMTP id 71dfb90a1353d-5eac90dd9bfmr454444e0c.13.1792372497778;
        Sun, 18 Oct 2026 18:14:57 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b474b2asm8039142e0c.4.2026.10.18.18.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:14:56 -0700 (PDT)
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
Subject: [PATCH v2 3/8] x86/mce/intel: Bound cmci_rediscover() to a single topology peer
Date: Sun, 18 Oct 2026 21:14:41 -0400
Message-ID: <20261019011446.834487-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019011446.834487-1-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_181459_342195_4C08C856 
X-CRM114-Status: GOOD (  19.52  )
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

When a CPU goes offline, cmci_clear() disables CMCI on any MCA banks
owned by that CPU, and mce_cpu_dead() calls cmci_rediscover(). Currently
cmci_rediscover() invokes on_each_cpu(cmci_rediscover_work_func, NULL, 1),
sending a synchronous broadcast IPI to every online CPU in the system,
all of which contend on the global cmci_discover_lock while reading up
to 32 MSR_IA32_MCx_CTL2 MSRs.

Any bank disabled by cmci_clear() is either thread-private, core-scoped
(shared between SMT threads of the same physical core), L2-cluster-scoped,
die-scoped, or package-scoped:
1. Any bank index that is already owned by the target peer in its own
   mce_banks_owned bitmap is private to a narrower scope than the shared
   level and will be skipped by cmci_skip_bank() on the target anyway.
2. Core- or cluster-shared MCA banks can only be claimed by an online
   SMT sibling or L2 cluster peer.
3. Shared die-scoped or package-scoped uncore banks can be claimed in a
   single pass by one online peer on the same die or package.

Record the bitmap of banks disabled by __cmci_disable_bank() in
cmci_orphaned_banks, select a single online topology peer
cmci_orphaned_target (SMT sibling, L2 cluster peer, die peer, or package
peer) in cmci_clear(), and mask out any bank indices already owned by
that target peer. In cmci_rediscover(), return immediately when
cmci_orphaned_banks is empty; otherwise probe only cmci_orphaned_target
via a single smp_call_function_single() call.

2-socket, 480-CPU Intel Xeon 6985P-C (N=479, mean of 10 runs):
  Offline:  11.42 s ->  9.63 s (-15.7%)
  Online:   11.08 s -> 11.11 s
  Total:    22.50 s -> 20.74 s (-7.8%)
  cmci_rediscover() (cpu479 offline):
    7,720.6 us -> 0.6 us (-99.99%)

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kernel/cpu/mce/intel.c | 57 +++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 4655223ba560..f57718b097d9 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -11,6 +11,7 @@
 #include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/cpumask.h>
+#include <linux/topology.h>
 #include <asm/apic.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
@@ -40,6 +41,8 @@
  * owned by the offlined cpu.
  */
 static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
+static mce_banks_t cmci_orphaned_banks;
+static unsigned int cmci_orphaned_target;
 
 /*
  * cmci_discover_lock protects against parallel discovery attempts
@@ -244,6 +247,7 @@ static void cmci_claim_bank(int bank, u64 val, int bios_zero_thresh, int *bios_w
 
 	/* This CPU successfully set the enable bit. */
 	set_bit(bank, (void *)this_cpu_ptr(&mce_banks_owned));
+	__clear_bit(bank, cmci_orphaned_banks);
 
 	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD) {
 		pr_notice("CPU%d BANK%d CMCI inherited storm\n", smp_processor_id(), bank);
@@ -328,6 +332,7 @@ static void __cmci_disable_bank(int bank)
 	val &= ~MCI_CTL2_CMCI_EN;
 	wrmsrq(MSR_IA32_MCx_CTL2(bank), val);
 	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));
+	__set_bit(bank, cmci_orphaned_banks);
 
 	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
 		cmci_storm_end(bank);
@@ -339,6 +344,8 @@ static void __cmci_disable_bank(int bank)
  */
 void cmci_clear(void)
 {
+	unsigned int cpu = smp_processor_id();
+	unsigned int target;
 	unsigned long flags;
 	int i;
 	int banks;
@@ -346,8 +353,31 @@ void cmci_clear(void)
 	if (!cmci_supported(&banks))
 		return;
 	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
+	bitmap_zero(cmci_orphaned_banks, MAX_NR_BANKS);
+	/*
+	 * A bank is shared by the CPUs of one SMT core, L2 cluster, die or
+	 * package, and these scopes nest. The first online peer found from
+	 * the innermost scope outwards is therefore part of every sharing
+	 * scope that still has an online CPU, so it alone can claim every
+	 * orphaned bank that is still claimable. If it already owns an index,
+	 * the instance released here is not shared with it, hence not with
+	 * any online CPU, and that index can be dropped from the rediscovery.
+	 */
+	target = cpumask_any_but(topology_sibling_cpumask(cpu), cpu);
+	if (target >= nr_cpu_ids)
+		target = cpumask_any_but(topology_cluster_cpumask(cpu), cpu);
+	if (target >= nr_cpu_ids)
+		target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
+	if (target >= nr_cpu_ids)
+		target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	cmci_orphaned_target = target;
 	for (i = 0; i < banks; i++)
 		__cmci_disable_bank(i);
+	if (target < nr_cpu_ids)
+		bitmap_andnot(cmci_orphaned_banks, cmci_orphaned_banks,
+			      per_cpu(mce_banks_owned, target), MAX_NR_BANKS);
+	else
+		bitmap_zero(cmci_orphaned_banks, MAX_NR_BANKS);
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
@@ -360,15 +390,38 @@ static void cmci_rediscover_work_func(void *arg)
 		cmci_discover(banks);
 }
 
-/* After a CPU went down cycle through all the others and rediscover */
+/*
+ * After a CPU went down, rediscover orphaned shared banks on a single
+ * topology peer (SMT sibling, L2 cluster peer, die peer, or package peer)
+ * selected in cmci_clear(). Core-private banks whose core is now completely
+ * offline cannot be claimed by any other core, so probing more than one
+ * peer is redundant.
+ */
 void cmci_rediscover(void)
 {
+	unsigned int target;
+	unsigned long flags;
+	bool orphaned;
 	int banks;
 
 	if (!cmci_supported(&banks))
 		return;
 
-	on_each_cpu(cmci_rediscover_work_func, NULL, 1);
+	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
+	orphaned = !bitmap_empty(cmci_orphaned_banks, MAX_NR_BANKS);
+	target = cmci_orphaned_target;
+	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
+
+	if (!orphaned)
+		return;
+
+	if (target < nr_cpu_ids && cpu_online(target))
+		smp_call_function_single(target, cmci_rediscover_work_func,
+					 NULL, 1);
+
+	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
+	bitmap_zero(cmci_orphaned_banks, MAX_NR_BANKS);
+	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
 /*
-- 
2.56.0.176.g3575e65682-goog


