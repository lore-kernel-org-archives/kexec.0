Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CABCD5BD0
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 00:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cpp3h87G8qknuAl35zSdpszjamPTiyZ/dw7XF2/OzTk=; b=tpMuiZ37VUJ7vbwf4tZ35RDs/n
	eiZs3u4sPMQnX5BDhN+HWzEDfB53sU3R2vwF49mxoGt69P6X+PPEK8aev7EajESDMqVP8KITxd7V2
	mCs1dtAIyamWPNZBN35bT8I7h+P/NoV+CIh8MjG1b9NMmYst64TIiooD4NUizi3MgMsYfJOZcTdNE
	IGEw3+FfJ1xj6Ayp7eKHgBCTc/JPzsjpyXw+J1ekW/e+274zrGfsX6QH1FlPi7kV0Nv9JhUa/MSYv
	9I7/zQNKrvkcmVu64Ub0azcKhgpENhC9wBsvIVvLnn1ZUffSskXyZ9wcJbbqRv9ilnnAnSu8EPwZR
	cT31XRkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOqD-00000004t74-2TQJ;
	Thu, 28 May 2026 00:43:17 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOpX-00000004sGt-37Br;
	Thu, 28 May 2026 00:42:37 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id D7DDE20B7187; Wed, 27 May 2026 17:42:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7DDE20B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928944;
	bh=Cpp3h87G8qknuAl35zSdpszjamPTiyZ/dw7XF2/OzTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PIEHqNECP5CTqhXoOkn4rDFNUhRk3G8ySSEWPLqOtUqj80vbwQHXMFlUQhyAXL6nk
	 Lkhsmhg721K+zYQEUnUOCDla7QLptnzUdto/HtBqJ3+Y+YsgwYNi4ynRenpctewPNA
	 Xaw+l3dqh3iNA2xMzdvnzv7XVsaBKTonUE6FHXyI=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 17/20] hyperv: Reserve crash MSR P2 for page preservation root PA
Date: Wed, 27 May 2026 17:41:59 -0700
Message-ID: <20260528004204.1484584-18-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_174235_835134_231479C9 
X-CRM114-Status: GOOD (  13.21  )
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

The crash MSRs have no formal semantics and nothing depends on their
contents, so the register assignment can be reshuffled freely.

Reserve crash MSR P2 for passing the KHO radix tree root physical
address to the crash kernel for MSHV page exclusion during dump
collection. Stop overwriting it in the panic reporting paths.

Move IP/PC to P3 and SP to P4 in hyperv_report_panic() on both x86
and ARM64. Remove the P2 write from hv_kmsg_dump().

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c | 6 +++---
 arch/x86/hyperv/hv_init.c   | 4 ++--
 drivers/hv/hv_common.c      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index e33a9e3c366a..b75337c4892d 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -185,9 +185,9 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 	 */
 	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P0, err);
 	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P1, guest_id);
-	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P2, regs->pc);
-	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P3, regs->sp);
-	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P4, 0);
+	/* P2 is reserved for the KHO preserved-pages tree root PA */
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P3, regs->pc);
+	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P4, regs->sp);
 
 	/*
 	 * Let Hyper-V know there is crash data available
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 55a8b6de2865..cd75e2be19b2 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -675,8 +675,8 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 
 	wrmsrq(HV_X64_MSR_CRASH_P0, err);
 	wrmsrq(HV_X64_MSR_CRASH_P1, guest_id);
-	wrmsrq(HV_X64_MSR_CRASH_P2, regs->ip);
-	wrmsrq(HV_X64_MSR_CRASH_P3, regs->ax);
+	/* P2 is reserved for the KHO preserved-pages tree root PA */
+	wrmsrq(HV_X64_MSR_CRASH_P3, regs->ip);
 	wrmsrq(HV_X64_MSR_CRASH_P4, regs->sp);
 
 	/*
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 8a593117e9b8..ae6415f42f25 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -212,7 +212,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 */
 	hv_set_msr(HV_MSR_CRASH_P0, 0);
 	hv_set_msr(HV_MSR_CRASH_P1, 0);
-	hv_set_msr(HV_MSR_CRASH_P2, 0);
+	/* P2 is reserved for the KHO preserved-pages tree root PA */
 	hv_set_msr(HV_MSR_CRASH_P3, bytes_written ? virt_to_phys(hv_panic_page) : 0);
 	hv_set_msr(HV_MSR_CRASH_P4, bytes_written);
 
-- 
2.43.0


