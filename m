Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B98ECD98F2
	for <kexec@archiver.kernel.org>; Thu, 18 Jun 2026 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9zs3o8mtyZf6a3mEQ56g0Zln0Vd2kWO9rUcsd+oFz5A=; b=UBX0I9uyJagh+m4Ro8Ikc5dpK0
	da0Ow41+VfiYCsBihMR6ya4EhH55sZXvcxwFsRXdYFvmac9CCUQmdHJDEJNhtrx+dcKY8R3UstGLV
	0sLvv0eg9lt74B+XMgVEeQ7X43Ny37GNaQT++wak2klsPXBKfTYuTxXbToWmBYvCk1DFKhxFAkGVI
	FQXnNhSfRObmgbb9ywkbGzdAQRYGh3q1w3ZXMz3GaDeSUVm2p5h8Z9cvV+SRzlhe+6krATDeSe6K2
	vToEYae7I54NVO5bI8tXJ/2JzmxNRM4LbSz2Pux/tGQkRKWRkMBWQIWA9I9Y3Ha55uNk/IC3wfHHE
	hqAMlIxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waAGK-000000017ZU-1m6b;
	Thu, 18 Jun 2026 10:46:20 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waAGH-000000017YS-4AMX
	for kexec@lists.infradead.org;
	Thu, 18 Jun 2026 10:46:19 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-4645995069bso257276f8f.1
        for <kexec@lists.infradead.org>; Thu, 18 Jun 2026 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781779576; x=1782384376; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9zs3o8mtyZf6a3mEQ56g0Zln0Vd2kWO9rUcsd+oFz5A=;
        b=DRfUU8QbDrPytz4JWDsdujxcC3q2L+knKPGA9svGIriN4FOqPUMJhhhjRON624zmbx
         NZrAT6LFYSkjSrtVdBq4J1odKprD0SRAdCKwSYVFl/4nbNoPnXxUDD5m/zna8Plxka26
         i+2rtqjbc2xhhRQkSGWI7NGFbS3berWTECzMasCDC5+G129BDAAbGJBwPCKvZHcDr3KG
         DolZzgieeNSDy4FN26HjTSei8z7t10sz11869fflZS4YUjA42YPUIQyibS6BNzNTz3Vr
         5sVeg9TrjrTY4lqaXzWPYSfFKqgPMwtqaKoOPQdA8hf1wpExkXLXozafCxsqC/rISIsw
         0u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779576; x=1782384376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zs3o8mtyZf6a3mEQ56g0Zln0Vd2kWO9rUcsd+oFz5A=;
        b=dp/OzehajqAGF40m3xVQKfsG+O2cdn5tRevY21DyNuD4xf+1gjowNCzGeuuU6OaTdG
         gB+AfKWrcXT//ct7gp9F7smRkRS4udm7g3+brBuDIm1c4Gnia9M/870RPP7c10Gve2Cv
         z+ii+rJ7/WqbFOONc2sEt9EFsd3soTlZuNt87/RwMiaXYBc8FsB+VU5ftvo9wp7TVEaP
         uZMwfQ7wdhvhdMHxgU//0/nssuX+0AolxgxDUtN1V89a2I1AnJ/uFORahI+8E1uIftHN
         Yu5RW4jXBmaX+jLYPnYEntrowgkcoJW5mF0fDurj3DNvpF/eGKvjw4byZkZCswy5EFtQ
         naQw==
X-Forwarded-Encrypted: i=1; AFNElJ9T3tYoPsEMpa7OvHtzpr4SniAgZ+UdoqxY2ozpZlAQapVWgj0atp4vxGDBg+7HXFmClwUC2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHDchWawtBdWjNXnAiQjgu1hARgK1tj/9b6JZvhKJkRiMzUYe4
	MuleF2sN6snSLcdstwNas/Ki/Rfwlcase4+MTp0L5qOR0ZTNPfJeCd75
X-Gm-Gg: AfdE7cmZQQ30leEiLYJMmZjzpbMxszsFlI0KkXP+0pR2i6mpxtt+sjezFyhspQ/7Qpx
	UKdRXGhy0ChiYNNjTTn+crPxryuoAeW1Wm32HmbTs7c5Ra43AHrlXKiZHvs4d0Nx1yBD4pRvS9w
	T3g6m0Is1YFSEKwomleF+3jgIdVJSJHBPmu3SwRFm/dhx9hiydVbVAugcruQFgOCdhNL9UmOT7A
	r8utD4nEITSTVvloOIYvaLj3QdQMmfMXVVx0ob5yEfky18rDOdWeZ7CcyDEYlG/pYIZVDDG6KlO
	LqGD12f8OokPSTsdl85bUJzSmIy5r5YutaQatdlhz1HPkEaLJfIP2584KZlCqoS2W80DhouhB4T
	xieq1H4FKzBCjSYOitgrrNGZXUSTTEY5MhFI5tG8MXy8ItufP9sSR/9X0e/V4eRdwPjW3W8Y+5h
	f/37AUizlZT/CTcMYdstMdn2RqRMK3k6x49GuOJaCtIVrfLL7Egyd2i/cRAS4+NuOEQReLfgz2L
	rV1T9es2a8M0kc51w==
X-Received: by 2002:adf:ec05:0:b0:45e:f780:6177 with SMTP id ffacd0b85a97d-463ab7020cemr3850916f8f.18.1781779575898;
        Thu, 18 Jun 2026 03:46:15 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d70sm62509268f8f.19.2026.06.18.03.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:46:15 -0700 (PDT)
Message-ID: <a372e209-fbf9-417f-ad08-226cb7025949@gmail.com>
Date: Thu, 18 Jun 2026 11:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] drivers/firmware: add SDEI cross-CPU NMI service
 for arm64
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Doug Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>,
 Breno Leitao <leitao@debian.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 kernel-team@meta.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
References: <cover.1781709543.git.kas@kernel.org>
 <cover.1781709543.git.kas@kernel.org>
 <ab745689c0bfd01438d98ed1c79328bf2121be3b.1781709543.git.kas@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <ab745689c0bfd01438d98ed1c79328bf2121be3b.1781709543.git.kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_034618_036504_B77FE330 
X-CRM114-Status: UNSURE (   7.77  )
X-CRM114-Notice: Please train this message.
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

Hi Kiryl,

On 6/17/26 20:20, Kiryl Shutsemau wrote:

> +config ARM_SDEI_NMI
> +	bool "SDEI-based cross-CPU NMI service (arm64)"
> +	depends on ARM64 && ARM_SDE_INTERFACE
The dependency on ARM64 is redundant here since you already have the
dependency on ARM_SDE_INTERFACE. Maybe a comment instead, though I think
it's pretty clear from the prompt...


- Julian Braha

