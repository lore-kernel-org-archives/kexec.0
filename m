Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59612CCF2D8
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 01:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k1COhzPK8MoPAOVKkuVJ9yCDV5Zgubw3w5lCCc8/uFo=; b=vCqzf1Qm0o+eYGqc1OR8mceAj9
	1vb761OjZDB5i8F8bWaEjj5IZVkH7JoVx+le5UKm4ikQVPwPdqav8CrC2h4a0jI6dFujxuSsSiJI7
	7V65yidCcr9WPN4qNkISkSfWLEMdT830dSmiHijtDSr/PaeJ2KSdWGKFvQIqoKBd9JaK38wN3auPK
	M1HwpPmfbN3td5x3E2s4BK9a1XKOE9Ck84/ScxQfM8N9wbQCcyK3zMmNnhlXiLM96bPpq/jyiAb3D
	H+oJM45/cE9t13PHQZnoYy5tLEv+bLwVQp1K666mp7j4GNLXjuprI39WzZyAk3g6fGfgVsX0QtiMq
	rM1ptaxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIby6-00000006NJE-1TQ9;
	Mon, 19 Oct 2026 01:15:14 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIby2-00000006NEw-2O8L
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 01:15:13 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5eac4855401so220891e0c.1
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 18:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792372509; x=1792977309; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k1COhzPK8MoPAOVKkuVJ9yCDV5Zgubw3w5lCCc8/uFo=;
        b=cERCkumT3E6f8vynY8lrdw1BhH6Wi5sqSIjYpTCPxqLlVjE8IhUfyQ459wZ2kpz2fD
         OPxEJxodfRVkFXVHfdOwWVUAlmccFLRII1r41sQ7QST9ZM8mBNaP3NLRgaIaEa/8YehM
         8Ow3CUfgK7ySHQVnt01IlH1IhRd0Nq9jqmFVu5P3oAe6JIWBEIC82uJxR/ZmfkYBokve
         GHHlcQA5ec7iNYn95jemrL4AXxdzWs7Y118+PMIdq+PD3Bed1GfjXaCZQaEnpph43tHQ
         Gy5BCqZipOm+FZpKFmRFKBszTqoIvLgukbpYdxC/WlwRR5lviSKVpNBAM7ofcPWAhnVD
         psZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372509; x=1792977309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k1COhzPK8MoPAOVKkuVJ9yCDV5Zgubw3w5lCCc8/uFo=;
        b=t6uI+HHSmWzX4rCmEDAMT4HGZuzbN6tJ44Ut7Zj/RKEFTRyo/Bb9PhlkWgekIfuC18
         pt542faDienKw/nvac4UwlI7DK091SqqdTGBsmgTmfdlhUljUpUXqQeuzs7ZFDB1RUsS
         /EbdvCEuXfjCHnhUmUNAyqwzopVDhXeFZFVBZuhEbnrnpi2gA/WD4+7h5vnXfIxbQf1S
         wAsmiZ7i/H0bj+F3myIHEBal4kLhwnLN9WHiXbeJFk9BX/1PA/bRgNtloV7Ch2Ien/w5
         OkIsefaLo+MiFT+PwpWiTyiRP35/DRBtPfJbUq7c4gm+sGMK7KV4QLEGsinC5VJ+fY/x
         JWhw==
X-Forwarded-Encrypted: i=1; AKwUvBwNgsJyZBHNttiuNPTLmK6tPL6ccOYKXHQ9yW5pQfVhraK+5b1UNszj6j+z7HFjxKaN0iAgFQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKNl6UcWN/7b2wlJDIHNZ8vd1VvpGTcc8j6fakGk98QDs1j9HIu
	W55zJt93+YIhGYWbwPVrm8pCpWdKqiFRZ259soKPTLg/YQ14UvkiC6wKv1E2FZX7IzE=
X-Gm-Gg: AYBFou3T4UbfnnNGmHqq8IDwETKflM4//UjQPnDS55ECA/cThYluTRE/rOycr/keXUK
	jhNboyudBHcCJnyaJpRafmLf8TLgrRnAR8byaKECqOPMGga9c4YlIjNUoJK8Q+hE5Nuqz0xYkqe
	Qh0kvhJVQzvpUvIgjjPiaPg5QYzdlU/xmwNJMcMdfFE9kfdO0+9Bk2l3xkkR3urWdSvl/qIgUxl
	gr4X2pRHjTWAatQRCRk+iKAiqEtp0xgsPZUytisBZ69o9s6eVjNQeqN76RgdJP2J1EAh7SGhzQg
	fkQPHFP2hyFQy+axWpR4ml5dHQGW63aQKxLtbCukN0IreXgrMVo4bKJE2Z8kZrrjUxnnAbi0r03
	5yvaX0PWptCIL4uqhr2xv3pTzvydOCtUzgO4A0o1ptW2MK2fi0ePh3evPmeUrsx+XEyWR7ykDW7
	La75ucMFSaluuZox/2Jr3d7TyWQfMNi/u7ypGg+GCpvOxVP51Qeb8xX9EdUEhJQfzyN80HCTseB
	kVdOcWCkzvvHQ47cxeRCafqLC4PYYMqoR2wLtITVAGt/1DFhwe8Aa78v6nCUBHWThXgrHeyVB6U
	J1sFRjrjYCLOA8rz9R2x2/O1CggXRpo=
