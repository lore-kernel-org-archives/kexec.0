Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1199E7E35C
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LlIqRCpSkn+vkqIUF9eytfuVueKTfFVCaHifeJ7gRrQ=; b=lsoW8nO0QLMLSYEYYOL+hBmJsF
	2+0PsR2yQ3trl5xMxDhl8Id0QjHNb3lgb/z1jeKyx6bq1kS0F98SagdD/d5f24g/o3qbxgBX5ZVIe
	FXCIDUlhyIDLt7n3ZAwpqnbqmD9U2kzlfSJkjaH6HDJg12Ub4g4IoLiCHsk5Fc5VTdFyGVPPUeZtN
	U+zcp47rVU3YVT/r1hWQKdXvyXImwAopt7luZ7qTPNT6CVshaPufUfGPdZzECRVyFr47kP8uTsO4R
	WXpSLKNtL33RYNGAG8UWwUj0+049F+hGdrBy8oGVkrDIIJZ4tcAnutASI2KS4fB52xzr1j4S+Ou0j
	Rcvp9Vfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8b0q-00000001pJT-0xYg;
	Fri, 03 Apr 2026 09:40:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8b0n-00000001pIY-2dQm
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 09:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775209219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlIqRCpSkn+vkqIUF9eytfuVueKTfFVCaHifeJ7gRrQ=;
	b=A0dIu9ORhbggiYvPd1998w+q9RQACT2bSqZLVKkp0imw3McPSbMqfwrDseZtx5BqIsPdgR
	v5o7VQSerWFelVD0PlB/4W1WmlckUX310ZWZwQT4szzSpQjfDejkHgRuv+JajcD/LFhi8e
	7LB0cgVGyWKlGaQvQO+Wg35ebqrq+7Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-GzJEozbHMEiouHUdcYVUpw-1; Fri, 03 Apr 2026 05:40:18 -0400
X-MC-Unique: GzJEozbHMEiouHUdcYVUpw-1
X-Mimecast-MFC-AGG-ID: GzJEozbHMEiouHUdcYVUpw_1775209217
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35c0cbe0f64so4156575a91.0
        for <kexec@lists.infradead.org>; Fri, 03 Apr 2026 02:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209217; x=1775814017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlIqRCpSkn+vkqIUF9eytfuVueKTfFVCaHifeJ7gRrQ=;
        b=aSlSOogBatTjKE2OZF9cEnl/aMVLT43MrBBq5Ywe22SDHcej8NBTVZQWT8dF9796sh
         XGOHC2RK3Spkbr5iafNtGKs4JB3TtEWxZzdkYMvlb6FE1pwNPc00dIPgOsKvNN99bNcj
         21k1KYqqgBahM49oXj5cWr3ssUv6EHpQx/+FuWZY9idAQKugXaSgdD190+ox8GUSiCCZ
         nLFvrWHTAyoGUvORHh2Adp5cWq8xW//mLBOiDlvZpB55i3Bm6ImrbEaDtLmNnOiCdgf3
         3A8/aH3udTMbL5Ubr/8gZsCkGo393dJwp1WlacoqCgiVncEo0i5TgUu6IXhNWarILcSx
         X2Lw==
X-Gm-Message-State: AOJu0YyMaw0EZvypOdvXWxnYAShfUvq/MBcJ8ujLZ3OTg19kRssCQ15R
	47Oj+hxZZ6W0c2XrWZ+sMRP/s/5oQiPJUlHOpusKFZX9W0+q1a78t/sXJ6MIMrgxw7defWduudP
	/6rSqs2BKAeYitEehYQMUWuHaWX5AY9ukToJzXvzc4q0pczLEZaOrpLj+IP1CLQ==
