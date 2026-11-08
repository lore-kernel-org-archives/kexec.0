Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30281606A326
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oVOY7tbD;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CeVj1SFy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DK+wvhFB9cC/ykY+2Qftzi8KfweL9NRM9vjrgu6Yo70=; b=oVOY7tbDhuEypY
	Hqz4PfMWysCYu9+iNXz+joTPJ59KHGh22kl1QLAj0oa08UPCD2+z08JHYz2na9UHMG73dc+z6EHEP
	v4ruBeDYerlUfqUWNWFtmRPeDnrf44Ti54eJcoRQT1c9x1Dq5La1pMvynIty1WLjIQiDslk3cRuRl
	t7gIrfZB0X/D0THqasFM/0BSVd5Ux1WZ76aG2DD1mE67bkYRvZYFBJblVBYfFMBbOFa6OOjU455Vo
	2XHTniWYSgSvRyVKh4vD58DC7hKCz9YYl8hi8C8jKzv0ypCKdPsNn3ax8vWlDfD9jPPlBMoLY8mwg
	jJcJY0SrdcTjnczz6fpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4kq-0000000GIug-3jN7;
	Sun, 08 Nov 2026 15:24:24 +0000
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4ko-0000000GIsi-0lJK
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 15:24:23 +0000
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so16964241.1
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794151461; x=1794756261; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DK+wvhFB9cC/ykY+2Qftzi8KfweL9NRM9vjrgu6Yo70=;
        b=CeVj1SFyqdowFht4zUP3L1bL4B0FC7on2DVyQR/myZmGlzHZe+Tls+H81i8mLZjwWM
         kkFI/+0q/sSQTy7BWAzW6AcBCrMaK5xyFV0xiO0RsQY/N5IC2bThNkJlcnhz9D6HdzPu
         skxC8Vo7DdLPoAC/hGvO6w7DygvQc69dF+X+St+oA5nt3xV0QhzmqvsDQ2v/02uRoF+Q
         nnQWiJDsA0AZwlPY7Oz6hUodYe1nWpgiq+GzNVfVLJBKSLnwc64yEJ/20dNufyZbXzSc
         keXTNpTHfust9cEQk7m2k2f/DpEC3Nhxa4NAvWN3OQIT04tSJr9Ncc3uHe4EovsRg/GY
         qZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794151461; x=1794756261;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DK+wvhFB9cC/ykY+2Qftzi8KfweL9NRM9vjrgu6Yo70=;
        b=WLzzxHiEwenqZ4guTV+7SmJsaD4slAPvcebzCg7+Fd+wFBSMy65HQ2GaFswrecxSdy
         FPFNty+LWBf4AhnFkknCNcWS4WTn5zeWcgHs0x8qqJPRHvdCNpCf/7IdwrJI9/owUP6K
         ClHjQb9YEY1VXBuGJ42xvO9onV5SdP5WSYi4x44rm+BiA6VTi1qGxs+dPjySZ2vvQJTR
         1asotnB4Ro8ZVvWubX7W9TW9kk4DHE/RT8PYQnGf2/1MbMffHxJOHlBXl75mLAJ8Gn33
         734zaItzx7iMUrRl37x97aRfKj4QrUGVjNkeVdYNKaFReOz/6YIFei+T2VyiNsv8tGzq
         ysgQ==
X-Forwarded-Encrypted: i=1; AL+hErGKXnvSPWavTOwFgbncIi5xhWNTjSDAnOvuuew4v4Yi7RKYLSUHdU0idxhX2HXCo3VghtSSzA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/S0sHVhl8kf0E6k4x3Wu5syHVef+DeFRBY8TT7pxIAhsowKSWZ
	duG5pQE8ZMTyrTjI2WH+9ROf8s6uWZKymZcE20Bx18w9XgAhiHYdWua9/fF2kpgJO/Y=
X-Gm-Gg: AYBFou1kTKz4L5p/KFRsFTWnP8y1o4dWzT36vR0NXG0VQySHnkiAdDr35R5EbpzZYvf
	TKXR5I5TOza6vbftx125IgkZmVKEbsiZ0dWIE1aG0iJZlYKkeqfFKyUE80OXgzIqPYTx7Hi4avI
	5hOrBglOGt66CccYFiivuL4uRBz0dtzrGpu3R2JVzP4ZUZCvI27Ulue+rbB1iiUWekhPAiD1ZW9
	S2yj/PE0m2ROEJWl07VkxP2L55/chR82zWlNEB7qMyMo3Kc47Jvlw1DsFeD3pfSchOZQGe2Y+Ho
	ladP5h+TRL6x++sflLL78T4vJlcax4S5a6wtigYYBxtGUSFWxMv1SorYokD9XPTMDhd+gKGSMe5
	L9MWBHgwiLDzP0JYe2LFkjGdarwIFvwsi86iHyNJn+GGVl6M7xO+Qt38vdHlxLOO0Ghqll2IdaQ
	TgSTjkTE4V86pFDG7erZVXbJPlsneDQuAu+ufChZzse7twWiqdP39X4XBDiw/u/pMOZnSRqQhT9
	XWVHebAP9pebD6BV3bXoooCii5GpCbWZ+TS5vIPy78Z8cU2kV79OaNDsOesfJC7azOo27OYcd3w
	G1djlU1c51McHhOydVCEzdorB8gcsYz5ohLfQuQ+YXmzPzjmt+P7HmH2X+b7k6PjtVNOfCTh+Qm
	tk9WnNhK2eDQ1xG5ac47Dtit6tx84/0hI1kg4IhIG3xXq4W8d
