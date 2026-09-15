Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2456C88E7B
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KFGAjcgsBNZUtMlZjlNuj+eLmu5d+vEUzhR99IX1VDA=; b=dDhH3A/OcJ+w2eocAj58TSE6sh
	oj4HZBsb7b2y4xQKLiEIqQ/sSTywMjwMjX4bbmwwCO+acuzEQYnLhCTSKVM4fFzzuREooVWDQQnpw
	Qq35Mi1tLq6QO8m+IWJ5dRmDuTpLawvgHWzmEiGP3RhnLLU98qc9NbMI7qniFQHcvyNEa5iYKF5qc
	6v7Zo4Jl8qPj7ZrsW6BKdqDHQOc9Ay11b2U29H3kaX5acKpzG9KLXck//dJD9N1YYyx0JgpA0vjzJ
	+qjFS+LD5bjvP+9E+Zh1g24RhpDPth6QVIyn0Mvwr47pomuu67CEOhMRPNPd92ofK4m4uYRIACi07
	UQYWXVHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Sge-00000006cam-2oeH;
	Tue, 15 Sep 2026 12:55:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Sgc-00000006cZW-2CdM
	for kexec@bombadil.infradead.org;
	Tue, 15 Sep 2026 12:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=KFGAjcgsBNZUtMlZjlNuj+eLmu5d+vEUzhR99IX1VDA=; b=mO8sBm6rBcCd7VVy4Dc228Pp0g
	PUUMFgukLVRnM2kvpEB42t1fGdbcY0E4L8nLA43c+/zsqZvx2WQ4Q/W5UdCsLNTW5MhmUIZAdXu+i
	RZbaiaJkbNcyeN/MDNtU9dezM+MJuL7jvdk5r9cmwCA7k37CPqOFDlUmlxOMOIvXZisSWxe9/rOF8
	DqUex2IgjAyJo0uq/jR+NTf9ZN8tOJnTcRH1Pw36x+3rZTdFhZAuES7Vl55VBHaKBQU+wmZd1m553
	7zm/0t0G0MNwjKc4gfiOPmgktVcd0muCKi5oXM2ill3CB7nZtgdRfFXaOpQtwpnUoJ7cw4zn6yOMQ
	tZ42oOGA==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6SgZ-00000006lvJ-3UaU
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 12:54:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=KFGAjcgsBNZUtMlZjlNuj+eLmu5d+vEUzhR99IX1VDA=; b=tthTfBN4x7zCU7oGsVV6Szsvt3
	jvEGAStFY3aByDpkFQ5VIXyHuEyyUNEGE8yGXVKQj1L8z+KaXwyg9EwFNjUaUaS/AtU47uM1fItm4
	WNYOH43FOfWuHSCwAI6seskU41IGUBS/s2Nvdv9mmSkUX2gx+A48JVhqafzaIwX5Q2o0gmOCa7J6/
	ITl+/NOqiGF+m9GDu6J2gzFRWbEEFJe8Yp1cuELMtoUWTSWgdja9ke2cHVwcb85jm09nAmp0vav+i
	UbM7uQ1VJHTBD86CwMtdGVcHr78GZTF07OnczSRjppPZmBpNj6OTeGtxnvfGyEs2Qc0UU1b69cwPg
	15mtXdIg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6SgN-004P8C-3B;
	Tue, 15 Sep 2026 12:54:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Sep 2026 05:53:40 -0700
Subject: [PATCH v5 6/9] mm/memory-failure: efi: answer whether a range is
 poisoned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-hwpoison-kho-v5-6-3bc7a57bd503@debian.org>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
