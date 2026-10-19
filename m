Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626C4CCF2D4
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 01:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oOMQVB/jXsWsIeoiodYZ/B+RDWxFCBllXDVeS82fgVc=; b=OhQ26+N3nwN4e4CqHYRNqgkshN
	4RVWr1TGTRHCI7X1FVgK50gJr58CO2CJsb8/vFILtYxl0Lt85LFiHL/bpdC/+pmVQVNGTIUuKya1W
	QEeTWsH+LjRewR1kAEfglSwKeiemgmcgDXhMEoFdTbjryUH74/9hEcxnCY1Mz6RzodWE3VH8svjKP
	ji15S+vae7ZxMJVfdcxoHXLOlgQUkWT8nNAES4yH8S7CEu8UrTVKfGcB5hgP+F/+JfssZo+HT0jfJ
	2vHunNQvFdgybKMi6PG9LdV9MAk9waTwKk8tV53pIuDamVazjShJe5nF9/Jqj/movoQH+dhYvXr/V
	yEOJdSwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxy-00000006NB0-4AeJ;
	Mon, 19 Oct 2026 01:15:06 +0000
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxv-00000006N6t-2V3W
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 01:15:05 +0000
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so520063e0c.0
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 18:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792372502; x=1792977302; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oOMQVB/jXsWsIeoiodYZ/B+RDWxFCBllXDVeS82fgVc=;
        b=MTGrXQqu+f4U1Kioda6jrb6IZk3uFjwh5Ns1BqQWjCtqOpsyRCvsBfLkEWRlyUSKkm
         yFm6VGn8MXVeZof57QR2GtAACVmerakPLiHcudYqLEPnQS9Tq0XCj77ohWSI6k0Bsjt/
         +Upkhysk482dzdu2q2s7MukF8PQ2r6Ak7KusZWPDO61OHyy25jBc6QESdP1mjtVcg54C
         fQLkw1z6dO24OzaBNxG4t5xOPYxt03vLMn/CkTZ+KhqIbYSnl4d93xYq35B2T4dvleBf
         JJJ8GwzmusRx9LsuTHUlCfvxXu2atF5jNFmZFKdmzvmQ7OGTDBYDGw2ngBZRZbb4sL9f
         Lm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372502; x=1792977302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oOMQVB/jXsWsIeoiodYZ/B+RDWxFCBllXDVeS82fgVc=;
        b=hXa028SxRX4YKKxlcS7i80k7dV26kvPAdDn3EWi51iUKtQBtTMDVD4q+71J67Idguj
         tYFl6J5+mqhHIjNzuzXDgzDTTNUBxGaJTp04ERDUSAfmyZ9l5sjF6O5cQtYucoFp9iGc
         F+UKYv+86TnL9MwaD7D1KPPsCts8763guSiyu+sPFVBNYUolDIKwsA7XCOJ7abVL6h1v
         kkl8HkJLvAX8pK9oo3ro/eDdDfAil+NEOhyyEA4BuKT862exGYIGWf7Ec57V5URSWxEA
         Ufz/YbgaphrjW2BX2RrnhyhkiKJCrO94GnArXg+x2E7CdbbE+nkxN/YdDkFqJvtRxpYI
         OSRA==
X-Forwarded-Encrypted: i=1; AKwUvBy7CFZaHZGEmnJzo3E8omRZDFNcYxP272fvwcXWCw6+ji2NBYZT57/PYGeFvJJ68gmUWyJxmw==@lists.infradead.org
X-Gm-Message-State: AFq9FYL928VOrj8JCB3wDLyA8RbFrL6Ni9ie+q648HdsNe4Z0Hkb/o3P
	SxnjDOT2ys/iHVkPrlSfa4mMQmSIwxQtFoTF9XAr6AoSyBf4fHzvVMM1Ycsr59py+iY=
