Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76200C79F82
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j2r0KoKgq2hanpcV5bTU2teAuvBMeSQzSfhGhjq68n4=; b=hrxIPxcMT4dJlOrT2M2/jfp1Do
	BW59F6WUyCAAJLGBds96WpJZKrLpH7zVsqPA91aBgCbmYcGlnLOGVqTwft/Kkboem+e34uLajgdkV
	EcL2lg2Fm+7vLW4zqDzdesvLLYE+eQVmdp3YLOemPETMrbdWdw4M7JuOGCsKDEUPYNLKOO1O2o0eE
	l8fUIQ7Dg99W5vKZzWE+rhidPzGrbRuJV1/966qWIr+dnA75lZBRZX+ztl24JJfXynuniiCL4ga3u
	/9+YlTwcYqr6/LV5jwCCeTxtkBS9/1+qQU08NeCp1slzeb8tKAYehpDzK/pr8U8CFlJmjkbXtkr41
	+0vhcYPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Wp0-00000002k2L-2Qo5;
	Fri, 04 Sep 2026 16:31:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Woz-00000002k1r-0EBw
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 16:31:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 304666053B;
	Fri,  4 Sep 2026 16:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9101F00A3D;
	Fri,  4 Sep 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788539479;
	bh=j2r0KoKgq2hanpcV5bTU2teAuvBMeSQzSfhGhjq68n4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RSemKsnrj3pHIuCVbsnDLx/wt1VFKGCe9P1UdS6sS6D04rgIzeYeog59OxZ2EqvG3
	 4AoaR2OnVKDz1Co0MgXRuABNi4x2XQX+ZYdHLu3iM/VWdythmpqCdnMLx6+XYGm1BO
	 JNO8PsqwfVAFpnfg/FhSD3yh990j6d+v+ucSzEtu7vyOBpUTIkni94ouoUaJMs6CVv
	 a49FcY6Et2SNenPmkKiozk8+UywCqZhX49cOrgY6YA8Lg+7pgnuKd6A0jjpme3RJzw
	 ZqIwYCT6BiFXcFWD/D7XByQ+oYxuP1mxJrw4CLvt9wIQONyOE2XdEcb6gcq0wPPzhF
	 1hAhD7grQ0peA==
From: Pratyush Yadav <pratyush@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  shuah@kernel.org,  ardb@kernel.org,
  guodongtai@kylinos.cn,  kernel@xen0n.name,  graf@amazon.com,
  liukexin@kylinos.cn,  loongarch@lists.linux.dev,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-efi@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] selftests/kho: add LoongArch vmtest support
In-Reply-To: <20260904031108.11986-1-dongtai.guo@linux.dev> (George Guo's
	message of "Fri, 4 Sep 2026 11:11:08 +0800")
References: <20260807103714.33074-5-dongtai.guo@linux.dev>
	<20260904031108.11986-1-dongtai.guo@linux.dev>
Date: Fri, 04 Sep 2026 18:31:15 +0200
Message-ID: <2vxzpkytvuzw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Sep 04 2026, George Guo wrote:

> Hi,
>
> While preparing v5, I retested the LoongArch vmtest without the explicit
> `kho_scratch=16M,16M,16M` setting. That setting was masking a pre-existing
> bug in the generic percentage-based KHO scratch sizing.
>
> The percentage heuristic itself is reasonable, but the old implementation
> calculated each per-node baseline after allocating the lowmem and global
> scratch areas. Since memblock allocations are marked MEMBLOCK_RSRV_KERN,
> those scratch areas were counted as new kernel demand and scaled again.
>
> On the 1 GiB LoongArch guest, the 98.45 MiB reservation baseline and 32 MiB
> alignment made the old ordering request 224 MiB of lowmem scratch followed
> by 672 MiB for node 0. The node allocation failed and disabled KHO. I sent
> a separate generic fix here:
>
>   https://lore.kernel.org/loongarch/20260904025101.9959-1-dongtai.guo@linux.dev

Oh, cool! Nice find. I just wrote Sourabh (+Cc) an email [0] about this
too.

I think there is other wonky stuff going on with scratch sizing, like
global scratch being inflated. See my email [0] about that.

Let me go review that patch, since this seems to be causing a lot of
pain.

[0] https://lore.kernel.org/kexec/20260821105609.983622-1-sourabhjain@linux.ibm.com/T/#t

>
> With that fix, the total aligned request is 448 MiB and the LoongArch
> vmtest passes using the default percentage-based sizing. I also ran the x86
> KHO vmtest with the fix; it passes as well.
>
> Therefore, I will remove `kho_scratch=16M,16M,16M` from loongarch.conf in
> v5 so that it tests the default sizing path, matching the existing x86
> selftest behavior.
>
> Thanks,
> George

-- 
Regards,
Pratyush Yadav

