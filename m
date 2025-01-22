Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51758C02181
	for <kexec@archiver.kernel.org>; Wed, 22 Jan 2025 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n2phdRioz+FPeu2qwKUYHdIsmJATa7bzMGgHi9VlFHo=; b=G+ZvXI4/DHqqrXtGqUParNKYCQ
	JQJhIf6G5X6p/kJlwCXSEdqcTpTiNH+LqEyOMI5HAZns8xwgAkFPMx7qEJoBbYYfjwEfstdqcE+vh
	V58bmUM/aaFg9K5o3EwQT8+Ea+qLIBO0C3ROvQFVs65JkJ2C4Czp2CvMRDBFLptZ9j2ECusXIHpSI
	G+22RgCA/hqt9y8CjxkS+NTTYw+EA3oPeasE1huMYsBv9XrdPbtUPyWWVMjfrtlOZAf1h3tSw03c9
	AbX4rrXcOJMXdA3aEE6N/uqZNzxRRxCkWgNsg8Z3OSYPsTfI2JNjkmEf8fK+nEqiiCUBP/xLV7sSa
	RT9DFdMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taaMH-0000000AEMp-1HNX;
	Wed, 22 Jan 2025 13:01:25 +0000
Received: from out-178.mta1.migadu.com ([2001:41d0:203:375::b2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taaMD-0000000AEJt-2wyT
	for kexec@lists.infradead.org;
	Wed, 22 Jan 2025 13:01:24 +0000
Date: Wed, 22 Jan 2025 14:01:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1737550876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2phdRioz+FPeu2qwKUYHdIsmJATa7bzMGgHi9VlFHo=;
	b=FTfL7UZTsxDgahGFlDHjMsxRy3TFUFJosHWHwbYxc4KCdjdAX3AfEFqEEPWVggte/W5i5T
	//NlabcvalcZnazUIma/vyF+Khg5JhBmNHpX+Two97l1iHu5OVmmHSJEudrM87NaC8E4XJ
	B3d1BBuPQb+lXA0Vl8cCHR5z3kOWytna4TrKneHGzFBTD8I0HQNpriqRUSPCyoLkRRneC2
	XkSCx9dCoMJjYweVEFoFZPbWMneS6aBsbksvf58yvSlaAgtC38ZLcf0VsRqqrB/6VKSr9X
	WcUilMOUdRLXuDxp5EvpaQrImwCJwsy14MqbAmmW3SMk+ON4WVCRsmY2duYdlg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: RuiRui Yang <ruyang@redhat.com>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z5DsGE4n2uYWedRX@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <CALu+AoQhCjUPr2dnYdN751dyUgNUpyx1HCfyztF5GaP3QRzibQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoQhCjUPr2dnYdN751dyUgNUpyx1HCfyztF5GaP3QRzibQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_050123_101918_4BF0DBD2 
X-CRM114-Status: GOOD (  13.27  )
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

On 2025-01-22 Wed 17:45:41 +0800, RuiRui Yang wrote:
> > I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> > running Void Linux, with the following commands:
> >
> > ```
> > # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> > # reboot
> > # printf reboot >/sys/power/disk
> > # printf disk >/sys/power/state
> > ```
> 
> Which kexec-tools version have you used?  I'm just asking to see which
> syscall is used for loading the new kernel.   From your bisect results
> it seems kexec_file_load, but just a double check as kexec_load and
> kexec_file_load use different sources for building the e820 table.

I have kexec-tools 2.0.29. strace confirms that kexec_file_load() is being used:

```
execve("/usr/sbin/kexec", ["kexec", "-l", "/boot/vmlinuz-6.13.0_ricci", "--initrd=/boot/initramfs-6.13.0_"..., "--reuse-cmdline"], 0x7ffeab8e8910 /* 15 vars */) = 0
brk(NULL)                               = 0x55f2897ea000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=10415, ...}) = 0
mmap(NULL, 10415, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7ff2d596e000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/liblzma.so.5", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=194704, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff2d596c000
mmap(NULL, 192544, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7ff2d593c000
mmap(0x7ff2d5940000, 122880, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7ff2d5940000
mmap(0x7ff2d595e000, 49152, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x7ff2d595e000
mmap(0x7ff2d596a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e000) = 0x7ff2d596a000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=100488, ...}) = 0
mmap(NULL, 102416, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7ff2d5922000
mmap(0x7ff2d5925000, 57344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7ff2d5925000
mmap(0x7ff2d5933000, 28672, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x7ff2d5933000
mmap(0x7ff2d593a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17000) = 0x7ff2d593a000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\236\2\0\0\0\0\0"..., 832) = 832
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
fstat(3, {st_mode=S_IFREG|0755, st_size=12652992, ...}) = 0
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
mmap(NULL, 2006416, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7ff2d5738000
mmap(0x7ff2d5760000, 1413120, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x28000) = 0x7ff2d5760000
mmap(0x7ff2d58b9000, 352256, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x181000) = 0x7ff2d58b9000
mmap(0x7ff2d590f000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1d6000) = 0x7ff2d590f000
mmap(0x7ff2d5915000, 52624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7ff2d5915000
close(3)                                = 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff2d5735000
arch_prctl(ARCH_SET_FS, 0x7ff2d5735740) = 0
set_tid_address(0x7ff2d5735a10)         = 587
set_robust_list(0x7ff2d5735a20, 24)     = 0
rseq(0x7ff2d5736060, 0x20, 0, 0x53053053) = 0
mprotect(0x7ff2d590f000, 16384, PROT_READ) = 0
mprotect(0x7ff2d593a000, 4096, PROT_READ) = 0
mprotect(0x7ff2d596a000, 4096, PROT_READ) = 0
mprotect(0x55f260483000, 20480, PROT_READ) = 0
mprotect(0x7ff2d59a9000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
munmap(0x7ff2d596e000, 10415)           = 0
access("/proc/xen", F_OK)               = -1 ENOENT (No such file or directory)
getrandom("\xa1\x28\xc8\xbe\xf9\xc2\xac\xa0", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0x55f2897ea000
brk(0x55f28980b000)                     = 0x55f28980b000
openat(AT_FDCWD, "/boot/vmlinuz-6.13.0_ricci", O_RDONLY) = 3
lseek(3, 0, SEEK_CUR)                   = 0
read(3, "MZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
close(3)                                = 0
openat(AT_FDCWD, "/boot/vmlinuz-6.13.0_ricci", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26563072, ...}) = 0
read(3, "MZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
close(3)                                = 0
openat(AT_FDCWD, "/boot/vmlinuz-6.13.0_ricci", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26563072, ...}) = 0
mmap(NULL, 26566656, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff2d3ddf000
read(3, "MZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 26563072) = 26563072
close(3)                                = 0
close(3)                                = -1 EBADF (Bad file descriptor)
memfd_create("kernel", MFD_ALLOW_SEALING) = 3
write(3, "MZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 26563072) = 26563072
openat(AT_FDCWD, "/proc/cmdline", O_RDONLY) = 4
read(4, "BOOT_IMAGE=/boot/vmlinuz-6.13.0_"..., 128) = 128
read(4, "el=512M\n", 128)               = 8
read(4, "", 120)                        = 0
read(4, "", 376)                        = 0
openat(AT_FDCWD, "/boot/initramfs-6.13.0_ricci.img", O_RDONLY) = 5
kexec_file_load(3, 5, 98, "root=UUID=71b5e20d-efaa-4c09-b18"..., 0) = 0
close(3)                                = 0
sync()                                  = 0
exit_group(0)                           = ?
+++ exited with 0 +++
```

The issue persists with the latest 6.13 kernel.

I also noticed that the bug is not 100% deterministic, but occurs most
of the times. I could test again with KMSAN and KCSAN, if I have a bit
of time this week.

