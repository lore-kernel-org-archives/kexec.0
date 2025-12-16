Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1431D5B161
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 07:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nlC4H+HZu5TOOreu4OEbcwwZ6SLR8CCJXl93GTnllT4=; b=piy8gvRgv+FsBCji3vyHqke6OV
	7kp9mH6nJcxhp9MpbeUoEd6gq9HVtwcjDmDItwKzits6mRvW4+6oGuFg4aVtQWT+mtLIA77cVQork
	B9mIEFWl1gXGJv5BbuqSoQdE+Pw1Zcb0dC4PwRx995C8kMF7NoFeMuU1n0CmIC1Qz2AkdKH5LpKx/
	Wwex3v0zUqFfEqUTCOcHW2RaecKcXcDxXEsFobkrfxLPalBSogK9v6MbQApb1mBSrvpkhubGjpdpV
	ypLaO//Zn/8+pWUt8113DypSF1kicNKB5VZ4nDYwrkll400LWiEGddIKn1PPR0K+Qcd49GQciBHy6
	gHccnfbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPuy-00000004soV-0mpB;
	Tue, 16 Dec 2025 07:56:24 +0000
Received: from smtpbg150.qq.com ([18.132.163.193])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPuv-00000004slr-0USB
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 07:56:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765871739;
	bh=nlC4H+HZu5TOOreu4OEbcwwZ6SLR8CCJXl93GTnllT4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=dGeKnEuuutmmStpt9Sl73pswPcxaTofKezDXddRgof9yU5f6nhwxuWlzwT50tU1io
	 JvnQhPdkpdehQdXg5Hw7HI17E0jXxtWrwt4PddbNHe1c5c2e8dK2hRI4gxhKYQPwiL
	 f+tG+SJ2XNYh8UgxOB/GCQiEtRsHmJYfAmRecU2w=
X-QQ-mid: zesmtpsz6t1765871734tf0651cde
X-QQ-Originating-IP: 6wjONADb7Dmiyy2GRLdVye8RdImTzi7oyW57IZANijM=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Dec 2025 15:55:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11387274927920160015
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2] kexec: Replace the goto out_unlock with out
Date: Tue, 16 Dec 2025 15:55:18 +0800
Message-Id: <20251216075518.1626114-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NFNrK8KlcSCR9EA66xMf7tIj8cl/Y9r1WzmwQ3y/nVI6t7O3selnbLVH
	EpbusAwj9vdFDIlPuIvXG6t5BHxi1Gbnqq0jWHhZeVSwVZfxED9KfQo5c4yGc9RZ7t4q7A2
	jjbHRPF9FXhgTmiXarcuieoLwKD84GvKRcFLCyM9yB/eRc4fibMuCQJlgYjHJ8u1v5Z7d44
	RgiERkbhPHVIsgAayePQPClecF6A7DGwiPkjJUGUJzqIbHnBVd4m6R8BVP9ILME478QdFCl
	w+07FRaRZiW5k6GVA28BaHiU8iocQgSh+auvzh4nMAx9Giqr/pBi9ba/w6iToyNG+rCXN8E
	tLS40yn+KANKlX4BWSXCxqMIv6JntRGW8tL5C1IKndts0z54+kaqWIFa1bvp5rd9YwcOLPN
	ccOkFBvLWrwwC/Wa0yc8hq6rcv2TpGAjLEubysm6ycFXyMpAPF66BYrLunjk3EzU+2kP4j3
	VQK+c5R8doHvInRzVwqCssSjHi7VoHGW47zO8c94q4LEesIOuJDSrL4Cql91y7+MPv2kL4F
	es5YZAmNunS/JGuQSbCSXB4YzO3CL4yb6RLETOAucz5JfbJYg0JNtjJjuxBGSmxrAF9Z240
	LHlhbgpXf/WjSHyE1XP4RyhhM5FcqWzV6IR3mRqqeKbMwuIFSP4cHWyasmS0CpBlL4X99wz
	LhDg1D+ZPhNIRkLmbnaBU4W9FfpjYrcq0hbvrcvm2hK9DdnJt50qd+b2m6BWbdb4imySIal
	fFDVYDI6nu92jd1wuTFdOjHCxfQIChj02aJ1NX69g/73JluDNgsxtICKmY+td7CZNtAarwe
	HokHeOEpn5bU2I/LRR2GZpxTWMxBxhyTQdYuRJ8L5qV+B3eeEzzbI2TppSpqb52EFgLxbuh
	a70yXKotYr3RXdjd4z41pZauZdZJ6NDT+n+ZKvqNbwNGZG7ZC3fcwn9KlkuOXlgnDho0UgC
	0K55b3pbm7XRggcgtFm8PFEcHJ967/QVjZhUUC5M+U0NNfatw+NQUnEA3LICK/bivM7ASGm
	++3gUjpl0FvsNXPxVm7lurFm8HQgskTKOiwN3l7w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_235621_910727_98A7FD6D 
X-CRM114-Status: GOOD (  10.50  )
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

This will prepare for the subsequent patch to reset the variable in
kimage_free.

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


