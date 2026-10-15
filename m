Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5470CC6B39
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imriAKslpKmc2rOuduOVfwOSxXiBTlYDccI9fjTDxi4=; b=Lr6jkp/FE71nrHzYIe+1wxgrUD
	qsrx3f33ydfeCOgqazvj5MB4P27YoYxrdzAtqRs1ISBkK6re5tmhxQt7UkwgsmXE3ti5ioZxfMuB+
	vIw4bmvAkbh7rCEylmnZbh4kczr/RlJ6W19cojbE5NqA2M/YVsMoKS26mgBTV5vaI+yYzeGhixVC0
	btZAQpz7qPRLPaML4eCn/PoEAZ0MnzmC0CDhFcfv52yq8NZKn/3CbzzyZS4AcNBLaOUMsPjqeOgeJ
	l9w5XGn/lcYXlPhvY0weS/hssbLDL7mWndGYgMuDR6h2Z9mjf2vucgMhBDBh2pXBgBqT83N83nj2z
	34k16E/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSi-00000000ZTs-3HJl;
	Thu, 15 Oct 2026 15:33:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNSg-00000000ZTF-2r6r
	for kexec@bombadil.infradead.org;
	Thu, 15 Oct 2026 15:33:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=imriAKslpKmc2rOuduOVfwOSxXiBTlYDccI9fjTDxi4=; b=f0tOjcG20KoqY3zjUi2NV9HLVb
	lCTvqbMa15hHUPsp1iiuGnYmZwP4n6Csiistgv943V566NXUTF4/Uay3etBrT9e2vlMf43vP2xG9n
	z5YJDXy69FV98SSx5UuUYlQRmNMEbCRbwVtG7JGa+iaRrC0o9PCHmvYn7Dg6G+BnuXSArWoPUFWzN
	m2wnQ1pRRk5JvRK1OrhmsDkVHVYy3CQpUvt/80syAN3LtnQTkVH4JvyKPS1b4Nb68cGtQKTegJP1T
	2yk4IN08lgBn4ervMndAlPTEnc7sf8qj7fBfTngRwpauM5HW0yCtuBOMa9f3uHqyoCUncIjhuZwps
	9t/DPd/A==;
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHNSd-00000000YPM-1zUU
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:33:41 +0000
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-9907fa1d2d1so92931241.3
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792078417; x=1792683217; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=imriAKslpKmc2rOuduOVfwOSxXiBTlYDccI9fjTDxi4=;
        b=AL/S9gYNfWatnzcecAsxtQCh4ipeCFAcX+USbFzCnN2jmip/t7qrn8fCkuWAVXIX9X
         f15fkBCHFOf+6Q3QIsqHSwaWa3fptT1wfmDijo1x26SEELkO1bOs6vjOWSpR8ZRKFzN2
         /PyPSWdPrAWOB9XLJEGvkal4h+64y9kw4JlLh7jUlkJdeBAYCaQFFDJeIWc5PIBB4jCa
         ZTNGg7G0j1c7WVQhO2R5/ajGr9H3fw/trzRSN+sRmtCMEM0RKG862UqXmFA3I1B52fbA
         QdavuT7UuZmGulTwKLS1eNAf//U2ENW6EpWngrN3tL3Q9fBwfW16nAzSaI4MV/z2Xo9M
         Cs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078417; x=1792683217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=imriAKslpKmc2rOuduOVfwOSxXiBTlYDccI9fjTDxi4=;
        b=vXh3g2WCIclVXx2nbXvsczw3QRJbIF9fn7RFMjjCFwG4aCGWnacc0Goo1L3HtAurmw
         bekW+Rp0H2z8DgxZgvwd2mN1tyU4/h71nLzsWrHchFRrc5ds6ysNknbcf8ou8DTDa+Yx
         4m2ie1PFHT8E0xdBPf733f5aCluYjoDtoKIqNQ1vxYSVJalsn2rK3MOzpW5pp9HexNTT
         L/ekEJgIbC2PZTvTp89ywHTnjxZSzIZxh7iBjHfaWZUltW/hl014sgcVmhwdmmskk6Oc
         VqZA0cysTQwafAL79YlrhlemQQv1/3FooYP1vwxsDTx/LB/uATpgPXhii6xikiTmeCIQ
         nYGw==
X-Forwarded-Encrypted: i=1; AKwUvBw0MiPoImvwuQm5lcZOI9oLzWLS0TUiGsBd98dPLWkVMPQCv1gDvyNejfCgNa9LdQIGCPP09Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYLev51yK+KTJMx44RtSNu7V5Ts+xOKebKlRMlXxcVTitSu4O4Ml
	O6B1xUfuEH8I4FTZ16GYy2b4WSavBsLyyDwo4rnj4il9YiDUgkIV+S2cKR+qBsnhClw=
X-Gm-Gg: AYBFou3yLnRWH4z7CA0nDPL9m1r85vH7DcW2OMtCTYfIACU7GyAd0kAdBkit7iHRnvZ
	epKXTeweNUb5JfBD17BWItWtBqGc+6X06I++XEUeM7h41JwIvuRvBfNRSQ0NmQl5PZsbJES6ilV
	8NzdRadr1gY2wUKdR4GxWPCK49srmBD87KovDLWEdBmv9/9I4Lh3hINasodevhthNwOlj9ib/Df
	E4GnyLAS3dpfTIC/mmN/YsyekBiAiPY2zKVSAksoDHX1GgPvATTdVDIVj5cOU686ErjD6L450ik
	/BChxTQxyEfJY8Qez9aMI+mMVl1B/uD+r2Fsdkc+sYjF3vUqlc+EbvibpHt/Ino0Vy/9KvNCOxd
	UEPTF/tTQkD+y3KY0BboPhj/Tj4x7BZ/0q/WIah+HIVdEk1fJw/WYzqfU+pNv6+Z2KsfDjeUqPC
	KN5jtwRekgWdoCkv0BXiUgRFWsPlEoSUJXOYk8w1fOt6YrbQc/ZJgd+EEbm6051LssZbBd0NO+W
	iQhGRDesdDb8RjQOLhblt8nbJT/Mvww+j5ChjJiZVQLR4A2lTvDMgFgy0t4mTyBXBQf5jbh35OW
	kkUBHscsvi8Vc8kSyUp7
X-Received: by 2002:a05:6102:441e:b0:7c3:263c:511e with SMTP id ada2fe7eead31-7cb36989716mr5308286137.3.1792078417340;
        Thu, 15 Oct 2026 08:33:37 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f66ad9sm12986347241.10.2026.10.15.08.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:33:36 -0700 (PDT)
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
Subject: [PATCH v1 1/8] x86/realmode: Remove unnecessary WBINVD from AP startup trampoline
Date: Thu, 15 Oct 2026 11:33:24 -0400
Message-ID: <20261015153331.1872641-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_163339_616432_89C51CC1 
X-CRM114-Status: GOOD (  11.79  )
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
index 3fad907a179f1..14e56ea954160 100644
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
index 14d9c7daf90f4..e5a3f03d62217 100644
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
2.56.0.385.gd3acb90ef8-goog


