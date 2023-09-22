Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CFFCD484B
	for <kexec@archiver.kernel.org>; Fri, 22 Sep 2023 17:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1Bl5V1d/parq5INcgl2yaMNGK8Ujyo2lPjkCxLM1/cI=; b=CVs0Uu1AttzBD7
	arjW5wUmN/OEOV4vI6tpjj+4sW23j6Az07RBK+ZjHQVwXOZKU+/4T0o4Jz/KugIIGwRqnPoJq9Il4
	MTiAALlazSGrZa/waqfFTEOQv71d9JWdUw5vcCTKeAwfhrZN3mBQlibxLuBhpnAbZRCjXFc2JYn7D
	TqcaKNbewdY2NFyfXZOmcKLN2Ces6RdezK19Hr7q+7e3pQCOn/X/n7uJFnYr1Ba+MDc2Pd7WZgVv5
	oEpaJmGwJGCb4U5tw4PoO0x4fx9NDUFb6zy4W+wJnfbYujJLv3YWi92YErI+c6z5FeXx32UIxwZYs
	oasxsf/vnx+xMP7lV2AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjkKT-009Yps-15;
	Fri, 22 Sep 2023 17:52:37 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjkKP-009Yn8-16
	for kexec@lists.infradead.org;
	Fri, 22 Sep 2023 17:52:35 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690bd59322dso2022672b3a.3
        for <kexec@lists.infradead.org>; Fri, 22 Sep 2023 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405146; x=1696009946; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0V3jWlF6ThW9BuslQEoTcg1mHcaUXfGXFyJTs8W3R6E=;
        b=erXekgzXUGGdbX8UywwBGPxYk2Vvzhyh/k65uDKGVfUT6IBAFm9pgcstJaBWqrwN72
         y9+75iDVuxt1I0hVZN6Wb1Q1zZZbegUvK0DLqm/DX/Tx+DUl+ErWv5ivMeQ7BEJE61uF
         rkzqXsRKP3yWDxz8QRmHcdhkBOPCbfLbeUOZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405146; x=1696009946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V3jWlF6ThW9BuslQEoTcg1mHcaUXfGXFyJTs8W3R6E=;
        b=wuhpk7sBbwO9ZPeC6qecgFHCNOMTPQhl04zlUwHcD8PBfdKie9FQSQ6dXzquxzhwGS
         xSgI8FGvxnT7e/8/Y+2zUhO6cyYp2+HTTFiyw0K1hisZrkv7snzSYVDtDaDb3eGBoW17
         Go7Zdy2LPn6zuKB2s+CPrWy/FDi+maAyF93uHf7v602aeYk67032YV9CDe1/nCiRrT3A
         9uHGR8q6SjRMLyqwx1bbxuSOTNdsTloUjlSaKgqRtZm3McMP6vbEg8Hnc7nGABeQvTJx
         jdnVWgPaASLFGLpN/K6cSVdO2TA+To6IZ89icwx7eFNQC60MWeR1duW9b2vVwXA++/S8
         8uVg==
X-Gm-Message-State: AOJu0Yxs5RHIAyNB8wgsOoQ5pGOzsPo1RqLiQLb+CmajcbLs8MxBpk3z
	oNqNKBe5nzbjHHleX1vHt3aVDA==
X-Google-Smtp-Source: AGHT+IHx4GnSNddp0w77bsyIRrhbxTM/759paXQ8qQVs8QwwnJM4CYqUGvwQocxlGPM8jBTrYu6dZA==
X-Received: by 2002:a05:6a20:918a:b0:149:9b2f:a79d with SMTP id v10-20020a056a20918a00b001499b2fa79dmr290578pzd.6.1695405146334;
        Fri, 22 Sep 2023 10:52:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a17090ade8600b002680dfd368dsm3539391pjv.51.2023.09.22.10.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:25 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Date: Fri, 22 Sep 2023 10:52:24 -0700
Message-Id: <20230922175224.work.712-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=keescook@chromium.org;
 h=from:subject:message-id; bh=L7QtPm9sV53utHLzzgBlBEkBDQ4wLhHXIn/rOvcMRB8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRYVSnSoLrnQY5IDtf2GC3u6QkTIyJo8C8QH
 UxbqYg6Z1eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UWAAKCRCJcvTf3G3A
 JiO2D/4/umN2M56qMMDxw25gfk0XXrNasJyvVidbf0iVWd2FgMZqMzVjLLRZKgALKtPtlbDlkh2
 uMauyeoWwoJreiokLRDV03uy+dbxUuXicnyG1bqS0hQX79TIbLta7QucwkDPvl6ApHxx5G7/lM5
 n1+Vo5Onde7/uK/2hXqgKAZObP3bWuBXqt/r7JbPJp709MTsA0KotCN0R3ZCUfDz2t8xfPIxvpR
 S/BBPo6ZplYLWO9EVXoJzCvwZxEGL0JmSI8IMvIYrw6hZRXg1j/dR/pmBplYZnXwLByQXsphPpR
 S1nRV9zZoQGb6SUX4mf/M71DVfcZKchFA9BihrGb4YXnLb47CU6/+m0AXiLZp5Qx5eVC0cZTHgM
 Qps2mjfP+ph6xuFEcF/gF8bWWrNbKVvtftK30Li+TojYHIK2xvrdmuBbOCY6g6EVijg0KCGHx8K
 i9yJ+ibNvqF2ArwEQHi13ri0WBKLiujrfoInUBfMHwjtOxZqjnVpwz1I4W5F22E6+6rWL1CaSZA
 QOK0C9uuoYEZJkZ74kv04YXgsLbr85durHrVptzD6/83FJLlgZAwX38fwmJ54utqv5Vmvv7EPlN
 eFnyapYuZ/+5urqf5Q8HplGM5D3AFfSZ6y+Y8OToC74qQf4wevVdjZsyKPHA2o6OuQXX0GnGdR8
 Eahlr6L R5b0zPWw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_105233_374667_98A9238F 
X-CRM114-Status: GOOD (  11.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct crash_mem.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/crash_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 3426f6eef60b..5126a4fecb44 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -131,7 +131,7 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
 struct crash_mem {
 	unsigned int max_nr_ranges;
 	unsigned int nr_ranges;
-	struct range ranges[];
+	struct range ranges[] __counted_by(max_nr_ranges);
 };
 
 extern int crash_exclude_mem_range(struct crash_mem *mem,
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
