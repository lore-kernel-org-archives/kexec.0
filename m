Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D59ECAAD1
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4ghKZlVakL1F4ydS8QG9j1POaOKJoIk495f++sTcQ9k=; b=PVg+XjjYk6IkOB
	CFkdu9US8oQYh/mWRTs9CPW10NwTcTROVSZwEcw3rZQlRYAx75d27Rar+Fl5XoSId274ppB9mAKfW
	cFVG2V5j59j5wZbAwgwmjeuSPOn0Yy8fOPLKXdTczNFiQ8cKRvMEeTh8ZvtrxUjWVO/6tcfBGRHh5
	eueOFc4CU4uGZj4Knix9o9GGloY+HrAiym4bOeNmahSqtBhEZVRDHEAk83E1q025DGPv4S0UMT2L4
	Xk7VgHiS5hPOHvUXPaeNVct1aznIY6V5lZYf+s0zAEvoCjeeyhfOIaXAbk3KBByAvXyhns6httSaP
	AnEUOMiP1lRBLTBpOFLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTL8O-005i8F-7E; Wed, 31 Aug 2022 10:39:48 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTL8C-005i6p-LD; Wed, 31 Aug 2022 10:39:37 +0000
Received: by mail-pf1-x430.google.com with SMTP id y127so14022305pfy.5;
        Wed, 31 Aug 2022 03:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wOwY8itHt8uazUdkq94DxdZkg/SDR8+3Y3ahMNupefU=;
        b=nfkSlY53P23F3x03xQrP4eu/bkO3JWBCJ9iyfQAQq4qWiJ7daGlQUwntPXT3PITeif
         y16sWZr+GrhAwMAOp5gW3N+Y6jenP385CCPBdu6R6bGVsUmO7qCjntFspMzdVAeUMHfn
         Z0zrxMhmvlEIC7omwrBrw26gwnStad+hRNooWWLyEcAbvsn8hfi6sIB4EhABufoYBNzh
         qLUJv5asLy/ltrAvAF2bqRBELRXwW7psuNrQ92LDFMsX3u45Fr7kbKpQvKeuM5n74ZIi
         Mdt0SC9Z4wxaCgmFJek8DCwm8z0lp1Uwwpa0bZvclZI0B9pEFIC6CkPEVPchF7HLOu7D
         Xfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wOwY8itHt8uazUdkq94DxdZkg/SDR8+3Y3ahMNupefU=;
        b=UJnc9PWyEfFl0mSn7l7fDruUyIaah2OSxyFw6Ndr2kTPjlpD4R0Tw2to8vb4C4a6hZ
         +jhH8UQBXNXHz2yRc54ZdbIg882MZSKLDxfvN1WxR0hhALOfhY2CUJ76T/iD2g4feMNB
         cgv0KW1XFcppe2j3quKgYmUYrXkIAMfH111xiZH2WF7stQZ50a71rvkemuez/gq/18yj
         LIjUhk0TAbSHPpJD3KOBMZLW+Yz4hAe4esgEh/shakwqMrNTmU5mewshTlA9CEu7wGui
         fd6mDBjbqyN/mSWd6TfYtp5nFLeZdquWLNuH2PtEfYr1F4x37nT4ix6jq+BukCbFpvCD
         OBTQ==
X-Gm-Message-State: ACgBeo3LgKpp+yLHGVKXN7SMeYbvVBmiaereZm6jLkCk8DiYOeSYi1/3
	q5hEavI46ddlOgmMVvUJTDM=
X-Google-Smtp-Source: AA6agR64P8U6wtu7FrDxOOS6p0FSnkiFLrwL6YILZB/NVOFoS+0twPVgULY7Qms4kloVOzZ9yLqIhw==
X-Received: by 2002:a62:2503:0:b0:538:426a:af11 with SMTP id l3-20020a622503000000b00538426aaf11mr13608844pfl.22.1661942374066;
        Wed, 31 Aug 2022 03:39:34 -0700 (PDT)
Received: from localhost.localdomain ([118.235.13.86])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b00172dc6e1916sm11245808plb.220.2022.08.31.03.39.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 31 Aug 2022 03:39:33 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: catalin.marinas@arm.com,
	bhe@redhat.com
Cc: will@kernel.org,
	nramas@linux.microsoft.com,
	thunder.leizhen@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Levi Yun <ppbuk5246@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] arm64/kexec: Fix missing extra range for crashkres_low.
Date: Wed, 31 Aug 2022 19:39:13 +0900
Message-Id: <20220831103913.12661-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com>
References: <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_033936_745761_3D4D001F 
X-CRM114-Status: GOOD (  10.72  )
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

Like crashk_res, Calling crash_exclude_mem_range function with
crashk_low_res area would need extra crash_mem range too.

Add one more extra cmem slot in case of crashk_low_res is used.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
Cc: <stable@vger.kernel.org> # 5.19.x
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..a11a6e14ba89 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	u64 i;
 	phys_addr_t start, end;

-	nr_ranges = 1; /* for exclusion of crashkernel region */
+	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;

--
2.35.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
