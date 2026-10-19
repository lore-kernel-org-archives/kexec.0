Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D87CCF2DA
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 01:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r5Uh0UovwmV8EFz8GLwox5sAAEwyuEzq/FgIh/SpVjc=; b=RGKVLPW9dBalTEuNs4ZnTG04F4
	9UCNrpb5pJrMBdSjl8nO9LbQWqm73uosMVYwWhX0ncTMVi7tYRX/i1THy0iLswC2UljDyH0cZIomB
	CPlulQD7NeOTbAmfGKjyb6nkg3xJCcryanN3sk4evi8zQxrzr2i3bY6m0soAxYLSLwKGrPuxhQ5gC
	8FtiuDCekwW+9v6doKwFTxiMz7aaFFH96/JVZpucI9fe+m/SXYVz2qPZa6t+retwXIIIYZpN2WhsX
	G92ZXRNw+tAIYRFcGCAnXfVE6sVRJo7nUKA7+cRrG8uhyj1D80XS4ttkn22VmqAS3yShMcFJDdxR7
	3JtgcxIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxt-00000006N6d-3Jxh;
	Mon, 19 Oct 2026 01:15:01 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxo-00000006N4W-2xaU
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 01:15:00 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso627356e0c.0
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792372495; x=1792977295; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5Uh0UovwmV8EFz8GLwox5sAAEwyuEzq/FgIh/SpVjc=;
        b=JSvwDggCaB1px5cJ3wemfgfHjFurkDmXQ1v60lkGdVvFmlP6hwmBj6NdJU+rOyUbpO
         BVZBd4qaBL2lIwMMR1s0F8YpX/Xu+40mVyxQ14OOwjKNmq/geznH2yyHPjzLTR6+VVUh
         SXdMd3aNI+GHzd5JcfpSwo+nBIXrlEijgFDXbChak/ektlFBFH0plb9ivzJs/HxcfS+f
         7UrD07RfJf9aMsSrMq9HBn+GNOotDOAyf0Px6ai8X+XZKRBndi3aMaKWtzwAuDyR0WE1
         klZCHtUuKWX7YuGGdDrAVRgFBKFkq1Ki5aPrk+sIQhpLnRWfU+JuAyNgFXW1eZ0H94wR
         +O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372495; x=1792977295;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5Uh0UovwmV8EFz8GLwox5sAAEwyuEzq/FgIh/SpVjc=;
        b=oJaKpSGt9P7tnWTOUsIeWSQ60uKTYzLxd5B+hnMAWEKSRN2LUk6BOQslve7wO7SbgD
         0wQy5LOBx8D7xhZWNkw0h6veJKKjQiF6t/fFFGF2BcAIrlJ/mDXUbhVKGne0DkLMhPFh
         owAPggbAO7H3Uec6CEkqZV/j3MEkONMeFiucjzdIZHxHs7rqYksvFd7aL5sVrw4cTclv
         oO4R1jKAcMv3+6Vsp+6Vz6i110wknME3I74JaW7ts0YC5upMmxFZMCkxbF1iEZBfrzCt
         IfhmwqCT5oSUI0iezTq9fUfr6qh0nDhgY0+ofZixS4sbCZZUCANj3COHVG9IyT1gyk/G
         WUfw==
X-Forwarded-Encrypted: i=1; AKwUvByXFWYmLVzqpSFOfB8obO0qWwKDjdQOozai+v4q5Cr9QRZVqm3/tRIWKPLNQUuyQs2GrmZ+6Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYLtEt3+N/j3PfpokJEZGpIh+RllPsgA/FTVZ1gVZ2+K16hOZ54l
	H13xrzP0oIQw0+Uaae26KtCRsgxsDrh2e5c+oy4NoQACTSY95BmFBhIWi8ASthIVwlU=
X-Gm-Gg: AYBFou0L4al1Qv38L7WwI/xnSJe3yATsbk/vK+ankaSJiHSAFjZIsJRJZXwYW/734uR
	TdpXDAxa9XLPu1Sb6nEcrUde9J61+Rd1lj49ehAzCF8N4OHXUCYJF6bfQdZg9KgJitq5cD/JRLc
	l5a0rJnrcq1wFLuZlSwH0UmJrW4fOdabr3ZJPiOn8lkiolxdrdgBVMeWh1svB4b5ZJp9rLVs/C7
	31Dnr/ig2r8kbxg1633bEU15Q/Dj3RYcpIjToN5v4ymcZGeW/ekMQlZKfw/x9ER8WETObl5pLX+
	zL2sMlVju6pXuE5PxUe5FABNN+fmOyBp0sfdHZ3PJz4vSwT7gz9A2f98P5tc08wHDtuhE7x4AQj
	lmhkxCJ5IK8miV5drkWGwske9NBJwbgUPQ9FXcahRewLPF1yYOI7E25IEt2FY6yHD82rK/Df8pk
	PWNvnzrAxyjaSQY4i8617anxRBlRZmaNoSXTe0MGPcD3SsYtMG8dXLvQEOq++TFAMTq1fYFd4zU
	6oay4Xom/jF17+0U7yKLGk0EInociEQMP4i/hm5239Zc4po6dp+nxK0nV6r4aAFFvthBwzDp84D
	bGxgOn+ocg1eWmA2fps=
