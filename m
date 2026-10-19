Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866B0CCF2D8
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 01:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cpnp3yMFelG0fvds3XdN1g7x4e9nS7OKWWPDPS530n8=; b=tybGiTCgplAm2p17lm6YX7S5xw
	NEtY7JfsIE+tIVBZ30Bdt8SH2E74zUtHt6y5cVGhVIPC7fXveOxn9vwnWkS8tFImQaM52EP/pOTHR
	DEErcZdoaMCKfa1BRhlL9rYOwUusc8fkpe2/68vEeqoJGbq7P9tfln/Ea52lpZj6sNG41SVUTA0Jo
	7YN55GtbLbCB8QgC61l4kb+gDCsy5P46PlWnVRcxG106T3eVgHG0oTobp5aq4k6heyFoLyAeqHND6
	wrJlEuAFFr2Ka03B0wVtZhQMOQiGFqstcTGviqYwE6GATodUOZpvFywxopWCVXiDqrsocMSpFT+Uq
	d4+2p8iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxs-00000006N5J-1fJJ;
	Mon, 19 Oct 2026 01:15:00 +0000
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIbxm-00000006N40-1udS
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 01:14:55 +0000
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-988bb309c2bso866496241.1
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 18:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792372493; x=1792977293; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cpnp3yMFelG0fvds3XdN1g7x4e9nS7OKWWPDPS530n8=;
        b=MXlJ3YQIkl14LZksByEACuhbOOItU1NyRhwV0/1QDbonoBhSLv/mKiJ9Vvl5jrvZP0
         8IAbW0z67q86JJUNrtvaMdVstBvp+ZvmMtan3H6TRibccHn5ZIxa+AOtrteGR8Ee9bJN
         LmwVCiQHnD+FN1EKTGcPJZbR2xh5NWxnenIxpzQ7g7nei2lC8GmFhkFHyNa/RamZZP57
         HfHZ9c2VtxIzheAluZ99eVWtkunipxylFpxl1yYJPjTLKfk8nN+8RWW4ih3B9Q7NP7nx
         HJh/Ev0c+emqLLLOhhqxUkyoqHIaA52ZQ6YU5ornbZrEiygb5LUns+GgtKl+nbM3pN0X
         qpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372493; x=1792977293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Cpnp3yMFelG0fvds3XdN1g7x4e9nS7OKWWPDPS530n8=;
        b=vJvHJvZVKwyk8rfrtEUIkXtTjv69gwGFEM9t39BPKNBvGnHvLasgOD8Q/77wOSbTcX
         uzbWh+L6kaQF0eMw2c6q00c7yL6ZeEXzp1yFfCsrLxltKhh6GXDFgKsG6P8RjLKW9uIF
         s2B2XOSZdHRBEp6LEmqAvrc4IrbHPQvz0szwaWWD3lhna3knNPw4EBoU4Pavvh3/et5b
         hol8NYtMa6leI6b1BFdjpQD69VCizh+wh9ZuvCmXIROHWfhmPfSffBZUefyqby/rxlnF
         sQl77T3XVSSw+roD1cX20ryhndHuBNMvGpklyWp/WnD7+0VN6gtm3lAL0FkPuVd5rHXM
         TJrw==
X-Forwarded-Encrypted: i=1; AKwUvBxnz/ML6waH3L8hi4PF9k+v+gVqUn5k/D8qbj5qe7OfVaxJN9wg4Z5Cau26VRHANsNmm+gF0A==@lists.infradead.org
X-Gm-Message-State: AFq9FYIS8uDJCHDby4KcKNwS6cx67ciMBJ+sZyvFabZowwS2yYiuxnYO
	t22jvcDiaIui1kd0P+bi/kC8W4l2p6OkZ0dKAPxgphi61daJ3/M1iwrrmuCn8pWzZiE=
