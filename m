Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D44BC4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 19:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dTsQu3RttaZ+SNfchXAMJ7W12nonpbooYGixdyfkDk0=; b=FUHMVwyMcNhFLI
	kBkDiRS1LjTOEDUJHXrTTsuUcSqjYyqbYgdxQkIRizluML6MSQF3If9JexCfjRb9UCkkdmdxrXXDN
	1yAY6A44lETiwcbfb93PtCoy5k8F29XBqgutkQ1VtWr/wS2ZMRLGL/7bXkMQbBMLOCn5wpr2FeYGy
	YKXJ5BaG5YktJ+HhZ7DbbvD2MbaHV7ssTUtMwgFL4OzZ6wqdZ4KeEiOvUY+zHbyLpbxt/fG4Dn490
	1VezPLqocdviJyCVZKNYN38PiEozPVlKqrUlNQfFsTqYEHq5XqRYmFj8CEgj7cTQQhjO8/h+xqOx/
	9InbYbpc131ng/8rtwvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAEOq-005QWR-2E;
	Mon, 04 Dec 2023 19:14:36 +0000
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAEOo-005QO4-2M;
	Mon, 04 Dec 2023 19:14:34 +0000
Message-ID: <17633619-fde3-4f36-b047-413e79c8116f@infradead.org>
Date: Mon, 4 Dec 2023 11:14:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv, kexec: fix dependency of two items
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
 ignat@cloudflare.com, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org, eric_devolder@yahoo.com
References: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
 <ZW04G/SKnhbE5mnX@MiWiFi-R3L-srv>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZW04G/SKnhbE5mnX@MiWiFi-R3L-srv>
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



On 12/3/23 18:23, Baoquan He wrote:
> Drop the dependency on MMU from ARCH_SUPPORTS_KEXEC and
> ARCH_SUPPORTS_KEXEC_FILE because CONFIG_MMU could be disabled while
> people may still want to have KEXEC/KEXEC_FILE functionality.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/riscv/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 95a2a06acc6a..24c1799e2ec4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -685,7 +685,7 @@ config RISCV_BOOT_SPINWAIT
>  	  If unsure what to do here, say N.
>  
>  config ARCH_SUPPORTS_KEXEC
> -	def_bool MMU
> +	def_bool y
>  
>  config ARCH_SELECTS_KEXEC
>  	def_bool y
> @@ -693,7 +693,7 @@ config ARCH_SELECTS_KEXEC
>  	select HOTPLUG_CPU if SMP
>  
>  config ARCH_SUPPORTS_KEXEC_FILE
> -	def_bool 64BIT && MMU
> +	def_bool 64BIT
>  
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y

-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
