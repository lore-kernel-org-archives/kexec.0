Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6A2CCF2DD
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFKyVkuGCKpOVLuQsnhKod7q0RL600zFuUYepG6R/FE=; b=0TRn9gpbPPuyjcvMVHvvYjOuoU
	roAvQyhHhDurP4rXHlAldWd/1yTgu420raaTXsW5eJXAUYfnhVfh3rznSVfwma7vW7ownWpPeEwpW
	khq1YYS/Om+gDrtKYigorZgpGq2Om4coXsOWIo+VBjDgGoSAM2jF2puHkeyWzs88GFGV3cVk7QGOa
	3Ge8knN4KOJNOmrP409XWBgCAd9SL06WnwOVsBs2ge1nUHM2guQj8M1qODBFS4ZvHPAdfCO3OEp94
	pea/gK5D1EE9iU3pKKy7vX3N4tcdJklsTzkv3cR1sjY70i/Zvpcc9vj/6QbdHTZrCsQ+qkIBSCuwW
	xZ+gJqBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqX-00000006RUb-0gyp;
	Mon, 19 Oct 2026 02:11:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqW-00000006RT0-1ixL
	for kexec@bombadil.infradead.org;
	Mon, 19 Oct 2026 02:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=HFKyVkuGCKpOVLuQsnhKod7q0RL600zFuUYepG6R/FE=; b=Ymu4TZx+nFQXddjl80Z91KHm6z
	tV2hFBV7V+Nzhr6X4z/8AnwbfnHWNKc0FWxtaTm6EG/j5FsG9i0Xb01EaqkSq6lW53tVbs3Lv9Hjn
	MvWnQ3OIljja4F9fd8HK/2DnHKqfFn7GlLkjm3AC0/QEQP4yovo4VCf13Cdryqq5i0d0534rXJLU4
	frooNqlz4hWAw6Uspvmki6CsvB5hcHykfcDtKnH05OCEKZmqtWUC9DMgKoX7wzoBu9sSRzZ9+VWL3
	hFMtJl4AOifSq//mLweQx4T7iPvIvUnbeSrmyA1YEf4ShNSsszgbWj7pYwGP4YyDwd1Zf96OTuHQe
	HM1EriTQ==;
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIcqT-00000003F1t-2cLJ
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:11:27 +0000
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-5e519c39196so454875e0c.3
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 19:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792375884; x=1792980684; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HFKyVkuGCKpOVLuQsnhKod7q0RL600zFuUYepG6R/FE=;
        b=eci5ytkaYZxfzGeEP1ONeu7yik9coy5DhBsMWmP7EC5benYZb7OQe3RKZrofET9q26
         rD25nJrtFsiwq4mfbToIxQKeFrrnQK8ekNe8p95crq9GqWtFZV7Ci07hqJkXr3IPLymr
         UgwhYNWAjRXH7v1ahsnn8At2emG81xZan7lDHYc9fBWLPog9oAfDbZz/RnpIc5UwG4F+
         FRTNdKnItMUbBdU8oxs1SZpflERlQrUkFLXEy4JuVuM1F4R3TBkJZNOnXU8ibt1A0Tmr
         hI5yQB1qQElK80s8YgBDf2wsp5YhYL6EPYa0zOUacFgM9VqNnkZYcAiLyr07emf/iJoq
         mIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375884; x=1792980684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HFKyVkuGCKpOVLuQsnhKod7q0RL600zFuUYepG6R/FE=;
        b=YbcixVZlbQGZF4MC0pMfHKiD5f5iJUTFzNvMe9UPYA34MEe9okBpJiakkxa6R4g+zF
         LKTX7G8kLyL7AmXyFaE9I9rN3smp/5WRlgd52iOGWK6SWvQCAqCqpAJQitL6tHm9i8Fv
         8gDH+Gs1QzCOamZgGdz8c0gQWvdVTotamWNcAofeSzNxf5dfKcdZirr5b//Cn/iWInk2
         Eg1T+MT7VZYnbNRxvTUm3AWJ+XtTmi/CnSldaSW3ZQaYcfauKuQs7ThUaab4sq1BAcjW
         +2NnucTmtd/NU5ZH16rukkkhzpvoJbFsEoo8wU36Nkdn4pUhe0TFC3u5SH6pxE8VYs80
         7knw==
X-Forwarded-Encrypted: i=1; AKwUvBw2H4wDi8y4160TzBiVumb0KOp0q4KT7orCifQJX1yoYbGvmS9x+crshzg/dm/xwh3wKN+NRw==@lists.infradead.org
X-Gm-Message-State: AFq9FYKwgDzAE0NoYF9Iv0Eic5g+lf3Vh2+pSaeJSbDKOSxfKGrGQkiP
	O7Q+GB5B9tvz7YYI/1DomaEqEvw32xbhy0rx44e3GfoO51g4C1H9cfonJFl2XK1VCbg=
X-Gm-Gg: AYBFou3RicqKxCO2/YZQ7QNQw0naBPwH5dR4xSPuq6tJ1rYaOGeBv3EO1Q6h5FMOAkG
	u7oTOAda3DAqkhUikI6sWAtibJo79OWm5lgqiFv1i10/6wzsvSN7VHMBIniVQxLdRI2GAIjlBC6
	WCQ1umOeWATxaTh9ANCc0dF9tXWLDj8NZWHxriI9OmM68lzlzXPKRe227Bw6qY0Rxhpu52vcpDJ
	1IJnIlVA5r7nLHoO5ZY4jiHU11/cvlhqNvufz3Ge0l9IyeVLLmGq4nGA303j0du/do1Jj23Xpgv
	v9z79EPufo1TiFpXzTD5tOHxFqfufKTF74U91BSMmYB/hKV8xgU9/x9G/fqzDgrzthwde6O7ujw
	NMRUJwUwD/utTyA5j824bAxrSYMDRWZR9TP9jVpwAocLHjQf6yyyghyS8F4RyRdjVzKCL/JFq2l
	zgeZJbBPHgfbizRVTlrB3OFz1u9VBl54F83QyKef+Bn1rIJdOX+ur/3RaCBrIaZ2Vp2wp5S+PkI
	6EkjL0LyfH/6pigJn1tmHstXbJX4NNDMhGsSFzjND0NI09xOVJQWHkr2hBCUlKzn8TT6cCOHPiP
	dx7ybIG294YELD/Yoq09dBSJKZs2vQ==
X-Received: by 2002:a05:6122:4b10:b0:5ea:b9b5:8c43 with SMTP id 71dfb90a1353d-5eab9b59387mr1211022e0c.18.1792375883763;
        Sun, 18 Oct 2026 19:11:23 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabbd9ea2bsm4271383e0c.2.2026.10.18.19.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:11:22 -0700 (PDT)
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
Subject: [PATCH v1 4/8] kho: do not modify incoming serialized blocks
Date: Sun, 18 Oct 2026 22:11:07 -0400
Message-ID: <20261019021111.990394-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019021111.990394-1-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_031125_773890_B28243FC 
X-CRM114-Status: GOOD (  12.26  )
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
2.56.0.176.g3575e65682-goog


