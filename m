Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0385D10395
	for <kexec@archiver.kernel.org>; Wed, 26 Nov 2025 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WufCdDOpzfL/WfQ3htR6pHmHReVaZ+8ySuuRY7Lmf9g=; b=wVn4GOltDfh/qv0fCw/Rze9008
	pge5wVgFf3QtZ8fZWDvB0w4OmEdXqHFbSzzMaFqYwjJu06aIcROSYkMpy3wFJESbyy22cfjpC08/7
	zfwXbIownpgStH2kBUUB6r0EMbzvIH+gMIm6vHWrliQlY7ZeQdJIlMYkDyD4Hx+PoVdbKLiRwEcHD
	L+42tO8jHXOVUgay4DR7JqOXfaL+2fhpZKnM0vlHsxluz7DtPolnvkQRJoClIUWOaZgTxmYoQR7cT
	NykavI0bw6kPXICnZFRePSbTqw/nzhVxDfjQrPA5XnMk+tAAmuAwUqDHEkxw5QzkQYl7s/CPWoVzo
	GAAkdReg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBA4-0000000EdqM-3ryq;
	Wed, 26 Nov 2025 08:46:04 +0000
Received: from smtpbgau1.qq.com ([54.206.16.166])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBA2-0000000EdkZ-3FHx
	for kexec@lists.infradead.org;
	Wed, 26 Nov 2025 08:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764146736;
	bh=WufCdDOpzfL/WfQ3htR6pHmHReVaZ+8ySuuRY7Lmf9g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lhUUGRDauK/AI2nblJZp5Xq0G6QtNYjkYdU21rs/5R0XxQXcIsAnwxU3lFpyCl80E
	 S4QEdAWWM4RHnFdKcKMi6qORy2FrsWZcvEnnGjI0QBkRpbctDg2DRUaG34c++HK21J
	 neO5vZUgBPtE/dxpLNbqH93NuqWxhZMEP/abP2AQ=
X-QQ-mid: zesmtpgz7t1764146731t05aa1bad
X-QQ-Originating-IP: rjDpBB+HlmgtOOJx3N41NKQSqniequPMppjqpg9r/ME=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 16:45:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4168768459753501341
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v3 1/3] kexec: Fix uninitialized struct kimage *image pointer
Date: Wed, 26 Nov 2025 16:44:25 +0800
Message-Id: <20251126084427.3222212-2-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251126084427.3222212-1-maqianga@uniontech.com>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OQhZ3T0tjf0aipUoODJiBJfVzWfh7sTjffBRh/jiLQkPX80f/edV/qCi
	NnfWqpapYAKQQO+SwqXukYaDt0D6FXp+SOlPoN4/LMCOl232VzTfmc+v15hHwV1pAAP1PlX
	WHHOLmURdgtvfV2lBMJsINTU/0yQWf0icIr5jKRHjcWth2G63fBiPkH0zEA4A6Sd99wEDsM
	rl/VXijWIeHbEd8cpKEjTs5uHb62+cWOBQ3zwLLyxsZeRvj9oBlJn2Dm9NEKlQAzyKy2++Q
	HfndFdxvnNZ6wjrfuxAvshGyM8KTRfLSYt+wppoAcizynju16Lz955gFbrSK4l3S3XDkAx8
	ypePyrrdmZvk8U/tDOrJu/YNvaPju0FsbssrW/0QQdSaw2vBhudlL6gjSWt7MX8UjIMf1Ju
	Mkxc9TB9Mt92i9y9Q2JMh+19+euxBBaQv4jec2cdyhowOMs6O3z+YZTO3VDm7sd7K8M4Rje
	EeOVuPPObcol7TJOJKV3VFTE0Bnh2VmVI/JS+zlcI08jz+JApEIcmvMisW4TV9eGhLMfXc5
	Gw+HSKgMbhPoj2WHz9iN/4B3+h+6Pn6zLzpE8+rFb2bqHXrAeUXUMQRXF81U6M1E3OXV3lV
	Q277rnxY4honUzbpcJ+RhUHmWxW8P8+AGK/zeKfgn3WVKuyzWt7Dr+FtW2acyURDuyahycB
	0kbVcS+9t0LSlD3sjYAb10rHA+/ylMwMEda2da6x+DeZ9Ne2ssoyhwe+14TKRM4FOE4jIJ7
	k3SfNM7MbypzetylHvdwtnT64mY/O33TVjaJBkYiIUUHeED6u0/OiN7I8ZjaJ8ydRVlaLWl
	NxNNajDxtri6v9wvkqZ+5URVvlWNey/irNndzaqVMLQ//xY23MVoA6l9mibvxBEY59W3sHL
	DwVfpF2IYYLFJCz9VerR46Ho+HnLdeilxjQzllP6DuBIgeBxd6BcGJLZLXtTuwlATOs+Cql
	IhUJJQlgZzvs+OtY9Gsf6zznZk025SWOo2nXCVmAjdGoYxAtGLZvbRL+/W1En90RZ4q0Msk
	paFhllOaKwQAc0hEzkauzAfHNJCDKFgIz53UC4gA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_004603_345565_CC31269C 
X-CRM114-Status: GOOD (  10.65  )
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

The image is initialized to NULL. Then, after calling kimage_alloc_init,
we can directly goto 'out' because at this time, the kimage_free will
determine whether image is a NULL pointer.

This can also prepare for the subsequent patch's kexec_core_dbg_print
to be reset to zero in kimage_free.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kernel/kexec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 28008e3d462e..9bb1f2b6b268 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	unsigned long i;
 	int ret;
 
+	image = NULL;
+
 	/*
 	 * Because we write directly to the reserved memory region when loading
 	 * crash kernels we need a serialization here to prevent multiple crash
@@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
 	if (ret)
-		goto out_unlock;
+		goto out;
 
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
-- 
2.20.1


