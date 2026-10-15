Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDC4CC6B39
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IofewvjhR0Ae8pfrPVVge9u/2aO2fEHS91BGZ9RvoVo=; b=vxtdOn4hiMabhotG6jXTPepAg4
	jHLVZy8/AfBRQGCT6IfbbnynJYXc7aYBZwfViw3fB1I2sT3dSevsRYR9kuH6n5SqkeSZyBAnjfHTU
	6IusD3ToMn/EluqxKhqgEm0jZz8q0LRTNP65yPFqx/AlARSXVnbxs8wfH0iAPk+i6iExsSa2Cj6OK
	5m4+pWwXz9N0oJlK7iFYI1o0y1pVpC4GoQ3yVbTAXDZuyRi4kt8zikpU2pciGVqadBvzaL3uORdAi
	N/qEQogEHVcb9foSOkxdFPLtQkq727RBEwfvTjIBllwItr0B9qGwEMtR6+HvpVk5etPbiq5n0/wId
	cZDtjnNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSo-00000000ZWR-0FPm;
	Thu, 15 Oct 2026 15:33:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSi-00000000ZTl-44MK
	for kexec@bombadil.infradead.org;
	Thu, 15 Oct 2026 15:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=IofewvjhR0Ae8pfrPVVge9u/2aO2fEHS91BGZ9RvoVo=; b=SYfzDFwPc/amWRE/D7ca+ooKgw
	JTUH2ZXuG8J0H0MVMY0rIC5ypkPRw3OOxKuH6qYGGdkwpbXaJpT0Cta6bNgtFpUZ1cC36d/BRQf5u
	Grt6wuyj5WncUTH14ehjaImzup2JMcIBObOmZ1Tdmsbn6NqVU6yo4uiZjH2LigK9G62hQwMMqCHpf
	rG8ylJK8H2d1Pk/FslKISiADwiK8R7/FSoYT1x/h0HhomLWQXKQVqd+D2HGVHebUs/zobvZ44/NGH
	4Xp69jh7lX+d/hMkVZQMleFHGedEsnsgqpiO8X+fsFokEjVATFfj7RDQgs9ZiwAqDAw/bgzCtPEue
	F8kbq0Iw==;
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHNSg-00000000YRP-0c3M
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:33:43 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-7c03a445cb8so1133898137.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792078420; x=1792683220; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IofewvjhR0Ae8pfrPVVge9u/2aO2fEHS91BGZ9RvoVo=;
        b=Egu2fPE0rfFupv/cti3pV8c1u7zwDg1jDRigXzajdr3JwuArlSRwOJPWnIiqy8NA50
         GkSGEMs3JaIEw67T/i6IoL2ZhVk/RHV884iHpCwkoEx1c6Lc2EAke0ZoLfFC74Q0XXU7
         8Z73hWIL8WsU9tUZZQjKGbW/kJ82Pg6m5bpgKt74YxDU0MRQ3vlOT0c6J4CjbNrT6CPR
         3kbZIW5N/D4iZ0/BUbhszA/quejmxzYUxafTO4XyT94R376gQVOa1HaMR9rhbnQozS3t
         5DV/Wu821/E9uD+1aLI/mM71pkF2+Q4pApFSR9JNVufa4GiNnTp9KrGr16o5isGORKon
         bo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078420; x=1792683220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IofewvjhR0Ae8pfrPVVge9u/2aO2fEHS91BGZ9RvoVo=;
        b=Jce1evrOxXpmRINUac1pHweuG+G23X4VhnUlIckaCD8Ch5cyAKcE4Xlnll2xpnc+SA
         wSnTWbTGvjU8we8ledIZ+uMhACViAzeDNMB5KZKpS+F5jOzNpj001E70DpTBpO1/s0PD
         uaMyxfeJbn+dlclaEySHuV5NP6GClEeE+Rjr2U79zE3ZoVzCOw1vJKPrlsqWn5WfD2Ad
         X8hwmFEhNkRx4NzJvDstMa/8vSNogTiM0iO+BoJQDi8A8irlL0kkOen+SfdKpZ8WwmqZ
         XwtjvmOmYsHnzzilD+uSGWcFk3aJkAEAd6LDNST//clfgwVI+BvTfpDgDXdgWhwsMqov
         Dxlw==
X-Forwarded-Encrypted: i=1; AKwUvBykU2EKih+ye1LhPbh6p9pItcyxrF54r5V8vTYaCR4DZG5Ze1HG4i4oRIqKPYxnCpGq8JINIg==@lists.infradead.org
X-Gm-Message-State: AFq9FYIlZhpuQKYjXyqk68qo+0bQAU/e7rIgpR+KaF7C3utIm3stVDV6
	Q2k5D2oQ5/FWu3m9HK+qZOOyJu+lhhfLB3eBRGZ1TgLTzBqNZGeYGbOecL+m8q8+qRk=
X-Gm-Gg: AYBFou1r/Nni+iwI2sLXEyxB0SKu2BNgJpMDWiKV2fFXzJ8LB0ss87giqsTtNh7D4CG
	ik10QVQsbPb978UdPtMey0kjjCwjYx5BVWK6BLAbpsK0jtaX2mapW1m0bhb1AiDHkNAiLt5plUM
	kDNQkxurUi7yML2o0wnNn/U1vnwlCRlYo3x8+eixN33nZZcxGYs+N/oi0wDoAWEgItXQVa5AXIF
	1BuzBfHnCCKXxApqbm6EOM673rwGqg6S3lF3vIxwbpQtQErNUYnbGaAkOZI3pEV4RUz5+GeG5ZC
	6ooyGZrzxS3/nsUUEHPgoji7WPzfuIr+z54TmW1gbE6xfcVJNu11Jy1BF8VGPIE2UWZgNMpTvOn
	NTSSE8o4ooomi8GOAsGLhcsP4akZfhtQTNE6fkGvuRv54Sl2VPG+was2h9lfnnk9OCKtaoWcdTZ
	funP46gLHhcVfBHHtlALvedweVj+CaobKAxVWIzWO4zukHan1H7eiSS5w5PDeJ6DYqRlpJTCxbT
	ntX8GVf1fJSr7Ts+TxTxBRZA+QCYNTnwCShrhkDFy1+S6xCq4MHzRPBtgQErVI9g2MRlHzl9rsc
	PUjv93lCBcJ9pBM/VJo=
X-Received: by 2002:a05:6102:8088:b0:7c1:62d2:e18a with SMTP id ada2fe7eead31-7cb372f3a68mr6949040137.16.1792078420419;
        Thu, 15 Oct 2026 08:33:40 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f66ad9sm12986347241.10.2026.10.15.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:33:39 -0700 (PDT)
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
Subject: [PATCH v1 3/8] x86/mce/intel: Bound cmci_rediscover() to a single topology peer
Date: Thu, 15 Oct 2026 11:33:26 -0400
Message-ID: <20261015153331.1872641-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_163342_413751_DD360041 
X-CRM114-Status: GOOD (  20.43  )
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
index 4655223ba5606..f57718b097d9b 100644
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
2.56.0.385.gd3acb90ef8-goog


