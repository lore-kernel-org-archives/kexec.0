Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA96DC0755A
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 13:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fH0M5vJkEyyZ+Ppbz+hh5HO3icUw75GU4ouZzArY1Fw=; b=D4oHrB5RQFlhAe
	oTbnzPZAgsMoePkitJhO5L3EIG9dzjuQjr7qrufPy3T09f9C8Ya8rx9fdXEiq8JysOYYtIwcPp6dt
	wKjJZq6eEmXW7BaUTSgImU7brQ0UVwKQgxbWlF30xnW4w6qml58tdkipxkG215tQ16h03HZdPPq/9
	8/FPE0MuEfv9yekj4IIpSTMX4BSvK32mT+oNuQCv7ZEmq7iaGmo8epEvqZMMvEPIZaEUa5aKg4gBt
	0ml7JWRmzEpuJ/1DMMYMSFcc08XqywYl0oAiiL0EpQ6XdnzQRokZ2WwAjkPSrzWFJL/Fei6FbLwsm
	RbNLJr3tokzILrWUeS/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7bwo-002bUf-2u;
	Mon, 27 Nov 2023 13:46:50 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7bwl-002bTM-0f
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 13:46:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 78B3FCE124A;
	Mon, 27 Nov 2023 13:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE314C433CC;
	Mon, 27 Nov 2023 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701092793;
	bh=wZRAQ/iOE0cqMKN7vQ6ujnAekEzC6TOQC8BNgOsWCSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDDrEP+MTqT27OgrZwZmhQyUGeUkvbmbpETX4tyMxdFn5BwIZH2A8yJEO2QIoDZif
	 GorrUSJxe94sDvIe5KYzNtIF+PPanqH8r3iiIzatKw8wMvcE013tDDcNm9WoG1CjDx
	 7YJpJgx/tw0rgwr/wx4zMpejo+CqDJPkAzw4PZGcloxDqqnNc+TjVdppcQvmqA707/
	 /Jx2B2CDBUwtavcnFO6RqyDNc3sUSRspLm+sPQ0h6UbhwKpFXpVFo4QNSXKxlJg3aO
	 SRIZMXCXnKAAWgdsgCMN3WFBmKlPS9JByIWYcFGKEqbUArZK1ydnmn38znrDzdWrLQ
	 GkFYYlmKkFrQA==
Date: Mon, 27 Nov 2023 13:46:30 +0000
From: Simon Horman <horms@kernel.org>
To: Laurent Vivier <laurent@vivier.eu>
Cc: kexec@lists.infradead.org, Jason@zx2c4.com
Subject: Re: [PATCH] m68k: fix getrandom() use with uclibc
Message-ID: <20231127134630.GB3354982@kernel.org>
References: <20230422095904.1303434-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230422095904.1303434-1-laurent@vivier.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_054647_665014_233A3F6E 
X-CRM114-Status: UNSURE (   9.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, Apr 22, 2023 at 11:59:04AM +0200, Laurent Vivier wrote:
> With uclibc, getrandom() is only defined with _GNU_SOURCE, fix that:
> 
> kexec/arch/m68k/bootinfo.c: In function 'bootinfo_add_rng_seed':
> kexec/arch/m68k/bootinfo.c:231:13: warning: implicit declaration of function 'getrandom'; did you mean 'srandom'? [-Wimplicit-function-declaration]
>   231 |         if (getrandom(bi->rng_seed.data, RNG_SEED_LEN, GRND_NONBLOCK) != RNG_SEED_LEN) {
>       |             ^~~~~~~~~
>       |             srandom
> kexec/arch/m68k/bootinfo.c:231:56: error: 'GRND_NONBLOCK' undeclared (first use in this function)
>   231 |         if (getrandom(bi->rng_seed.data, RNG_SEED_LEN, GRND_NONBLOCK) != RNG_SEED_LEN) {
>       |                                                        ^~~~~~~~~~~~~
> 
> Fixes:  b9de05184816 ("m68k: pass rng seed via BI_RNG_SEED")
> Cc: Jason@zx2c4.com
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
