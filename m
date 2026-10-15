Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798C4CC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j4tKjkoRHQBs/0qfSCONCIuiBtr3cfqRy92h/STkCYg=; b=YMfD2iRLNpWfr5vJMG2qf4wYHE
	3nR4LV0TdDk26jgxOz4DFbOd8YjPBiYZ/PsmpVp3n25tm/5Dlj58fAVU44kb6+rgZi6v8E42WOQCt
	w7xv2n5rnjumv8lY5Dl6K+wGYSJUYM715iqrQ4nKGBCizjrqumdtTwwTljPToG2IGMUaPRSKketJh
	RbwTewP2J6Esz4sCaoMIbkvmCrWGuQOtWumVcojATikUPGOoUyLBPHRA8SHzsLjbuIGO3owmh782A
	oFRH++E7CdMeeAn9Ou1UUkDXxJ9IIAIcBlEqQzOFRmwKVdn3SDS3x9vRcp7xv9vlLkX9RCOmltGP8
	zLIYFlWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSp-00000000ZXZ-0KI1;
	Thu, 15 Oct 2026 15:33:51 +0000
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSe-00000000ZSV-12q4
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:33:45 +0000
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so2640581241.2
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792078419; x=1792683219; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4tKjkoRHQBs/0qfSCONCIuiBtr3cfqRy92h/STkCYg=;
        b=PfHib/sqLBAqFonhs7OGj0QW2GBxbXy2f7z7Pqo+gYUWFfqgwcGlx42rCqKzmBSsZT
         s9d37uramQAwS6O2sk7HnHtETPbim+3n9bvSsiX6VDso2mRrdfZwv2gGhvCccy/Y7WnM
         NA6kg9nVXYyYrCsU3cZPHyu5CriomN1r3q9T1siO2FL0K+wXebrYeCttnkag1uBLxWag
         9HdIZNV8lJ2nbNWYboM8DHEuh4ZaL6OgbFz3bnyTdk/Dlo/01Eko/VC59MDShZoti6gu
         AWxjuuqmKuerGBuxeKdFIdPDRhgorKj104j0fg614/0DIYp9QnHzB6ZD0cEVO0zdqA98
         TJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078419; x=1792683219;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4tKjkoRHQBs/0qfSCONCIuiBtr3cfqRy92h/STkCYg=;
        b=NRMTEzP6tBlL+LeP7xjd3btHAzupsbGSxIkFYFpxzbeGhVktkUgpeNjL226s2dSGnO
         l1o/AetGbNZOQ0qbZYtAvDRDfHz/byEvB1Nl9kOjo85B4sRCy0TOh9h8YT/8T71tkTCQ
         zp+qaix0dP+4NMmlI6dtoFf726idMydGHNagH0xf9jYv563ESdRnezf9PM+3w+4LhGKG
         ijqUleTcD+x3NyuS5FvE0gKaZeMFnUMGigxjyZFrIsDFsjaV/CZUDgTWB+l00yUZh5Yj
         gtCLoX4QTmTfA5SOeuSUmHHe6ADPuw5ghqKHkk5mTWja0NA+gxqT8DVPzI7kmU2ZcPmP
         +s2Q==
X-Forwarded-Encrypted: i=1; AKwUvBw6YyRz3PD1bXGzGOILPHlBxfpFose+ly6XPFvXajn3A4i2z8uK25DperO9lUbiaxLVml74Nw==@lists.infradead.org
X-Gm-Message-State: AFq9FYIVcmNV7Xofg/sj4V9trUGwaxm7YbTHQ+kqhPNsjsdJ7TSFH+Ob
	0P/+8Di3iNq5VGQfJqGosOot746X7zajPt6zns9v+rePFrBf+3HYamxruAtfksw9RMZjOLqWars
	oWnrA
