Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D94606A8B2
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vb5A8GUB;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=jk0jvKFw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VhufRV4BoS98pezOde2Ss8la06aT4y3vZY8jTMf1PWs=; b=vb5A8GUBuNQjUj
	pi6oybH9PKPSk2DLKimmmr7Xl25/a/gDaJB8GgY4/zGNasYHxILdcDygQHZRTfX2NgLNxoRsz64Ya
	hM+MJXHkpJ8LVYjiQ5Gy/r222iQCF6lYo4iKnoVDMfuRLMblck7zRmggXXc1JGj2hvpqXEzdp4gvw
	wJjty+f751Ce8qcimAXw0IHxbZTWZiur27gNg9oX6gI31QivrX5Nezgs3JJU9Oz9MicwMMK8Kzbxz
	kDI4SeG2K1BDYoY2RyIY6nXiiwtYaWDMHeqCSU+BAUgyW2K1pPzeJgE/7hu/nGOUSW86S3G1VLULP
	QM55ObDggO4Xn9kV4/PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGot-00000007xcY-1UGr;
	Wed, 11 Nov 2026 22:29:31 +0000
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGon-00000007xV1-3PlD
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 22:29:30 +0000
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso2281635e0c.1
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 14:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794436164; x=1795040964; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VhufRV4BoS98pezOde2Ss8la06aT4y3vZY8jTMf1PWs=;
        b=jk0jvKFwanp+/xgmCbKZvSAvgmSBM2ZZSkHT3ogtaKUswr6JWVcvo+ri5GEKLmUJZi
         NKILts226V5wT1riYWZOHcL3Moz6WAYyxrDuzbXqvRBIKwR65AUJHFBNDdL/LJVLn0Yz
         s2BluM/bjhPdOFw2ETokvfzrFXdhzYe/t6aKR5a7QOyu5iNKVjW6NwqCLWy5ps3SkJg9
         ufRLKDdGSWd9tYas70EcAZCmSu/hy2PQ+5fsYX90utri+YSILip8ygloJY8d77Oi7fPt
         EYarlLa1Hxz2mHh76tY0XiQtLbZe0H8RKX51IeafbQct6vFmZionh6vPvHKq6Z+VVvTK
         ZkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794436164; x=1795040964;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VhufRV4BoS98pezOde2Ss8la06aT4y3vZY8jTMf1PWs=;
        b=fTz2Y4hQlvaKSB7Q6YOPa1l8u+uvQnJwBOtF8CVjXtv9HasT1kv2W006VDY2XbIPvB
         lcfeXoXKq5zcp+OIPrDSA9rDcpHHAbAccCWMV4c3NGGDuqRLc9KlW7VmzLooNKbLOjCG
         sCGinp2+sR3goZbBaKMSM6KBDC0cC6DxQGSv8+pQdxkhApnMLIrBs63IPpodGf/xGRu4
         lv21GA77CdsrMlaNUck9lJxSbEFDw2rgNLLW13tLtwFoAn6C5+L1xpPwjaU9dCedIp2b
         u8gLfkWG6MJ+kR9FIQy8sz/Y/bshhyZb8d1xpJ2HrFDccqeMoV4c/JgOCP/MU8WIfoeP
         27aA==
X-Forwarded-Encrypted: i=1; AL+hErGf55o8J189beI2ygE1/kLOpnRf6D2Q8yq//DgnFRQcd0F3reY1GyETTheMGOBodYjCDtAeKw==@lists.infradead.org
X-Gm-Message-State: APuU4Z83oVomAg72ZKlUYTot+tdp05VnmoxenwWuxh53qKtK+1zhYAME
	Za1ZHEn+NKfVkz8krXBW2aGRAHTaVDOqnBHalmCzgxGio+rt4S+NQBLlUq/pz4bCMLM=
X-Gm-Gg: AYBFou1LVW0uae7I5p8xmNwKbZ5Cqh0rtD5u8F9eAvIw6kq8WsJjBUf9okVr4U/2GrK
	U7ORzAnSLI57o2+2CQ8x7HF1HrOUFFKS5VTq/vBFgoNF2HsryEJAU6SsFDPfH3vkQNJ1q4ooiG7
	9ui3Y3qdX3jDaZOUhq2DJd7+emuAN2FWIuvqeGlXwwmx+o+VFPyjsZCZwj9V1bFBO1lSAB6NenP
	xpApLAEwoLyKEe3wQBhHVfpiH1sm2N1dp8QFEgz3oB5Pbb8PQyN5kLpvbm1JlYHGudpZSAM5++H
	j81wwJkQuNIMRnFaB1ImWZ9h7R9mM2/k7Xo/RJs5ttoYY2w5Ufz70599l/vctQLrAPW3vp88xOr
	HfHbiYRGUxjlipQnF9GTzIRPFmAeN1jUen6wg4XT1IkxTyCE2OjsmubSPkb3w3+Wnemt+fCylLI
	S9DitzmT10vmksaWYAtgX9sp12QwuBDL6QT0yuAVw227sLG/OPRM3qa03oKVJg2AOjF89EQEdNP
	tvF+942+JG1dFViRFvg08F+rTQx2LQOt1AtORyxkg61qV0kvG0S9dUNb5Si/p81Nkb1JkfN7Vkr
	OIhCKL57P00tMx6DrZNb/BluEK2IEt8gK6IXuE9U9jeZfGPXfCCzr3Af3mq6stsjOGiffM1Llmk
	h1QG/DEQz8zwQx61Buri1vzX3jXfh6M3jNX5TveAcgQC6
