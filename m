Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D40C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=txqh/4dMVNkv3jAnEFkWYzpJcEFlwoVpdz1x6TA4rUQ=; b=LTZQDEhURcBuK+5mFHjGXIdBYM
	QbnfI8oWOV+xHjKVnNGY7Fs5FWk2fZdgH/ppd0HFa6b1GBsO/XVfiwU/5QYxUFfYHXWOWhdsIIPaW
	eReHio8Q+XlpF8bxzd3iobK0bQ217HE7QPztgjGwAiPaFg8VInW0p00TXAySPzuFn1IFJxNX1OPS3
	2wJtS5tyq9UHdkNtW76/tmRr5kd13TJ4E9OMwYaUM40Zg5BZrikvh7wXh7DeyEyVcT5H2qMzHGe/4
	EeSUEBV9LOkAFbe7XgonJsZQsoM9pqEpVqZjBjINPX21W5USvZgLcFuWp6RD8QJJ3trzFNMmvqqBS
	K5u2DwBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Sg2-00000006cIg-12MN;
	Tue, 15 Sep 2026 12:54:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Sg1-00000006cIF-2ZLn
	for kexec@bombadil.infradead.org;
	Tue, 15 Sep 2026 12:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=txqh/4dMVNkv3jAnEFkWYzpJcEFlwoVpdz1x6TA4rUQ=; b=qQsoZ1SjtXEQjZUdujjMBuo9rD
	Vqa9q1841ku4A/TfbkP5Xt/aP/+ipLcgtEOcU4CAB3qsSahAdl8KjdlqAUcM6J0e5FHITjHje6B0u
	89CEqJNLBwox/EPE9cPH1H1uTodMEiBP0c4XF02vpOJl9WZV9yzjWsIDBClv00zwVvDxiUF44ZSIJ
	/YPyCR67viLnWmYaVCpUgmZKpQS1ySka2Cgsbkg+6Ov6wdlKEdCAufcPpQmVo23gTw1Aw8cNwSqdo
	ehjF3+oYzWFwFxmmj675mtB0DAKEWvgYOfO+m4R++dd91fukteS6IuB35Si+47WdKVlhX3uBt+6Go
	oeg99AgQ==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6Sfy-00000006lj0-43ZV
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 12:54:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=txqh/4dMVNkv3jAnEFkWYzpJcEFlwoVpdz1x6TA4rUQ=; b=QY0GrUg+hg2FpxWgJ8xxZXb26i
	a40KcG1CY1FLiZgOkpyJzp7DOw1gx1xQpWXRtn5i+i0aRmh548I+laXxHuxipkTKTvSiRNGRa5cCa
	15eEcGqTe1tBJvKRukwl9HWsRnOCulnpK4y+qO0fhIOzcDFrlMZl+0CfRcEvuSOcPBgro4LJ8Yp5T
	+W95tZNqEZYj0PJvLqiJ78uIB6UGaw0dgkHbkpn2unqZVyAM2xLbbEbzam7ULQANjEZAiAHBDlgK7
	ZG96j8aQrDleLqQAt/XRd2xXSUxwLy+Qib1h43v3kLn4zpG6CtscsiWn1xAmBwv68+/Wm51M3Kvks
	hdLJbdeA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6Sfl-004P5U-0I;
	Tue, 15 Sep 2026 12:54:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Sep 2026 05:53:35 -0700
Subject: [PATCH v5 1/9] mm/page_alloc: factor out the accept-and-free tail
 of __free_pages_core()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-hwpoison-kho-v5-1-3bc7a57bd503@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=leitao@debian.org;
 h=from:subject:message-id; bh=QndDTWh5bGLYFpgTzNsBMcjtlSoq6B2ZnR6/EP1pCQo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqqT/e/q5/cYr405F2RzQcKhfWFrisnYG55iAgq
 UvT/67s8SiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqk/3gAKCRA1o5Of/Hh3
 bceTEACgTXdW1ZYLhwiIgzpNy3/tIJlO0t6mQw1xMfw4l9nQV4a9dvbY/XfEh5CoXZ1SxwevYyr
 jYhT3krAmc4hkLt0U0WC3K64jg+VIQ1OpVudj7jjOnaFTFoQCk+Wco/JApTvPg0TXGejrmXZnAA
 7bmbJKaGYUBr0k+GH132hy4tzAGPNsbMghbh0+ZOx+CUZOLCAJ1OW+tW8seGCZ1H1iOZb33i/cN
 yfqd5+3JA5PFya4Rq4iDZ+h+fhXelxujWlvkWhenA1TReHsfprrwXMK5NAlwxaOUqqy2mhKpzfd
 WWyC+BjxTCT1RAF47MCnkAAi3/QAS8UDySy7+N26+WFvGImkuhmkRHw+Fb+yqxmn9erNjh6i2Da
 pkX0o7jatRDIeeA0Tc6nEDsHerPH/Ao+Ph2vjQVWkC42Hy0Criep/Mi5EcLHD16RcBqgbyGCVHZ
 Zmh4ahHaN07+XvCyatxhM9P3MiIQK+etSZDTegputerYeHbzVpCcMCTOkBz2i3R7GmpRoq/7IGf
 u3uZYqGtBbqF5p5463cbsewXIL75U79WBO5rTMPMvegvHF85MkpAbTtQK5N/RZckds3O02TLBIY
 ttKp3I2XptzsAjyHnmWewT1GB5fAUo2ahpu2ryFEAHzvDUf6GoZMUUMxTP39H4en8Sr4iglVSmT
 l5jNgyb+RfmoLoQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_135419_058035_61144D8C 
X-CRM114-Status: GOOD (  14.25  )
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

__free_pages_core() ends by accepting the block if it is still
unaccepted and then handing it to the allocator. The poisoned-memory
replay later in this series needs that same tail for the parts of a
block it does not withhold.

Move it into accept_and_free_block(). This will be used later, when
we need to accept and free a subset of a order-block that is
not-poisioned.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/page_alloc.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 404896b53003ef..b07b5f4751cb95 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1579,6 +1579,24 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 		free_one_page(zone, page, pfn, order, fpi_flags);
 }
 
+/* Accept the block if it needs it, then hand it to the allocator. */
+static void __meminit accept_and_free_block(struct page *page,
+					    unsigned int order)
+{
+	if (page_contains_unaccepted(page, order)) {
+		if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
+			return;
+
+		accept_memory(page_to_phys(page), PAGE_SIZE << order);
+	}
+
+	/*
+	 * Bypass PCP and place fresh pages right to the tail, primarily
+	 * relevant for memory onlining.
+	 */
+	__free_pages_ok(page, order, FPI_TO_TAIL);
+}
+
 void __meminit __free_pages_core(struct page *page, unsigned int order,
 		enum meminit_context context)
 {
@@ -1613,18 +1631,7 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
 		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
 	}
 
-	if (page_contains_unaccepted(page, order)) {
-		if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
-			return;
-
-		accept_memory(page_to_phys(page), PAGE_SIZE << order);
-	}
-
-	/*
-	 * Bypass PCP and place fresh pages right to the tail, primarily
-	 * relevant for memory onlining.
-	 */
-	__free_pages_ok(page, order, FPI_TO_TAIL);
+	accept_and_free_block(page, order);
 }
 
 /*

-- 
2.53.0-Meta


