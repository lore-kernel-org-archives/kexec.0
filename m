Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186460A2603
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OoLQG+Bj;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=asuggaDB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Z1nKV9RROXIYz6IEYr9bUViL602rE2TVHzP14wnkAeE=; b=OoLQG+BjXhdTpL
	6UPdOVEHfUL0vw3DQdqI4E72BIQK598AmHOM34YNg1qvQpRyAp4/mSOPShPZP29GeODXk0VTvSQmm
	KBDsIUxXtpda/lyNQnxLJH3mLz6pCj7I+fBSvQ4vVZICl32+xegcWIdzgJKKp7VeGC5dzz9Y+Onue
	tdGob1QgSb15sidy6FdzjVi7dNzskmqd81IezLa1cDMKcceMSYoPFqW/KeGsRYM7VoS8Q4UCgSdUb
	Y4TW7uJF9DXuJCZwrioCUmVZiJWQBtDYMHgrHEWx8kpJTBcD8VEs+kD7hJILwfYq/egKSXGTOClz+
	+WD3b+vFsztwVVnnIp8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cq-00000001Eut-1Pen;
	Sun, 25 Oct 2026 17:40:28 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Co-00000001Erm-1eYq
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:27 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-5eac01ff101so962820e0c.2
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950025; x=1793554825; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z1nKV9RROXIYz6IEYr9bUViL602rE2TVHzP14wnkAeE=;
        b=asuggaDBpZivYaTFQSSdWWVumyGPNYdW32GmLfaR6tU3DO7fXDUwgzoh/ed0u7gFzF
         FM6Ou5WyvJNQPNXK+tivRZsp5YKjR1B0UQ9Y/4PPCtLVkiWB//0yeZodOqErMsAlhGgq
         ZSEjHXbffFJhSULixTEiR7g6lCWVF6zocVyMTgh5w5cy4OPWhlFwDOfD6hH500kI87Ss
         DSJy2nqK0GXVcs3xRqRaKgxElJfWkg1Xv0RE1qnnWln3TBLMXlaMPe4looZSBAGdVRzy
         zUYfYGT2O+J4nRB3cCIAdSvti0GETNP0YQGY3N0WYWdO5UZAW3iiJyU7QbOEXPvMmEqk
         wV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950025; x=1793554825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Z1nKV9RROXIYz6IEYr9bUViL602rE2TVHzP14wnkAeE=;
        b=rBRQGRkNtinKV3TPULQM7HXWxSIB3ANLluxHo2Fb0SkT97jn812kZGTX1uWxs73Y8X
         kca0NO9eRnMFYaX1MoTR4uhbHzVkHXQqiFsCWywcaZatTQ9S9N2IclvydRmcQE5S/vZO
         A1T9mrCpvIrRABkWFbkAt917ofNF32kM52gXYNWjbACqWAC6QROtEL0fDxOVNWRlmlUI
         Xt4Agt2vX5CrbojwYxZD3L56Th7Kw568w+Dm+z+xI7OmaLOFvwk8Je/0gD9kMRQWtA/O
         7PpWjgOmay9xLJDC71YxA6HCG2BklA0Ky7VdNDHatppBwTLyiJjGohQlebuUUu7TMe1N
         uWUg==
X-Forwarded-Encrypted: i=1; AKwUvBxhA9eAmWxQvFfcKYFrnvA5MegSc4goffRJhN1HKlJ6qmhZoUbGomvUQeSu4HYsxv8/cU67KQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLI1vcX2dZ6CUWHxQWVPFXAEGQBNE+kjE2AWqQUlHZ5gpaTpgQT
	WVWQIIo9uNQPtalIBFaCSActMLjEeSsf1XPfQG+Utl4QlB5+uaNxzwWP8BSrumeVlR0=
