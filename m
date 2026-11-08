Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38E606A31C
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XKJdAJ1M;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Yloox7Wr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JK29MDVmuTI3bC659OetYO7/ux09RXcoPKlf4Kypjy4=; b=XKJdAJ1MuO+FoX
	VRZZ1Ru7FsicXyg3PI5evR32GnMKZ/7DiEuoUuORHGajxi1bHz0ByTdd7mykrDvYmbSj90ZeYsp7Q
	fILZalhLDUySBlR6d3pcVfGzAJKywnE3SmRSV7lFP/B5rhGqcdKvYo2VI9hF+JZPz7CoYq3q9IN6I
	aFWKqb/LGGrep2/V9EgwVYdfl+vAsyQ7ek+ASRbrv1tiY9dREf/KSr1MP1uvjYavCgtF0QXLpkmay
	KKXRDWZeWznWyxGoy7UViI95+uiljOcikfjZE0Eu3q833gRPKOD/OBehkH6r9ux2RgZKEBHoPiVH8
	IWjvZK6gCVAr9t2W7c9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ5G6-0000000GMpu-3vMi;
	Sun, 08 Nov 2026 15:56:42 +0000
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ5Fx-0000000GMpD-1eSS
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 15:56:34 +0000
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-5ecda93627eso38757e0c.1
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 07:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794153392; x=1794758192; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JK29MDVmuTI3bC659OetYO7/ux09RXcoPKlf4Kypjy4=;
        b=Yloox7WrRsNNZaLSV7Jd+eF5yJpcDUsmulDa6GafFtubvNGtTgDwN60C3ZDEWfN67R
         JnWZUe0rm0mGHjLF3fjSD9RQ2nG3AznqRzBhoJ5D9WIuLE2V7XHEQxNOn+hrnZP4G+QG
         XAkRdvZ0UGn8iuu+9vw92UwBMN1uUNB6FktC83AThhEELVicpSEuVLZnwL4kML6LkeAW
         0sEUEb2rVY6vhXEsIuewm//cyb9YRi37ZsjdY1Gbn4k99nbweUJP8oZ4j9+boAG8acxr
         uYqKVf8qN0j+55v8BbwSz5+2F5Lz1Crzy1uZRKIoNY67nnBcDknJGZN7ftF3WwC2Povp
         35dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794153392; x=1794758192;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JK29MDVmuTI3bC659OetYO7/ux09RXcoPKlf4Kypjy4=;
        b=uP5I6PSh8K125MFaMQFTpdLqoiIp0LXq9BYR8tTpld4RT90kyElkYG4f7A9HHZXg7K
         3Ya+ZyXuSBV5mQ//pmuwuwin0b9wh3lEKOkwHPVNlE4VwxkoMmcqgHn2DkCID6Vdhfxx
         kDwxDGbNSvix3YPW2YlLb/v2mQIaeaZNkiXYIgA4oXsPn9+yWItYdkroMK/LCCW9W452
         DpCj0Nj5K5qLhUkz1XyPTk5wNp4gT4cPemXa2sy+TuJ8UqQVnVtnv3xxSNpEJp4VeVUB
         Ktgcvb/eg8um7l1j9Eaq4mLf+8ZA8Ubb3d1NptOiYzpJpE+C/Lqeryh/0K01cJUbFnld
         yDQQ==
X-Forwarded-Encrypted: i=1; AL+hErFfVcKbID6PWmGOaPzQzPSqaWdWQZ1vtJeXahW5pe2IqKPm0PX8fuIXqUbCs8W/t/9oU/nn8Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z+hHPgW3wFFTXOFgOdg/lgBZGC6FH+rwrWxTBvOmrgGc3/urdXB
	g7iyJJCQhK+0EFq4gTtMX5dqSXySu/cVJGWM1G/zi+UKeNWZ/v+xFobeM1/s01JpYms=
X-Gm-Gg: AYBFou2OysIJ9Lgkaw9oYPzY4xaXW4YbXfTJK522lsZ14muqmp7NT7Iq+BglBOpdBrm
	5g3+z64lXZ8S86hpIDrcMSySfXmbfPGpgPMpq5/2vd4jKfFprHKMGLZhbAX1T1fA0VDYMCtySI3
	xoT6usveRY1tPIfM8T8ql05OjX8Z45StUzwrZ0xdfuV1c2EgFtlUJdK5hzWS7S0xYUUL+IlboiQ
	rJA1VxxRBH94T2VA0z8170yRfolKlMAZ8QJV67ue1aUpIbPUfRgqtYj8qtDQzXjdu/PcxvLpdbe
	O2r+5hsezJaqak9eGSd4ZEepBJhWpi8zGZO3HzgeJn++Tpi2UDcKOj8YSJECexbF9kNJhDTAWT8
	GL5+1KGBojAQ9FsEcULDeZ8LpatB/YhQZVrB1NZbAyRrMr3hUwz28o9nFtyu/9+nUA3sh2ZgDW8
	OzVkHvrElbEObpNwcTB9GCYDg9pCCpKvb/0Xr48jUqqfGujfwrOxxRFTxQQesaJmqUBx9dwyVuQ
	jbqYAPtYp4SMfT214oIjr1cIJFpSLSdVLXaURksfVGKZC6AqIAqHQgSnEM9on+QvH6pDZW4SO8g
	GRiW6d3iKisM2meEDQlKIXcBODxM6BsodSa71kToHAHunKRNEGenqfCDPf5iHYp+oxEnFsSkVRZ
	7F6cajcs4UpYEdC1cD0w98Tc6ZKb1IViE7c6feL4YNBGbJOgmDuIKydkCxsm2UZK7kzpy
