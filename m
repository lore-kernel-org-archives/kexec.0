Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70907CAC582
	for <kexec@archiver.kernel.org>; Wed, 10 Sep 2025 00:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+7i6AL/giGG8sDoDggEW2tn65nUMUUOKofKssaLcy1w=; b=1SDAgUDIsFqWSLvZ7m16pfE7c2
	WiSaJZi62vXxnZK8cVeWXtTuT0m2io8zqwzY1brgfSeTWDnPWAE/jXQ0a/tWZjp2zoIne4sx99DVT
	OdC6vD3lkhhYIp76Jp3u8gZrWQdBy9TEMD4ppQvymMBGeyFln0NPZCef5u1fx2Y3HN9K5TnTppRKq
	V/Cr6FGoPXnd5G4qecXIG+69hhhgQ2QPhxw5fxJ4BaLkRArjWwgwmpT6Js0nxIYntqHQsNTBx58Zz
	FTQ51ggbUxg6EN0sUH95s0hj2eSB75VXdlyJDcuVeMlX/171LNi05hvF5vKagqae7FP8QrTu6kVlI
	dUG7pjFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw8lz-0000000BBPE-3K6e;
	Wed, 10 Sep 2025 00:33:19 +0000
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw8lw-0000000BBNh-38jX;
	Wed, 10 Sep 2025 00:33:16 +0000
Message-ID: <1c79b3c7-5847-4960-9454-0c70d02a6441@infradead.org>
Date: Tue, 9 Sep 2025 17:33:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] kstate, test: add test module for testing kstate
 subsystem.
To: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 James Gowans <jgowans@amazon.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
 William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-6-arbn@yandex-team.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250909201446.13138-6-arbn@yandex-team.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/9/25 1:14 PM, Andrey Ryabinin wrote:
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index b6ea861006bf..af9a25bdcd6e 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -69,6 +69,14 @@ config KSTATE
>  	  state, save it into the memory and restore the state after kexec
>  	  in new kernel.
>  
> +config KSTATE_TEST
> +	bool "KSTATE test code"
> +	help
> +	  Build a simple test/playground code that is useful for kstate

	  Build simple

> +	  subsystem development. It contains some structure with different

	                                          structures
?

> +	  kind of data which migrated across kexec to the new kernel

	  kinds        which are migrated

> +	  using KSTATE.
> +

-- 
~Randy


