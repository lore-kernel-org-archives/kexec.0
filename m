Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9D606A329
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iO38vUo1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ewqv2x7q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PshXrkjIu/oVh8H0uuMMexWF+3wbEqyJSvZGNZ3+nBg=; b=iO38vUo1jwJwH/16CzzRsgz4Ih
	b6NA65jjfImyw5roMKr7lkmT0ONoPZGwsKiiwGqkZFpv8aKaS7rrZPU9iBs6BsTwSFtdh/+iwD+ni
	mmeLqjhkZJoPDVo3x7V1r55Cq7k4pVnq5VAGcx4T53jcFsfcRwQo25Tdw94WyfDVYVLZE8JlaTmmH
	Rx46sIhCwU6GKnYEtysJp3bNMBmScbLg3GuvNO/735VEvBXbVMRGBIjwOIU9600GRJxFpYf+qoPJf
	liS7NjmJ5jzTNdlnEIVosnsNJAuMQRSR6xCrhY1txyzQ8ycnVbIUnPkOdW6J9z5ZusBYwP72da0Mj
	ZP1isI2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsGw-000000083ZG-0rlw;
	Thu, 05 Nov 2026 07:52:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsGu-000000083Yx-26Tx;
	Thu, 05 Nov 2026 07:52:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 82C67605FF;
	Thu,  5 Nov 2026 07:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ABD1F00A15;
	Thu,  5 Nov 2026 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793865151;
	bh=PshXrkjIu/oVh8H0uuMMexWF+3wbEqyJSvZGNZ3+nBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ewqv2x7qC/seZGztnmn60Jxwl1553DY/3Df5K32EVdXJ/LFXDDt8XPm0md4mvIdbe
	 O7baTlLtl+fjfHYpiP6NcAphW25/jd9J02KuH6IpVpOf128w6Gk/QhyuyYiZ8AkWEd
	 5I8acWTijjPru9qgJ7HQjHMGzi6ZlJdrE9q8FPGTREZLPcuF2t9RZCaCb3gZIq0i2F
	 0CenpiJNcoERzlwxTs0A3D2xG24ySM7ZrAY0uQR/yg7LLM7PxiAALyYLO9ZiDNOVS8
	 XhlU+5NQ65DYU30sIL8WOqi4fmSQc0g+DhJNmCoP27d9xfq6w4CfLjfd7xU/0Ji7zb
	 e/wsPKB9qBz9g==
Date: Thu, 5 Nov 2026 09:52:10 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	akpm@linux-foundation.org, baoquan.he@linux.dev,
	pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com,
	leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org,
	sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com,
	Yeking@red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com,
	zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org,
	adityag@linux.ibm.com, hui.wang@canonical.com,
	sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn,
	kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.com,
	piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com,
	me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: Re: [PATCH v7 00/15] kexec: Fix CMA and elf header leaks and rework
Message-ID: <auw1qgmjWko52oS_@kernel.org>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <179380419709.28814.2122135856184991710.b4-review@b4>
 <932cdfda-7030-4829-8b43-062d208450e4@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <932cdfda-7030-4829-8b43-062d208450e4@huawei.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 11:45:39AM +0800, Jinjie Ruan wrote:
> 在 2026/11/4 22:56, Mike Rapoport 写道:
>
> >> Patches 8-10 pass the kbuf fields to crash_prepare_headers() to
> >> simplfy code.
> >>
> >> Patch 11 frees the elf core header from the generic post-load cleanup.
> >>
> >> Patches 12-15 add kexec_load_other_segments() and convert the three
> >> architectures, and arch_kexec_setup_other_segments() builds
> >> the architecture specific boot parameters (a DTB or a command line).
> > 
> > I think the refactoring should go before the identical fixes in arch/
> > code.
> 
> However, this will cause trouble for the fix patch in the stable round.

That's right, but since actual fixes anyway require changes to kexec core,
I think it's better to refactor first. The core than will take care of
proper freeing in the most cases.

And since CMA support in kexec is quite new I think the entire set can be
backported to stable then.

I'm planning to have a closer look at the refactoring Really Soon :) 

> -- 
> Best regards,
> Jinjie
> 

-- 
Sincerely yours,
Mike.

