Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OtW3M-0006is-Ks
	for kexec@lists.infradead.org; Thu, 09 Sep 2010 01:35:57 +0000
Date: Thu, 9 Sep 2010 10:35:47 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [GIT PULL] Please pull x86 biarch crashdump support and misc devel
Message-ID: <20100909013546.GD5783@verge.net.au>
References: <m1y6bcf2aq.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1y6bcf2aq.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Wed, Sep 08, 2010 at 12:44:29PM -0700, Eric W. Biederman wrote:
> 
> I thought I had x86 biarch crashdump working on x86 but it turns
> out was wrong.  So I have merged crashdump-x86.c and crashdump-x86_64.c
> to ensure that things will work fine.
> 
> There are a few misc cleanups in here to support biarch crashdumps.
> 
> There is a kexec bzImage load  optimization that allows me to use
> a 64bit crash kernel in 20M in my setup.  Perhaps less.  Earlier
> because of an alighment foulup I needed 32M and the kernel was
> loaded in the middle of the reserved crashdump region.
> 
> There is also a new program vmcore-dmesg.  Functionally it is very
> similar to the makedumpfile's --dmesg mode but it handles all of the
> crazy multi-arch cases so I only need to keep one binary around to strip
> the kernel's dmesg out of a core file.  Additionally vmcore-dmesg is
> about half the size of makedumpfile and I can build it against uclibc,
> which makes it much more usable in my constrained initrd setup.
> 
> I would post patches but I know I would fat finger that horribly.
> 
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/kexec-tools-devel.git

A git pull request is fine.
Actually, with this many patches, its significantly easier for me too.

> ---

[ snip ]

> commit c8e346688c6358427213d9d6fdb83765e365cccd
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 12:05:40 2010 -0700
> 
>     crashdump: Move kern_vaddr_start from kexec_info into crash_elf_info
>     
>     These fields as defined in kexec_info are not biarch safe and
>     beyond that crash_elf_info is the structure for passing this kind
>     of information not kexec_info.  So move them in prepartion for
>     properly cleaning up biarch x86 functionality.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

There appears to be a typo in the following hunk of this patch.
I can fix this if you prefer.

diff --git a/kexec/arch/ia64/crashdump-ia64.c b/kexec/arch/ia64/crashdump-ia64.c
index 6b64271..5653e6e 100644
--- a/kexec/arch/ia64/crashdump-ia64.c
+++ b/kexec/arch/ia64/crashdump-ia64.c
@@ -246,11 +246,11 @@ int load_crashdump_segments(struct kexec_info *info, struct mem_ehdr *ehdr,
 				continue;
 			if (kernel_code_start >= mstart &&
 			    kernel_code_start < mend) {
-				info->kern_vaddr_start = mstart + LOAD_OFFSET;
+				elf_info.kern_vaddr_start = mstart + LOAD_OFFSET;
 				break;
 			}
 		}
-		info->kern_size = kernel_code_end - kernel_code_start + 1;
+		elf_info->kern_size = kernel_code_end - kernel_code_start + 1;

-------> elf_info->kern_size should be elf_info.kern_size ?

 		if (crash_create_elf64_headers(info, &elf_info,
 					       crash_memory_range, nr_ranges,
 					       &tmp, &sz, EFI_PAGE_SIZE) < 0)

Which results in the following build error:

$ make
ia64-unknown-linux-gnu-gcc -Wall -Wextra -O2 -fomit-frame-pointer -pipe -fno-strict-aliasing -Wall -Wstrict-prototypes -I/home/horms/local/opt/crosstool/ia64/gcc-3.4.5-glibc-2.3.6/ia64-unknown-linux-gnu/include -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ia64/libfdt -I./kexec/arch/ia64/include  -c -MD -o kexec/arch/ia64/crashdump-ia64.o
kexec/arch/ia64/crashdump-ia64.c
kexec/arch/ia64/crashdump-ia64.c: In function `load_crashdump_segments':
kexec/arch/ia64/crashdump-ia64.c:253: error: invalid type argument of `->'

> 
> commit d9bf000b6260ee4558b2d2eb3af08e09cd1fe794
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 11:42:39 2010 -0700
> 
>     kexec: Kill arch_init
>     
>     The function only had one user, the error checking was wrong,
>     and the functions it performed are best done elsewhere
>     so remove the tempation of a problemenatic hook.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

[ snip ]

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
