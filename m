Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A8EC87FCB
	for <kexec@archiver.kernel.org>; Fri,  1 Aug 2025 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kTioCqvPRy4Kr/yOeoSKJ6C7AGXie8DKEeVszAcKMBk=; b=csZxjBVhbKfHoUAPF7FmkX48Vq
	Zha5YncWZelBPrhUAJd/+vjruI6gpH8Qn4wd6CX7u/LphscFb72eJJjvSl2TEbYEQ2FHBbc0zwwVA
	xQ3pA3VgLvnHx2g6ImsKOV+uF5WUrLiq75XpHX5ZXbIDvVyrDKgBQMJvtwANUaRiJ9n/P6FU94BF4
	VsYF7s1xIMNZIU74fjAQf6++NnkQj0z7LbCaXG8nPM2SMmKC8dzbn9PkI0deRAN88yPMVFDzY51cV
	OcYVRCpyBD+b9JABTXXNTTSQ0hOeHyvSvmCLTZ1ISRplRrEwC7/6v+LD3BbOhX5xKLoctZHm8q4aj
	UWLYRQaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhnUf-00000005VVM-1VUr;
	Fri, 01 Aug 2025 11:00:09 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhnUb-00000005VTs-22Xd
	for kexec@lists.infradead.org;
	Fri, 01 Aug 2025 11:00:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754046003;
	bh=SrU/DgzHeB8T3HhnNHwe7Wv/zYSsrNNui/GdxVK0W4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5XcAc7orQ0efweZPqsyH2aaYb5dB1Cm4NdBXX4yXTCC1YJcN0it9EzLj5fUOjdl7
	 1xJ43F93jc3ed/QfN/z3CSPwtFqMIqL5SuLReiJH9l4Ch+Hg2+hdLkAcv8TJTkBdDh
	 WvSMwyX2w3I5uBA8hz//tzkBvBSQ2qqOri7p2I6k=
Date: Fri, 1 Aug 2025 13:00:03 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] kho: add test for kexec handover
Message-ID: <fae1936d-3f45-44d4-a9b0-43b29115d5ac@t-8ch.de>
References: <20250801100630.3473918-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801100630.3473918-1-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250801_040005_672168_45490191 
X-CRM114-Status: GOOD (  24.29  )
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

On 2025-08-01 13:06:30+0300, Mike Rapoport wrote:
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

Looking at it while awake brought up some more nitpicks.
In any case:
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net> # for the nolibc usage

> diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
> new file mode 100644
> index 000000000000..8044ca56fff5
> --- /dev/null
> +++ b/tools/testing/selftests/kho/init.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <errno.h>

Not actually used.

> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/syscall.h>
> +#include <sys/mount.h>
> +#include <sys/reboot.h>
> +
> +/* from arch/x86/include/asm/setup.h */
> +#define COMMAND_LINE_SIZE	2048
> +
> +/* from include/linux/kexex.h */

"kexec.h"

> +#define KEXEC_FILE_NO_INITRAMFS	0x00000004

This is actually part of the UAPI headers, why not use it from there?

> +
> +#define KHO_FINILIZE "/debugfs/kho/out/finalize"

KHO_FINALIZE

> +#define KERNEL_IMAGE "/kernel"
> +
> +static int mount_filesystems(void)
> +{
> +	if (mount("debugfs", "/debugfs", "debugfs", 0, NULL) < 0)
> +		return -1;
> +
> +	return mount("proc", "/proc", "proc", 0, NULL);
> +}
> +
> +static int kho_enable(void)
> +{
> +	const char enable[] = "1";
> +	int fd;
> +
> +	fd = open(KHO_FINILIZE, O_RDWR);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (write(fd, enable, sizeof(enable)) != sizeof(enable))
> +		return 1;
> +
> +	close(fd);
> +	return 0;
> +}
> +
> +static long kexec_file_load(int kernel_fd, int initrd_fd,
> +			    unsigned long cmdline_len, const char *cmdline,
> +			    unsigned long flags)
> +{
> +	return syscall(__NR_kexec_file_load, kernel_fd, initrd_fd, cmdline_len,
> +		       cmdline, flags);
> +}
> +
> +static int kexec_load(void)
> +{
> +	char cmdline[COMMAND_LINE_SIZE];
> +	ssize_t len;
> +	int fd, err;
> +
> +	fd = open("/proc/cmdline", O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	len = read(fd, cmdline, sizeof(cmdline));
> +	close(fd);
> +	if (len < 0)
> +		return -1;
> +
> +	/* replace \n with \0 */
> +	cmdline[len - 1] = 0;
> +	fd = open(KERNEL_IMAGE, O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	err = kexec_file_load(fd, -1, len, cmdline, KEXEC_FILE_NO_INITRAMFS);
> +	close(fd);
> +
> +	return err ? : 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	if (mount_filesystems())
> +		goto err_reboot;
> +
> +	if (kho_enable())
> +		goto err_reboot;
> +
> +	if (kexec_load())
> +		goto err_reboot;
> +
> +	if (reboot(RB_KEXEC))
> +		goto err_reboot;
> +
> +	return 0;
> +
> +err_reboot:
> +	reboot(RB_AUTOBOOT);
> +	return -1;
> +}
> diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
> new file mode 100755
> index 000000000000..3f6c17166846
> --- /dev/null
> +++ b/tools/testing/selftests/kho/vmtest.sh

(...)

> +function mkinitrd() {
> +	local kernel=$1
> +
> +	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -nostdlib \
> +			-fno-asynchronous-unwind-tables -fno-ident \
> +			-I "$headers_dir/include" \
> +			-I "$kernel_dir/tools/include/nolibc" \
> +			-o "$tmp_dir/init" "$test_dir/init.c"

You could build this as a userprog as part of kbuild.
Then it will also work automatically with clang.

> +
> +	cat > "$tmp_dir/cpio_list" <<EOF
> +dir /dev 0755 0 0
> +dir /proc 0755 0 0
> +dir /debugfs 0755 0 0
> +nod /dev/console 0600 0 0 c 5 1
> +file /init $tmp_dir/init 0755 0 0
> +file /kernel $kernel 0644 0 0
> +EOF
> +
> +	"$build_dir/usr/gen_init_cpio" "$tmp_dir/cpio_list" > "$initrd"

This could also be hooked up to kbuild.

> +}

(...)

