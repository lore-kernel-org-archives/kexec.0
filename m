Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5sIZ-0003aB-BU
	for kexec@lists.infradead.org; Fri, 28 Nov 2008 01:37:35 +0000
Message-ID: <492F465D.6000609@mxs.nes.nec.co.jp>
Date: Fri, 28 Nov 2008 10:16:13 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Parse 64 bit VMCOREINFO on 32 bit userland
References: <20081127160034.121f5911@hale.suse.de>
In-Reply-To: <20081127160034.121f5911@hale.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2058410404=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

--===============2058410404==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> This bug fixes the problem that on a 32 bit userland makedumpfile (as common
> on the PPC platform) the parsing of the 64 bit VMCOREINFO fails with:
> 
>    # makedumpfile -c /home/sachin/dump/vmcore vmcore.filtered
>    read_vmcoreinfo_symbol: Invalid data in /tmp/vmcoreinfowVoyJK:
>    SYMBOL(mem_section)=c000000000bb4400
> 
> We just need to assume that the symbols are always 'unsigned long long' (64 bit)
> instead of 'unsigned long' (native pointer size on Linux platforms).

I agree with this patch basically. But I have not tested kdump on PPC64
platform (PPC32 also) and I don't know it well. So may I ask a question ?

For PPC64 kdump, is it common thing that makedumpfile runs on PPC32 ?
In other words, do you use PPC32 kernel as 2nd-kernel for PPC64 kdump ?


> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> ---
>  makedumpfile.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -13,7 +13,6 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   */
> -#include <stdlib.h>

This is not related to this purpose, but this is reasonable and will
be merged as the other patch ;-)


>  #include "makedumpfile.h"
>  
>  struct symbol_table	symbol_table;
> @@ -2274,7 +2273,7 @@ read_vmcoreinfo_basic_info(void)
>  unsigned long

unsigned long long ?

>  read_vmcoreinfo_symbol(char *str_symbol)
>  {
> -	unsigned long symbol = NOT_FOUND_SYMBOL;
> +	unsigned long long symbol = NOT_FOUND_SYMBOL;
>  	char buf[BUFSIZE_FGETS], *endp;
>  	unsigned int i;
>  
> @@ -2291,8 +2290,8 @@ read_vmcoreinfo_symbol(char *str_symbol)
>  		if (buf[i - 1] == '\n')
>  			buf[i - 1] = '\0';
>  		if (strncmp(buf, str_symbol, strlen(str_symbol)) == 0) {
> -			symbol = strtoul(buf + strlen(str_symbol), &endp, 16);
> -			if ((!symbol || symbol == ULONG_MAX)
> +			symbol = strtoull(buf + strlen(str_symbol), &endp, 16);
> +			if ((!symbol || symbol == ULONGLONG_MAX)
>  			    || strlen(endp) != 0) {
>  				ERRMSG("Invalid data in %s: %s",
>  				    info->name_vmcoreinfo, buf);
> 


Thanks
Ken'ichi Ohmichi


--===============2058410404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2058410404==--
