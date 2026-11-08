Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41891606A31A
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y+IAPgpW;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZDHXsNa0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ZXPOl0YSd6S/HY373Pp8Ndi01/j4+eSRlC/6LdJKdNo=; b=Y+IAPgpWQU0MYO4D1nnV1DmE4Z
	ohuq1T9LjWr2fbNivnztmFWDbcuU/B49p0vO0H+201yuwRjNxybB6fB3AxjAwHZvWyBK1z57b1gtN
	Q8xmiUTb4KlxCWxq93Ph359ca1TLpE1zRMALZVOV1nj7lYemADmgH5Rph8/jWjk6u87ocBRHtJHg2
	Z90ZIlvnsaklYYVfYwzdlJPmHMvSDAKwDzTThVFoNTAPZ+YINYuYJ7KdKo1L3qTjMC/8HnIAcbQ19
	AZ9IXDnWCHEwHORHd4QQZ45Buc5y9FW9088rqf92HRCEfbS1azBR3tF+MCEiFXsrAKnueRgTr+SEi
	v/ZwqX6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPtm6-0000000FeZu-3uit;
	Sun, 08 Nov 2026 03:40:58 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPtm4-0000000FeZZ-1IRa
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 03:40:57 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so73454a91.1
        for <kexec@lists.infradead.org>; Sat, 07 Nov 2026 19:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794109254; x=1794714054; darn=lists.infradead.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXPOl0YSd6S/HY373Pp8Ndi01/j4+eSRlC/6LdJKdNo=;
        b=ZDHXsNa0fAQCXjRNqLaHK6NzrrUfjcRrzA61jP3VE/hFiZrAiVhvFymk6DO42yLErD
         uG3GlZGL3IhG0puJSfOR4yYm9blnHeFkbMJLzgpu67/Uh7ZEi0oz4p3tONwpoiLfgLj5
         qJXzVundrhZxqhPYsLalxQ3AJtrnyVI8Ciog8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794109254; x=1794714054;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZXPOl0YSd6S/HY373Pp8Ndi01/j4+eSRlC/6LdJKdNo=;
        b=xCWga+sKSzYYm6zigmWrbX7acBlM6kkvtZcgGhJJ439MVYTyh0uToNdsIy/+Blb3tY
         9v/+POWLw0mHhMkBVwDhDh9F4+JyIhg4lZm8NG8cz4sAQ+ej3au9o9nYtZoCrFaHJzO1
         pa4CU4uJ58LubWhF/tV+p3tIUdFU5dbbwlmsqhq41qBh3lroeREoPoTnaFkZ6euOo+ji
         otg+dMt00qHdoTtbASCaG2wuacPCMW2JxyehMeYLP1mTo+4OXIB8Hu8CoSgKpAgDNv3t
         HiqFL1ifjKvskeWnEJJ+euHAQx0pMp4iD26ydbc8iaN3ogNa41KMuMRhybnvdmC97Tn3
         l4qg==
X-Forwarded-Encrypted: i=1; AL+hErHGhaUpkZgA7C/7KDKR9XfTNARmQnAq3KHN2ZQmwayIlUZJn+DIhl8sB4RtT2YKlVnjED6dWw==@lists.infradead.org
X-Gm-Message-State: APuU4Z+p2HfU98gBqnhMWSOUH+/Jl5eTj0vgGUswgCu707RDEVEObstr
	Zo1Mr2zHym+/4E0j0x+GHIbaHKakZlYt9bcHprY0HcSgatqj68o0qL1J3hwPwHn6q0k=
X-Gm-Gg: AYBFou0mTMWsRoFzGx4QoBik8DrXS0mqt/EQiig0QAPSp8fQ2XbmUMO6lnpRAT1WRNT
	ORDXttZeI6w1bT/l21uDT+Cl9tvHu5oJlVHfGt5adaumaysThRDvhibOXssjzFs+x4XykEHBoPe
	as+zj7HTZxxX972oerop1SLjAJ1Y0UdT+pnSo32gkqthg9azQgtYeUIegj57su8pQ6+hBzzoHpH
	9cG85vRxxmDkACalCvA2p6uS2tzFDohfSnhOKYiwNoW3HxCqfdIwcuvHKPEwz71Hz22eJXrvHKk
	x9spqXtvD2Y4Aa7HnHPSpGHL8CYEr0edleo6QcmL60EO0+Abpn5WrqDW/iVcZQ3lnfEEwwlMF/F
	VCPLdSHco1VcK2chRzN3iUq9rhKv/STx4++gywkF8oJP0i3bRndSV1xiB3fuO/J9bGUV3G6pYqI
	FHG9esLv4QH7BEgjLlnExRxiS+E1MmGuaMfgHgtVpUTOCniapqDrxnOvVpnQuQ9SGnsj3TAlJWb
	O7Gps5xg4HZXax25l+OJVopbDZrH/0eP1Pb57OldrlnvUXcEMPzkkp9EpHPVE5xHEvbVjY6VYbC
	FJCPkVcN5QPkTrlR2m/QNgsmTrqD7LTFxPhY/tktfePM26Bz69tCJ+koAmkRFHjpUpdYZDawqDC
	KuTqCIJcPcvKqUEfhA9iNOcsbJ+lS4G/C75tPlu6DHaQLzgszV5TVLR7B+yA1VfYseYyOLK8m0Y
	KEbZqdKwloVvfPKXZYwQe+zbAFgvclcEVRY0Hrz3lDN0lyUaSTk1PC
X-Received: by 2002:a17:90b:1e48:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3b12d5933a0mr344498a91.49.1794109254287;
        Sat, 07 Nov 2026 19:40:54 -0800 (PST)
Received: from localhost ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058d3310sm5374560a91.15.2026.11.07.19.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 19:40:52 -0800 (PST)
Date: Sat, 7 Nov 2026 19:40:50 -0800
From: Chris Down <chris@chrisdown.name>
To: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: graf@amazon.com, kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH] kho: Don't release incoming bootmem areas when kho_init()
 fails
Message-ID: <au_vQhHAcJbkryXN@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261107_194056_368522_8386942E 
X-CRM114-Status: GOOD (  10.71  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kho_populate() adds the incoming bootmem areas without reserving
them. memblock_free_all() then hands the remainder to the buddy
allocator.

Unfortunately however, if kho_init() fails, err_free_bootmem
currently frees every area with free_reserved_area(). This can free
pages still backing early allocations or free buddy pages a second
time.

To fix this, let's only free the areas on a cold boot when
kho_reserve_bootmem() reserved them.

Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 kernel/liveupdate/kexec_handover.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe3181..a566ad6634d8 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1899,11 +1899,13 @@ static __init int kho_init(void)
 	kho_radix_destroy_tree(tree);
 err_free_bootmem:
 	kho_out.fdt = NULL;
-	for (int i = 0; i < kho_bootmem_cnt; i++) {
-		void *start = __va(kho_bootmem[i].addr);
-		void *end = start + kho_bootmem[i].size;
+	if (!fdt) {
+		for (int i = 0; i < kho_bootmem_cnt; i++) {
+			void *start = __va(kho_bootmem[i].addr);
+			void *end = start + kho_bootmem[i].size;
 
-		free_reserved_area(start, end, -1, "");
+			free_reserved_area(start, end, -1, "");
+		}
 	}
 	kho_enable = false;
 	return err;

base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
-- 
2.54.0


