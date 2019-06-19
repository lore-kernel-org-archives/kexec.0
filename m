Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hdi3O-0001a6-Oi
 for kexec@lists.infradead.org; Wed, 19 Jun 2019 21:23:40 +0000
Received: by mail-pf1-f171.google.com with SMTP id i189so319814pfg.10
 for <kexec@lists.infradead.org>; Wed, 19 Jun 2019 14:23:35 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [Query] arm64: Right approach to support Image.gz file type via
 kexec_file_load()
Message-ID: <9d54bb1e-7371-5163-69b0-0af0426ee4a0@redhat.com>
Date: Thu, 20 Jun 2019 02:53:26 +0530
MIME-Version: 1.0
Content-Language: en-US
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
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, matthewgarrett@google.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>

Hi,

Since most distributions use 'make zinstall' rule inside 
'arch/arm64/boot/Makefile' (see [1] for details) to install the arm64 
Image.gz compressed file inside the boot destination directory (for e.g. 
/boot), currently we cannot use kexec_file_load() to load vmlinuz (or 
Image.gz):

# file /boot/vmlinuz
/boot/vmlinuz: gzip compressed data, was "Image", <..snip..>, max 
compression, from Unix, original size 21945120

Now, since via kexec_file_load() we pass the 'fd' of Image.gz 
(compressed file) via the following command line ...

# kexec -s -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname 
-r`.img --reuse-cmdline

... kernel returns -EINVAL error value, as it is not able to locate the 
magic number  =0x644d5241, which is expected in the 64-byte header of 
the decompressed kernel image (see [2] for details):

The decompressed kernel image contains a 64-byte header as follows:
<..snip..>
   u32 magic	= 0x644d5241;	/* Magic number, little endian, "ARM\x64" */
<..snip..>

I can figure out two ways to address this:

1. Add support in user-space kexec-tools (for which I have a RFC patch 
ready), which handles an 'Image.gz' being passed via kexec_file_load(), 
using an approach as follows:

a). Copy the contents of Image.gz to a temporary file.
b). Decompress (gunzip-decompress) the contents inside the temporary file.
c). Pass the 'fd' of the temporary file to the kernel space. So 
basically the kernel space still gets a decompressed kernel image to 
load via kexec_tools

This seems to have the following pros and cons, which I can think of:

Pros:
  - Changes can be handled in the user-space (kexec_tools) and no 
changes are required in kernel space for handling the 
unsigned/non-secure boot case.

Cons:
  - One obvious issue is how to handle the signed kernel Image.gz, 
because signature verification is managed inside the kernel, so handling 
a signed Image.gz would require kernel intervention eventually.
  - Passing decompressed image from user-space requires the kernel to 
read large amount of data from the user-space.

2. Add support in kernel (for which I have a RFC patch ready), which 
handles an 'Image.gz' being passed via kexec_file_load(), using an 
approach as follows:

a). Define a 'arch_kexec_kernel_image_probe' for arm64, which overrides 
the __weak definition in 'kernel/kexec_file.c'
b). Inside 'arch_kexec_kernel_image_probe' for arm64, check if we have 
been passed a  magic header  0x1f, 0x8b (\037 \213) which indicates a 
'gzip format' Image file.
b). Decompress the contents inside a buffer using a decompress_kernel() 
-> gunzip() -> inflate() logic.

This seems to have the following pros and cons, which I can think of:

Pros:
  - Handling signed Image.gz becomes easier in the kernel itself.

Cons:
  - One needs to add a decompress_kernel() -> gunzip() -> inflate() 
kind-of logic in kernel space to handle gzipp'ed image for arm64.

So, I was wondering which approach should be more suitable - fixing this 
in user-space v/s fix this in kernel-space.

Please let me know so that I can send out a RFC patch for the same.

[1]. https://github.com/torvalds/linux/blob/master/arch/arm64/boot/Makefile
[2]. https://www.kernel.org/doc/Documentation/arm64/booting.txt

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
