Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EDA60A3802
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=h/4q7GXB;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WX4W4kU7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8hRjHNT+bDawf2n+fS4w87yYb1rrNIQllzNnUpN3o7M=; b=h/4q7GXB/b3WmHLOg6L20d874Q
	0BY9FP31Q0b/+JQOeRj5LJDKIk0Y1DBYzOdiHkEKFnj5jeWQr+1XsSdmqWGb8g5YFhXH3pzuV5byF
	Rt9/wfLWzfCMhR4mPGsme2kDtTIRLaQUC/G1Cq+fIw2MQLLV0npdYIj/VjoiwpIgk7v8PvYOt4Yq/
	JzqAbZOtS/SsaUluwdi7vdiJN/Xkl1YmWY4RXDOtY8gAZlQE8IRbi4fcD8sSzxwqGWDWqObZj95H8
	27gs7jVIKdMK1lixCCFgV4yFX+tm/MhAWzTkjsmG+M2/b4KkDAjxipg+48zcyvzpQUnPwkJ40mE5L
	EH5hqprg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8M-00000005Ihz-136S;
	Wed, 11 Nov 2026 00:24:14 +0000
Received: from mail-ot1-x345.google.com ([2607:f8b0:4864:20::345])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8I-00000005IgO-1N8f
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 00:24:11 +0000
Received: by mail-ot1-x345.google.com with SMTP id 46e09a7af769-824cc5f7fcdso3319716a34.3
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 16:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794356648; x=1794961448; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hRjHNT+bDawf2n+fS4w87yYb1rrNIQllzNnUpN3o7M=;
        b=WX4W4kU7cGUasV8Wa1ylvif1dn2wQy/Ypb8AM8BbkO5GxPkxboYnPv6OUOuC2yLU6k
         r0VxkOW4QHkUFtjjzZmVwtPmR2Lsw2Rw66TgqFrIDB3ivn6+xCWocPIaYoZAv26lvOLO
         rMd0t+94/R39osScSMoPEKTJTdHjVYOlocyFpj3eCOQOjhYu3ZMzxP3PB/q+Qkd0xFFW
         qjCuFmwNtOsP8QIYzYIxC7Y/nduHMI8AI9uCgsSg+OkoPY1Th7FzRYbLivL8SWGa46Qg
         NUSQpsbbY3zCZYL08t+IR1jOhQgQVOZ6ZEnpjp4J55uD2NhUJW/8Adc12Xs2Kya3m2lr
         QHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356648; x=1794961448;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8hRjHNT+bDawf2n+fS4w87yYb1rrNIQllzNnUpN3o7M=;
        b=JL9yGvQO52cfz3wOwZqx1lV+kDwe6SoXDEYycDgXsZH7ybu6bkBfZiwO7FdRbU+wky
         ZF34ayOmW2FNKdUjo26h6nFiH3U612VNjSFIGumiVfBxczAubM2DIJ2ddOiuWIqCSumW
         v5Snxlc37vGnxWtlQhGAEGhGRcCenLbrdn3vPN6j1HGe4mnfpyLiloOTfMud2oo7/Vup
         jJy/aK009Y+3x+WIK3JuEOGlpyp+hOeBfv7HRTT+LiR4/ncwOKil29KWqwHDR6aBCfTA
         WiV1+82v0UQVZN3p8yjAtGpju9g4ll0KMbK6oIVbFZ8sGvAYaDaVfDgKMD0fB5CSI9wi
         7oUA==
X-Gm-Message-State: APuU4Z+U2v28W7n9u4znABE4puFEfd+/B+O436uREastcDuwBR+XFdgW
	fvGafMUchwCcx70rukJV9mO4hW1CLV2T+cJ1FUqsAtVXKMAOGorTt+LBi8wqPogk8o9vH6e/zeT
	xUtGyd6zBSHbA5vgUWNvd+PdSElW3JK2VbE2RpWwzjTrxyzbozl1MfGo3TLnE2lS8dw9fnN73Z6
	hVMSKLWdMlGfZg1D8YqrOjgOJ+HoalzckgkqY5X78f6Y6FII7BzWY=
X-Received: from iohf2-n2.prod.google.com ([2002:a05:6602:a5c2:20b0:9e3:4940:4cc3])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:13cc:b0:567:fd8f:403b with SMTP id 5614622812f47-56b97b17653mr680403b6e.42.1794356648195;
 Tue, 10 Nov 2026 16:24:08 -0800 (PST)
Date: Wed, 11 Nov 2026 00:23:39 +0000
In-Reply-To: <20261111002358.1842967-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111002358.1842967-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111002358.1842967-2-dmatlack@google.com>
Subject: [PATCH v4 01/19] liveupdate: Remove the list of steps from
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
X-CRM114-CacheID: sfid-20261110_162410_372693_7F7A5B6C 
X-CRM114-Status: GOOD (  13.33  )
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
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the numbered list of steps from the kernel-doc comment of
luo_preserve_file(), along with the sentence that introduces it, which
repeats the first sentence of the previous paragraph.

The list only restates what the code does, and goes stale whenever the
code changes.

Suggested-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: David Matlack <dmatlack@google.com>
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
2.56.0.542.g3ef89b7020-goog


