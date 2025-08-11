Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C70BC87FD2
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D6mDOZNO2M8bgcPUt67qcFUpkk7LTdWtsD73Aun5+3g=; b=XYTA+JpbQodj/W+Tgo8MEnBID8
	07FCpBeR96YSAm0GwDGdFkawgfBDotJgXQXdt5Pz9yfH1khW/zOqucO2uPX3VOwQfpiLSCOBbDXUM
	AVzPMdaOmi4Uywe9pcy2ElG/CR32C22M8OhFhtXopClP+so1sGZd1rJGHmfIY/WrURMfcSF6X/WbU
	I3jn7a/Js10D/fgpJpIryOYY2Bad77lfh8aCIFrYuGhKoXToNWAD3phsz+PfYquYkXcDmjq3+U7Dt
	dDN/4+l+HVltEuF0yAhV5RI0j5rHaISWzUuq8adOTuT36XEjUz6knyc3X2piUO2Yp4eyZdUskC5wn
	n2t4DPMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOHO-00000006utY-47IP;
	Mon, 11 Aug 2025 08:53:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulNqY-00000006qVb-0Ghq
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 08:25:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8BF7F5C5E4B;
	Mon, 11 Aug 2025 08:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E4DC4CEED;
	Mon, 11 Aug 2025 08:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754900733;
	bh=AX4qbF1XwwQU81rpLwIDoyjLFeF3rSGWbifPTbjdHrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBu0tV7SisZJigpGLwfJlV2DUdG+zG1xMTy9xi/TIyeMR5QWWzL0vrHVWTDRyETLf
	 9wif8JusDG/lncKaw75hHOvcdqYqn/hmr+fqPbslLarR0lND4TxrjqOXleCy0VgHww
	 GueKwq1d+VQbbVudmODDZr+IKPx3dEjguWd30pfO49xBo595IUSrVNKUlqaptMEDm9
	 KP31uI9G5AP37tXrvaMBfcsjXU1W0CCSlWIXI4CgqU7P5fOOJ/Xo7AU7E4ynb4fCqu
	 n34r44Dg10BdzEJjqjj3L+enf9CPz3opBOem/pEGx2qDAobHWQmPbtyV9jD4PbU+67
	 7mhcCWzujOfug==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=DFschuh?= <linux@weissschuh.net>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] lib/test_kho: fixes for error handling
Date: Mon, 11 Aug 2025 11:25:09 +0300
Message-ID: <20250811082510.4154080-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811082510.4154080-1-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_012534_188092_6A04E14C 
X-CRM114-Status: GOOD (  15.78  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

* Update kho_test_save() so that folios array won't be freed when
  returning from the function and the fdt will be freed on error
* Reset state->nr_folios to 0 in  kho_test_generate_data() on error
* Simplify allocation of folios info in fdt.

Reported-by: Pratyush Yadav <pratyush@kernel.org>
Closes: https://lore.kernel.org/all/mafs0zfcjcepf.fsf@kernel.org
Fixes: b753522bed0b ("kho: add test for kexec handover")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 lib/test_kho.c | 52 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index c2eb899c3b45..fe8504e3407b 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -67,13 +67,20 @@ static struct notifier_block kho_test_nb = {
 
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
-	phys_addr_t *folios_info __free(kvfree) = NULL;
+	phys_addr_t *folios_info;
 	int err = 0;
 
-	folios_info = kvmalloc_array(state->nr_folios, sizeof(*folios_info),
-				     GFP_KERNEL);
-	if (!folios_info)
-		return -ENOMEM;
+	err |= fdt_begin_node(fdt, "data");
+	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
+			    sizeof(state->nr_folios));
+	err |= fdt_property_placeholder(fdt, "folios_info",
+					state->nr_folios * sizeof(*folios_info),
+					(void **)&folios_info);
+	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
+	err |= fdt_end_node(fdt);
+
+	if (err)
+		return err;
 
 	for (int i = 0; i < state->nr_folios; i++) {
 		struct folio *folio = state->folios[i];
@@ -83,17 +90,9 @@ static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 
 		err = kho_preserve_folio(folio);
 		if (err)
-			return err;
+			break;
 	}
 
-	err |= fdt_begin_node(fdt, "data");
-	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
-			    sizeof(state->nr_folios));
-	err |= fdt_property(fdt, "folios_info", folios_info,
-			    state->nr_folios * sizeof(*folios_info));
-	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
-	err |= fdt_end_node(fdt);
-
 	return err;
 }
 
@@ -140,7 +139,10 @@ static int kho_test_generate_data(struct kho_test_state *state)
 		unsigned int size;
 		void *addr;
 
-		/* cap allocation so that we won't exceed max_mem */
+		/*
+		 * Since get_order() rounds up, make sure that actual
+		 * allocation is smaller so that we won't exceed max_mem
+		 */
 		if (alloc_size + (PAGE_SIZE << order) > max_mem) {
 			order = get_order(max_mem - alloc_size);
 			if (order)
@@ -165,13 +167,14 @@ static int kho_test_generate_data(struct kho_test_state *state)
 err_free_folios:
 	for (int i = 0; i < state->nr_folios; i++)
 		folio_put(state->folios[i]);
+	state->nr_folios = 0;
 	return -ENOMEM;
 }
 
 static int kho_test_save(void)
 {
 	struct kho_test_state *state = &kho_test_state;
-	struct folio **folios __free(kvfree) = NULL;
+	struct folio **folios;
 	unsigned long max_nr;
 	int err;
 
@@ -185,13 +188,23 @@ static int kho_test_save(void)
 
 	err = kho_test_generate_data(state);
 	if (err)
-		return err;
+		goto err_free_folios;
 
 	err = kho_test_prepare_fdt(state);
 	if (err)
-		return err;
+		goto err_free_folios;
 
-	return register_kho_notifier(&kho_test_nb);
+	err = register_kho_notifier(&kho_test_nb);
+	if (err)
+		goto err_free_fdt;
+
+	return 0;
+
+err_free_fdt:
+	folio_put(state->fdt);
+err_free_folios:
+	kvfree(folios);
+	return err;
 }
 
 static int kho_test_restore_data(const void *fdt, int node)
@@ -291,6 +304,7 @@ static void kho_test_cleanup(void)
 		folio_put(kho_test_state.folios[i]);
 
 	kvfree(kho_test_state.folios);
+	folio_put(kho_test_state.fdt);
 }
 
 static void __exit kho_test_exit(void)
-- 
2.47.2


