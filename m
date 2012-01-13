Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RlX1H-000686-Sj
 for kexec@lists.infradead.org; Fri, 13 Jan 2012 02:37:35 +0000
Subject: Re: [PATCH] makedumpfile: Compile fix
In-reply-to: <1326381154.2729.1.camel@br98xy6r>
References: <1326381154.2729.1.camel@br98xy6r>
Message-Id: <20120113112727tachibana@mail.jp.nec.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Fri, 13 Jan 2012 11:27:27 +0900
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
To: holzheu@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org

Hi Michael,

On 2012/01/12 16:12:34 +0100, Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> When compiling makedumpfile git head or 1.4.1 on s390x, I get the following
> gcc error:

Thank you for the fix and sorry for our insufficient tests.
We will release a fixed version next week.

Thanks.
tachibana


> 
>  # gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
>  -D_LARGEFILE64_SOURCE -DVERSION='"1.4.1"' -DRELEASE_DATE='"6 January 2012"'
>  -D__s390__  print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o
>  arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o arch/s390x.o -o
>  makedumpfile makedumpfile.c -static -ldw -lbz2 -lebl -ldl -lelf -lz
>  In file included from makedumpfile.c:21:0:
>  sadump_info.h:86:1: error: expected identifier or '(' before '{' token
>  sadump_info.h:85:19: warning: 'sadump_num_online_cpus' used but never defined
> 
> The attached patch fixes this problem.
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  sadump_info.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/sadump_info.h
> +++ b/sadump_info.h
> @@ -82,7 +82,7 @@ static inline int sadump_initialize_bitm
>  	return FALSE;
>  }
>  
> -static inline int sadump_num_online_cpus(void);
> +static inline int sadump_num_online_cpus(void)
>  {
>  	return 0;
>  }
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