In-Reply-To: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, kas@kernel.org, 
 kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 hannes@cmpxchg.or, shakeel.butt@linux.dev
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, 
 Breno Leitao <leitao@debian.org>, harry@kernel.org, 
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2450; i=leitao@debian.org;
 h=from:subject:message-id; bh=i08dYaHI1fvoon+7eeYigKp4zMx+PElqpyXpuKwzxk8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqqT/embGYYuss6ak1wnwb0KANA/8FHnDgmX1h4
 yqoOR7u5/GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqk/3gAKCRA1o5Of/Hh3
 bdAqD/9H0G93KgtP4UxtzgrruldA6BytJMy0AZ6jAhasSf8Xy51dKJbfJUkHr7TKK2A/9p/lW5m
 jws0OZ2Jh1HezfvwYd+6NvlKCOa+QGaJnDmH6HqzVpJC2ZlumNgcZ3RNcfpfw+4W+mh6vny5/iZ
 0fvgOwqc+HRut7kUs/auiQbJGbqAU2fCfUSdkKIRVUPSgw1nNzJyir+kgdj4l1k5h/xt630UA0E
 j0CbE9MU7zcmubN03NhUszPfN16ZKJTuxCjS7i2ZjLsnbWNJyzIJ16ILdTbVwPw7Fb2EgLJzFXS
 3pIug07eedNDCbACtksMxD1viJqIoeGbS8a+1ltS6rbYv06jp6kghZjmPViI+rTWQrBD79maXZt
 ZUMgXjcdw+MhWAxCbeLoreCBlQcOKru/nzd/T10zivH86oljN2CnnTDe3s/uUhVqJqmIL5MqaBU
 WI2IkZreup6BBbcP7ECZFUW9EWEGEdV4JeU02oE/OqL+tucY2LGyeurRFz34tQs+bJl7hepbsO+
 2Z7o3h3vo52+4AEnCR44nK7x6TkZSDgVEF+0/sF2ay4niRqriVVCTDeazUUcTCf2GjooHeBWvt6
 yuXaXrYH6gutAekaiv1f3EOttoKg1VkUvmDxRic4Rm1mQq5MbrIAloJxWAKRhUlKq941oiT4yU7
 LHTs6WyqCVbzWDQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_135455_958208_71DE7DEB 
X-CRM114-Status: GOOD (  14.05  )
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

The bitmap an earlier kernel filled in gets in this one through EFI,
but nothing reads it back yet.

Introduce range_contains_poisoned_memory(), which the page allocator
will use to ask about a block before handing it out.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/poison.c | 29 +++++++++++++++++++++++++++++
 include/linux/mm.h            | 14 ++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
index 847592862f01d3..4e5cad0d1b9b65 100644
--- a/drivers/firmware/efi/poison.c
+++ b/drivers/firmware/efi/poison.c
@@ -101,6 +101,35 @@ static struct linux_efi_poisoned_memory *efi_poisoned_memory(void)
 	return phys_to_virt(efi.poisoned_memory);
 }
 
+/* Does the range cover a unit an earlier kernel recorded as bad? */
+bool range_contains_poisoned_memory(phys_addr_t start, unsigned long size)
+{
+	struct linux_efi_poisoned_memory *pm = efi_poisoned_memory();
+	u64 first, last, nbits;
+	phys_addr_t end;
+
+	if (!pm)
+		return false;
+
+	nbits = pm->size * BITS_PER_BYTE;
+	end = start + size - 1;
+
+	/* Clamp the start into the table, but keep the caller's end. */
+	if (end < pm->phys_base)
+		return false;
+	if (start < pm->phys_base)
+		start = pm->phys_base;
+
+	first = (start - pm->phys_base) / pm->unit_size;
+	if (first >= nbits)
+		return false;
+
+	last = (end - pm->phys_base) / pm->unit_size;
+	last = min(last, nbits - 1);
+
+	return find_next_bit(pm->bitmap, last + 1, first) <= last;
+}
+
 /*
  * A bit is never cleared: it stands for a whole EFI_POISON_UNIT_SIZE, so an
  * unpoison cannot tell whether the unit as a whole is good again.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 274fa880077c54..b68824fcfbef19 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5387,6 +5387,20 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 	return range_contains_unaccepted_memory(pfn << PAGE_SHIFT, PAGE_SIZE);
 }
 
+#ifdef CONFIG_EFI_POISONED_MEMORY
+
+bool range_contains_poisoned_memory(phys_addr_t start, unsigned long size);
+
+#else
+
+static inline bool range_contains_poisoned_memory(phys_addr_t start,
+						  unsigned long size)
+{
+	return false;
+}
+
+#endif
+
 void vma_pgtable_walk_begin(struct vm_area_struct *vma);
 void vma_pgtable_walk_end(struct vm_area_struct *vma);
 

-- 
2.53.0-Meta


