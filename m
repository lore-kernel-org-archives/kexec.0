Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE09ECCA466
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IWqiGzk/pYHC1ZT+qsWV7wuDwiIjMUnX6pd7W6OrNuo=; b=T3S2ZOR8CKcMNtko1GqZehB6sJ
	Zh6Ga7duRR60NqHMq5448erPsiNhCgGlWLUmaM/0YhaeUC6xImPKDSU0+Hj0/3ZSBkD5clhvJttHt
	qBXlER/yn881psDJTKxq+6m+rrtGfOZXw2YHXXEW4mIay92U4ERZylSPJnzWfi2vHKZtgbK69I/X4
	2JLis2BsvZGg1efQHg46uDr3utRRgC8xiLOuWCTc9JpDDxptFYYltNo+1osX/6m9qslSZy8mC/XYj
	Fy7uSFA87lHP1VMEdMrm5fKCIFPhJC7Maxt8bHEKiucazljw12h7LdntUzfIWRYldn4v1RMzHr8WR
	VGsKxkcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSs-00000000ZcB-2YRX;
	Thu, 15 Oct 2026 15:33:54 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSb-00000000ZRp-1Ufs
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:33:51 +0000
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-74ab99038afso3462121137.3
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792078416; x=1792683216; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IWqiGzk/pYHC1ZT+qsWV7wuDwiIjMUnX6pd7W6OrNuo=;
        b=O9ofgyIlqnKrJxW16euTfSjIKerVdmK8O/IX0/dDl8hXkDiMkx/shkWZN2ag1JH5G6
         ff6aNoEcuXsitNMoGp/eI+zFzAdnwlIHqKew3rmbx5mScxIZujMbqgiit9LYhFv3Yf+U
         BPpMupKOoNighNUIiN33OsErJk0A+Nfniz4XeObDpp7YjZMP3TFi135bBuO//YZKUcDx
         GawPrMGlUFeVXFWEiLufe5huRf8eouVDKk2Hnl8NKCXh5guDBXsg/Wj4Fo9br+cnYemX
         SPqscUOc+ZY3E3tpZDrSrhuEzbLQ6hj5L6/VNu2jPNZi561+UVO9sA12ol9SZfDRi1YH
         juQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078416; x=1792683216;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IWqiGzk/pYHC1ZT+qsWV7wuDwiIjMUnX6pd7W6OrNuo=;
        b=u7oDEsCOrtdXcnU+q4mLsaSz1z3Gpd8qWnusU7heKvM38R182H56XjNfuAvCFwqfMS
         WEeJXjqfpA/Pb48d0XP1ST20sGcJu2qlxWYkHk678Ch+QVxc9TB0ADEPorBHdBP1Mbm8
         qLNrCDEMmtbKh02LXaJCaWS+SLPiKzwgR2/B8sWTe4OB4hm373CLKSqEiESaQtOi8CFV
         HydwqCliikOEj/7J+1PGpULaPp4b5UY+U1jnnFbKSc6ufICrgEz7ygQUHxkiKJs2BBwf
         SycNcVs9fRhoMl0aKDLCU4SSz7Kt1n0sAkoLOZ3gXSibgFW+8YG8Xzep15byFlXBki2q
         uiMw==
X-Forwarded-Encrypted: i=1; AKwUvBwPCG8xvTwLyHpPy3yV69r7GSA8GPe68goeln9L7X0E7aX9M9RDnbD7638bxMWPvgWVpTUBEQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYIZDL1pHzpPoWgYKmdVYzENYYshqXyKlJZpClBqlmFhSvc9gTTH
	jA4CFqWQZe7mDGh3sS/jbmF74dbQb8v9Jwfbd93ZHzR4IY5pZck/avfV6WMbc6A20ZQ=
X-Gm-Gg: AYBFou3/0mqtHP/ow8WNKegmN0KXbnTnhHjDMlBY5uTFDiLGYCC0VclNng6gFsjS3MY
	h7h49CDtBBFBsbnYga+Vopl1r2LiHZZJa1dqfsx/GKvr1bR3dUhTTxACdtqedsq+vXW2QQjdqOR
	qO+ndJyn38j7Gd7Mm3yTkEV4FFDqNZIH5W3SK5TjbaD2dd71ZgfDYLR03eH7w8InPj1CvQpkXoU
	S7haDXg8b0IW9tDv0g3eXJtNHZcteLuO+i4/Cn9wuBpNrIdMeuAlzNoL/w2QK8n0UbGnabXnSwq
	5mqET85yVvvAfEZv0jTy/c91tcT+jiigp5nmZxWw5jqt9KpykB+g2Pc+3u5UH9KEEK5fcgkPVRz
	9jmoSPo6WjugvZlQ1g80x9fHslf0iXWv5dCCCYP8m6d2gIEQR2z6lwreaiMHH2jwMX6B5Mnl+x5
	U7/e5QrBwKSGB7fNX5xFbhW/UwUGG3DJMMpo4p44fmuB+I/mf9EXB5DpO1YhED4UDdDtZddzcu/
	NEftqWdpwwX7pQOv9eLt8B3GeBMM+3xCKHSLoSpR+0v/s91O/rd2op7qUOLMLe70JKlEIh5hGVT
	hU74UW/amqMqbzoqi+o=