X-Gm-Gg: AYBFou3drnhT0cCWS0Iqe+/U0mOmxTV0kB4ZrYMDfw9VEInqrfyogUkXUVWARQmGIt5
	vwELC5v2HOJCBzP2a3k9hkZdQOBh4z1rEseemY/Aq5Bk9WPrgN3V2G6ll8eXvAJF+LhyAmAirXm
	4GFBKapyHEUuIX3JXFzN9+80u+/slSAznL+/hZs2mSFBnC5kUYmEjmn0PimLFOzhqC94V7AovQN
	R4UL+RhATsqYcm3MgOAdsICTKREuUnTtaC5udKm6lwQsaTx5ruFlkyVfLme0fPhg/Gt8KQGpQvY
	sv80cSqfBrzpcEU+amYMeKiK8LwBA2GNaWCOQ6cdDJ6i6hTjVbo2JnweqUMmqmGTBlAxAtUb2Yq
	BBMGMsDKogz13tbCXLhAmQr27ds9ejVLRjJwihSVOU2fUmghfScCC+VdFz5aACFEV4cjSfurzxW
	qYpjN0bbDilxCuXlemaDJoZcfIOnYuLbQovp8/72bUkP9lPPm2ELc5h5SVDzcJJ7xr4kJT91yUc
	wWePvH7DEFXux7J+/2uZLvjnstKKEQG54pBF2xntZVFqdP/PFoKlipYE2wE9GsIsnyNj3aWeVoq
	YArRUa2TZD5PgzEu/F0=
X-Received: by 2002:a05:6122:78e:b0:5ea:389c:51e4 with SMTP id 71dfb90a1353d-5eaaa0c78fcmr2260825e0c.2.1792372502039;
        Sun, 18 Oct 2026 18:15:02 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b474b2asm8039142e0c.4.2026.10.18.18.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:15:01 -0700 (PDT)
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
Subject: [PATCH v2 5/8] sched/topology: Avoid redundant O(N^3) group capacity walks and unused allocations in build_sched_domains()
Date: Sun, 18 Oct 2026 21:14:43 -0400
Message-ID: <20261019011446.834487-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019011446.834487-1-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_181504_237536_F9CBE532 
X-CRM114-Status: GOOD (  23.14  )
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

During sequential CPU hotplug on large systems, build_sched_domains() is
invoked for every CPU offline and online step. Two bottlenecks in the
domain construction path scale poorly with CPU count:

1. On non-overlapping topology levels, all CPUs sharing a domain span
   share the same circular ring of sched_group instances, and on
   overlapping NUMA levels, groups with identical spans share
   sched_group_capacity (sgc). However, init_sched_groups_capacity()
   walks the entire group ring for every CPU in the domain and repeatedly
   recomputes group_weight, cores (walking the group cpumask and clearing
   cpu_smt_mask), and asym_prefer_cpu (O(N^3) bitmap operations per
   hotplug step). Similarly, init_overlap_sched_group() recomputes
   build_balance_mask() and cpumask_weight(sg_span) even when the shared
   sgc was already initialized.

2. __sdt_alloc() and __sds_alloc() upfront-allocate a sched_group,
   sched_group_capacity, and sched_domain_shared for every CPU in cpu_map
   at every topology level, even though get_group() only uses the entry
   for the first CPU of each child domain and d.sds is only used once per
   LLC (plus at most once per SD_ASYM_CPUCAPACITY_FULL domain). All other
   per-CPU allocations are immediately freed unused by
   __free_domain_allocs().

Cache group_weight, cores, and asym_prefer_cpu on struct
sched_group_capacity so init_sched_groups_capacity() computes them once
per shared group capacity, reuse already-initialized sgc instances in
init_overlap_sched_group(), and allocate sdd->sg, sdd->sgc, and d->sds
lazily on demand.

2-socket, 480-CPU Intel Xeon 6985P-C (N=479, mean of 10 runs):
  Offline:   9.85 s ->  5.15 s (-47.7%)
  Online:    8.69 s ->  4.05 s (-53.4%)
  Total:    18.54 s ->  9.20 s (-50.4%)
  build_sched_domains() (cpu479 offline / online):
    35.65 ms -> 10.39 ms (-70.9%) / 35.68 ms -> 9.58 ms (-73.2%)

