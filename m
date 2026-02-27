Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDF8104891E
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 23:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QJIIPRBWqu2HSoQ5Rn8Z/3bFqXXOfFgdn1gvbsH/uFQ=; b=WkEAxHF3xW6z0h3FD1WjbbdhIj
	SElXiDJ7eOK7ffpK6eiFiPpovesiKGZZTcbQU8yURawVQ7g8ZEZEMRxykQ2AsJzsTe/72VDgn/vr3
	P9elduDeJaAfkFY09VdI2DLLwyUP4623Yg7CHaiSBabUAyRTwpnxyVrQOrAL4QhLaAl3MCtb0eY6H
	lt0GC7A7ljj0g7ubA/QNFAxgEw4kruZkGI7arX+aSTX46Wj412cl3bWLOnHRq67RDxNZfQ4vxEQ2H
	43xJpUmsB+R7hny72sM0OcF56M6IXY99p+90nCn3MTrgbn0mlSU5zVACbTZvdjHx5YQ62YHjPP9+U
	tvsP2rtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6t0-00000009FeY-3tCi;
	Fri, 27 Feb 2026 23:04:42 +0000
Received: from out-177.mta0.migadu.com ([91.218.175.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6sx-00000009Fdh-1cM9
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 23:04:40 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772233475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QJIIPRBWqu2HSoQ5Rn8Z/3bFqXXOfFgdn1gvbsH/uFQ=;
	b=QKN+H1zZ+GFTCkO2VUwohbeOaDsZz57X+e3UTOoNmKLogXZQ6dKVZHFXeCpnXe71T75FDJ
	RL7PSSXQRuriz2HD4smngoVQCKlrVXNhfW7h8k+hpG2nAwQBYC8K0KWsnGnaOiZnfktjyl
	OykLp3KGmd+4E4cpmK+0QiVQExqbrBs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crash_dump: Fix typo in function name read_key_from_user_keying
Date: Sat, 28 Feb 2026 00:04:21 +0100
Message-ID: <20260227230422.859423-1-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_150439_581871_82630300 
X-CRM114-Status: UNSURE (   8.89  )
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

The function read_key_from_user_keying() is missing an 'r' in its name.
Fix the typo by renaming it to read_key_from_user_keyring().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/crash_dump_dm_crypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 27a144920562..dcb69e96c6ff 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -139,7 +139,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	return 0;
 }
 
-static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
+static int read_key_from_user_keyring(struct dm_crypt_key *dm_key)
 {
 	const struct user_key_payload *ukp;
 	struct key *key;
@@ -387,7 +387,7 @@ static int build_keys_header(void)
 
 		strscpy(keys_header->keys[i].key_desc, key->description,
 			KEY_DESC_MAX_LEN);
-		r = read_key_from_user_keying(&keys_header->keys[i]);
+		r = read_key_from_user_keyring(&keys_header->keys[i]);
 		if (r != 0) {
 			kexec_dprintk("Failed to read key %s\n",
 				      keys_header->keys[i].key_desc);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


