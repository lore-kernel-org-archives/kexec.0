Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AC7EA3C30
	for <kexec@archiver.kernel.org>; Thu,  9 Apr 2026 10:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xOrV9v/5kxkZp0KXqbx4oj3rerkVpVOAiY3HoKygQhQ=; b=f1ByXPi1/3JglGnceTE7XD7PPw
	nT98Qo/3UblqerlPfVK7axX6OkEdsz4QVzwys0WADQC960KWFJcsCCIBiqNB2aZJaSWwMYxxc4TyL
	/gCCIFmyNkKIkrnRlRighnNfgdn71YPmRQWVQlLKgH99lPF+sWy7cL+mgJxJn0TG57zMFb6ndC3yC
	xt/ujT2JfPW5qeeffWW3mfIETutNVetDly6WLudlVRQM1fKdtIjZHkqzFFvGnLqUwo+xf5zxkdTog
	PGg2dsXv6sgO9PNqFXT2LAbsDHHwToGryJFnIxXVxRTk7FDdrdSHZPnoEqIfLzkWFUCnlR6WccawY
	JCZXCyJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAmhb-0000000AAHh-3ScK;
	Thu, 09 Apr 2026 10:33:35 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAmhZ-0000000AAH5-2shv
	for kexec@lists.infradead.org;
	Thu, 09 Apr 2026 10:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=xOrV9v/5kxkZp0KXqbx4oj3rerkVpVOAiY3HoKygQhQ=; b=POD5uUIZoOTuiW6NvSJFl/al3v
	kyctPd4Lx/snwwcr/OqX+VbUyglwKdUwj0ciLg9yugoI4LHruQFZ0D48BQQgUuklW0ooaVYdccQmQ
	SGO9l9h1JN75E+YI9fSuGs0erYD8q6edi1YeGPneeukROmKLcaWVcM2XnMUcbx1oCb1aU9NaAjPbt
	eCQ4d89Vu18CPNmDxRxBx+tr/ObTfbu6R1z1DWKcL2Y3Nz0t0a6oLjIb+fyqXCRWdVhy3g7OYOApk
	JqtLIV99moAa5pGsv/M3k5JOrbWHa6IqpaTMG4tQ2iwZqOJcnkgkP9oxnLq94nMP1DTYcjC6E95tF
	xpOa63EQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wAmhM-0098a8-2h;
	Thu, 09 Apr 2026 10:33:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 09 Apr 2026 03:31:40 -0700
Subject: [PATCH] kho: call kho_kexec_metadata_init() for both boot paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-kho_fix_merge_issue-v1-1-710c84ceaa85@debian.org>
X-B4-Tracking: v=1; b=H4sIAAuA12kC/yXMQQqDMBAF0KsMf20gihWbq0gJiY46LWrJ1CKId
 y/a5du8HcpJWOFoR+KvqCwzHOUZoR3DPLCRDo5Q2KKypb2b17j4XjY/cRrYi+rKpguxrqsYy5D
 fkBHeiXvZrrV5/K1rfHL7OSscxw+z/pjLdwAAAA==
X-Change-ID: 20260409-kho_fix_merge_issue-dab886bb4a15
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=leitao@debian.org;
 h=from:subject:message-id; bh=5TlKEPR92vw6WZwmmebWNqLJax06gARkdAVbmtTdh6M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp14BtJdPwc3Hpzi3uZYw2/s/qlNiR0GbkZVNEi
 dueDjuqzMSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCadeAbQAKCRA1o5Of/Hh3
 bco2D/9u05uwdj+Zbie+rIxz6AQMsA1kX0NaBwLKkxNj9ytJ9DyIXCbjq7jiDnQBplZD/5iQtIW
 72teRKZHY3ubuCjx+uIA+cvy4Q8tGAFF7IGuuoxcCKfmHl212FOE7VrCv1gfEadMC38KuldqLFm
 S18mYegdvopvZ8sqiTt4f8owggEho98Aw4PNIDmw0ZMH0Ncrltt1Q9r41GCO/fO1krw4BbbaMnb
 2USc3JZz/oCKTX4gIIQzH52AwFboEWYHnuH1WY+XSe/00pUuq1Z5rgaaPQAWPau2k/jz+oViwhF
 +Uv2uRgkBnyAF7AdUkTJQi6dOAmmoqQytIFtfRxHqdOOENgIbeoylRNVc38kPa6N5zfaJsQC/EX
 8SQHQLFzCTG5ag92i1Tup6jMZIn4BND9lucvnOvWw04kDaqM6Rjp6n8ns8Tx1kQKXtcBw7Ell/u
 B6/Gv2uQxBFfaJwRW/qg+9XmhyT8IUvHFzpyd/C2VVzQnBUgq1WzYM1fIlAFJ59XYjCZBtiWtGm
 /JjsrcWr3WRNysn/zkzPIF/yspzBHoLSPwS2JS9TyGcyEsXeEP6pmOuMtlBYrpQ+k7Hry55zln6
 FFSJrtjH17appPImq9DT1f4jSNVkY7G3C1WmgY/9xVGRC6hxaLZGb4nPzuee6ayBSLXS3Jng7Fo
 dN8ZsreJPOFjWHg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_033333_736225_96B16090 
X-CRM114-Status: GOOD (  12.24  )
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

kho_kexec_metadata_init() was placed after the fdt check, causing it to
run only on the fresh boot path (no incoming FDT) and skipping metadata
initialization on the KHO restore path.

The original patch[1] was based on commit 5c9e55fecf93658 ("Add linux-next
specific files for 20260312"), which included commit d7176a010afce8
("kho: fix deferred init of kho scratch"). That commit has since been
rebased and reworked in linux-next, changing the code flow so that
kho_kexec_metadata_init() is no longer reached on the restore path.

Fix this by moving the call before the fdt check so it runs regardless
of whether an incoming FDT is present.

Link: https://lore.kernel.org/all/20260309-kho-v8-5-c3abcf4ac750@debian.org/ [1]
Fixes: 047117e78331a ("kho: kexec-metadata: track previous kernel chain")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/liveupdate/kexec_handover.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 5e8206235d99e..94762de1fe5f0 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1519,15 +1519,15 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
+	err = kho_kexec_metadata_init(fdt);
+	if (err)
+		goto err_free_fdt;
+
 	if (fdt) {
 		kho_in_debugfs_init(&kho_in.dbg, fdt);
 		return 0;
 	}
 
-	err = kho_kexec_metadata_init(fdt);
-	if (err)
-		goto err_free_fdt;
-
 	for (int i = 0; i < kho_scratch_cnt; i++) {
 		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
 		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;

---
base-commit: db7efce4ae23ad5e42f5f55428f529ff62b86fab
change-id: 20260409-kho_fix_merge_issue-dab886bb4a15

Best regards,
--  
Breno Leitao <leitao@debian.org>


