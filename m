Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999C8C021B2
	for <kexec@archiver.kernel.org>; Mon, 24 Feb 2025 03:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjsUMYFp+Mx49YvN7hD/3KWP7s9neIA8zwh6iIzC7CU=; b=vxQDKAUjmo+1bnsDLHG2iLMoRy
	8wrgVptKCsWNqWWkZJJyeyCG06cWf+97LhOjTF1XwMlbI3fGx/BlxyyN0NE0m3zmjYQ3srj/GdIzu
	ZL50WenEM2sra59b+7JdFkPdwWru7L29hDbejYhA1HyF2uOb9nxmD+FPeXiZPmK9uWHcTrcSQieop
	wJBclS1hXjUGF/RMVbgDgKyf8JrGmCUmM7otoBFWJNJHzbYLc6moiZIegABEz0pA43SihlzkmaNtM
	qkEDsn4jGARGXroG6elcRxUes6ckkQu1YDq0ZS0b26oHBj9MU6KlZNXxFq9tHmQHYNd7khIFk2M8A
	pG9mE4CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOk4-0000000CCnM-3Jtc;
	Mon, 24 Feb 2025 03:02:48 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOk1-0000000CCma-3n52;
	Mon, 24 Feb 2025 03:02:47 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so7197279a12.3;
        Sun, 23 Feb 2025 19:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740366164; x=1740970964; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjsUMYFp+Mx49YvN7hD/3KWP7s9neIA8zwh6iIzC7CU=;
        b=GZo2zeJ8j87XYzad07BhUf0iqb/HM9mZ7apEQDzceMuFyHqpS/lKvwKhhxupW+qJJ6
         whGppcRkrSv55Sc+x+A9p5X4b9Is/l5f4P30dXeCPqsjkoHmF3wMZ1wA9/7RpB7g4T8f
         u2qrS5G/3jgeGSvbN64rvtkEEtVoS66Y/puuZ6XEUwA88HvNrS58GvCzb5pk8gKi6oAN
         UgIkA7JPThtreMq/6+9GR7pX4gEvgXBqVl4lOoUn7WKv65zfVHtBt7eDaVI9Or1wAENt
         d16MQAF4Ml9MQlxpAJ2NrtXwFKbrNuSWtlHZUphiHWv4d2AR25X1dZts04cUzhVL97UQ
         dMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740366164; x=1740970964;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SjsUMYFp+Mx49YvN7hD/3KWP7s9neIA8zwh6iIzC7CU=;
        b=bTPwIrSwcBuXUZjAtmPTGIoFnXxOaqIktmnTxaxx8quF3Ny4oEW+CgF3dUky4i4QHR
         al4c3XZbTdxZ3mBdzDYXTn/+P+40HWaKdGhRj3Fzfe8emGsmaMhGSxoZW/r4pRjvYufR
         fA+Xgh7kaTjtqQvsmcd5LN0aOoZMJ6OAdP0uJAptcBqoeMyotvrKxMD7eKgCB3YcA83M
         p5vdwUElI6lw2T9QI+PSDxkxut1ddmP1rMZ4bAJN13z12QFLHn+6dJXz6+0bs5wNo0eF
         kjqL8WFddOvnveVx4I8e+/hPtQB0moR/zxpQBdNGZKvipu0mPFych3ImdP11kFCCcg0L
         6TVA==
X-Forwarded-Encrypted: i=1; AJvYcCW0iNqf3GChttDK0LQeCKw8C8z4pmj6HInQIL8o0u70qHl6xU4l59dNa8Wg7JFvwVPXijNB8kguNyWMW/Xhgo/lqA==@lists.infradead.org, AJvYcCX3Ek8uKoNA3D0oUrmi0HGqHJAGpNsl1lodXIkqtD3A/Jnp4j0xQz8qWAsStU0uRHNyzCUyzw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzDT9e6zygVp0EkkK0OM8TsOQk2d+UZKJOaWpGRpSKVSEj1EKFa
	BP0a4+V22eAF6Hb7ntXMFt14rk8IovKVKlrgPNCOV39S+gSSJoyC
X-Gm-Gg: ASbGncstN2TWsGAATmr9XQROwYPQXp77jBllpAi/43P1HSrDXVBMqguMf5YqveMSArQ
	QBaiBByuL7gCOr3O9cm1UBoA5/ob39hltYWksqxLSU5tLWQhEijq80d/k87e7SyTQjKMnKiNsG/
	pCJ/9t9G9OcG4PdxWBvtqmfphhx6XlI07BvW7pWhgBHdUfsY/YEUh0p2nN+uK28dTZbo+HPnck4
	/PEOY8mOueD5pcxaoVqh+WL6zvRO6pO/mxO8AcC51CSumIBCYzc6c+yHWuFVkj+YvTOTfzE2gOJ
	Utpm9by4BqQv4lPgD6Lw9u5W3A==
X-Google-Smtp-Source: AGHT+IHzUc14TKjsGWWce5aAn1HH4tsAMVuHoPc6eeAzqtQVN04INfU1hh5sqPpMyJ9gzD/SRveTag==
X-Received: by 2002:a17:906:c148:b0:ab7:b250:aaa with SMTP id a640c23a62f3a-abc0df5a73cmr933979066b.54.1740366163994;
        Sun, 23 Feb 2025 19:02:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb961594absm1510893366b.111.2025.02.23.19.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2025 19:02:43 -0800 (PST)
Date: Mon, 24 Feb 2025 03:02:42 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 04/14] memblock: introduce memmap_init_kho_scratch()
Message-ID: <20250224030242.rdmzcdrth6qmlims@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-5-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_190245_950606_5BC2A96B 
X-CRM114-Status: GOOD (  12.48  )
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Feb 06, 2025 at 03:27:44PM +0200, Mike Rapoport wrote:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
>With deferred initialization of struct page it will be necessary to
>initialize memory map for KHO scratch regions early.
>
>Add memmap_init_kho_scratch() method that will allow such initialization

memmap_init_kho_scratch_pages ?

>in upcoming patches.
>

-- 
Wei Yang
Help you, Help me