X-Received: by 2002:a05:6102:508d:b0:7d2:840b:b064 with SMTP id ada2fe7eead31-7d2daa8ec5fmr326255137.3.1794151460771;
        Sun, 08 Nov 2026 07:24:20 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece60c1adfsm2166205e0c.8.2026.11.08.07.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:24:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/4] riscv: Add support for kexec handover (KHO)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, 
 shuah@kernel.org, guoren@kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261106071459.2003-3-cp0613@linux.alibaba.com>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com>
 <20261106071459.2003-3-cp0613@linux.alibaba.com>
Date: Sun, 08 Nov 2026 10:24:13 -0500
Message-Id: <179415145358.358073.165272378597657083.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=ohwRzPbI/pF5KX5v3Lzs009TPAWX3IxDBN4XddXH9Jk=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8JQhhVigFV4eOxTx4e3e80HlzS/OtAzSEvy/o
 QEXLdFCC06JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavCUIQAKCRC7dyhM23N6
 3jcdD/4utq4C5K121vM+fg4odzwfN+cDjx2VRvt37vUTCJl2NKJyDEA/6O74csfV+flN3PepeIe
 Z9mn1ZjNry4hdEYrftWGGTccrmdMzbJnCBtpRCnMLoFjA8FpZY2ACeQIv+IcAkhMOa6wphuDtI1
 N5OfQGqjO0rGApz2R/3xqFSutMTKfiiAY1qtbSiSSWRpdN5YUGxyFL3rebfa/JcPZNB+3Dvc66h
 MtJEyUv0CUrr28lnHvtDe5jWmWnab1yHiiWNGZgBcgaZRMV6UsEGGALfV79zwuIqAqWd/aLq/jW
 VyhN38LrLXymGAb3N6edWgXBKb5Vw/QPsU4N38+QNx1C94ZluCI/raSClLXa64MjPgyj7Vi+yEg
 qQSbI1WFUVWejGUhZBssz9xgwkjx1/WRwaIMWs/jz4yK1Lg1k0fx8oG7nLhTux0NrlFIkMhuWfA
 kMEHUoBr+OtHc4mbRL6OhmThZxeMXfDd2UU7B7l0p6ulbzfREE7ZoA3uYPuju4iVcAQ9b+0hj9K
 34WZZ/zn4tj2f2btFZ0ruN8PS7KCaYmn3249Ay6LlsI0n1mbqyytmeXLPExkib6jwIEp0JSLPqC
 3//pyo5DhG88hIZrnh55hwcBJg8Px1HqmxDUqoVsH1MtHMJtKRyHcHy7231ekVpw6Rs6i7We2fG
 FUugHQuc8USPaZQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_072422_287568_E5206B8D 
X-CRM114-Status: GOOD (  12.74  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nit: please change subject either to:
Add support for Kexec HandOver

or 

Add support for KHO

No need to spell out right in the subject.

> The generic handover paths are already in place on RISC-V: the outgoing
> kernel publishes the handover FDT and the bootmem list in /chosen of the
> DTB built by of_kexec_alloc_and_setup_fdt(), and the incoming kernel
> picks both up while scanning that node. Only the architecture symbol is
> missing.
> 
> Set it to 64BIT && MMU: ARCH_SUPPORTS_KEXEC_FILE is already 64BIT only,
> and KEXEC_HANDOVER selects CMA, which depends on MMU.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e7891a2a89da..a5c56252ff44 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1125,6 +1125,9 @@ config ARCH_SELECTS_KEXEC_FILE
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
>  	def_bool ARCH_SUPPORTS_KEXEC_FILE
>  
> +config ARCH_SUPPORTS_KEXEC_HANDOVER
> +	def_bool 64BIT && MMU
> +
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

But pre-reqs. should be applied prior taking this series:

1. https://lore.kernel.org/all/20261023054518.3258350-1-gthelen@google.com
2. https://lore.kernel.org/all/20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org

-- 
Pasha


