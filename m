Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15984FEE4D6
	for <kexec@archiver.kernel.org>; Sat, 28 Feb 2026 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YhcUvXElMmMtAuDvouG9Fdh+PuKMUo/ONV8mgk2gKU0=; b=MUovQ9/QkSViClK8vCDIVRBdIo
	PXtvXpCbk9Z7HJnG+RTzLGIaPuJt/eYR9LOJ28C4bukNnuJeXGpqNqoZoOIWabgN8DYjstYBoT9Nb
	/ak2l/UvDub26q8Fxo8ldUFWua++5y1T9vPxsznJsR0Pn99jIE6JdeVKSCUQ+AE9DA+I++0VkGX/V
	/l9Xm+0t+f3JmGFYipznx7Nme1N24tJRD6q5QZ0fFznQz6m9Ma23L3FKNNkv8YwV0h0hc/vn2Z4sW
	GFHQSd/fY28pQwqLOz1mwuTtWJhvjHgsuWl/DHrSQBBoNGdjdahesSGr7xY4CfLdolf5nFeSadCic
	6EhzSzPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwG3R-00000009fXC-00K8;
	Sat, 28 Feb 2026 08:52:05 +0000
Received: from out-174.mta1.migadu.com ([95.215.58.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwG3O-00000009fWL-1YaG
	for kexec@lists.infradead.org;
	Sat, 28 Feb 2026 08:52:04 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772268718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YhcUvXElMmMtAuDvouG9Fdh+PuKMUo/ONV8mgk2gKU0=;
	b=o4qVS3rXfiJB+DCIHacwR6HDakO53aBvv5Ob+gllXFdiEIVPadxgeIWfnWB9ar3dmLVetF
	DH1jMGn3Ofefa9Y6Ap/KtF7QdrbW+mm0j2k4w8vRYRdyyI3MyyGZqIVpx+P5/q1LQUunYr
	t4fRk7LutimAK+sqa3iXoKshKMJRxH0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crash_dump: Remove redundant less-than-zero check
Date: Sat, 28 Feb 2026 09:51:36 +0100
Message-ID: <20260228085136.861971-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260228_005202_860547_5FA467E9 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
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

'key_count' is an 'unsigned int' and cannot be less than zero. Remove
the redundant condition.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/crash_dump_dm_crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 1f4067fbdb94..27a144920562 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -115,7 +115,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	addr = dm_crypt_keys_addr;
 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
-	if (key_count < 0 || key_count > KEY_NUM_MAX) {
+	if (key_count > KEY_NUM_MAX) {
 		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
 		return -1;
 	}
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