X-Received: by 2002:a05:6102:c09:b0:78e:1e0f:ea42 with SMTP id ada2fe7eead31-7cb3971582emr7015724137.2.1792078415811;
        Thu, 15 Oct 2026 08:33:35 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f66ad9sm12986347241.10.2026.10.15.08.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:33:35 -0700 (PDT)
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
Subject: [PATCH v1 0/8] x86, sched, mm: Speed up CPU hotplug on large systems
Date: Thu, 15 Oct 2026 11:33:23 -0400
Message-ID: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_083337_646826_898ED99D 
X-CRM114-Status: GOOD (  13.59  )
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

For live update we require a fast CPU online and offline capability.
However, sequentially offlining and onlining all application processors
on modern high-core-count x86 servers exposes a series of hardware and
algorithmic bottlenecks across arch/x86, the scheduler topology builder,
deadline bandwidth accounting, and vmstat.

This series addresses these bottlenecks, reducing the time to offline and
online all AP CPUs by 95.2% (21.0x faster) on a 2-socket, 480-CPU Intel
Xeon 6985P-C and by 59.8% (2.5x faster) on a 2-socket, 512-CPU AMD EPYC
9B45.

Benchmark workload (mean of 10 runs per step):

  # echo 1 > /sys/kernel/rcu_expedited
  # for i in {1..N}; do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
  # for i in {1..N}; do echo 1 > /sys/devices/system/cpu/cpu$i/online; done
  # echo 0 > /sys/kernel/rcu_expedited

  2-socket, 480-CPU Intel Xeon 6985P-C (N=479):
    Offline:  40.40 s ->  3.09 s  (-92.4%, 13.1x faster)
    Online:   65.83 s ->  1.98 s  (-97.0%, 33.2x faster)
    Total:   106.23 s ->  5.07 s  (-95.2%, 21.0x faster)

  2-socket, 512-CPU AMD EPYC 9B45 (N=511):
    Offline:   4.53 s ->  2.30 s  (-49.2%,  2.0x faster)
    Online:    3.88 s ->  1.08 s  (-72.2%,  3.6x faster)
    Total:     8.41 s ->  3.38 s  (-59.8%,  2.5x faster)

  (On AMD EPYC 9B45, each 8-core CCD has a 32 MB L3 where WBINVD takes
   < 0.5 ms, offline uses acpi_idle rather than mwait_play_dead(), and
   Intel CMCI is unused, so Patches 1-3 do not affect AMD, which enters
   Patch 4 at 4.53 s offline / 3.92 s online / 8.45 s total. Without
   rcu_expedited=1, final 10-run mean total time with all 8 patches
   applied is 12.04 s on Intel and 15.99 s on AMD.)

1. x86 WBINVD, CMCI rediscovery, and MTRR rendezvous (Patches 1-4):

   On processors with large shared last-level caches (such as the 504 MB
   L3 per socket on Xeon 6985P-C), CPU hotplug is initially dominated by
   full coherence-domain cache flushes (WBINVD), each taking ~85-115 ms
   per CPU while stalling active cores:

   - Patch 1 removes the obsolete WBINVD from trampoline_start, which was
     added in the 1990s for Sequent NUMA-Q hardware (removed in commit
     b5660ba76b41 ("x86, platforms: Remove NUMAQ")). Per the Intel SDM
     and AMD APM, INIT preserves cache contents and leaves CR0.CD and
     CR0.NW unchanged. Removing it cuts 479-CPU online time on Intel from
     65.83 s to 11.14 s (-83.1%) and total time from 106.23 s to 51.60 s
     (-51.4%).

   - Patch 2 skips the redundant WBINVD before MWAIT in mwait_play_dead()
     during runtime CPU offline (retaining it when cpuhp_tasks_frozen is
     set for system sleep). Architectural MWAIT C-states maintain cache
     coherency while the package remains powered and flush core-private
     L1/L2 caches to the LLC on C-state entry, just like normal idle in
     intel_idle. Skipping it for runtime offline cuts 479-CPU offline
     time on Intel from 40.46 s to 11.42 s (-71.8%) and total time from
     51.60 s to 22.50 s (-56.4%).

   - Patch 3 bounds cmci_rediscover() on CPU teardown. Currently,
     cmci_rediscover() broadcasts an IPI via on_each_cpu() to all online
     CPUs, serializing them on cmci_discover_lock while reading up to 32
     MCA MSRs. Because any disabled MCA bank is shared at most with an
     SMT sibling, L2 cluster peer, or die/package peer, probing a single
     online topology peer via smp_call_function_single() (or returning
     immediately when no shared banks were orphaned) reduces 479-CPU
     offline time on Intel from 11.42 s to 9.63 s (-15.7%) and total time
     from 22.50 s to 20.74 s (-7.8%).

   - Patch 4 skips the stop_machine_from_inactive_cpu() all-CPU
     rendezvous (and the AP's cache disable/flush and MTRR reprogramming
     in cache_cpu_init()) in cache_ap_online() when the AP's hardware
     MTRR MSRs already match mtrr_state (which cache_aps_init() already
     programmed during initial boot and warm reset preserves). This cuts
     online time on Intel from 11.11 s to 8.69 s (-21.8%; total 20.74 s
     -> 18.54 s, -10.6%) and on AMD from 3.92 s to 3.15 s (-19.6%; total
     8.45 s -> 7.66 s, -9.3%).