X-Gm-Gg: ATEYQzzUDpMSgcaw7cyUwfbSt0/6d68eXj7g5LHCmiSCQ0tyrgvpGYCxVxHDa0JY3ue
	RNjJMJF++4ekaBwQefsK03npZuwYQ4wxCgOGtKmWxQuTyc4WMB++CnNsCTFGSzZaXQy3yjMaxd7
	Xhn5EvfYB0w/RSpVXcv8fT9/1WymVEspYrJY0YmowvjvD4DOqpQ0f8Xasd6zub0W4FsS6Ky3OhB
	k3I4DNUUHml5tv6Wc9SES/1B8A7SrfFW2HHGlhzLia1kZAGR7CWtxgTTIw1WpxVKmhgblwIFUr9
	TYczHZ2dHcLgW2GfEaMCCc6I7Y8v11ItXCb7qFEASW7ICrQJJ0kDenXJdBEZn+oe7hjLdGvA5Kf
	EwEWOZ9LwEkNf
X-Received: by 2002:a05:6a20:734b:b0:39b:c4cd:d854 with SMTP id adf61e73a8af0-39f2f072479mr2129496637.30.1775209216621;
        Fri, 03 Apr 2026 02:40:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:734b:b0:39b:c4cd:d854 with SMTP id adf61e73a8af0-39f2f072479mr2129461637.30.1775209215889;
        Fri, 03 Apr 2026 02:40:15 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491fe0sm4419498a12.11.2026.04.03.02.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:40:15 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:36:38 +0800
From: Coiby Xu <coxu@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Rob Herring <robh@kernel.org>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Will Deacon <will@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Saravana Kannan <saravanak@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-ID: <ac-HoiqxZma0M7Ko@Rk>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-4-coxu@redhat.com>
 <51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y6fd3SZbyT70wvpSFPPEBNP0fQf80-6cCuRr9sg8Sx4_1775209217
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_024021_964896_6A702A3E 
X-CRM114-Status: GOOD (  23.82  )
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

