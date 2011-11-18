Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RRDyZ-0001OT-SV
 for kexec@lists.infradead.org; Fri, 18 Nov 2011 02:14:49 +0000
Date: Fri, 18 Nov 2011 11:11:56 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec: fix several issues in get_crash_notes()
Message-ID: <20111118021155.GM14082@verge.net.au>
References: <1321448966-25163-1-git-send-email-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1321448966-25163-1-git-send-email-xiyou.wangcong@gmail.com>
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

On Wed, Nov 16, 2011 at 09:09:26PM +0800, WANG Cong wrote:
> a) We don't need 'crash_notes' array at all, save some bytes on stack.
> b) We forgot to fclose 'fp' before return.
> 
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
> 
> ---
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 98cda72..333f6ba 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -589,20 +589,18 @@ static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
>   */
>  static int get_crash_notes(int cpu, uint64_t *addr, uint64_t *len)
>  {
> -	char crash_notes[PATH_MAX];

I wonder if the following might reduce memory usage:

	const char *crash_notes = "/sys/kernel/crash_notes";

>  	char line[MAX_LINE];
>  	FILE *fp;
>  	unsigned long vaddr;
>  	int count;
>  
> -	sprintf(crash_notes, "/sys/kernel/crash_notes");
> -	fp = fopen(crash_notes, "r");
> +	fp = fopen("/sys/kernel/crash_notes", "r");
>  	if (fp) {
>  		if (fgets(line, sizeof(line), fp) != 0) {
>  			count = sscanf(line, "%lx", &vaddr);
>  			if (count != 1)
> -				die("Cannot parse %s: %s\n", crash_notes,
> -						strerror(errno));
> +				die("Cannot parse /sys/kernel/crash_notes:"
> +					" %s\n", strerror(errno));
>  		}
>  
>  		*addr = x86__pa(vaddr + (cpu * MAX_NOTE_BYTES));
> @@ -610,6 +608,7 @@ static int get_crash_notes(int cpu, uint64_t *addr, uint64_t *len)
>  #ifdef DEBUG
>  		printf("crash_notes addr = %Lx\n", *addr);
>  #endif
> +		fclose(fp);
>  		return 0;
>  	} else
>  		return get_crash_notes_per_cpu(cpu, addr, len);
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
