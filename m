Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE653606A883
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CLgq8sB6;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=MOdWtvWo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:To:Subject:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=t9kO9XGAegdg1V2vmzxAZZmN+Wm2FOyrI5Nk2f8kXVM=; b=CLgq8sB6PdLgOVCNCBDG9cBpBu
	ejRru2yBZmAmZ/I3ez2f4NJdMi5QMP4Jq0dkap5EbQdKislW8jfL+FUmsSYyalnukFAAHp2hnfQez
	wS+DGErqFnmTFw3dT/ja9cisxzFYLbKAribdDu3wPkexLHlH93X9SJ6tDwghcQhlLe0tQsyiX4mMu
	yHzNAC383nnwPvll4hAKJ07XYzI4t3HrLbBFpyuIyv58tYEU+yuWkerEbUSZTKNZh20/cc9Hnfs0+
	Bfy9kiuT9X4W+VWJO6nu5uPbfev3kP/+dDEjRk/8aomxavFgffl153gyOH6YRSBLIL6h0egS+dKS5
	bFDbWoVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHi4-0000000886c-1KT4;
	Wed, 11 Nov 2026 23:26:32 +0000
Received: from out-164.mta0.migadu.com ([2001:41d0:1004:224b::a4] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHi1-0000000884r-2Mlq
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 23:26:31 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=b/8lLMDlwRa4+gznMkDz96CHWdfImhJ5sxzvM1VsIDw=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794439585; v=1; x=1795044385;
 b=MOdWtvWoXkBNJaA4bOpDVYlDcwCRHMWccYHPEbF14qgfh4c/hoMYub9Ykk3C6TU4x5jiOuyo
 QtwZI1Kpx1hB0E/VWP32Df9LYBv63Id4NtJP7W12/dsZQpEW+zd454PRyEn3fj8rVm+xecFZfeU
 6dAsxcEO2SH7Khx3jWWXoWRUcTJv5tXsaJh4AmNCdLog3tU4ljPqfph6wDa39AF8U8NJivVZ1Dl
 LNXOzq7NGhUfzDtRWXclH4mNedpphhvNyidaudP1JiBEiwA1SfAW+muNTi6OdEoNZHGkvXzM2A2
 mzGDMFy5U1DxpaBp1CvBkOyOrkM8b2bLy3GCU7W7rWXcg==
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 4893caac69ce6e85;
	Wed, 11 Nov 2026 23:26:25 +0000
X-Mizu-Trace-ID: 4893caac69ce6e85
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Subject: [PATCH v2 0/2] arm64: use typed entries into copied code for kCFI
X-Change-ID: 20260924-arm64-kexec-nocfi-496e643578ce
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
 Jeson Gao <jeson.gao@unisoc.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Nov 2026 15:26:03 -0800
Message-Id: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_152629_895153_826B7CFB 
X-CRM114-Status: GOOD (  11.55  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An arm64 kernel built with CONFIG_CFI=y oopses after "Bye!" on every
kexec that relocates the image. v1 [1] marked machine_kexec() __nocfi.
This version types the copied relocation code instead, as Kees Cook
suggested [2], and does the same for hibernate, as Mark Rutland asked
[3], so that swsusp_arch_resume() loses its __nocfi. Only kexec faults
today, and its fix does not depend on the hibernate patch. x86 follows
as a separate patch.

Kees, the kexec patch is your diff with two comments and the ASSERT
message reworded. It had no sign-off, so it carries Suggested-by. Send
one if you would rather be co-developer or author.

An LLM diagnosed the oops, did that rewording, wrote the hibernate
patch, and drafted the changelogs and this letter.

Tested on v7.4-rc1 with clang. Under QEMU TCG, so functional only,
kexec_file_load(2), kexec_load(2), crash kexec and hibernate/resume pass
with CFI at EL1 and booted at EL2, and with CFI off at EL1. In KVM
guests at EL1 on Graviton4 the three kexec cases pass, where v7.4-rc1
alone oopses under the two load calls, and hibernate/resume passed one
commit before v7.4-rc1. The KHO selftest passes under TCG, and oopses
at v7.4-rc1. Bare metal, BTI at the typed entries on hardware, GCC's
kCFI and LTO are untested.

Changes in v2:
- Type arm64_relocate_new_kernel() and enter its copy at the symbol's
  offset, instead of marking machine_kexec() __nocfi (Kees Cook, Mark
  Rutland).
- Take back v1's statement that arm64_relocate_new_kernel "cannot be
  given a type hash".
- Add the hibernate patch (Mark Rutland).
- Rebase onto v7.4-rc1.
- Drop the Assisted-by tag. The cover letter now says how tools were
  used.

[1] https://lore.kernel.org/20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev
[2] https://lore.kernel.org/202609241804.BB23BF10@keescook
[3] https://lore.kernel.org/arZSe8hNnRPM5FqY@J2N7QTR9R3.cambridge.arm.com

---
Ben Cressey (2):
      arm64: kexec: use a typed entry to fix kCFI oops
      arm64: hibernate: use a typed entry to drop __nocfi

 arch/arm64/include/asm/kexec.h      |  2 ++
 arch/arm64/include/asm/suspend.h    |  5 +++++
 arch/arm64/kernel/hibernate-asm.S   |  7 +++++--
 arch/arm64/kernel/hibernate.c       | 14 +++++++++-----
 arch/arm64/kernel/machine_kexec.c   |  7 +++++--
 arch/arm64/kernel/relocate_kernel.S | 11 +++++++----
 arch/arm64/kernel/vmlinux.lds.S     | 10 ++++++----
 7 files changed, 39 insertions(+), 17 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260924-arm64-kexec-nocfi-496e643578ce


