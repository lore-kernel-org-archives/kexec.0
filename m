Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zKA-00005C-Ei
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 07:38:00 +0000
Date: Thu, 30 Aug 2012 15:32:14 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: add a missing return statement
Message-Id: <20120830153214.3ab942a019439d41a83d4881@mxc.nes.nec.co.jp>
In-Reply-To: <201208281716.02572.ptesarik@suse.cz>
References: <201208281716.02572.ptesarik@suse.cz>
Mime-Version: 1.0
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
To: ptesarik@suse.cz
Cc: kexec@lists.infradead.org

Hello Petr,

On Tue, 28 Aug 2012 17:16:02 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> The remap_init() function lacks a return statement when all goes well.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

Thank you for your work.
I will merge this patch into v1.5.1.


Thanks
Atsushi Kumagai

> ---
>  arch/x86.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/x86.c
> +++ b/arch/x86.c
> @@ -64,6 +64,7 @@ remap_init(void)
>  	}
>  
>  	max_numnodes = n;
> +	return TRUE;
>  }
>  
>  int
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
