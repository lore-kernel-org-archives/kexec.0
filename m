Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5445CD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jv7htWRaexdWX7r0/O/5aQjJsBEQgyvtoCI5ugM9CJs=; b=CoczxvnuZrj4/YxE4KGEYo6Vo8
	8QaOekTN584ZfuKhQycQuaYWI4xRQK/GXgKxKBJseQibLZROlL8nVZ+H3zERzamOH6suF8w8rXPqX
	K69jZfay2H2dOKSYPp4zNEzPUVtN20Ak3qC7Rv41TmHloss57HNLu29t4WulBT7kbjXaASJno+U7G
	Xpv5ZwVgvxYWlil5+EX1zPmWj1Dj/6RWIIDm2wbcawVhcQp60gozw1MHpelLYV058hkxzlgzdFhsK
	6PpF5Z26noC1ECFcwj0YZB7K006QLhLKc9j2N58XYjH3jkyfU5Sea+zD8rQmcUwze4oIEvjdPcImw
	YyZhcqrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuP5-0000000F2eE-2whU;
	Mon, 18 May 2026 09:36:51 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuP1-0000000F2Zl-1jbv
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 09:36:48 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-48fdb2b0cb8so13558965e9.0
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097004; x=1779701804; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jv7htWRaexdWX7r0/O/5aQjJsBEQgyvtoCI5ugM9CJs=;
        b=PdW+Zz8bRFOY7LuJNPCpriRbifsH58fFR3R9Yvq4mFEI6V0HLmVzFgAiUwowuAmXJQ
         xla0iQ6lgIIFa/gnCSEIYjeZv9p4cIEgkFCBDSKWNHsCirlZrRcfljauTiIlp4qFm3Ml
         nofxcjiV7yO9E7k7RvuQq/3P+hCE4c8blp4iH7SgTc60zrni/3TaGBlUbGYyqN4xD6jJ
         xBx5ckNfq9f1b0h7huSwkpvNBk5inMwNHo9EozmDHlf+c7icIZifvDrF0huJVLizCGTS
         Bv7ch2i0lrscBJgq1O44voDpKKnoc4AzHEbnBQVxreSBsqblf0ayPdwfGjrkSrRIS1oG
         tFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097004; x=1779701804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jv7htWRaexdWX7r0/O/5aQjJsBEQgyvtoCI5ugM9CJs=;
        b=P3hwPQ7iZHIgza9net0JRPdtlihPdBoOEg2EaoJyLqxUFCxSrXOH0Mx2suuLApFe7K
         I6I3r7Vn0/TjlMPtFpU+Q7R1nNRg9t9PwjATJapXMPvbVPZl6Nkspgug5IpdMpe1bltO
         +HPMXehVPwmuPDTrx1wFbHeZeY984BPQsEhYxfzVv1qLzhowAk7tUhu7d9MT1D2T1G6e
         iihx5lO9H3/6nN631rjLcrIivCgGzKxEfSoCnHg56kYTnCk4inWK30lPJ3T8GaKSpYeo
         qKxu0Ad4rV+7fr+68Mzo4G0yk2w2OA9149r3qKfJ3uPgnVihOqPbG65YkWFHeMPoCNKm
         h+iA==
X-Forwarded-Encrypted: i=1; AFNElJ96BZ2IEVnPyBK56FFaz5ai0tVzvYyUYokv/D6soYY2MEhXBrRl44e9+QSjmfP1XukpZxj2tg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+Z6Izkt+SBdMv4uF1Oal/ZwVGZIsnxXffw+gb5Z7+I3izx5+Q
	dKjgVyhDj/rPZBSt+D+oTY5G/2CLspht9ZzB4qpyishGkaeazc6iWF7w0dh7IIwfrweeVt0t3BV
	o6jwMSXMgU4I5Y91oWg==
X-Received: from wrmj10.prod.google.com ([2002:adf:e50a:0:b0:44c:111d:990b])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48fe61ed21amr229120015e9.20.1779097004324;
 Mon, 18 May 2026 02:36:44 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:32 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <63776195da42f3307cfa0ad9ee7aa5504e4c2cb1.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 2/9] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: Tarun Sahu <tarunsahu@google.com>
To: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_023647_492239_7C55E743 
X-CRM114-Status: UNSURE (   8.79  )
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

Introduce the LIVEUPDATE_GUEST_MEMFD Kconfig option. This option
enables live update support for KVM guest_memfd files, enabling
guest_memfd-backed memory preservation across kernel upgrades.

Currently this support only guest_memfd files that are full-shared
and pre-faulted.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 kernel/liveupdate/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 1a8513f16ef7..0bbc4037192e 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -88,4 +88,19 @@ config LIVEUPDATE_MEMFD
 
 	  If unsure, say N.
 
+config LIVEUPDATE_GUEST_MEMFD
+	bool "Live update support for guest_memfd"
+	depends on LIVEUPDATE
+	depends on KVM_GUEST_MEMFD
+	default LIVEUPDATE
+	help
+	  Enable live update support for KVM guest_memfd files. This allows
+	  preserving VM Memory backed by guest_memfd file across kernel live
+	  updates.
+
+	  This can only be used for the guest_memfd that are fully-shared
+	  and pre-faulted.
+
+	  If unsure, say N.
+
 endmenu
-- 
2.54.0.563.g4f69b47b94-goog


