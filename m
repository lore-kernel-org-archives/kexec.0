Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEC1C369A2
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 03:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7dlryhVy6NeWg3O2Okngw+V+H7NewUDTwovui9xGS0o=; b=jFUFSgF+Reqb1XGoJoWMK66gWC
	0+T/q2z4kkYUCBuus8vzm5L4FhEH/wxIS2q3X8ES+sIX5vc9BVTJ8O9jU0ds2KMq9K6OIhrE0yKE3
	/jefkoVxJ00C7rSCttq6f4Wcs9G/cLEoPizwh2sL5Rv5P25BTuY54PhJSu5eMQhv6Frb9ZDM3d5eB
	HWoOdobv6fe3gXyG1IvHsjsET5WgMdBGdI646si8tIxFxGHLl62lipLqncjV1G4SgdUmQYsnBQUss
	X3iruG4I/CWa5F3NBeXWEWkxFcLxEcTBlIDuSqA5slNTSxUGHimHpbbZv94BoWsWKe6OnEOANxuvO
	eDKMbwTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u35Oy-0000000CQ1G-1vD9;
	Fri, 11 Apr 2025 03:50:00 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u35N9-0000000CPpb-3qxV
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 03:48:09 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2240c997059so17933285ad.0
        for <kexec@lists.infradead.org>; Thu, 10 Apr 2025 20:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744343286; x=1744948086; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dlryhVy6NeWg3O2Okngw+V+H7NewUDTwovui9xGS0o=;
        b=yEaQ/BNwjYedlBFGYGE77swhbiGSf4hFLAnLFY4kYTbpSgqWll74Ae6a7/kMr0KjNO
         hcwbMNNH5LV4f7uxf9S34oaR8d5eoYXCtBH8JHwnUA92GHdt0giFrUce3OIwjZ7/b1ju
         k2eYWoX2ZbdcVF1hi1qS8DGuAiaFSFc5emr6u8uHO2nwU2f8+MkUJMz1FCEFPInkb8k3
         q41weoJT1nVHhwP7ekcrofuWGTXQkOhIfQ1wzlfiJMnHWj36KYvw9s6Bd36oPb/O5gj4
         8sSvMQ5kTQGaOxOF2Kc9SNZBdNu+LlBcOGs1mTY+G7bAHjbKYfLxh3NZ/rxpMC2dFCBf
         HHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744343286; x=1744948086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dlryhVy6NeWg3O2Okngw+V+H7NewUDTwovui9xGS0o=;
        b=DeZDit+aQFFRZjQ4rr1fRTmvaVaGCIZrukuF181ryg996v/eNkQWJksB+WULpxYlC4
         f6xAfzBS265GeFC8IFxKY5wMknL7nUgLReFSjsDi6xFLRhXT5RNPSrn26t4jM9/HQyLS
         AYk/+VB5mEpvFrNFoGe4F1FJenqpJOs6gfuLCVniQdjlhsA8ybaSOCc1JrQII4t8V4wM
         2MQenhq1NkzVrHuf9HEObQVMNyjNUrBhauVy/cuUubWXOeeMDpeFSP+pwcvowI/5Plac
         bN9m5SOFqMyxp85fIEwZOGbceWUV8PlXxQd9IWeqh8hd+BwPT3PeH0djh5KtZXI1oUZm
         lg6w==
X-Forwarded-Encrypted: i=1; AJvYcCVZExMikGXO9/J2EWFfLdT2j+rZ4OWjZLVtCR1BPO590ftEJOrG8a/f8PFOpga4aXKqmxtv7A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4irP8jjQs7CmTGaeXIYa6XS0qJBIexR+wD1HUySOm1fyMH8Fy
	RmFtJecaERCrrnAn5w8LoVD0S2KLI9g5mtw+HPcaWCK5Wg9BsbooRv1f9smrXoVp3doL5AUHYc/
	w1slqEUTnjQ8eGd+2kA==