X-Received: by 2002:a05:6123:64:b0:5c9:a60b:e5c0 with SMTP id 71dfb90a1353d-5ece724fbd5mr492168e0c.16.1794153391927;
        Sun, 08 Nov 2026 07:56:31 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece6069662sm2078039e0c.5.2026.11.08.07.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:56:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] kho: check fdt_phys in is_kho_boot()
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Greg Thelen <gthelen@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261023054518.3258350-1-gthelen@google.com>
References: <20261023054518.3258350-1-gthelen@google.com>
Date: Sun, 08 Nov 2026 10:56:28 -0500
Message-Id: <179415338854.358073.9410769433043113739.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=mM2B1WNxYEzouTeXd1iMrrTZ9Kih7nqHtFvmUB5THMA=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8JuuMqQ0q2iiQjSKjFS6r+naeIRZABjkt1NEg
 9AFf7Sq2OOJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavCbrgAKCRC7dyhM23N6
 3kMmD/9uCE4nQFVuk15wOnI9NIxeSab1p5bGiQyaOO1FPMifDpfLJgy4YhFU1/HPX9XWn5ekYEg
 p0qr/AVUD+JXW/MxeCXhsPafSlziDGPcHhcZrrgdOG6ro39EIj6WrS77ta3QhQWcqh6+vGvEem2
 yGrcqfR5If1LYD/jiNemKuLGvElD+xnG1Q+GVn9PLm0szTidchmpiESGFf82iOd8R+pmIgr1Cw0
 FBebpRNz3Ju2Kvk66F1ekS01vnGyX+Eo4QhuHPcPP+wrjZTgLR7x24wV5T80aQGDHamLZQqMtal
 TqzeATUi4YvNQMsavBwZ6Y13Majg8MnDaFWK5ClMDThk+WtmaTQ1GgN09AsoQHp9kEcfWVEBRGU
 9yCNx1+3Oxl6gg1I5qbGxYIMW1JF4sKPEISWrRN3hkK9wlK0zuPF4AljgRiHDjvimUfWmM+iduS
 1hk3ldlqQKmkQXwG8qVbAPHxzJzHISCjJo5UyiEOu74OZXxD2pUaUVJzsLtNis+5Js/ndbko80p
 3w6ENK7E800cYwSL8v374m4vHg+Vzr0/iLwf+9sCPUtMhfYJLugrMkxYb6sSsqSsLEtEcuztmEJ
 3kajzAcRiLi+lQn2EIvjWexnxSCodVLr3gsDdJJ/QkYjGsyb98dgsTCp/1xi78lGcH38cAR+aYw
 CRs86UV2DQ0ZQxg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_075633_472196_CB8CB83E 
X-CRM114-Status: GOOD (  10.05  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I am planning to take this patch, and change the commit message as 
follows to address Mike's concern:

> During arm64 setup_arch(), efi_init() -> reserve_regions() calls
> is_kho_boot() before arm64_memblock_init() initializes memstart_addr.
> At this point memstart_addr still holds its initial sentinel value (-1).
> 
> When booting via kexec with KHO enabled, kho_populate() sets
> kho_in.fdt_phys from the /chosen FDT node. Calling is_kho_boot() ->
> kho_get_fdt() invokes phys_to_virt(kho_in.fdt_phys), which evaluates
> PHYS_OFFSET and triggers VM_BUG_ON(memstart_addr & 1) on arm64 kernels
> built with CONFIG_DEBUG_VM=y:

Repalce the above two parapgraphs with:

is_kho_boot() is called early in boot before the linear memory map is 
initialized, so calling phys_to_virt() via kho_get_fdt() there is 
invalid.

On arm64 (and similarly in upcoming riscv64 support), this triggers 
BUG_ONs in debug builds, such as:

> 
>   kernel BUG at ./arch/arm64/include/asm/memory.h:377!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   Call trace:
>    is_kho_boot+0x2c/0x38 (P)
>    efi_init+0x94/0xf8
>    setup_arch+0xf0/0x240
>    start_kernel+0x84/0x490
>    __primary_switched+0x88/0x98
> 
> Check kho_in.fdt_phys directly in is_kho_boot() instead of calling
> kho_get_fdt() so that early boot callers do not invoke phys_to_virt()
> before the linear map offset is initialized.

Replace the above with:

Use kho_in.fdt_phys in is_kho_boot() directly instead of translating it 
to a virtual address.

-- 
Pasha