X-Received: by 2002:a05:6122:4210:b0:5ec:d84e:3833 with SMTP id 71dfb90a1353d-5ee1c453cbdmr1849715e0c.14.1794436164290;
        Wed, 11 Nov 2026 14:29:24 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ee8csm4508834e0c.6.2026.11.11.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:29:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] kho: Reclaim the metadata page left reserved after
 kexec
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Chris Down <chris@chrisdown.name>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Graf <graf@amazon.com>, 
 Baoquan He <baoquan.he@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name>
Date: Wed, 11 Nov 2026 17:29:20 -0500
Message-Id: <179443616043.2329176.17166425351392983946.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2439;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=jGQo4CvboZX/j4iYyskgIcnUkGUfctp7MromfOrLaYc=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq9OxDl5eSqxBhOZE5p1XG7yi8PQ1rOiwUmOTWN
 tSoxjgP6WuJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavTsQwAKCRC7dyhM23N6
 3uNSD/0Wo/iIWR2aXRe5YzNSrRfo/731JlX1MXOtpy+A5vTlCNvhVm398rzpLHqepWduInwcdRK
 4tex7caWuDlEdOt+RIVRYZ9mDjBo4xRQ0pvDBu9TWfu/8iU6zATD9T2YuP0IZnK23JCBq2LZdNL
 Pd1ZB7+If5y2zy1PJcSHbWDjJR9cu52ZsvA6Ni0FgTTyy3SdqMWwntgGPXP/LkzxuTKVIxTCew/
 zAi8DC6COcIzjFKPckc3lqS4x+o2s5Zwpfgfa/yAKCJIXNcdgmZhS/bqjRG1k30OiLRzjm1AUH0
 +/Wzasj+qb7r0d0gsdRO44Q3LUAgYoBNNtbFLy+xdLMwqLcDpWFCNFIsuQoxoTLzbNi/ldIvWM7
 Bhe1ME5c/vfVxRfgVtSpaG6iwt7oCEesTRczv6SaBP0L2VXQcphd+4/BXqpxAX3OQlRgygYDjh2
 1FlvPx3aw7hsvLSA1SpUCaE1/h4TboRhZXeYpX7Qjfo5WJMt9pwdUSkpQoQ/IZ0H7DlnI3dcKAJ
 LKGf5Y3yLsfxcsbOghJ6yLAHz8Qa5p2lyNP/Jke0X30ny06+HzRS9+hTk2lJkxIc+bfFW/kZkt1
 l4/OofVK10BUEKi4onJaayj27ChYPFFdnwt9J1sO+PHCisIKLgi9L8aR/AUtsyOX7ZBzKO2lVH8
 P8fa89xifqHqa4w==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_142925_933954_8C36BAA8 
X-CRM114-Status: GOOD (  19.65  )
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> After a KHO kexec, the new kernel keeps the page holding the previous
> kernel's kexec metadata reserved for as long as it runs. It only needs
> the page once, since kho_in_kexec_metadata() copies the previous release
> and the kexec count out of it at boot, and nothing reads it again.
> 
> Free it with kho_restore_free() once copying is complete.
> 
> Fixes: 76aa46b9e404 ("kho: kexec-metadata: track previous kernel chain")

Do we really need to apply this to stable? It behaves correctly, and 
your patch performs a minor optimization by releasing a single page back 
to the system.

> Signed-off-by: Chris Down <chris@chrisdown.name>
>
> diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
> index 902d171a780a..f9d2cc5999ee 100644
> --- a/Documentation/admin-guide/mm/kho.rst
> +++ b/Documentation/admin-guide/mm/kho.rst
> @@ -120,4 +120,6 @@ stabilized.
>  
>  ``/sys/kernel/debug/kho/in/sub_fdts/``
>      Similar to ``kho/out/sub_fdts/``, but contains sub blobs
> -    of KHO producers passed from the old kernel.
> +    of KHO producers passed from the old kernel. A blob disappears
> +    once the kernel has read and freed it, as ``kexec-metadata`` does
> +    during boot.
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe3181..8a07783326a4 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1782,6 +1782,9 @@ static void __init kho_in_kexec_metadata(void)
>  
>  	pr_info("exec from: %s (count %u)\n",
>  		kho_in.previous_release, kho_in.kexec_count);
> +
> +	kho_debugfs_blob_remove(&kho_in.dbg, metadata);
> +	kho_restore_free(metadata);
>  }
>  
>  /*
> @@ -1859,14 +1862,15 @@ static __init int kho_init(void)
>  	if (err)
>  		goto err_free_fdt;
>  
> +	if (fdt)
> +		kho_in_debugfs_init(&kho_in.dbg, fdt);
> +

so add debugfs node here.

>  	err = kho_kexec_metadata_init(fdt);

Remove the kexec metadata node here. While this is somewhat unintuitive, 
I do not see a better alternative.

>  	if (err)
>  		goto err_free_fdt;
>  
> -	if (fdt) {
> -		kho_in_debugfs_init(&kho_in.dbg, fdt);
> +	if (fdt)
>  		return 0;
> -	}
>  
>  	for (int i = 0; i < kho_bootmem_cnt; i++) {
>  		unsigned long base_pfn = PHYS_PFN(kho_bootmem[i].addr);

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


