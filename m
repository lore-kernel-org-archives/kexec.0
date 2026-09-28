Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136D60A3813
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mtrNrUo/;
	dkim=permerror header.d=jaseg.de header.i=@jaseg.de header.a=rsa-sha1 header.s=fm1 header.b=f4Jdeeeb;
	dkim=permerror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha1 header.s=fm1 header.b=ONnaoMW+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJz8EQpPkK5dirGHjixLblXPE0Wssy9Pl4MCLZ0+6fQ=; b=mtrNrUo/lKdGyAL6Hej/OpkQuA
	6D7fRK7GutiY8XGhe0Wv+71UIGdNg6bpqNsI8roKeUIy8p8cUFL640xbXmffaHvztYiSTgUTsaBG0
	EARnfiYdiegtzYvsZ8hGIL75nA0vTxdldd3hXIcMy4T21ogtd70+0i8DAckHvk8kc8iCDV/aVYQoy
	rnZj2yzK/yk2df3zjWsRdvRrnnUk6MeVsvWbpegietbKoYFD8RV3unCse+6sPlQBS8/p6Ic10FPQs
	kKaHJkI4kqHmxEIUhqsGVymYx+9wF+tGsZAYRu/ZG9fnwKZr/2KnqbhXpPmmuYu6YF+eeOKCa+N78
	K8V8CXyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ55z-0000000993k-21Kw;
	Tue, 20 Oct 2026 08:21:19 +0000
Received: from flow-a2-smtp.messagingengine.com ([103.168.172.137])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF20-000000018tE-1Wab;
	Mon, 28 Sep 2026 17:20:49 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 7E12213804E6;
	Mon, 28 Sep 2026 13:20:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 13:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790616047;
	 x=1790623247; bh=fJz8EQpPkK5dirGHjixLblXPE0Wssy9Pl4MCLZ0+6fQ=; b=
	f4JdeeebjueKH7ptVPXg9yoUidMKxSR/xbTUV13BYJMixzn8a+agIvN137gLDxLc
	aS7eid66bSbZF7zEHELRYf+urBf6MNb2yAOgQBSIbBbolGwcll0fD4tHkcg3rYlh
	ccXaOfBLATfQa3dl+UKKfKooBH5Bl2Zwn1PKnY2YgqYHFeom9gl/oCCZL9FJyTcD
	3nkjCUYtFgNJbkrT1P97vJZpKPJ6oQeKNSRRFPnrmj/7doWJ2nna1dCBUMyNL72H
	iyrEnXb/8nJfzszJaKuC0w5AuMYhBPBUzb7IL5RbDjxkwgpv70sh37AsVQY6dAzL
	rduPcc0zVv2nD3l4EZKwAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790616047; x=
	1790623247; bh=fJz8EQpPkK5dirGHjixLblXPE0Wssy9Pl4MCLZ0+6fQ=; b=O
	NnaoMW+2zQHkNDVwNrITLkagrR029Br1BAO9nUFTX8lCbpYaC2qU2F4Vcjip+Ula
	Mupx+52KG+ol62sbiSxJTkszHne9+BISMFpSXsNsq6ZRJkWX5A+C9u/IUTi6mYok
	uAi5FcXSUpOWFlXZWQa8423AX1So7GAW72/j7JqKOlp38FvLIsw1JfBKG2wp0mw5
	PU2tWUasXduwhMNiqF63JBuIkN4NirumVvhihC75UcFl7C3Ap9Kued6Kl4zzQ7an
	meBZDjTlFwyl0rwOVBJqxe04FslcT9kI6/1OkBaS+XP1IeYA8S/zBTGM8c79Q4Gm
	s56EnFvtre8X7v2+BKPAw==
X-ME-Sender: <xms:7qG6alzE978dBNRLukxM_mVEgrVOXFiXtAyWffYzCpjwNgnV30TgnQ>
    <xme:7qG6aouhmlgq-mVGa6ghryYHxEfwf8ulLvPjFUDo33_3OkjN5mCfCWur9c7i_TK6m
    oaBTC_RxI5MJVn8bX7Vlq80fgLR3qkEyBUOd4D2TWuL62HsPgu7CA8>
X-ME-Received: <xmr:7qG6armG8LrOEqbbWuGrL9ytqTnHnyy1rsNQCZYPaW9VAPtgwzxkWVBcH9VBJQwa>
X-ME-Proxy-Cause: dmFkZTE3Dtw6IjhE/poi/CDPb5VXEYPNUPEe3rZRr1/3vnluvSNGZwYnc7Od0VEEqw6V8C
    kWRAMYAJAJV5aq+CNT4OFQyy1fVW8k3upxKlO9V7Rt5yUqYEIYE/wijeDPsE7H4gglp/5v
    F6D384IbY5FCBCgoXmGheBdMQQxOBU4ICiAnYejBlRLhJ/CKeqEcgPSAZh68CS/pdW/x+j
    oysMrjjAyGFH6oDZSV+ReHQBDpEH3XjCRs+r4WEsyv+LCLa1ZQRyjrSR6cKgS0Pi5Ve0FP
    CSaf3rI2+ul2/rPFwdCO88CC3NXOaOC07b4Jq2/gPXxONS3ydc229KCVcj4zNvzLHbXFfR
    eF4x0mLD+Fcfbzuser4/iLJZt8Fbokzu1nzs2ppJ4QnO/tS8WSt8700vWuD+S0oklObrCZ
    eYUJXuXrVgCNBCBdaN07KqmODR19hbi8nuGl2UeTd1BMVfWD0zHPP2oNak6KLD0VPoNxRA
    3Ak2HOrZ1IVBIqFUI0Ae4j33l6nDbJZlRWS9P1AeDiwcepSkX4qgDOR1DzF3eI0JfDzXGb
    llEZJrMALOTu1I8Ke0lJQ99N1YvgfXf1A2PRoxOzk4hanz1XgNFkkehoH+rc6/TY1L0mx6
    aNLkbSjOj7d4l8vP88bPuGlxta3VDopv7l8wJZXPSTS1TxgdetOYLw9Gr3OQ