X-Received: by 2002:a05:6122:e14e:b0:5c8:46e3:ec57 with SMTP id 71dfb90a1353d-5eaaa0ba603mr2227545e0c.1.1792372508911;
        Sun, 18 Oct 2026 18:15:08 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b474b2asm8039142e0c.4.2026.10.18.18.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:15:07 -0700 (PDT)
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
Subject: [PATCH v2 8/8] mm/vmstat: Avoid redundant per-CPU stat_threshold writes in refresh_zone_stat_thresholds()
Date: Sun, 18 Oct 2026 21:14:46 -0400
Message-ID: <20261019011446.834487-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019011446.834487-1-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_181510_622007_E945FF2F 
X-CRM114-Status: GOOD (  14.21  )
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

During CPU hotplug, vmstat_cpu_online() and vmstat_cpu_dead() invoke
refresh_zone_stat_thresholds() on every CPU transition. Currently,
refresh_zone_stat_thresholds() first zeroes
per_cpu_nodestats->stat_threshold across all online CPUs and all online
nodes, and then unconditionally writes per_cpu_zonestats->stat_threshold
and per_cpu_nodestats->stat_threshold inside the zone loop for every
populated zone and every online CPU.

However, calculate_normal_threshold(zone) only changes when
fls(num_online_cpus()) changes (at powers of 2) and is clamped at 125
for large normal zones (>= 16 GB) once num_online_cpus() >= 64.
Unconditionally zeroing and rewriting every CPU's per-CPU stat_threshold
on every hotplug step repeatedly dirties remote per-CPU cachelines with
identical values (and briefly exposes stat_threshold == 0 on live CPUs).

Compute pgdat_threshold across each node's populated zones first, hoist
the per_cpu_nodestats->stat_threshold update out of the zone loop, and
only write stat_threshold when the value actually changes.

2-socket, 480-CPU Intel Xeon 6985P-C (N=479, mean of 10 runs):
  Offline:   3.37 s ->  3.09 s (-8.3%)
  Online:    2.06 s ->  1.98 s (-3.9%)
  Total:     5.43 s ->  5.07 s (-6.6%)
  refresh_zone_stat_thresholds() (cpu479 offline / online):
    1,158.9 us -> 135.3 us (-88.3%) / 1,468.2 us -> 128.6 us (-91.2%)

2-socket, 512-CPU AMD EPYC 9B45 (N=511, mean of 10 runs):
  Offline:   2.34 s ->  2.30 s (-1.7%)
  Online:    1.12 s ->  1.08 s (-3.6%)
  Total:     3.46 s ->  3.38 s (-2.3%)
  refresh_zone_stat_thresholds() (cpu511 offline / online):
    104.6 us -> 50.7 us (-51.6%) / 109.3 us -> 53.5 us (-51.1%)

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/vmstat.c | 58 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index cb57714539fb..c671e9669b43 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -280,41 +280,45 @@ void refresh_zone_stat_thresholds(void)
 	int cpu;
 	int threshold;
 
-	/* Zero current pgdat thresholds */
 	for_each_online_pgdat(pgdat) {
-		for_each_online_cpu(cpu) {
-			per_cpu_ptr(pgdat->per_cpu_nodestats, cpu)->stat_threshold = 0;
-		}
-	}
+		int pgdat_threshold = 0;
 
-	for_each_populated_zone(zone) {
-		struct pglist_data *pgdat = zone->zone_pgdat;
-		unsigned long max_drift, tolerate_drift;
+		for (int z = 0; z < MAX_NR_ZONES; z++) {
+			unsigned long max_drift, tolerate_drift;
 
-		threshold = calculate_normal_threshold(zone);
+			zone = &pgdat->node_zones[z];
+			if (!populated_zone(zone))
+				continue;
 
-		for_each_online_cpu(cpu) {
-			int pgdat_threshold;
+			threshold = calculate_normal_threshold(zone);
+			/* Base nodestat threshold on the largest populated zone. */
+			pgdat_threshold = max(threshold, pgdat_threshold);
 
-			per_cpu_ptr(zone->per_cpu_zonestats, cpu)->stat_threshold
-							= threshold;
+			for_each_online_cpu(cpu) {
+				s8 *pz = &per_cpu_ptr(zone->per_cpu_zonestats, cpu)->stat_threshold;
 
-			/* Base nodestat threshold on the largest populated zone. */
-			pgdat_threshold = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu)->stat_threshold;
-			per_cpu_ptr(pgdat->per_cpu_nodestats, cpu)->stat_threshold
-				= max(threshold, pgdat_threshold);
+				if (*pz != threshold)
+					*pz = threshold;
+			}
+
+			/*
+			 * Only set percpu_drift_mark if there is a danger that
+			 * NR_FREE_PAGES reports the low watermark is ok when in fact
+			 * the min watermark could be breached by an allocation
+			 */
+			tolerate_drift = low_wmark_pages(zone) - min_wmark_pages(zone);
+			max_drift = num_online_cpus() * threshold;
+			if (max_drift > tolerate_drift)
+				zone->percpu_drift_mark = high_wmark_pages(zone) +
+						max_drift;
 		}
 
-		/*
-		 * Only set percpu_drift_mark if there is a danger that
-		 * NR_FREE_PAGES reports the low watermark is ok when in fact
-		 * the min watermark could be breached by an allocation
-		 */
-		tolerate_drift = low_wmark_pages(zone) - min_wmark_pages(zone);
-		max_drift = num_online_cpus() * threshold;
-		if (max_drift > tolerate_drift)
-			zone->percpu_drift_mark = high_wmark_pages(zone) +
-					max_drift;
+		for_each_online_cpu(cpu) {
+			s8 *pn = &per_cpu_ptr(pgdat->per_cpu_nodestats, cpu)->stat_threshold;
+
+			if (*pn != pgdat_threshold)
+				*pn = pgdat_threshold;
+		}
 	}
 }
 
-- 
2.56.0.176.g3575e65682-goog