2-socket, 512-CPU AMD EPYC 9B45 (N=511, mean of 10 runs):
  Offline:   4.51 s ->  3.26 s (-27.7%)
  Online:    3.15 s ->  2.03 s (-35.6%)
  Total:     7.66 s ->  5.29 s (-30.9%)
  build_sched_domains() (cpu511 offline / online):
    11.69 ms -> 5.61 ms (-52.0%) / 12.24 ms -> 5.84 ms (-52.3%)

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/sched/sched.h    |   9 ++
 kernel/sched/topology.c | 218 ++++++++++++++++++++++++++--------------
 2 files changed, 150 insertions(+), 77 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 499a5649582e..314fcad94668 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2262,6 +2262,15 @@ struct sched_group_capacity {
 
 	int			id;
 
+	/*
+	 * Build-time cache shared by all groups using this sgc while
+	 * build_sched_domains() runs; not maintained afterwards (e.g. by
+	 * sched_update_asym_prefer_cpu()). Use the sched_group copies.
+	 */
+	unsigned int		group_weight;
+	unsigned int		cores;
+	int			asym_prefer_cpu;
+
 	unsigned long		cpumask[];		/* Balance mask */
 };
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 919d0fb00bd9..a5a5d1378ce2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1207,6 +1207,33 @@ int group_balance_cpu(struct sched_group *sg)
  */
 
 
+/* Find the group_balance_cpu() */
+static int find_group_balance_cpu(struct sched_domain *sd, struct sched_group *sg)
+{
+	const struct cpumask *sg_span = sched_group_span(sg);
+	struct sd_data *sdd = sd->private;
+	struct sched_domain *sibling;
+	int i;
+
+	for_each_cpu(i, sg_span) {
+		sibling = *per_cpu_ptr(sdd->sd, i);
+
+		/*
+		 * Can happen in the asymmetric case, where these siblings are
+		 * unused. The mask will not be empty because those CPUs that
+		 * do have the top domain _should_ span the domain.
+		 */
+		if (!sibling->child)
+			continue;
+
+		/* If we would not end up here, we can't continue from here */
+		if (cpumask_equal(sg_span, sched_domain_span(sibling->child)))
+			return i;
+	}
+
+	return nr_cpu_ids;
+}
+
 /*
  * Build the balance mask; it contains only those CPUs that can arrive at this
  * group and should be considered to continue balancing.
@@ -1216,17 +1243,19 @@ int group_balance_cpu(struct sched_group *sg)
  * can fully construct this using the sched_domain bits (which are already
  * complete).
  */