X-ME-Proxy: <xmx:7qG6aghCTTcvhFpjk8LCnNnfEzxbJxFnnuuWYAeYa-YLH4YUzHbUvQ>
    <xmx:7qG6ahHzIjRNQA6Z0Bccd6_bi4pkkyrffh9120ESI4juzY9MmRMgGg>
    <xmx:7qG6atN5TbDRD3GLUL4DjcKB-z281sLaNyhV79ElVGm-UARn8iTyRA>
    <xmx:7qG6as0CG56dy-xqVJHMlukxHoSqQ2SjzGkRNQhFIaTJCurJkhaKbQ>
    <xmx:76G6avDdeuSydoAaX6v9kdMCGrc0KNeoZfiEobVCpMGbamPVv-bmn3LI>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 13:20:26 -0400 (EDT)
From: =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
Date: Mon, 28 Sep 2026 19:17:56 +0200
Subject: [PATCH v3 08/12] mm: Add VM_CRASH_MARK
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260928-crash-memaction-upstream-20260921-v3-8-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
To: Jonathan Corbet <corbet@lwn.net>,
  Shuah Khan <skhan@linuxfoundation.org>,
  Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>,
  Saravana Kannan <saravanak@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
  David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
  Brendan Jackman <brendan.jackman@linux.dev>,
  Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
  Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,
 Alasdair Kergon <agk@redhat.com>,  Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
  Benjamin Marzinski <bmarzins@redhat.com>,
  Herbert Xu <herbert@gondor.apana.org.au>,
  "David S. Miller" <davem@davemloft.net>,
 Mimi Zohar <zohar@linux.ibm.com>,  David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,  Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
  James Bottomley <James.Bottomley@HansenPartnership.com>,
  "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,  Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,  Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>,  Lance Yang <lance.yang@linux.dev>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
  Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
  Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
  Matthew Brost <matthew.brost@intel.com>,
  Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,
  Ying Huang <ying.huang@linux.alibaba.com>,
  Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
  Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kexec@lists.infradead.org, driver-core@lists.linux.dev, linux-mm@kvack.org, 
 linux-arm-kernel@lists.infradead.org, dm-devel@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_102048_472915_011AF5A9 
X-CRM114-Status: GOOD (  13.32  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:06 -0700
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a VMA flag saying that the folios mapped into a VMA should be
described to the kdump kernel through crash_memaction. The flag
indicates "marked" pages. The specific meaning of what pages are marked
is set through the crash_memaction= cmdline param, which currently
supports marking "secret" or "cache" pages.

The flag is an ordinary VMA flag, so splitting, merging, mremap() and
inheritance across fork() all behave the way they do for MADV_DONTFORK
and friends.

To allocate the flag, CONFIG_CRASH_MEMACTION gains a dependency on
64BIT. Both architectures that support the config are 64-bit already.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
Assisted-by: Claude Opus 5 <noreply@anthropic.com>
---
 fs/proc/task_mmu.c   | 3 +++
 include/linux/mm.h   | 9 +++++++++
 kernel/Kconfig.kexec | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c0d228036b8a..880946edf4df 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1161,6 +1161,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #endif
 #ifdef CONFIG_64BIT
 		[ilog2(VM_SEALED)] = "sl",
+#endif
+#ifdef CONFIG_CRASH_MEMACTION
+		[ilog2(VM_CRASH_MARK)] = "cm",
 #endif
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b9ed4f569b75..4ffe6350f865 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -345,6 +345,10 @@ enum {
 	DECLARE_VMA_BIT(UFFD_MINOR, 41),
 	DECLARE_VMA_BIT(SEALED, 42),
 	DECLARE_VMA_BIT(UFFD_RWP, 43),
+#if defined(CONFIG_CRASH_MEMACTION)
+	/* Describe this VMA's folios to the kdump kernel; carries no type. */
+	DECLARE_VMA_BIT(CRASH_MARK, 44),
+#endif
 	/* Flags that reuse flags above. */
 	DECLARE_VMA_BIT_ALIAS(PKEY_BIT0, HIGH_ARCH_0),
 	DECLARE_VMA_BIT_ALIAS(PKEY_BIT1, HIGH_ARCH_1),
@@ -526,6 +530,11 @@ enum {
 #define VM_ALLOW_ANY_UNCACHED	VM_NONE
 #define VM_SEALED		VM_NONE
 #endif
+#ifdef CONFIG_CRASH_MEMACTION
+#define VM_CRASH_MARK		INIT_VM_FLAG(CRASH_MARK)
+#else
+#define VM_CRASH_MARK		VM_NONE
+#endif
 #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
 #define VM_DROPPABLE		INIT_VM_FLAG(DROPPABLE)
 #define VMA_DROPPABLE		mk_vma_flags(VMA_DROPPABLE_BIT)
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 890c35199bea..3cdc8d459ac0 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -189,6 +189,8 @@ config CRASH_MEMACTION
 	depends on !SLUB_TINY
 	select SLAB_BUCKETS
 	depends on ARCH_SUPPORTS_CRASH_MEMACTION
+	# VM_CRASH_MARK needs a bit from the 64-bit-only half of vm_flags.
+	depends on 64BIT
 	help
 	  Track pages that may require special handling by the kdump kernel:
 	  pages holding secrets such as crypto keys, which it can wipe before

-- 
2.55.0


