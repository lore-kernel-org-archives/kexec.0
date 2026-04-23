Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5EBF589AD
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oCWWahIemX4BzZi3Pb2z29oKLrHnKRsi0RRUy/lRLsk=; b=XrcEvzpASAAd1tCZyTAaaDZw0w
	deVIlfgGGa9LbkkRb8I8AxJRrapQfeN93HF9lQBQ2n+jUUK9p5TU/aU1VZpuUhyI8cd5fXhqFkJSR
	C2X3mAw2xsGPTIlkDEVVEc3FjCznFl8IuuUZ18/mVOnTc3Y2iMpYdDKd0sNWki1kxjrRy1KctZhW/
	BEEPcO8vGyLjWh8lTe4iPQ6YrjR0pFwaLXsDQFe1V0sv9gyYQVme30QysZ8E6GMb4/Xrm+wFo/MiK
	QPUr75PsyJJTH5xOfmO/adgKOveMN4KzDl/xE8B7XoOFI9wfhxRzB52MZPje57r6QUayJGCq0rtxf
	w6Yt8nkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFt84-0000000Bc2c-0wIJ;
	Thu, 23 Apr 2026 12:26:00 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFt7z-0000000Bbza-24Rd
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 12:25:59 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so73789605e9.3
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776947153; x=1777551953; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCWWahIemX4BzZi3Pb2z29oKLrHnKRsi0RRUy/lRLsk=;
        b=vvEcBCelFJGLA50A4Z4uKIj6gZXFpBXMi7Z3Vekz7ig6cECOagXGlncmYfJzYPrwlP
         drMjoJxucenxNoKyM9I9Xt28T8/DTlK/HPw67ilhP3vD/a1U2XgMrFxbskfinSNFLNMK
         yw0zWFFkk6OngM1+OxOlc+pIHjdfiL//xIxUMuwasDBDoXOqzVAhENPZJAqqHi71P8YP
         IJz79zmoA2Ii31fXmsDTQuIEinujAYtXbFFzFFFL4Ll/56lrUiGORhc8Zk3DwujVVnzk
         0MIkU7G3q29XlPpKNnF3XuHuWyYvEdOuB4qYDRkYpL9w83HzaUKJNqxPyRdnv34lO2Gt
         6UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947153; x=1777551953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCWWahIemX4BzZi3Pb2z29oKLrHnKRsi0RRUy/lRLsk=;
        b=D7cFyOBQ1Y/d8ooIE66JZAm9HR2ZoycuOYSjhBwMH9bNpBLYBGQOroH2+js7dDCP+W
         jWWWa6npGWioGqBxqG816hg//tynYYvEetCp6olmtXULgMWZYdg1JdxoH9XEt0I9lAsy
         1fmrFbxsOrskrxO9NHE3Tt3jE1M7LE6A9RKh/rIthMmqO4kdmBaaVVU3IA8eFi0QBSKo
         Y0JAOp1eiKDSJOzoYsHO6qFPivxiP0xgF110bN4D+uXi6Dved4E1TBdA6FgQQECRr3LJ
         lQq9S1u+rgoi/hufQHLBoGuCM0ZInVtkJZvUeG2QA3xepMezurbE0OtZyPUpHh3HmgO0
         IycQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uW8foEoXTkp6k9PiMtnB7oahQIKqQC5pjpUu8+vUk87IynJEdJcEvTT6yF03apikvyZR7Pw==@lists.infradead.org
X-Gm-Message-State: AOJu0YznSBU5VFbOZolI5tmMquDe7R09WihOAt3o/K4ZtwruyV40V+Vy
	tSCqvGQ1YYsAa2FXaDUeLsBakq54GO0LTzR01PQUbKsJCv5nnefDA3lK5VjhXXKPElg8WyziDJ7
	nq5IrK0bW1lkU5IsJIM6j/w==
X-Received: from wmbdx21.prod.google.com ([2002:a05:600c:63d5:b0:485:2f1e:2ed5])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a103:b0:48a:58e1:6d17 with SMTP id 5b1f17b1804b1-48a58e16ee0mr105282075e9.20.1776947152925;
 Thu, 23 Apr 2026 05:25:52 -0700 (PDT)
Date: Thu, 23 Apr 2026 14:25:38 +0200
In-Reply-To: <20260423122538.140993-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260423122538.140993-1-mclapinski@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423122538.140993-4-mclapinski@google.com>
Subject: [PATCH v9 3/3] selftests: kho: test with deferred struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_052555_540369_D61FF860 
X-CRM114-Status: UNSURE (   7.35  )
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

Enable DEFERRED_STRUCT_PAGE_INIT which depends on SMP.
Also enable additional debugging options.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 tools/testing/selftests/kho/vmtest.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 49fdac8e8b15..0014bd76e88d 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -59,10 +59,14 @@ function build_kernel() {
 	tee "$kconfig" > "$kho_config" <<EOF
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KEXEC_HANDOVER=y
+CONFIG_KEXEC_HANDOVER_DEBUG=y
 CONFIG_KEXEC_HANDOVER_DEBUGFS=y
 CONFIG_TEST_KEXEC_HANDOVER=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_VM=y
+CONFIG_DEBUG_VM_PGFLAGS=y
+CONFIG_SMP=y
+CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
 $arch_kconfig
 EOF
 
-- 
2.54.0.rc2.533.g4f5dca5207-goog