X-Google-Smtp-Source: AGHT+IEOZPbbuwHUT+vSKb7YqC/0TcONKVVdEEEvZeXr5rZzrszLtokHPfZVQrxjUuNtcfTum+JkVNbqScaVm0pW
X-Received: from plks14.prod.google.com ([2002:a17:903:2ce:b0:226:4240:2027])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5cf:b0:215:94eb:adb6 with SMTP id d9443c01a7336-22bea4efe58mr23857515ad.40.1744343286238;
 Thu, 10 Apr 2025 20:48:06 -0700 (PDT)
Date: Thu, 10 Apr 2025 20:47:48 -0700
In-Reply-To: <20250320015551.2157511-13-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-13-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411034748.1781232-1-changyuanl@google.com>
Subject: Re: [PATCH v5 12/16] arm64: add KHO support
From: Changyuan Lyu <changyuanl@google.com>
To: changyuanl@google.com
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	rppt@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_204807_976791_40E41DCE 
X-CRM114-Status: GOOD (  15.70  )
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

On Wed, Mar 19, 2025 at 18:55:47 -0700, Changyuan Lyu <changyuanl@google.com> wrote:
> From: Alexander Graf <graf@amazon.com>
> [...]
> +/**
> + * early_init_dt_check_kho - Decode info required for kexec handover from DT
> + */
> +static void __init early_init_dt_check_kho(void)
> +{
> +	unsigned long node = chosen_node_offset;
> +	u64 kho_start, scratch_start, scratch_size;
> +	const __be32 *p;
> +	int l;
> +
> +	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER) || (long)node < 0)
> +		return;
> +
> +	p = of_get_flat_dt_prop(node, "linux,kho-fdt", &l);
> +	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
> +		return;
> +
> +	kho_start = dt_mem_next_cell(dt_root_addr_cells, &p);
> +
> +	p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
> +	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
> +		return;
> +
> +	scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
> +	scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
> +
> +	kho_populate(kho_start, scratch_start, scratch_size);
> +}
> [...]
> +static int kho_add_chosen(const struct kimage *image, void *fdt, int chosen_node)
> +{
> +	int ret = 0;
> +#ifdef CONFIG_KEXEC_HANDOVER
> +	phys_addr_t dt_mem = 0;
> +	phys_addr_t dt_len = 0;
> +	phys_addr_t scratch_mem = 0;
> +	phys_addr_t scratch_len = 0;
> +
> +	if (!image->kho.fdt || !image->kho.scratch)
> +		return 0;
> +
> +	dt_mem = image->kho.fdt->mem;
> +	dt_len = image->kho.fdt->memsz;
> +
> +	scratch_mem = image->kho.scratch->mem;
> +	scratch_len = image->kho.scratch->bufsz;
> +
> +	pr_debug("Adding kho metadata to DT");
> +
> +	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-fdt",
> +				       dt_mem, dt_len);
> +	if (ret)
> +		return ret;
> +
> +	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-scratch",
> +				       scratch_mem, scratch_len);

While testing on ARM64 today, I realized that calling "fdt_appendprop_addrrange"
here intercedes a bug that prevents consecutive KHO-enabled kexecs.

Suppose we do KHO kexec from kernel 1 to kernel 2 and then from kernel 2 to
kernel 3. The firmware DT got by kernel 2 from kernel 1 already has
"linux,kho-fdt" and "linux,kho-scratch" in the "chosen" node. And when KHO
kexec-ing to kernel 3 from kernel 2, kernel 2 will __append__ the its KHO
FDT address to the "linux,kho-fdt". Thus the "linux,kho-fdt" received by
kernel 3 contains 2 address ranges. Kernel 3 would fail at
early_init_dt_check_kho() above.

I will fix this bug in v6.

> +
> +#endif /* CONFIG_KEXEC_HANDOVER */
> +	return ret;
> +}
> [...]

Best,
Changyuan

