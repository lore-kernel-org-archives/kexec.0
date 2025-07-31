Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D559C87FD2
	for <kexec@archiver.kernel.org>; Thu, 31 Jul 2025 21:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2nkHd1b/2MRDkjnRLov6dxOfEPt7nfNIj5VrbrXjH2k=; b=V1BFMXAZtCo4Izf5TdKk0L7X8q
	Tgk9mzQW2AkJtfDP+DmBuNp70untiJjVI8WMI/iQW72ad73Qs7fHz7LXLOoW5TZb6gI4/j0r1oJWg
	3IQuTN/r851FY8gaGzx/dkCGRFmF61JzU+ocMNyByyJ4ZFyjxQDfkSwKPLDmtDnGJHpVmTThBmhBN
	vMpsvXwZ6zaHJ/hBNp6gbKwrcHLvnvGRmB3KF217HMB21gELDJt6CGfuuD6XLRlY7zsjKdjlmzOzG
	4g3+9mb0hAhxkxocOePWzXkRqawj3FT/Tkd2BSqSXtWpI+Vf2Cf56EIQE/rCOQVNXizW3Pu2wuwRi
	1f+liYHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhb2C-00000004UMA-2tAO;
	Thu, 31 Jul 2025 21:41:56 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhanx-00000004TAQ-1EBD
	for kexec@lists.infradead.org;
	Thu, 31 Jul 2025 21:27:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1753997227;
	bh=wjDa7WOGxyHO7D5dQF8LxTZo+LlEelFi+YPWHmw+YgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik2cyJWK4ofmcUVOZKooHAK3Hx+C25v+XJtLc51IX7lfPrqYTCULgZpCSxZOCRZ+Z
	 4qpZXXY221LjjYd8Myeu0O6KZq89Sy5J8mJcddZ60oIFZyThxRsOTaWB/kJtr07dah
	 s0kPO0xeFpx9zl9QEHujyrWH709KZOouJ95i10lc=
Date: Thu, 31 Jul 2025 23:27:07 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: add test for kexec handover
Message-ID: <c54e6f3f-64b9-408e-9668-e96664f52f27@t-8ch.de>
References: <20250727083733.2590139-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727083733.2590139-1-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_142713_505962_3C587123 
X-CRM114-Status: GOOD (  17.16  )
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

Hi Mike,

On 2025-07-27 11:37:33+0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Testing kexec handover requires a kernel driver that will generate some
> data and preserve it with KHO on the first boot and then restore that
> data and verify it was preserved properly after kexec.
> 
> To facilitate such test, along with the kernel driver responsible for
> data generation, preservation and restoration add a script that runs a
> kernel in a VM with a minimal /init. The /init enables KHO, loads a
> kernel image for kexec and runs kexec reboot. After the boot of the
> kexeced kernel, the driver verifies that the data was properly
> preserved.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

(...)

> --- /dev/null
> +++ b/tools/testing/selftests/kho/init.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef NOLIBC

This is not necessary anymore, nolibc now provides these headers.
You can keep it if you want, though.

> +#include <errno.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <syscall.h>

This should be <sys/syscall.h>.

> +#include <sys/mount.h>
> +#include <sys/reboot.h>
> +#endif
> +

(...)

> --- /dev/null
> +++ b/tools/testing/selftests/kho/vmtest.sh
> @@ -0,0 +1,183 @@

(...)

> +
> +function mkinitrd() {
> +	local kernel=$1
> +
> +	mkdir -p "$initrd_dir"/{dev,debugfs,proc}
> +	sudo mknod "$initrd_dir/dev/console" c 5 1

You could generate the initrd with usr/gen_init_cpio or
usr/gen_initramfs.sh which would remove the need to use sudo.
Especially as I think the mknod should fail if $TMP is mounted 'nodev'.

> +
> +	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -I"$headers_dir/include" \
> +			-fno-asynchronous-unwind-tables -fno-ident -nostdlib \
> +			-include "$test_dir/../../../include/nolibc/nolibc.h" \

If you drop the #ifdef NOLIBC, use '-I "$test_dir/../../../include/nolibc/'
here instead. Or better, $kernel_dir/tools/include/nolibc/.

> +			-o "$initrd_dir/init" "$test_dir/init.c" \
> +
> +	cp "$kernel" "$initrd_dir/kernel"
> +
> +	pushd "$initrd_dir" &>/dev/null
> +	find . | cpio -H newc --create > "$initrd" 2>/dev/null
> +	popd &>/dev/null
> +}

(...)


Thomas