X-Received: by 2002:a05:6122:10e7:b0:5e7:e3f9:1322 with SMTP id 71dfb90a1353d-5eaaa4183dbmr1605940e0c.9.1792372495503;
        Sun, 18 Oct 2026 18:14:55 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b474b2asm8039142e0c.4.2026.10.18.18.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:14:54 -0700 (PDT)
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
Subject: [PATCH v2 2/8] x86/smp: Remove unnecessary WBINVD from mwait_play_dead()
Date: Sun, 18 Oct 2026 21:14:40 -0400
Message-ID: <20261019011446.834487-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019011446.834487-1-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_181459_346775_D6D2C7B7 
X-CRM114-Status: GOOD (  18.57  )
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

When a logical CPU goes offline via mwait_play_dead(), it executes
WBINVD before entering the MWAIT loop. On processors with large shared
last-level caches (such as Intel Xeon 6985P-C with 504 MB L3 per
socket), each WBINVD takes ~85-115 ms, flushes and invalidates the
entire socket's shared caches, and stalls the physical core (including
any online SMT sibling on that core) for the duration of the flush.

mwait_play_dead() places the logical processor into an architectural
MWAIT C-state—the same hardware C-states entered by intel_idle during
normal idle without executing WBINVD—where C-states deeper than C1/C1E
flush core-private L1/L2 caches to the coherent LLC on C-state entry
and maintain cache coherency while the package remains powered.

As long as at least one CPU sharing the same LLC on the package remains
online, system-wide cache flushes (wbinvd_on_all_cpus()), system sleep,
and kexec will still flush that shared LLC via the online CPU(s).
However, when the last online CPU in an LLC goes offline, no online CPU
remains to service wbinvd_on_all_cpus() or flush the package before
S3/S4 power removal. Similarly, if the target MWAIT state is C1/C1E
(which does not flush core-private caches) or cache_state_incoherent is
set (e.g., SME), the CPU must flush its caches before entering MWAIT.

Skip WBINVD in mwait_play_dead() when entering a C-state deeper than
C1/C1E while another CPU sharing the same package and LLC remains
online (unless cache_state_incoherent is set).

2-socket, 480-CPU Intel Xeon 6985P-C (N=479, mean of 10 runs):
  Offline:  40.46 s -> 11.42 s (-71.8%)
  Online:   11.14 s -> 11.08 s (-0.5%)
  Total:    51.60 s -> 22.50 s (-56.4%)

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kernel/smpboot.c | 46 +++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ba01a9e919b7..0dccd2f927bb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1414,10 +1414,28 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
-/*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
+static bool mwait_play_dead_needs_wbinvd(unsigned int eax_hint)
+{
+	unsigned int cpu = smp_processor_id();
+	u32 pkg_id = topology_physical_package_id(cpu);
+	u32 llc_id = per_cpu_llc_id(cpu);
+	unsigned int i;
+
+	if (cpuhp_tasks_frozen || MWAIT_HINT2CSTATE(eax_hint) < 2 ||
+	    llc_id == BAD_APICID || this_cpu_read(cache_state_incoherent)) {
+		return true;
+	}
+
+	for_each_online_cpu(i) {
+		if (topology_physical_package_id(i) == pkg_id &&
+		    per_cpu_llc_id(i) == llc_id) {
+			return false;
+		}
+	}
+
+	return true;
+}
+
 void __noreturn mwait_play_dead(unsigned int eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
@@ -1426,15 +1444,29 @@ void __noreturn mwait_play_dead(unsigned int eax_hint)
 	md->status = CPUDEAD_MWAIT_WAIT;
 	md->control = CPUDEAD_MWAIT_WAIT;
 
-	wbinvd();
+	/*
+	 * Entering MWAIT C-states deeper than C1/C1E/C2 writes back and
+	 * invalidates core-private L1/L2 caches into the shared LLC before
+	 * power-gating the core. While the CPU is still in C0 prior to MWAIT,
+	 * its L1/L2 caches remain coherent and snoop external cache flushes,
+	 * and once in MWAIT its L1/L2 caches are empty and all dirty lines
+	 * reside in the shared LLC. Thus, as long as at least one CPU sharing
+	 * this LLC remains online, any concurrent or subsequent
+	 * wbinvd_on_all_cpus(), system sleep, or kexec will flush the shared
+	 * LLC to memory.
+	 *
+	 * Only flush here during system sleep (cpuhp_tasks_frozen), when
+	 * entering C1/C1E/C2, when the last online CPU in the LLC goes
+	 * offline, or if the CPU's cache state is marked incoherent (e.g. SME).
+	 */
+	if (mwait_play_dead_needs_wbinvd(eax_hint))
+		wbinvd();
 
 	while (1) {
 		/*
 		 * The CLFLUSH is a workaround for erratum AAI65 for
 		 * the Xeon 7400 series.  It's not clear it is actually
 		 * needed, but it should be harmless in either case.
-		 * The WBINVD is insufficient due to the spurious-wakeup
-		 * case where we return around the loop.
 		 */
 		mb();
 		clflush(md);
-- 
2.56.0.176.g3575e65682-goog


