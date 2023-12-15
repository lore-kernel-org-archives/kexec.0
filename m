Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49FAC4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bn6ml2ZLmW0K5hK8ld/PnqVHu/SbaeKGhEJxNKgyrXo=; b=zi7fJNwUEYk06k
	tkN+nqh1uP0KHzmfxUOdJsoc/+PsmQdMASc0Shgv/BOSW0dTCaQOKRB6A/DC5cl6grlehso3AhVMy
	JWWZugmpOh7Vntahf57bZhqU5TSDjZZ/dyuJiSn/x4agm1DcLUV/hg+HNWfgpSVBNk+fKa3WZ4PT6
	n7Gj4kf3NK6q+EMbkdOtFpMknsBUIfXjSrm+rJ/0ru81tov529AMdeN2ph00IZlTvV02N5vHI9a74
	x64nftquoqLtVQdcnRMxsIjOiQTnf9A5sbZoI4LDTRYy5neoHvUoEGMoyn7tR5D4r3i7Zmd1fwFWo
	sjWiZyZhqOUr7pCOg6IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3Gl-002Pqe-0O;
	Fri, 15 Dec 2023 08:10:03 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3Gg-002PoH-1U
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 08:10:00 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so259719b3a.0
        for <kexec@lists.infradead.org>; Fri, 15 Dec 2023 00:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702627797; x=1703232597; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0/MBCfdXawjZKv2ZV3awmKhfLQGaRPuP5dSW02Zx1g=;
        b=Wfc9ZOv1xkRRstcZ77+G/ogUHoxpfEH2K8wNER+7dfJ1THdOTAPixJI6w39GsOS+zM
         Ws3uoHU8odj52KV06hdQtTdP5nIgomW+dfHKU1OnFGQLGvy+4X/TgwAMSCyRkG/fXiQD
         12CjbzhzqDShpsX3rfiFyy/nHC/kBeXNTy9v4TSgKEOkEITQd568KC0yRLapywN1NmAE
         WJV3uAyqUQS+E37WxIsQsk0My9MfuX9Lgk22TH4CJhQgJLp2Yj2fsea2VAUgYsxsDfof
         eD4GF/S58k8W4FlPTm+QJsXJp+yMnAQl1/MtpGFs7YEt1qHksWbbdVw2i96tlhVmoLIU
         rhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627798; x=1703232598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0/MBCfdXawjZKv2ZV3awmKhfLQGaRPuP5dSW02Zx1g=;
        b=xFpVh8LO8txsq4XicMeuKTFdMjFi0DyHOO4haVSLJTpzSY6PhwTlj6cfsEPu374ui/
         jWQ47ofBJR6Vvw+7tOh/YV3DU5hui7USHHzhS7YVMwsHqQPlZRnTgIvLY7GSqcOOzmWD
         uITByg8/dpPNp0+1/V57PA7hmo77MqpdhhpDpGRqIuIkjEaJvDwkY/XLrSmAj6Kxr6Pf
         6aOqzDqrdYkp1qlv0Ge29k9PqgkSDODPIt6PoEyto56+qfnz1EykI5p+nZwKxvJA/uYD
         ylB9GrKn0eVeF2Jv5YZNnKLDEBr9M5eJhuk+TaCLbRWTke4PMJYgOSbkPFopV4xxDtPe
         OEtw==
X-Gm-Message-State: AOJu0Yz5FyPTxHUmQHA2rkcMuU2BBugYRblYKt4i/nVm/BMjuBq2TTFU
	U5A4YvJtAGPP4ny3r8609IA=
X-Google-Smtp-Source: AGHT+IFJGQnjFgAMnUCZUi9/NN5yXdMK/QUUi/s5YLp19cYbU54DBnzCc7uUZLehiHETGePvX24pXg==
X-Received: by 2002:a05:6a00:6c9e:b0:6d2:6918:d039 with SMTP id jc30-20020a056a006c9e00b006d26918d039mr2591566pfb.22.1702627797500;
        Fri, 15 Dec 2023 00:09:57 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm11783792pfl.156.2023.12.15.00.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:09:57 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 1/3] kexec_file: fix incorrect end value passed to kimage_is_destination_range()
Date: Fri, 15 Dec 2023 16:09:08 +0800
Message-ID: <20231215080910.173338-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215080910.173338-1-ytcoode@gmail.com>
References: <20231215080910.173338-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_000958_504960_FDCCF65C 
X-CRM114-Status: GOOD (  14.49  )
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

The end parameter received by kimage_is_destination_range() should be the
last valid byte address of the target memory segment plus 1. However, in
the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
the corresponding value passed to kimage_is_destination_range() is the last
valid byte address of the target memory segment, which is 1 less. Fix it.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/kexec_file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..26be070d3bdd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -435,13 +435,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 		if (temp_start < start || temp_start < kbuf->buf_min)
 			return 0;
 
-		temp_end = temp_start + kbuf->memsz - 1;
-
 		/*
 		 * Make sure this does not conflict with any of existing
 		 * segments
 		 */
-		if (kimage_is_destination_range(image, temp_start, temp_end)) {
+		if (kimage_is_destination_range(image, temp_start,
+						temp_start + kbuf->memsz)) {
 			temp_start = temp_start - PAGE_SIZE;
 			continue;
 		}
@@ -475,7 +474,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 		 * Make sure this does not conflict with any of existing
 		 * segments
 		 */
-		if (kimage_is_destination_range(image, temp_start, temp_end)) {
+		if (kimage_is_destination_range(image, temp_start, temp_end + 1)) {
 			temp_start = temp_start + PAGE_SIZE;
 			continue;
 		}
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