-static void
-build_balance_mask(struct sched_domain *sd, struct sched_group *sg, struct cpumask *mask)
+static void build_balance_mask(int group_balance_cpu,
+			       struct sched_domain *sd,
+			       struct sched_group *sg,
+			       struct cpumask *mask)
 {
 	const struct cpumask *sg_span = sched_group_span(sg);
 	struct sd_data *sdd = sd->private;
 	struct sched_domain *sibling;
-	int i;
+	int i = group_balance_cpu;
 
 	cpumask_clear(mask);
 
-	for_each_cpu(i, sg_span) {
+	for_each_cpu_from(i, sg_span) {
 		sibling = *per_cpu_ptr(sdd->sd, i);
 
 		/*
@@ -1277,32 +1306,51 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
 	return sg;
 }
 
-static void init_overlap_sched_group(struct sched_domain *sd,
-				     struct sched_group *sg)
+static int init_overlap_sched_group(struct sched_domain *sd,
+				    struct sched_group *sg)
 {
 	struct cpumask *mask = sched_domains_tmpmask2;
 	struct sd_data *sdd = sd->private;
-	struct cpumask *sg_span;
+	struct cpumask *sg_span = sched_group_span(sg);
+	struct sched_group_capacity *sgc;
 	int cpu;
 
-	build_balance_mask(sd, sg, mask);
-	cpu = cpumask_first(mask);
+	cpu = find_group_balance_cpu(sd, sg);
+	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
+		return -ENOENT;
 
-	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
-	if (atomic_inc_return(&sg->sgc->ref) == 1)
-		cpumask_copy(group_balance_mask(sg), mask);
-	else
-		WARN_ON_ONCE(!cpumask_equal(group_balance_mask(sg), mask));
+	sgc = *per_cpu_ptr(sdd->sgc, cpu);
+	if (sgc && atomic_read(&sgc->ref)) {
+		atomic_inc(&sgc->ref);
+		sg->sgc = sgc;
+		return 0;
+	}
+
+	if (!sgc) {
+		sgc = kzalloc_node(sizeof(*sgc) + cpumask_size(),
+				   GFP_KERNEL, cpu_to_node(cpu));
+		if (!sgc)
+			return -ENOMEM;
+		sgc->id = cpu;
+		*per_cpu_ptr(sdd->sgc, cpu) = sgc;
+	}
+
+	build_balance_mask(cpu, sd, sg, mask);
+
+	sg->sgc = sgc;
+	atomic_set(&sgc->ref, 1);
+	cpumask_copy(group_balance_mask(sg), mask);
 
 	/*
 	 * Initialize sgc->capacity such that even if we mess up the
 	 * domains and no possible iteration will get us here, we won't
 	 * die on a /0 trap.
 	 */
-	sg_span = sched_group_span(sg);
-	sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sg_span);
-	sg->sgc->min_capacity = SCHED_CAPACITY_SCALE;
-	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
+	sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sg_span);
+	sgc->min_capacity = SCHED_CAPACITY_SCALE;
+	sgc->max_capacity = SCHED_CAPACITY_SCALE;
+
+	return 0;
 }
 
 static struct sched_domain *
@@ -1405,7 +1453,10 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		sg_span = sched_group_span(sg);
 		cpumask_or(covered, covered, sg_span);
 
-		init_overlap_sched_group(sibling, sg);
+		if (init_overlap_sched_group(sibling, sg)) {
+			kfree(sg);
+			goto fail;
+		}
 
 		if (!first)
 			first = sg;
@@ -1507,6 +1558,25 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 		cpu = cpumask_first(sched_domain_span(child));
 
 	sg = *per_cpu_ptr(sdd->sg, cpu);
+	if (!sg) {
+		sg = kzalloc_node(sizeof(*sg) + cpumask_size(),
+				  GFP_KERNEL, cpu_to_node(cpu));
+		if (!sg)
+			return NULL;
+		sg->next = sg;
+		*per_cpu_ptr(sdd->sg, cpu) = sg;
+	}
+
+	if (!*per_cpu_ptr(sdd->sgc, cpu)) {
+		struct sched_group_capacity *sgc;
+
+		sgc = kzalloc_node(sizeof(*sgc) + cpumask_size(),
+				   GFP_KERNEL, cpu_to_node(cpu));
+		if (!sgc)
+			return NULL;
+		sgc->id = cpu;
+		*per_cpu_ptr(sdd->sgc, cpu) = sgc;
+	}
 	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
 
 	/* Increase refcounts for claim_allocations: */
@@ -1562,6 +1632,8 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 			continue;
 
 		sg = get_group(i, sdd);
+		if (!sg)
+			return -ENOMEM;
 
 		cpumask_or(covered, covered, sched_group_span(sg));
 
