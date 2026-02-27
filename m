Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6796B104891D
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 23:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f83mZvouigfOnm3JS7ZtfSKIhAmQ+Bxe6S0lXNepeKM=; b=ld5T1Ikv2LfHj7PhsYw5LUYj2n
	/pYoMPM/56QCbL6MbFbtp6lvKOa4W/esQhH1oUJSdoOlg4DcElvcnSzZ1m9Os2qC7ZQEqZATQ93Pm
	cx7075rN3C7c+K8QcsmgYKZQfoijOxbG+CsZB/V5iQWdm3p5WIsAIh75Ijk3pSRege5ruQBv3NYt8
	UeyZCQ20NvZtrrxxTZGZ9Q9NcDyQrvwE3f9Ad3ahKbWVlUK6qdkhkFaddoK0lmC8jYY1O3quH6ujp
	SYWOSpbsDldgX/4XuhxTqcnNu/k2Tjek5eolJ4i4P2PfFixWNglzslkcyiJerYwFHW0lZGS6Zpcl2
	mSzLAPcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6pO-00000009FLg-45Zr;
	Fri, 27 Feb 2026 23:00:58 +0000
Received: from out-177.mta1.migadu.com ([95.215.58.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6pM-00000009FLE-3nQl
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 23:00:58 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772233250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f83mZvouigfOnm3JS7ZtfSKIhAmQ+Bxe6S0lXNepeKM=;
	b=h00peL+AccAhBGNphQwdzqANq+R2EFOQu50iORciSlJ4eDZBommnIssqbmu99doaXHiRsp
	pSW+pUUYlCZ1fTb9VLYdqIrDnDdbtqI8JRraRLhlRBGOXKfhm+46IkfSTFV7U2V2E/i7eE
	BEvZ6M5Pga8na4nPvKEZBBnpgQBNIxQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Coiby Xu <coxu@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crash_dump: Don't log dm-crypt key bytes in read_key_from_user_keying
Date: Sat, 28 Feb 2026 00:00:09 +0100
Message-ID: <20260227230008.858641-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_150057_243989_C5C29A8D 
X-CRM114-Status: UNSURE (   7.12  )
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

When debug logging is enabled, read_key_from_user_keying() logs the
first 8 bytes of the key payload and partially exposes the dm-crypt key.
Stop logging any key bytes.

Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/crash_dump_dm_crypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 27a144920562..5ce958d069dd 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -168,8 +168,8 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 
 	memcpy(dm_key->data, ukp->data, ukp->datalen);
 	dm_key->key_size = ukp->datalen;
-	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
-		      dm_key->key_desc, dm_key->data);
+	kexec_dprintk("Get dm crypt key (size=%u) %s\n", dm_key->key_size,
+		      dm_key->key_desc);
 
 out:
 	up_read(&key->sem);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


