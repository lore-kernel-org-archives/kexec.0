Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OtWE5-0008C5-RS
	for kexec@lists.infradead.org; Thu, 09 Sep 2010 01:46:59 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <m1y6bcf2aq.fsf@fess.ebiederm.org>
	<20100909013546.GD5783@verge.net.au>
Date: Wed, 08 Sep 2010 18:46:50 -0700
In-Reply-To: <20100909013546.GD5783@verge.net.au> (Simon Horman's message of
	"Thu, 9 Sep 2010 10:35:47 +0900")
Message-ID: <m1bp877kol.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [GIT PULL] Please pull x86 biarch crashdump support and misc devel
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
To: Simon Horman <horms@verge.net.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Simon Horman <horms@verge.net.au> writes:

> On Wed, Sep 08, 2010 at 12:44:29PM -0700, Eric W. Biederman wrote:
>> 
>> I thought I had x86 biarch crashdump working on x86 but it turns
>> out was wrong.  So I have merged crashdump-x86.c and crashdump-x86_64.c
>> to ensure that things will work fine.
>> 
>> There are a few misc cleanups in here to support biarch crashdumps.
>> 
>> There is a kexec bzImage load  optimization that allows me to use
>> a 64bit crash kernel in 20M in my setup.  Perhaps less.  Earlier
>> because of an alighment foulup I needed 32M and the kernel was
>> loaded in the middle of the reserved crashdump region.
>> 
>> There is also a new program vmcore-dmesg.  Functionally it is very
>> similar to the makedumpfile's --dmesg mode but it handles all of the
>> crazy multi-arch cases so I only need to keep one binary around to strip
>> the kernel's dmesg out of a core file.  Additionally vmcore-dmesg is
>> about half the size of makedumpfile and I can build it against uclibc,
>> which makes it much more usable in my constrained initrd setup.
>> 
>> I would post patches but I know I would fat finger that horribly.
>> 
>> git pull git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/kexec-tools-devel.git
>
> A git pull request is fine.
> Actually, with this many patches, its significantly easier for me too.

Definitely on a good day I would post the patches for review but still
send you a pull request.

>> ---
>
> [ snip ]
>
>> commit c8e346688c6358427213d9d6fdb83765e365cccd
>> Author: Eric W. Biederman <ebiederm@xmission.com>
>> Date:   Tue Sep 7 12:05:40 2010 -0700
>> 
>>     crashdump: Move kern_vaddr_start from kexec_info into crash_elf_info
>>     
>>     These fields as defined in kexec_info are not biarch safe and
>>     beyond that crash_elf_info is the structure for passing this kind
>>     of information not kexec_info.  So move them in prepartion for
>>     properly cleaning up biarch x86 functionality.
>>     
>>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> There appears to be a typo in the following hunk of this patch.
> I can fix this if you prefer.

If you could add a commit that fixes this that would be great.  I
have an ia64 compiler around somewhere but not handy :(


> diff --git a/kexec/arch/ia64/crashdump-ia64.c b/kexec/arch/ia64/crashdump-ia64.c
> index 6b64271..5653e6e 100644
> --- a/kexec/arch/ia64/crashdump-ia64.c
> +++ b/kexec/arch/ia64/crashdump-ia64.c
> @@ -246,11 +246,11 @@ int load_crashdump_segments(struct kexec_info *info, struct mem_ehdr *ehdr,
>  				continue;
>  			if (kernel_code_start >= mstart &&
>  			    kernel_code_start < mend) {
> -				info->kern_vaddr_start = mstart + LOAD_OFFSET;
> +				elf_info.kern_vaddr_start = mstart + LOAD_OFFSET;
>  				break;
>  			}
>  		}
> -		info->kern_size = kernel_code_end - kernel_code_start + 1;
> +		elf_info->kern_size = kernel_code_end - kernel_code_start + 1;
>
> -------> elf_info->kern_size should be elf_info.kern_size ?

Yes.
>
>  		if (crash_create_elf64_headers(info, &elf_info,
>  					       crash_memory_range, nr_ranges,
>  					       &tmp, &sz, EFI_PAGE_SIZE) < 0)
>
> Which results in the following build error:
>
> $ make
> ia64-unknown-linux-gnu-gcc -Wall -Wextra -O2 -fomit-frame-pointer -pipe -fno-strict-aliasing -Wall -Wstrict-prototypes -I/home/horms/local/opt/crosstool/ia64/gcc-3.4.5-glibc-2.3.6/ia64-unknown-linux-gnu/include -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ia64/libfdt -I./kexec/arch/ia64/include  -c -MD -o kexec/arch/ia64/crashdump-ia64.o
> kexec/arch/ia64/crashdump-ia64.c
> kexec/arch/ia64/crashdump-ia64.c: In function `load_crashdump_segments':
> kexec/arch/ia64/crashdump-ia64.c:253: error: invalid type argument of `->'
>
>> 
>> commit d9bf000b6260ee4558b2d2eb3af08e09cd1fe794
>> Author: Eric W. Biederman <ebiederm@xmission.com>
>> Date:   Tue Sep 7 11:42:39 2010 -0700
>> 
>>     kexec: Kill arch_init
>>     
>>     The function only had one user, the error checking was wrong,
>>     and the functions it performed are best done elsewhere
>>     so remove the tempation of a problemenatic hook.
>>     
>>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> [ snip ]

Thanks, 
Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
