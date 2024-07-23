Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7691C3DA49
	for <kexec@archiver.kernel.org>; Tue, 23 Jul 2024 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2CMrzxPvxCZlE2IZdKmzb9BWUmWNT0LcpMPuhLPCmf4=; b=aGcGWiMKTbHYyi
	diom8jraicp7DO9f88inHrEsiOgrvSUCeTT1nMW6EWAn5J7kYTDPZtQ61ySCwOZ3S5AJSfNrWulnZ
	wi4IhLbnkQjUWb1h8dAXfZRg+IbiTjmEeFZgmuVhauIJMfREkDxlOnFxogesZ6STcTM0xAsHWji3c
	GWgPNzb2lx/FyRqakiD4CgH7n5cQbKA+fCAQdPvR/sFk7Z13AoNxvQHK0RLGj6WQ/5DZCPvFnLs1D
	y6G7PRVNXq503AVDmAfdfF9or4drMVIfUixhhpkMz6S3C9tRNWVbeeumEiUwKwlelB1ECe7ZX3Uh7
	QCjzFKFDVublBedWBG9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWCIN-0000000C5yz-2xOQ;
	Tue, 23 Jul 2024 09:58:59 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWCIK-0000000C5xO-2G2k
	for kexec@lists.infradead.org;
	Tue, 23 Jul 2024 09:58:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 24622CE0E34;
	Tue, 23 Jul 2024 09:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3344C4AF0A;
	Tue, 23 Jul 2024 09:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721728733;
	bh=g+5Q2/0jNWVF5PTuVLBW8ar9h495rkLpJi7d+4WcFQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFz8FTQLC8TlE7Z6PMpnGBPVv8+QfFNwlnic/JdVlwD1kESQw4kbpyYeOs8gWpCNU
	 gLK5Yv6KAwIQXtVYheZKdezSXl7tu464baXTXc90E+Ttj1AbRzslmBwhCS83w5GFb7
	 5zfrJxLITC1M/686JkcTRP1LwgsRPcV/c5YsUl6KDPeOWDskt3GvzoQ1nIc/fft1hJ
	 zn8AGW6qkaWWtV8SqSkymEFWzvKjPa8PWrRSwCzy5vMnQcqITa4wjexwxQF+nskvu/
	 lhWWuQ9KcD5+m6F2AR8aicDo0+PRGDkuaWq0VoRFU7yxb/JtP+HQMyZyOq4OuLkdET
	 KuELiBRGNP+dw==
Date: Tue, 23 Jul 2024 10:58:50 +0100
From: Simon Horman <horms@kernel.org>
To: Julien Olivain <ju.o@free.fr>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH 1/1] s390: add missing limits.h header inclusion
Message-ID: <20240723095850.GD24657@kernel.org>
References: <20240719174744.549913-1-ju.o@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240719174744.549913-1-ju.o@free.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_025856_774755_C8406547 
X-CRM114-Status: GOOD (  14.18  )
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

On Fri, Jul 19, 2024 at 07:47:44PM +0200, Julien Olivain wrote:
> Commit b84fcdd48c [1] introduced a usage of PATH_MAX in file
> "kexec-s390.c". This constant is defined in the <limits.h> header.
> See [2].
> 
> With some libc, such as musl, kexec-tools fails to build with output:
> 
>     kexec/arch/s390/kexec-s390.c: In function 'remove_offline_memory':
>     kexec/arch/s390/kexec-s390.c:120:19: error: 'PATH_MAX' undeclared (first use in this function)
>       120 |         char path[PATH_MAX];
>           |                   ^~~~~~~~
> 
> The issue can be reproduced, for example, with Buildroot Linux, using
> a s390 gcc toolchain with the musl libc and the following commands:
> 
>     git clone -b 2024.05.1 --depth 1 https://gitlab.com/buildroot.org/buildroot.git
>     cd buildroot
>     cat > .config <<EOF
>     BR2_s390x=y
>     BR2_TOOLCHAIN_BUILDROOT_MUSL=y
>     BR2_PACKAGE_KEXEC=y
>     EOF
>     make olddefconfig
>     make
> 
> Note: in this test, kexec-tools v2.0.28 is used.
> 
> This commit fixes the issue by adding the missing header inclusion.
> 
> [1] https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=b84fcdd48cbe70e54e66f2cf1b251e0db58f04f4
> [2] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/limits.h.html
> 
> Signed-off-by: Julien Olivain <ju.o@free.fr>

Thanks Julien, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