X-Gm-Gg: AYBFou3ifv377r0NYqyBumJVeSJsX4RSJsSIQnxpmIKLoJceSyXDFGuwA73TDno0gqk
	98lG3k1HJ63GRavRUkrCkJFm4fuTVHs0tKIO2wsyT7geV1TNduZIWTqJRaiyGU+tnr1QdEY9HBU
	r0yl9AZBSqfJicNNYuLV/lQZy1+mJZ7AZvcfs1Kth6pFomXLSuc2UMaqYq/v+SGeXQteIkZrdpT
	qF+eltsZcNDzrTaIjJ/2ydT6R3WLKB4FmYwje1pArI2g7EjLZDDx0xtnrMYBnT6exzbCXVBFKau
	IVtHsM/3Vw49V8elMQ56/QBUbd/Ut41lbxB7x196PpL3Er8e3YhbrVp91fn9ipvlFHgcXH9kIsu
	nH1XhyO0HqOA/eVkQXLWd7Bf0Zt/P+j1hsqoUjzMI85Z1cbZghGGoONKNWrX+hQVJ4AaLHfO1Yy
	pTaIIiob2/GCnOQYjqP6BBc2KQ+ihENyL/JYZVZmr7zVzJJaSm774W/hRH1yrKuCQI6YIUvetw4
	DEzL0PkN8udK75JUaD9q+npTRGr6PKt2Je2bnh9EUczhdRe45CbKi0ilrw/1FnqCqjPNln85QVl
	JjI5h66fULE9WvL7pLUsW5VhYHEA9w==
X-Received: by 2002:a05:6102:5110:b0:7c8:448:5237 with SMTP id ada2fe7eead31-7cb3a0e2580mr5832272137.24.1792078418833;
        Thu, 15 Oct 2026 08:33:38 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f66ad9sm12986347241.10.2026.10.15.08.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:33:38 -0700 (PDT)
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
Subject: [PATCH v1 2/8] x86/smp: Remove unnecessary WBINVD from mwait_play_dead()
Date: Thu, 15 Oct 2026 11:33:25 -0400
Message-ID: <20261015153331.1872641-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_083340_333855_ABAED028 
X-CRM114-Status: GOOD (  15.27  )
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
normal idle without executing WBINVD—where hardware maintains cache
coherency while the package remains powered and automatically flushes
core-private L1/L2 caches to the coherent LLC on C-state entry.

During system sleep (cpuhp_tasks_frozen), however, power may be removed
from a non-boot package's caches after all of its CPUs are offlined,
and the sleep-entry cache flush on the boot CPU only covers the boot
CPU's own package. Skip WBINVD in mwait_play_dead() during runtime CPU
offline and only execute it when cpuhp_tasks_frozen is set. Note that
wbinvd_on_all_cpus() callers (such as cpu_cache_invalidate_memregion())
only reach online CPUs, so a package whose CPUs are all offlined at
runtime retains its cached lines while powered.

2-socket, 480-CPU Intel Xeon 6985P-C (N=479, mean of 10 runs):
  Offline:  40.46 s -> 11.42 s (-71.8%)
  Online:   11.14 s -> 11.08 s (-0.5%)
  Total:    51.60 s -> 22.50 s (-56.4%)

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kernel/smpboot.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ba01a9e919b78..60a781dac9991 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1414,10 +1414,6 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
-/*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
 void __noreturn mwait_play_dead(unsigned int eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
@@ -1426,15 +1422,21 @@ void __noreturn mwait_play_dead(unsigned int eax_hint)
 	md->status = CPUDEAD_MWAIT_WAIT;
 	md->control = CPUDEAD_MWAIT_WAIT;
 
-	wbinvd();
+	/*
+	 * MWAIT C-states keep the caches coherent, so runtime CPU offline
+	 * does not need to flush them. System sleep, however, may remove
+	 * power from this package's caches while all of its CPUs are
+	 * offline, and the flush done by the boot CPU before entering the
+	 * sleep state only covers the boot CPU's own package.
+	 */
+	if (cpuhp_tasks_frozen)
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
2.56.0.385.gd3acb90ef8-goog


