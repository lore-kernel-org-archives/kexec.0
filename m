Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB08606A680
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tqrdEgeb;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FqPwDvAy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NNY7sb7Lc3fUr2Yc/4c0jbyfUC5yRtKrBOqqupJLhM4=; b=tqrdEgebIrJjQiiInxDcGT5Qvr
	iyrIbe/FpOXD3URdOMAiZB48V5dUS42FPOF2lnlGoTL2Vp635ktaNwqW4ZlOVsi0LKY+K9kVsI/M8
	PRVp71a+sBYYcJxIBcmCYzRhovdQm3a/aO6t/TYB3X768OhTAjk5g6e9H0YmDh8FehPM01EnSQ3ZE
	6tUoXI3cRdU3ij87OnHrY4J1CVIv6A64lDqHMcAZa1M61CWkrpLZQQ7d0YwS/1jClip8v4458gnVV
	mbt3RcJEvysLJFzIhwBclhpGsBuigDTO8L6a/mGF2umvuAOntRH3ZakZaWkfCPzGDLB8QFpTJvbRo
	vEYFHstw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddG-00000005BMa-1qnV;
	Mon, 23 Nov 2026 23:39:34 +0000
Received: from mail-oi1-x248.google.com ([2607:f8b0:4864:20::248])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddE-00000005BLS-15m1
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:33 +0000
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-4a41f46d629so5746407b6e.3
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477171; x=1796081971; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNY7sb7Lc3fUr2Yc/4c0jbyfUC5yRtKrBOqqupJLhM4=;
        b=FqPwDvAy1/2cvav24PX7F9HZl8aU2/rUmTQZMbhDgx1UE+Mz86fDjOInbFiEoI0sX4
         kWXkbWJo4Xv9/mlBF/MphgoK9tALD21NAiLEvlaB99urY6cuYnNV2yV59o/DjZ8eG/2x
         0GgS2CtI21bENZBIgOgjn7Vn2F/gYL6LquyEre1ZC7Mm9fJSN4B0HMaxOK6ACNS8Mw4n
         wtsYQuCPrT/GJeNinDifYTjB/p/RBMuyGe8Zme2Xtnv6oG1hZfpS4WnnT5kLU2QJJLo8
         0mw/BTSA6YSj0kCKMKVqkc0LNCgpKp2z3gXGn1Gzd8Cmc6LXf26oq8h55WslRL5N7KF7
         GORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477171; x=1796081971;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NNY7sb7Lc3fUr2Yc/4c0jbyfUC5yRtKrBOqqupJLhM4=;
        b=I4qtPtoomL1p6xwU9rjaH56ZN5ZX3AO+H1gqVlS4KW3yphB517gWN3SxMsrj4zcEtU
         UKkbysSraYOS96tUKRR5m4YEZxXkWOxO82LxGn/I3KFVujvnRJdpxwf5cug2YBkz8Ubz
         oMrLNYeI8be1f2TwPkuWqRahHo4AWVOe6z6svIEfHGd1b+iyFabSTE61YqPbCxLbu71U
         v4x052TQyZTpCFRsNXK8ePt/dlZcqyGxgvso1Q3+R1tq6Y8hKmknYRFvlcBHTOvaAHcI
         XiTBx91t5dw0sbsbIG3+cxCo1LaJ80un1CcHCxxLUxvMJI0vgC3SxKaTV+mYVRIcKD9t
         bupw==
X-Gm-Message-State: APuU4Z+E0hCIoEqX7cLh206y6JxWVKkrc2ZMSbQgD/A4RmQi/prZyBp0
	gTtQhCrIsvF6qiYwdBcwFRniSgnkwpgl8W2bwpdNRtbV98cRN8CgVdyCpXiUMdeoTEIzCIJelWU
	Wy03O+vJ2HZz/7cv4p/7HR4rW8996DgyVoGxAIZkTtgs1kTmwbKsyWyLF+8JJb17hysDBbVPwAE
	pSzAj+8RrEE2CgyaRxHePBJEDqyUcQmrC89x8Nz3k92CrsO9qYC/g=
X-Received: from iobdo25.prod.google.com ([2002:a05:6602:4619:b0:9ca:bcca:dd8b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6615:b0:573:1dfa:f0cf with SMTP id 5614622812f47-57a0a404865mr13656920b6e.51.1795477170400;
 Mon, 23 Nov 2026 15:39:30 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:06 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-2-dmatlack@google.com>
Subject: [PATCH v5 01/18] liveupdate: Remove the list of steps from
 luo_preserve_file()'s comment
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_153932_303469_78C493B5 
X-CRM114-Status: GOOD (  13.10  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the numbered list of steps from the kernel-doc comment of
luo_preserve_file(), along with the sentence that introduces it, which
repeats the first sentence of the previous paragraph.

The list only restates what the code does, and goes stale whenever the
code changes.

Suggested-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/luo_file.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504f..a42b60356d52 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -214,18 +214,6 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  * unpreserved or successfully finished in the next kernel, preventing the file
  * from being prematurely destroyed.
  *
- * This function orchestrates the first phase of preserving a file. It performs
- * the following steps:
- *
- * 1. Validates that the @token is not already in use within the file_set.
- * 2. Ensures the file_set's memory for files serialization is allocated
- *    (allocates if needed).
- * 3. Iterates through registered handlers, calling can_preserve() to find one
- *    compatible with the given @fd.
- * 4. Calls the handler's .preserve() operation, which saves the file's state
- *    and returns an opaque private data handle.
- * 5. Adds the new instance to the file_set's internal list.
- *
  * On success, LUO takes a reference to the 'struct file' and considers it
  * under its management until it is unpreserved or finished.
  *
-- 
2.56.1.809.ga0b61035b5-goog