2. Scheduler domain rebuilds, deadline accounting, and vmstat (Patches 5-8):

   Once the x86 hardware bottlenecks are removed, CPU hotplug on both
   Intel and AMD is dominated by O(N^2) and O(N^3) work inside
   partition_sched_domains_locked(), build_sched_domains(), and
   refresh_zone_stat_thresholds():

   - Patch 5 avoids redundant O(N^3) group weight, SMT core-mask, and
     asym_prefer_cpu recomputations in init_sched_groups_capacity() by
     caching those fields on struct sched_group_capacity, reuses
     already-initialized sgc instances in init_overlap_sched_group(), and
     allocates sdd->sg, sdd->sgc, and d->sds lazily on demand. This cuts
     total hotplug time on Intel from 18.54 s to 9.20 s (-50.4%) and on
     AMD from 7.66 s to 5.29 s (-30.9%).

   - Patch 6 eliminates three O(N^2) dl_server bandwidth walks per
     hotplug step. Because fair_server is enabled on every runqueue by
     default, rq_attach_root() performs O(N^2) remote extra_bw updates
     when attaching def_root_domain during teardown and again when
     attaching the new root_domain during build, followed by a nested
     O(N^2) loop in dl_clear_root_domain(). Dropping the redundant
     __dl_server_attach_root() calls in rq_attach_root() and converting
     dl_clear_root_domain() to two linear O(N) passes cuts
     dl_clear_root_domain() at ~500 CPUs from 1.8-5.5 ms to < 65 us,
     reducing total hotplug time by 30.5% on Intel (9.20 s -> 6.39 s)
     and 18.7% on AMD (5.29 s -> 4.30 s).

   - Patch 7 eliminates per-CPU bitmap scans over already-covered groups
     in build_sched_groups(), reuses temporary per-CPU domain pointer
     arrays across rebuilds instead of calling alloc_percpu() and
     free_percpu() on every hotplug step, reuses precomputed domain/child
     span weights, and hoists LLC size calculations. This cuts total
     hotplug time by 15.0% on Intel (6.39 s -> 5.43 s) and 19.5% on AMD
     (4.30 s -> 3.46 s).

   - Patch 8 avoids unconditionally zeroing and rewriting every online
     CPU's per-CPU stat_threshold in refresh_zone_stat_thresholds() on
     every hotplug step (since calculate_normal_threshold() only changes
     at powers of two and is clamped once num_online_cpus() >= 64),
     reducing refresh_zone_stat_thresholds() by ~88-91% on Intel and ~51%
     on AMD, and bringing total hotplug time down to 5.07 s on Intel
     (-6.6%) and 3.38 s on AMD (-2.3%).

Pasha Tatashin (8):
  x86/realmode: Remove unnecessary WBINVD from AP startup trampoline
  x86/smp: Remove unnecessary WBINVD from mwait_play_dead()
  x86/mce/intel: Bound cmci_rediscover() to a single topology peer
  x86/cacheinfo, mtrr: Skip stop_machine rendezvous in cache_ap_online()
    when MTRRs match
  sched/topology: Avoid redundant O(N^3) group capacity walks and unused
    allocations in build_sched_domains()
  sched/deadline, topology: Avoid O(N^2) dl_server bandwidth walks
    during root_domain rebuilds
  sched/topology: Avoid redundant percpu allocations and bitmap walks in
    build_sched_domains()
  mm/vmstat: Avoid redundant per-CPU stat_threshold writes in
    refresh_zone_stat_thresholds()

 arch/x86/include/asm/mtrr.h          |   2 +
 arch/x86/kernel/cpu/cacheinfo.c      |   7 +
 arch/x86/kernel/cpu/mce/intel.c      |  57 ++++-
 arch/x86/kernel/cpu/mtrr/generic.c   |  49 ++++
 arch/x86/kernel/smpboot.c            |  16 +-
 arch/x86/realmode/rm/trampoline_32.S |   2 -
 arch/x86/realmode/rm/trampoline_64.S |   1 -
 include/linux/cpuset.h               |   6 +-
 include/linux/sched/deadline.h       |   1 -
 kernel/sched/deadline.c              |  89 ++++---
 kernel/sched/sched.h                 |  10 +-
 kernel/sched/topology.c              | 339 ++++++++++++++++-----------
 mm/vmstat.c                          |  58 ++---
 13 files changed, 422 insertions(+), 215 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.56.0.385.gd3acb90ef8-goog