On Thu, Apr 02, 2026 at 04:24:14PM +0530, Sourabh Jain wrote:
>
>
>On 25/02/26 11:33, Coiby Xu wrote:
>>CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
>>device dump target by addressing two challenges [1],
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump.
>>
>>To also enable this feature for ARM64 and PowerPC, the missing piece is
>>to let the kdump kernel know where to find the dm-crypt keys which are
>>randomly stored in memory reserved for kdump. Introduce a new device
>>tree property dmcryptkeys [2] as similar to elfcorehdr to pass the
>>memory address of the stored info of dm-crypt keys to the kdump kernel.
>>Since this property is only needed by the kdump kernel, it won't be
>>exposed to user space.
>>
>>[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
>>[2] https://github.com/devicetree-org/dt-schema/pull/181
>>
>>Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
>>Cc: Baoquan he <bhe@redhat.com>
>>Cc: Dave Young <dyoung@redhat.com>
>>Cc: Kairui Song <ryncsn@gmail.com>
>>Cc: Pingfan Liu <kernelfans@gmail.com>
>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>Cc: Krzysztof Kozlowski <krzk@kernel.org>
>>Cc: Rob Herring <robh@kernel.org>
>>Cc: Thomas Staudt <tstaudt@de.ibm.com>
>>Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Cc: Will Deacon <will@kernel.org>
>>Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>---
>>  arch/arm64/kernel/machine_kexec_file.c |  4 ++++
>>  arch/powerpc/kexec/elf_64.c            |  4 ++++
>>  drivers/of/fdt.c                       | 21 +++++++++++++++++++++
>>  drivers/of/kexec.c                     | 19 +++++++++++++++++++
>>  4 files changed, 48 insertions(+)
>>
>>diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>>index fba260ad87a9..e31fabed378a 100644
>>--- a/arch/arm64/kernel/machine_kexec_file.c
>>+++ b/arch/arm64/kernel/machine_kexec_file.c
>>@@ -134,6 +134,10 @@ int load_other_segments(struct kimage *image,
>>  		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>  			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
>>+
>>+		ret = crash_load_dm_crypt_keys(image);
>>+		if (ret)
>>+			goto out_err;
>>  	}
>>  #endif
>>diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>>index 5d6d616404cf..ea50a072debf 100644
>>--- a/arch/powerpc/kexec/elf_64.c
>>+++ b/arch/powerpc/kexec/elf_64.c
>>@@ -79,6 +79,10 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>  			goto out;
>>  		}
>>+		ret = crash_load_dm_crypt_keys(image);
>>+		if (ret)
>>+			goto out;
>>+
>>  		/* Setup cmdline for kdump kernel case */
>>  		modified_cmdline = setup_kdump_cmdline(image, cmdline,
>>  						       cmdline_len);
>>diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>index 331646d667b9..2967e4aff807 100644
>>--- a/drivers/of/fdt.c
>>+++ b/drivers/of/fdt.c
>>@@ -866,6 +866,26 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>>  		 elfcorehdr_addr, elfcorehdr_size);
>>  }
>>+static void __init early_init_dt_check_for_dmcryptkeys(unsigned long node)
>>+{
>>+	const char *prop_name = "linux,dmcryptkeys";
>>+	const __be32 *prop;
>>+
>>+	if (!IS_ENABLED(CONFIG_CRASH_DM_CRYPT))
>>+		return;
>>+
>>+	pr_debug("Looking for dmcryptkeys property... ");
>>+
>>+	prop = of_get_flat_dt_prop(node, prop_name, NULL);
>>+	if (!prop)
>>+		return;
>>+
>>+	dm_crypt_keys_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
>>+
>>+	/* Property only accessible to crash dump kernel */
>>+	fdt_delprop(initial_boot_params, node, prop_name);
>>+}
>>+
>>  static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>>  /*
>>@@ -1097,6 +1117,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>>  	early_init_dt_check_for_initrd(node);
>>  	early_init_dt_check_for_elfcorehdr(node);
>>+	early_init_dt_check_for_dmcryptkeys(node);
>>  	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>>  	if (rng_seed && l > 0) {
>>diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>>index c4cf3552c018..fbd253f0d3c5 100644
>>--- a/drivers/of/kexec.c
>>+++ b/drivers/of/kexec.c
>>@@ -423,6 +423,25 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>>  		if (ret)
>>  			goto out;
>>+		if (image->dm_crypt_keys_addr != 0) {
>>+			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
>>+						       "linux,dmcryptkeys",
>>+						       image->dm_crypt_keys_addr,
>>+						       image->dm_crypt_keys_sz);
>>+
>>+			if (ret)
>>+				goto out;
>>+
>>+			/*
>>+			 * Avoid dmcryptkeys from being stomped on in kdump kernel by
>>+			 * setting up memory reserve map.
>>+			 */
>>+			ret = fdt_add_mem_rsv(fdt, image->dm_crypt_keys_addr,
>>+					      image->dm_crypt_keys_sz);
>>+			if (ret)
>>+				goto out;
>>+		}
>>+
>>  #ifdef CONFIG_CRASH_DUMP
>>  		/* add linux,usable-memory-range */
>>  		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
>
>The above changes look good to me.
>
>Feel free to add:
>Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for reviewing the patch!

>
>But while reading crash_load_dm_crypt_keys() I noticed a possibility of a
>double free at the address pointed by `keys_header`:
>
>In crash_load_dm_crypt_keys()/crash_dump_dm_crypt.c
>    snip...
>
>    kbuf.buffer = keys_header;
>
>    snip....
>
>    r = kexec_add_buffer(&kbuf);
>    if (r) {
>        pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>        kvfree((void *)kbuf.buffer);                           <--- 
>First Free
>        return r;
>    }
>
>Since `keys_header` is not reset, the next call to build_keys_header()
>will cause a double free at `keys_header`.
>
>static int build_keys_header(void)
>{
>
>    snip...
>
>    if (keys_header != NULL)
>        kvfree(keys_header);
>
>    snip...
>}
>
>What do you think?
>
>- Sourabh Jain

Good catch! I'll send a patch to address this issue. Thanks!

-- 
Best regards,
Coiby