X-Gm-Gg: AYBFou31CMAA/7xCrw+GY2VzLh20O9mUvQq1lY93xhZ5yLxcPFZplEVEHZottsRvARC
	myGubMQ5hc5E1Wkbv3R+sKhMI2pDX8jUVjWVkXmv4/5U1MWlMimBckO93GCs73yovB86JTOHWFK
	dCCj/YrXVDpg/y8xGjW21Hlp6hPvBldPU7voaOMK9S2HdRtfV4M6kOi/IqFc0xnrF1PQzaE5j9h
	l7dWnO0AnqAg9PcQEzU/szaCRkJeQqesYM4vCaUOW+eoe+zVYfA3esbpdfHXdy9qAlvO1QHcWV7
	9dPHM2dvZa/T/aOqtzNNOiNAithyJ/1cJD8Nj7DBNPizjMGPBzvqRGmNIGyN7y30WOZggto8bib
	83UUZnCRaPrmCCP33X2Lp5zK7/ZvWotD1HrRsph+2neSexu9ClkFw5VwCsXBLCnG5+ivtifTFLW
	2WTDZN6CdbO2inG4NIhxtbhH8OcK397XDfZ4XkIaTR2M4umY6onUydH2YjvMBCLAsJeyMEXnj0w
	tgc7NEqzs9L6JCQ/Jw7UcwfVFbKIwaV7aCE0vJfez9n1oi7EmEq6GKAVxpp7hApg32UMZV4psYQ
	wD6f9iSHXLnxvP+AIsQ=
X-Received: by 2002:a05:6102:290d:b0:7c7:f976:ea9c with SMTP id ada2fe7eead31-7cc369118cfmr2079452137.13.1792372493221;
        Sun, 18 Oct 2026 18:14:53 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b474b2asm8039142e0c.4.2026.10.18.18.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:14:52 -0700 (PDT)
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
Subject: [PATCH v2 1/8] x86/realmode: Remove unnecessary WBINVD from AP startup trampoline
Date: Sun, 18 Oct 2026 21:14:39 -0400
Message-ID: <20261019011446.834487-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019011446.834487-1-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_181454_503245_6ACBF5E6 
X-CRM114-Status: GOOD (  10.76  )
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

trampoline_start executes WBINVD in 16-bit real mode before switching to
protected mode. This WBINVD was originally added in the 1990s for
Sequent NUMA-Q hardware (as noted by the comment in trampoline_32.S:
"Needed for NUMA-Q should be harmless for others"), whose cross-quad
caches came up non-coherent prior to OS initialization. Sequent NUMA-Q
support (CONFIG_X86_NUMAQ) was removed in commit b5660ba76b41
("x86, platforms: Remove NUMAQ").

Per the Intel SDM (Vol. 3A, Table 10-1, note 2) and AMD APM, the INIT
IPI used to wake secondary CPUs preserves cache contents and leaves
CR0.CD and CR0.NW unchanged (0, as already enabled by firmware or the
kernel). Neither sev_es_trampoline_start nor trampoline_start64
executes WBINVD.

On modern multi-core processors with large shared last-level caches
(such as 504 MB shared L3 per socket on Intel Xeon 6985P-C), WBINVD is
not harmless: each execution flushes and invalidates the entire
coherence domain's caches and takes ~85-115 ms per CPU while disturbing
active workloads on online CPUs.

Remove the obsolete WBINVD from trampoline_start.

2-socket, 480-CPU Intel Xeon 6985P-C (N=479, mean of 10 runs):
  Offline:  40.40 s -> 40.46 s
  Online:   65.83 s -> 11.14 s (-83.1%)
  Total:   106.23 s -> 51.60 s (-51.4%)

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/realmode/rm/trampoline_32.S | 2 --
 arch/x86/realmode/rm/trampoline_64.S | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/x86/realmode/rm/trampoline_32.S b/arch/x86/realmode/rm/trampoline_32.S
index 3fad907a179f..14e56ea95416 100644
--- a/arch/x86/realmode/rm/trampoline_32.S
+++ b/arch/x86/realmode/rm/trampoline_32.S
@@ -30,8 +30,6 @@
 
 	.balign	PAGE_SIZE
 SYM_CODE_START(trampoline_start)
-	wbinvd			# Needed for NUMA-Q should be harmless for others
-
 	LJMPW_RM(1f)
 1:
 	mov	%cs, %ax	# Code and data in the same place
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 14d9c7daf90f..e5a3f03d6221 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -60,7 +60,6 @@
 	.balign	PAGE_SIZE
 SYM_CODE_START(trampoline_start)
 	cli			# We should be safe anyway
-	wbinvd
 
 	LJMPW_RM(1f)
 1:
-- 
2.56.0.176.g3575e65682-goog