@@ -1595,27 +1667,40 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 	WARN_ON(!sg);
 
 	do {
-		int cpu, cores = 0, max_cpu = -1;
+		int i, cores = 0, max_cpu = -1;
+
+		if (sg->group_weight)
+			goto next;
+
+		if (sg->sgc->group_weight) {
+			sg->group_weight = sg->sgc->group_weight;
+			sg->cores = sg->sgc->cores;
+			sg->asym_prefer_cpu = sg->sgc->asym_prefer_cpu;
+			goto next;
+		}
 
 		sg->group_weight = cpumask_weight(sched_group_span(sg));
 
 		cpumask_copy(mask, sched_group_span(sg));
-		for_each_cpu(cpu, mask) {
+		for_each_cpu(i, mask) {
 			cores++;
-			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
+			cpumask_andnot(mask, mask, cpu_smt_mask(i));
 		}
 		sg->cores = cores;
 
-		if (!(sd->flags & SD_ASYM_PACKING))
-			goto next;
-
-		for_each_cpu(cpu, sched_group_span(sg)) {
-			if (max_cpu < 0)
-				max_cpu = cpu;
-			else if (sched_asym_prefer(cpu, max_cpu))
-				max_cpu = cpu;
+		if (sd->flags & SD_ASYM_PACKING) {
+			for_each_cpu(i, sched_group_span(sg)) {
+				if (max_cpu < 0)
+					max_cpu = i;
+				else if (sched_asym_prefer(i, max_cpu))
+					max_cpu = i;
+			}
+			sg->asym_prefer_cpu = max_cpu;
 		}
-		sg->asym_prefer_cpu = max_cpu;
+
+		sg->sgc->group_weight = sg->group_weight;
+		sg->sgc->cores = sg->cores;
+		sg->sgc->asym_prefer_cpu = sg->asym_prefer_cpu;
 
 next:
 		sg = sg->next;
@@ -1889,7 +1974,8 @@ static void claim_allocations(int cpu, struct s_data *d)
 {
 	struct sched_domain *sd;
 
-	if (atomic_read(&(*per_cpu_ptr(d->sds, cpu))->ref))
+	if (*per_cpu_ptr(d->sds, cpu) &&
+	    atomic_read(&(*per_cpu_ptr(d->sds, cpu))->ref))
 		*per_cpu_ptr(d->sds, cpu) = NULL;
 
 	for (sd = *per_cpu_ptr(d->sd, cpu); sd; sd = sd->parent) {
@@ -1898,10 +1984,12 @@ static void claim_allocations(int cpu, struct s_data *d)
 		WARN_ON_ONCE(*per_cpu_ptr(sdd->sd, cpu) != sd);
 		*per_cpu_ptr(sdd->sd, cpu) = NULL;
 
-		if (atomic_read(&(*per_cpu_ptr(sdd->sg, cpu))->ref))
+		if (*per_cpu_ptr(sdd->sg, cpu) &&
+		    atomic_read(&(*per_cpu_ptr(sdd->sg, cpu))->ref))
 			*per_cpu_ptr(sdd->sg, cpu) = NULL;
 
-		if (atomic_read(&(*per_cpu_ptr(sdd->sgc, cpu))->ref))
+		if (*per_cpu_ptr(sdd->sgc, cpu) &&
+		    atomic_read(&(*per_cpu_ptr(sdd->sgc, cpu))->ref))
 			*per_cpu_ptr(sdd->sgc, cpu) = NULL;
 	}
 }
@@ -2700,8 +2788,6 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 		for_each_cpu(j, cpu_map) {
 			struct sched_domain *sd;
-			struct sched_group *sg;
-			struct sched_group_capacity *sgc;
 
 			sd = kzalloc_node(sizeof(struct sched_domain) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
@@ -2709,24 +2795,6 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 				return -ENOMEM;
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
-
-			sg = kzalloc_node(sizeof(struct sched_group) + cpumask_size(),
-					GFP_KERNEL, cpu_to_node(j));
-			if (!sg)
-				return -ENOMEM;
-
-			sg->next = sg;
-
-			*per_cpu_ptr(sdd->sg, j) = sg;
-
-			sgc = kzalloc_node(sizeof(struct sched_group_capacity) + cpumask_size(),
-					GFP_KERNEL, cpu_to_node(j));
-			if (!sgc)
-				return -ENOMEM;
-
-			sgc->id = j;
-
-			*per_cpu_ptr(sdd->sgc, j) = sgc;
 		}
 	}
 
@@ -2767,23 +2835,10 @@ static void __sdt_free(const struct cpumask *cpu_map)
 
 static int __sds_alloc(struct s_data *d, const struct cpumask *cpu_map)
 {
-	int j;
-
 	d->sds = alloc_percpu(struct sched_domain_shared *);
 	if (!d->sds)
 		return -ENOMEM;
 
-	for_each_cpu(j, cpu_map) {
-		struct sched_domain_shared *sds;
-
-		sds = kzalloc_node(sizeof(struct sched_domain_shared),
-				GFP_KERNEL, cpu_to_node(j));
-		if (!sds)
-			return -ENOMEM;
-
-		*per_cpu_ptr(d->sds, j) = sds;
-	}
-
 	return 0;
 }
 
@@ -2954,7 +3009,7 @@ static void adjust_numa_imbalance(struct sched_domain *sd_llc)
 	}
 }
 
-static void
+static int
 init_sched_domain_shared(struct s_data *d, struct sched_domain *sd, int flags)
 {
 	struct sched_domain_shared *sds = NULL;
@@ -2976,6 +3031,13 @@ init_sched_domain_shared(struct s_data *d, struct sched_domain *sd, int flags)
 	 */
 	for_each_cpu(cpu, sched_domain_span(sd)) {
 		sds = *per_cpu_ptr(d->sds, cpu);
+		if (!sds) {
+			sds = kzalloc_node(sizeof(*sds),
+					   GFP_KERNEL, cpu_to_node(cpu));
+			if (!sds)
+				return -ENOMEM;
+			*per_cpu_ptr(d->sds, cpu) = sds;
+		}
 
 		if (!sds->alloc_flags ||
 		    sd->span_weight == 1 ||
@@ -3000,6 +3062,8 @@ init_sched_domain_shared(struct s_data *d, struct sched_domain *sd, int flags)
 	 */
 	atomic_set(&sd->shared->nr_busy_cpus, sd->span_weight);
 	atomic_inc(&sd->shared->ref);
+
+	return 0;
 }
 
 /*
@@ -3015,25 +3079,24 @@ init_sched_domain_shared(struct s_data *d, struct sched_domain *sd, int flags)
  * degenerate into a single-capacity group. The relevant edge cases are instead
  * covered by the caveats above.
  *
- * Return true if this CPU's asym path claimed sd->shared, false otherwise.
+ * Return 0 on success or if not claimed, -ENOMEM on allocation failure.
  */
-static bool claim_asym_sched_domain_shared(struct s_data *d, int cpu)
+static int claim_asym_sched_domain_shared(struct s_data *d, int cpu)
 {
 	struct sched_domain *sd = *per_cpu_ptr(d->sd, cpu);
 	struct sched_domain *sd_asym;
 
 	if (!sd)
-		return false;
+		return 0;
 
 	sd_asym = sd;
 	while (sd_asym && !(sd_asym->flags & SD_ASYM_CPUCAPACITY_FULL))
 		sd_asym = sd_asym->parent;
 
 	if (!sd_asym || (sd_asym->flags & SD_NUMA))
-		return false;
+		return 0;
 
-	init_sched_domain_shared(d, sd_asym, SD_ASYM_CPUCAPACITY);
-	return true;
+	return init_sched_domain_shared(d, sd_asym, SD_ASYM_CPUCAPACITY);
 }
 
 static int __sched_domains_alloc_llc_id(void)
@@ -3179,15 +3242,16 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		if (!sd)
 			continue;
 
-		if (has_asym)
-			claim_asym_sched_domain_shared(&d, i);
+		if (has_asym && claim_asym_sched_domain_shared(&d, i))
+			goto error;
 
 		/* First, find the topmost SD_SHARE_LLC domain */
 		while (sd->parent && (sd->parent->flags & SD_SHARE_LLC))
 			sd = sd->parent;
 
 		if (sd->flags & SD_SHARE_LLC) {
-			init_sched_domain_shared(&d, sd, SD_SHARE_LLC);
+			if (init_sched_domain_shared(&d, sd, SD_SHARE_LLC))
+				goto error;
 
 			/*
 			 * In presence of higher domains, adjust the
-- 
2.56.0.176.g3575e65682-goog


