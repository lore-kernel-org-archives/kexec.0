Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zc9AT-0008LZ-5w
 for kexec@lists.infradead.org; Wed, 16 Sep 2015 09:38:21 +0000
Date: Wed, 16 Sep 2015 17:37:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] vmcore: replace Elf64_Ehdr/Elf32_Ehdr with elfhdr
Message-ID: <20150916093749.GD6699@dhcp-128-62.nay.redhat.com>
References: <1442372321-16334-1-git-send-email-yanjiang.jin@windriver.com>
 <1442372321-16334-2-git-send-email-yanjiang.jin@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1442372321-16334-2-git-send-email-yanjiang.jin@windriver.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: yanjiang.jin@windriver.com
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org, jinyanjiang@gmail.com, linux-kernel@vger.kernel.org, chaowang@redhat.com

Cc kexec list.

On 09/16/15 at 10:58am, yanjiang.jin@windriver.com wrote:
> From: Yanjiang Jin <yanjiang.jin@windriver.com>
> 
> Function parse_crash_elf_headers() reads e_ident[EI_CLASS] then decides to
> call parse_crash_elf64_headers() or parse_crash_elf32_headers().
> But this happens in run time, not compile time. So compiler will report
> the below warning:
> 
> In file included from include/linux/elf.h:4:0,
>                  from fs/proc/vmcore.c:13:
> fs/proc/vmcore.c: In function 'parse_crash_elf32_headers':
> arch/mips/include/asm/elf.h:258:23: warning: initializatio
> n from incompatible pointer type
>   struct elfhdr *__h = (hdr);     \
>                        ^
> fs/proc/vmcore.c:1071:4: note: in expansion of macro 'elf_
> check_arch'
>    !elf_check_arch(&ehdr) ||
>     ^
> 
> Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
> ---
>  fs/proc/vmcore.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4e61388..576bb26 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -999,7 +999,7 @@ static void free_elfcorebuf(void)
>  static int __init parse_crash_elf64_headers(void)
>  {
>  	int rc=0;
> -	Elf64_Ehdr ehdr;
> +	struct elfhdr ehdr;
>  	u64 addr;
>  
>  	addr = elfcorehdr_addr;
> @@ -1055,7 +1055,7 @@ fail:
>  static int __init parse_crash_elf32_headers(void)
>  {
>  	int rc=0;
> -	Elf32_Ehdr ehdr;
> +	struct elfhdr ehdr;
>  	u64 addr;
>  
>  	addr = elfcorehdr_addr;
> -- 
> 1.9.1
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
