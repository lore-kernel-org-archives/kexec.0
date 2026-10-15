Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8F9CCA469
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XxAI2LBfmW3xr29v/N2DJy+DieVEUynw79jHC0KaBOY=; b=TXtWXYdcc1PdaLO+3QafkKFZll
	ByYrnSi/auCCwkDYPLQrBmcOCkI4BNyxGnqcJUCuHsdh6/5kwzcb3EV7yxbMqahprwilEE6Tlx8BO
	z7HTOJgmA2Rs9m6bqbqrMIbochN2wNOtnSWhvWqQHKNW9aw4eAVhMQHx4r6rvKF28lO2CSfchvYgR
	ajHdZIhjWzgVI9v28k+AOrw0YlwIqfn1NTHufzqeG1nWy/fsFxmb65ILdEzdTLpva+53OMRWVV33T
	MGaRtf2wIdhKEL6Rd0y3Bo4MeyT4VDQYG4TRtChKNiysjC/QHTmBsR0/mMwIoXdTkOA56SVUr13T5
	BJPePJ1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSt-00000000Zdi-2UQA;
	Thu, 15 Oct 2026 15:33:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSr-00000000ZZM-0PKR
	for kexec@bombadil.infradead.org;
	Thu, 15 Oct 2026 15:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=XxAI2LBfmW3xr29v/N2DJy+DieVEUynw79jHC0KaBOY=; b=dOFmiE1pJxr8whIbzMb3+Ldgd3
	kjng5nBr8hmpeHduFLDQe77uyirfKLM3E7qzvVeXga/zigsqdJ2Y2D62i3pnnufga+WrzxHwUuwG2
	1v+qRJneYYq1N3/6vk9I9fqJoCL4ZIuWVWPpZYXuzeXxfv8+41cy8IAIY0F+2cjdSL8sKdS4XRg9q
	mNoX9QyT7IhHO1H8c/k+e/UIavJTO58cbmKBkdR5zuEyEwK2Dc3hKKogMuhUe7BYBUkQZASICqC+F
	BxDc8NZkBQirWSUS1OXvfMaknZiRLQ5uDy6AZl1lvcnyfExs478Kvs3vv5eccszavqupyZLkoUSx5
	sm8mZH9A==;
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHNSm-00000000YW3-3sqT
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:33:51 +0000
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-7c03a445cb8so1134019137.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792078427; x=1792683227; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XxAI2LBfmW3xr29v/N2DJy+DieVEUynw79jHC0KaBOY=;
        b=ESs7cfgbap+hty+ILnx8KJD7ODqFHvnxuBlhIdxmOYTeeMzlPheC4Mq9UJ5KypU/xV
         5V8woiMXKsMuBQRJ9zP3si5LetOs3cKBzcbdESAyLdO082mR9fJrRnBWMN1rRhzl/LqG
         /ZF2Y/Jc/CYMFZQG2pc+ze5Gb5NjYhnBLvBHvmr8N+PLtu1HvnVvICh+exUjo3Iw9lr/
         vlIv6NjqFQ465kWfVVO69dDeUtflALdBuut58TZlcCXVuGlTMLv7p52IXyX3DKLu4Zll
         3TkuR7fpvnIgsBSHNWQkCohklw1MP7FjoAfwBTfBoAvqaFpVjId+qVVv0WAtbk684Neu
         eheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078427; x=1792683227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XxAI2LBfmW3xr29v/N2DJy+DieVEUynw79jHC0KaBOY=;
        b=HlPahpe1LfD/WBI4qW6nXEML1nIRG9Tpqc/XaaxX+qmLb+TcJpCcPD65w+h1lbbP7y
         mIc5Kr6ANSJV2gJRybkF4SUnn3K24x/WqZ365z5ScJU8SpMBwd4k73CoFtx26YAJ/Hla
         FseMIAqhCRBkR7K9jjhsElqTf14pRY7R9UNH0ozqv7pWx8AXogvZdqaCeWy+MVw41TCx
         ZNM4dXQPZjJUeLHrT42LJI97cWGTl7jf4xWmJev1dH3wU/fgAMe8M+DWabH4fK33AWtL
         lxPrgD8XXw9fJvieCidI+uKuKDZQwFUybwqGn5aOvW/Le60vK+NwEfzrWakfi+WapFlW
         pXlA==
X-Forwarded-Encrypted: i=1; AKwUvBy1bNg6dQXGtZnLNQOKhTOF/ChyhvamzpZ6B1uwNmWxbmpc+gAaPyc0lPcnX4lhXPwOMi/zPg==@lists.infradead.org
X-Gm-Message-State: AFq9FYLv3IYsLYG1egv6wSd2hvMpDCuh9MIAxJ63Bg27Gyu1R928Rg8T
	4ECUzHotHq4LEnHl7qIHXxL0/jS47WFq1FuJFGGrMh249TlBiuiMIVpRGvC/Vsq0KIk=
X-Gm-Gg: AYBFou3Gpkd2Dd3gqNyAw47l285q+XeanUgtk7498t9LD6TqlDHJEQiPdJI1njHMlu/
	AzKBjFY9mUlAVjyXqJ9lu9JhP+J/uFZOnckLMjVjxlxebcKQ6Duln21WADBBcGqku/E6Zt64boV
	PLyGgx3PkrWvl8TMv6VDdUswd7RoaXuIR53NGBpR1izWefDu7CdpIB8iuJj5TpYo9dUumMZ9tmO
	bnSEFJpFJ6POH77SGnrYMJKnmpUavCCJ90CTZNtz1DQK0oVmsebvprTMG6C5mhG7p4YqrD1ijDg
	kD4x5vqF7z5dnn3yEoyC4QTCIp5oQwZr+VlPnJIszIaLwFC722hLASYQfCRS6Z6Q7NzPYt2nu2V
	NGbNW0fgTWsCE1Yu1atJoSm51TLUxmXE+tZINePN9RXuitDNUxgXRzsM94LecsEUYw6GNK1YlQq
	qGAH41YSI7032DkryaFp+Mom4sfw8lu0xqLeev52ecTiQoUUW3YpFJRhTtD5XPu/PAcSE+FBLr8
	diuuy5yshP/oOm3Ze3wxSTJiEXFMsR3WJ8/YXNbe4w/6sIt6Bg1coQovE5SWQFHQ8Iy0+iy+dax
	MlPOlDM9mjXBJpQUBlw=
X-Received: by 2002:a05:6102:3f12:b0:7c3:b15:a981 with SMTP id ada2fe7eead31-7cc17cf0534mr339488137.15.1792078427302;
        Thu, 15 Oct 2026 08:33:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f66ad9sm12986347241.10.2026.10.15.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:33:46 -0700 (PDT)
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
Subject: [PATCH v1 8/8] mm/vmstat: Avoid redundant per-CPU stat_threshold writes in refresh_zone_stat_thresholds()
Date: Thu, 15 Oct 2026 11:33:31 -0400
Message-ID: <20261015153331.1872641-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_163349_081843_71A484B5 
X-CRM114-Status: GOOD (  15.15  )
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
index cb57714539fb5..c671e9669b43b 100644
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
2.56.0.385.gd3acb90ef8-goog


