Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byo8A-00027E-7A
 for kexec@lists.infradead.org; Mon, 24 Oct 2016 22:54:11 +0000
Subject: Re: kexec and arm64 advice
References: <CAKYm0coteEEapCNwmj+KmGd57C_C3--nXQfjyD_FLoGXSkqMkQ@mail.gmail.com>
From: "Goel, Sameer" <sgoel@codeaurora.org>
Message-ID: <16c384ed-0875-daa8-b52a-f03af764460b@codeaurora.org>
Date: Mon, 24 Oct 2016 16:53:47 -0600
MIME-Version: 1.0
In-Reply-To: <CAKYm0coteEEapCNwmj+KmGd57C_C3--nXQfjyD_FLoGXSkqMkQ@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon T <smith.not.western@gmail.com>, kexec@lists.infradead.org

It seems that the kexec_load syscall is not defined. Can you please 
check the configs of your running kernel once again?

Thanks,
Sameer

On 10/24/2016 8:42 AM, Simon T wrote:
> Hi,
>
> I'm trying to get kexec working on a cross-compiled arm64/aarch64
> system, using Linux kernel 4.4.23. I'm using kexec-tool's master
> branch (commit e345e27417db00a9e754ca0ca14b2ec87d0552f7 from
> https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git). I
> initially tried using the patches for linux-kexec's kexec-13 branch
> with manual massaging in some spots because kexec-13 is for 4.4.0 not
> 4.4.23. Both tools and kernel appear to build fine, however when it
> comes time to kexec, I encounter this message: "kexec_load failed:
> Function not implemented"
>
> Searching through the patches, I don't find any reference to kexec_load itself.
>
> Should I be applying a different version of kexec-tools, or
> linux-kexec patches, to my build? (I'm restricted to 4.4.23 as the
> base kernel)
>
> Is there a way post compile to check if the kexec_load function is
> implemented, aside from actually deploying the image and calling
> kexec? I've run strings against the Image but it doesn't give an exact
> match for kexec_load (see below).
>
> Anything else I should be looking at?
>
> # kexec -l /mnt/target/boot/vmlinux --initrd=/tmp/root.sfs
> Modified cmdline:root=/dev/mmcblk0p2
> Unable to find /proc/device-tree/chosen/[linux,]stdout-path, printing
> from purgatory is disabled
> kexec_load failed: Function not implemented
> entry       = 0x8095f000 flags = 0xb70000
> nr_segments = 4
> segment[0].buf   = 0x7fa0f64010
> segment[0].bufsz = 0x7fbc00
> segment[0].mem   = 0x80080000
> segment[0].memsz = 0x8d0000
> segment[1].buf   = 0x20cc0830
> segment[1].bufsz = 0xe515
> segment[1].mem   = 0x80950000
> segment[1].memsz = 0xf000
> segment[2].buf   = 0x20ccf840
> segment[2].bufsz = 0x6080
> segment[2].mem   = 0x8095f000
> segment[2].memsz = 0x7000
> segment[3].buf   = 0x7f9e843010
> segment[3].bufsz = 0x2720000
> segment[3].mem   = 0xc0000000
> segment[3].memsz = 0x2720000
>
> (I've also tried kexec -l with boot/Image instead of boot/vmlinux)
>
> $ grep -i kexec .config
> CONFIG_KERNEL_KEXEC=y
> CONFIG_PACKAGE_kexec-tools=y
> CONFIG_KEXEC_TOOLS_TARGET_NAME="aarch64"
> # CONFIG_KEXEC_TOOLS_kdump is not set
> CONFIG_KEXEC_ZLIB=y
> # CONFIG_KEXEC_LZMA is not set
>
> $ strings <build_dir>/arch/arm64/boot/Image  | grep kexec_load
> Wcompat_sys_kexec_load
> Wsys_kexec_load
>
> Thanks!
>
> Simon
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
