Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35831CAC58E
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pPGNTWcfTMCf7LM5UsEIAfkz8s4zcbBDjcuDh5GLSao=; b=NsI+VX6U4j8DeSabaR7b5WmJbC
	X+NfTt4jr9QHLv8AKh7pZZnUT1dUYtWPCCJsSpPC3A6Jj/xkYFoYeDJbciqlvzEVjiapM55qidYU0
	YWkHShmcQWl+xKrlC6iigpsMIsYW7hVkIttz1AYq9kSQINxMQzlwMpmewP2Rob3NfddBZfdyOwMmA
	CYdPyD9tcXwGsAnbbvbgkdXy5CWOX4shFVhr7o2zFulQPo7Pq1FMgoHY2RSOjTP1rYGWnLU87jo3/
	Nu+GobmEl10zNiH+hOXIJWN9HCY6meEkA8pWzIWwjKNNnYPGOBbmDibRMm+UbChCyGXnTIpLRkqeT
	xr7Wie7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw21y-00000008xne-1URy;
	Tue, 09 Sep 2025 17:21:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvzaR-00000007pA4-0sV6
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 14:44:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EE08244D1B;
	Tue,  9 Sep 2025 14:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB53FC4CEF7;
	Tue,  9 Sep 2025 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757429086;
	bh=5rpwGu8/al+jSPVVDiN+aC7cVtsur+Qn+e55fU0YUFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5MFgw81ctwGvYwePgn0tk5D0dAPf1flnsty/cI4NL15pvNkly5f8OUHdx9B9NQgf
	 WZkofDjZ9wOKpW0h5ohIT89geDptp4SKbq7w9YRCuPU8NxKrYxIsLAtFxDzgdC+RIe
	 AnSgoxvyjnsn2jVvpvy2Tn/DXkjKYhcFjRaRC60S9rdwSO7H/cbFpzkOVyZanvL4QQ
	 fQV8/JgmbtLt6mz2D39P+y2IM65bbjWQ4kn7wwKDq6Q/OA42Za2LuhQyHmjSieIUr6
	 vbJ1HMhsZeme3QsIhuwq2edA+jBSUjkQq4fJ9GZF0FojJgMBKRoGqZjcAAFTUcmAa7
	 /MNRrfJy5mnrw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt
Date: Tue,  9 Sep 2025 16:44:24 +0200
Message-ID: <20250909144426.33274-5-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909144426.33274-1-pratyush@kernel.org>
References: <20250909144426.33274-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_074447_291294_E3372DB3 
X-CRM114-Status: GOOD (  14.88  )
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

KHO test stores physical addresses of the preserved folios directly in
fdt.
Use kho_preserve_vmalloc() instead of it and kho_restore_vmalloc() to
retrieve the addresses after kexec.

This makes the test more scalable from one side and adds tests coverage
for kho_preserve_vmalloc() from the other.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
[pratyush@kernel.org: use the KHO-array version of kho_restore_vmalloc()]
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 lib/test_kho.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index c2eb899c3b456..3f4cb39cd917e 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -32,6 +32,7 @@ module_param(max_mem, long, 0644);
 struct kho_test_state {
 	unsigned int nr_folios;
 	struct folio **folios;
+	phys_addr_t *folios_info;
 	struct folio *fdt;
 	__wsum csum;
 };
@@ -67,14 +68,18 @@ static struct notifier_block kho_test_nb = {
 
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
+	struct kho_vmalloc folios_info_preservation = {};
 	phys_addr_t *folios_info __free(kvfree) = NULL;
 	int err = 0;
 
-	folios_info = kvmalloc_array(state->nr_folios, sizeof(*folios_info),
-				     GFP_KERNEL);
+	folios_info = vmalloc_array(state->nr_folios, sizeof(*folios_info));
 	if (!folios_info)
 		return -ENOMEM;
 
+	err = kho_preserve_vmalloc(folios_info, &folios_info_preservation);
+	if (err)
+		return err;
+
 	for (int i = 0; i < state->nr_folios; i++) {
 		struct folio *folio = state->folios[i];
 		unsigned int order = folio_order(folio);
@@ -89,11 +94,14 @@ static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 	err |= fdt_begin_node(fdt, "data");
 	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
 			    sizeof(state->nr_folios));
-	err |= fdt_property(fdt, "folios_info", folios_info,
-			    state->nr_folios * sizeof(*folios_info));
+	err |= fdt_property(fdt, "folios_info", &folios_info_preservation,
+			    sizeof(folios_info_preservation));
 	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
 	err |= fdt_end_node(fdt);
 
+	if (!err)
+		state->folios_info = no_free_ptr(folios_info);
+
 	return err;
 }
 
@@ -197,7 +205,8 @@ static int kho_test_save(void)
 static int kho_test_restore_data(const void *fdt, int node)
 {
 	const unsigned int *nr_folios;
-	const phys_addr_t *folios_info;
+	const struct kho_vmalloc *folios_info_preservation;
+	phys_addr_t *folios_info;
 	const __wsum *old_csum;
 	__wsum csum = 0;
 	int len;
@@ -212,8 +221,12 @@ static int kho_test_restore_data(const void *fdt, int node)
 	if (!old_csum || len != sizeof(*old_csum))
 		return -EINVAL;
 
-	folios_info = fdt_getprop(fdt, node, "folios_info", &len);
-	if (!folios_info || len != sizeof(*folios_info) * *nr_folios)
+	folios_info_preservation = fdt_getprop(fdt, node, "folios_info", &len);
+	if (!folios_info_preservation || len != sizeof(*folios_info_preservation))
+		return -EINVAL;
+
+	folios_info = kho_restore_vmalloc((struct kho_vmalloc *)folios_info_preservation);
+	if (!folios_info)
 		return -EINVAL;
 
 	for (int i = 0; i < *nr_folios; i++) {
@@ -233,6 +246,8 @@ static int kho_test_restore_data(const void *fdt, int node)
 		folio_put(folio);
 	}
 
+	vfree(folios_info);
+
 	if (csum != *old_csum)
 		return -EINVAL;
 
@@ -291,6 +306,7 @@ static void kho_test_cleanup(void)
 		folio_put(kho_test_state.folios[i]);
 
 	kvfree(kho_test_state.folios);
+	vfree(kho_test_state.folios_info);
 }
 
 static void __exit kho_test_exit(void)
-- 
2.47.3


