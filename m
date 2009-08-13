Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
References: <OF7433B9C5.3D5E2748-ON65257611.0037CE47-65257611.0037EEDB@tcs.com>
	<OF8B20E4B3.38CCED3C-ON65257611.003DC8CE-65257611.00461ED3@tcs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 13 Aug 2009 13:39:06 -0700
In-Reply-To: <OF8B20E4B3.38CCED3C-ON65257611.003DC8CE-65257611.00461ED3@tcs.com>
	(Chandan's message of "Thu\, 13 Aug 2009 18\:15\:54 +0530")
Message-ID: <m1eirf30ut.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: vmcore file 0 size in x86_64
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
To: Chandan12 K <chandan12.k@tcs.com>
Cc: kexec-bounces@lists.infradead.org, fastboot@lists.linux-foundation.org, kexec@lists.infradead.org

Chandan12 K <chandan12.k@tcs.com> writes:

> Hi,
>
> I checked.. through and fond out that one of the following check condition is
> failing
>
>  516         if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 ||
>     517                 (ehdr.e_type != ET_CORE) ||
>     518                 !vmcore_elf_check_arch(&ehdr) ||
>     519                 ehdr.e_ident[EI_CLASS] != ELFCLASS64 ||
>     520                 ehdr.e_ident[EI_VERSION] != EV_CURRENT ||
>     521                 ehdr.e_version != EV_CURRENT ||
>     522                 ehdr.e_ehsize != sizeof(Elf64_Ehdr) ||
>     523                 ehdr.e_phentsize != sizeof(Elf64_Phdr) ||
>     524                 ehdr.e_phnum == 0) {
>     525                 printk(KERN_WARNING "Warning: Core image elf header is
> not"
>     526                                         "sane:%ld\n",elfcorehdr_addr);
>     527               return -EINVAL
>     528         }
>
> If I comment this return at line 527, then the code flows through and the
> vmcore is getting generated.
>
> However, I am facing a new issue, my user space is 32 bit and the kernel is 64
> bit. And I want to access the high memory (high_memory - BACK_UP_SIZE) area of
> the previous/primary kernel. Where some log data I had saved. The toral RAM is
> 8GB.
>
> As the 32 bit pointers could not reach there... means simple file operations
> lseek() , read etc are not working.. to access some region around 8GB.
>
> Can you please suggest me some way to reach that memory and read my raw data
> from the user space.
>
> I am able to read the data from kernel space( a simple kernel module via /proc
> interface to transfer the data from kernel to user space using physical address
> of the primary kernel).

Typically in user space that can be solved in a 32bit userspace
with FILE_OFFSET=64 or something like that.

There are 32bit syscalls that accept 64bit offsets to files.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