X-Gm-Gg: AYBFou2OAij5sRKQ1QmFA9lOoBp1GrwL5TcfquNw3u+Au19j9vbqUpfXr6t5lSHZxXa
	p1aoVSV/xrm93SxKI9FEzt+KgWMfCS7SD2tu4FlrJnhYcaKmyl7IuWLbY/2Y3/Vrs+qqFw+Csbd
	6S+gvb6vT2GMqatBRr52DKRnZQ8f+fcoez2CljVLfM4hZA8/BdfoMQEXw3B/5+pn88dDN4KTAZD
	RGW4ARYPKVlQMjQlpusvnVO1x/FZnTcCLelvnIqCEzcw+o2HVp0joGxsdVYnGAkWC45R0oAIntD
	wuIiLIotkGAAcbaIxVlP8C0Vpb4k9N6Bz5xxKHJnFMd0OsM7JGjfC7tOAIU493Frpwr2mteEehR
	pR6l6BG0D7/5pCTu3aqmLEqAoGWm/d02W7gblJxzBYf8cWa1YngdgnlLKG5qOm08h7kuQO4+8RK
	0o1nrjbuYXTLHV0yySrk7ZKuWEeTBehTYi6bmvXymzRbL7hqofsB6TZIhmigtra7QvYwbaffSFe
	PZsQUr2KqcIkeJP3Jk43Cfyoo0JUjjLDAAOnFuPKB74BsaupmZ9ez36YmDJDLyORuvBdoc0Rni8
	wILBbvP+K1Ndf9REzhhetxy7k30qHlfjkEwncELLOO/WyD64nfUp9ii36nh/pARrZco7RucAg9f
	6
X-Received: by 2002:a05:6122:83c3:b0:5ea:d1c4:7cbe with SMTP id 71dfb90a1353d-5ec2332c72bmr1427722e0c.23.1792950025414;
        Sun, 25 Oct 2026 10:40:25 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:25 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	kuba@kernel.org,
	enelsonmoore@gmail.com,
	bp@alien8.de,
	shuah@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vbabka@kernel.org,
	dapeng1.mi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	elver@google.com,
	graf@amazon.com,
	lirongqing@baidu.com,
	liam@infradead.org,
	jlayton@kernel.org
Subject: [PATCH v2 4/9] kho: do not modify incoming serialized blocks
Date: Sun, 25 Oct 2026 13:40:11 -0400
Message-ID: <20261025174017.3870481-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104026_454363_6ECC05EC 
X-CRM114-Status: GOOD (  11.00  )
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When restoring an incoming block set via kho_block_set_restore(), the
physical chain of blocks is already linked and bs->head_pa is already
set. However, kho_block_add() unconditionally rewrites last->ser->next
and bs->head_pa, and kho_block_set_shrink_one() clears
new_last->ser->next even when operating on an incoming block set.

In the upcoming KHO read-only mode, incoming serialized blocks are
mapped read-only and must not be modified. Guard the ser->next and
bs->head_pa updates in kho_block_add() and kho_block_set_shrink_one()
with !bs->incoming.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kho_block.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index 0d2a342ef422..a4e945f28fad 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -93,10 +93,12 @@ static int kho_block_add(struct kho_block_set *bs,
 	list_add_tail(&block->list, &bs->blocks);
 	bs->nblocks++;
 
-	if (last)
-		last->ser->next = virt_to_phys(ser);
-	else
-		bs->head_pa = virt_to_phys(ser);
+	if (!bs->incoming) {
+		if (last)
+			last->ser->next = virt_to_phys(ser);
+		else
+			bs->head_pa = virt_to_phys(ser);
+	}
 
 	return 0;
 }
@@ -133,10 +135,10 @@ static void kho_block_set_shrink_one(struct kho_block_set *bs)
 	kfree(last);
 
 	new_last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
-	if (new_last)
-		new_last->ser->next = 0;
-	else
+	if (!new_last)
 		bs->head_pa = 0;
+	else if (!bs->incoming)
+		new_last->ser->next = 0;
 }
 
 /**
-- 
2.56.0.307.g5fe7bd680c-goog


