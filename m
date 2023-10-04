Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEFAE7B5F9
	for <kexec@archiver.kernel.org>; Wed,  4 Oct 2023 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R8q2U9v23QRTD0ma7wbnLoew1iFmvA22PL5b9N7t7zA=; b=uroTTburhelYhl
	8GvaWnErLz/EJpl0AHDxtimFTZ/kNfA1KZMQ/SkayjSqL5qiTLVmh64QCVljJFM6xLT8ljhr9k+yA
	94qi0/0EJjcQNp+vmfnFKt42ottEJ9TJohsbtzhKMQLOps/MDv36Wjt62ELhQYut2glBYEgouCtfa
	ucwbfjQ+8Hy1mZZFsXfGEnxBpHXvyeURNfC0EXo5l1eTZVrU8u3SXh3ABKB0Rk79J4bnI27UE9tVQ
	rklEQXETwyyPyyGtYBdAD1Xrtjp/5Dx+TfXkBudQRZKweG3k417/yv2RMeVNquWAet8yzCno/SkaS
	zzqcz0N2mS5Rl9zazcxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0gp-00HZMv-2v;
	Wed, 04 Oct 2023 12:09:19 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0gm-00HZLL-1j
	for kexec@lists.infradead.org;
	Wed, 04 Oct 2023 12:09:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 36270B81D0C;
	Wed,  4 Oct 2023 12:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0197FC433C8;
	Wed,  4 Oct 2023 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696421354;
	bh=12GWZ5PwV1a0IDQPnx15PvCUAneryVPGQPcj0UMG3ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/xVru/pVExyfQgw5P6c65Qbhr1CuTeClqTW/n/bDNUZKtDohpZjdwWL3W0gBHM1V
	 DyFXbT2asU3zYQHrgXBge6kA7j9IgR/aYooPIBzi5IveiU9QpSOp+5xKdX6nsJNp6A
	 sCjC524n0PGItvLBLexkJC75Mzp72iM6BbZbNwiRXu9W+4rSjXfTWzMbA0xc5tid3w
	 UNVW8zdtccHGg8dmN7DWYF/g73c95hksbJGQX5RKQu3bF1KE/OmK+4ktT0RoYdZaia
	 rGpj3onmG/d4enHjeM1s8Hu/48c6XRakgPBas/y8qBKBth00HvxweQ/t9J5szYCcp4
	 0BPYsaKqMFgUQ==
Date: Wed, 4 Oct 2023 14:09:11 +0200
From: Simon Horman <horms@kernel.org>
To: Julien Olivain <ju.o@free.fr>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH 1/1] kexec: provide a memfd_create() wrapper if not
 present in libc
Message-ID: <ZR1V5yARQ3sDU8qw@kernel.org>
References: <20230923164606.58424-1-ju.o@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230923164606.58424-1-ju.o@free.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_050916_847148_7D1D5DF6 
X-CRM114-Status: GOOD (  21.46  )
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

On Sat, Sep 23, 2023 at 06:46:06PM +0200, Julien Olivain wrote:
> Commit 714fa115 "kexec/arm64: Simplify the code for zImage" introduced
> a use of the memfd_create() system call, included in version
> kexec-tools v2.0.27.
> 
> This system call was introduced in kernel commit [1], first included
> in kernel v3.17 (released on 2014-10-05).
> 
> The memfd_create() glibc wrapper function was added much later in
> commit [2], first included in glibc version 2.27 (released on
> 2018-02-01).
> 
> This direct use memfd_create() introduced a requirement on
> Kernel >= 3.17 and glibc >= 2.27.
> 
> There is old toolchains like [3] for example (which ships gcc 7.3.1,
> glibc 2.25 and includes kernel v4.10 headers), that can still be used
> to build newer kernels. Even if such toolchains can be seen as
> outdated, they are is still claimed as supported by recent kernel.
> For example, Kernel v6.5.5 has a requirement on gcc version 5.1 and
> greater. See [4].
> 
> Moreover, kexec-tools <= 2.0.26 could be compiled using recent
> toolchains with alternative libc (e.g. uclibc-ng, musl) which are not
> providing the memfd_create() wrapper.
> 
> When compiling kexec-tools v2.0.27 with a toolchain not providing the
> memfd_create() syscall wrapper, the compilation fail with message:
> 
>     kexec/kexec.c: In function 'copybuf_memfd':
>     kexec/kexec.c:645:7: warning: implicit declaration of function 'memfd_create'; did you mean 'SYS_memfd_create'? [-Wimplicit-function-declaration]
>       fd = memfd_create("kernel", MFD_ALLOW_SEALING);
>            ^~~~~~~~~~~~
>            SYS_memfd_create
>     kexec/kexec.c:645:30: error: 'MFD_ALLOW_SEALING' undeclared (first use in this function); did you mean '_PC_ALLOC_SIZE_MIN'?
>       fd = memfd_create("kernel", MFD_ALLOW_SEALING);
>                                   ^~~~~~~~~~~~~~~~~
>                                   _PC_ALLOC_SIZE_MIN
> 
> In order to let kexec-tools compile in a wider range of configurations,
> this commit adds a memfd_create() function check in autoconf configure
> script, and adds a system call wrapper which will be used if the
> function is not available. With this commit, the environment
> requirement is relaxed to only kernel >= v3.17.
> 
> Note: this issue was found in kexec-tools integration in Buildroot [5]
> using the command "utils/test-pkg -a -p kexec", which tests many
> toolchain/arch combinations.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=9183df25fe7b194563db3fec6dc3202a5855839c
> [2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=59d2cbb1fe4b8601d5cbd359c3806973eab6c62d
> [3] https://releases.linaro.org/components/toolchain/binaries/7.3-2018.05/aarch64-linux-gnu/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/process/changes.rst?h=v6.5.5#n32
> [5] https://buildroot.org/
> 
> Signed-off-by: Julien Olivain <ju.o@free.fr>

Thanks Julien,

applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
