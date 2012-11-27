Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TdSfS-0000Di-Fs
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 21:26:11 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <3774326.lMtTTFYZT3@azariah.suse.cz>
Date: Tue, 27 Nov 2012 15:25:35 -0600
In-Reply-To: <3774326.lMtTTFYZT3@azariah.suse.cz> (Petr Tesarik's message of
 "Tue, 27 Nov 2012 15:13:32 +0100")
Message-ID: <87ehjeivqo.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Save PG_compound or PG_head value in VMCOREINFO
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Petr Tesarik <ptesarik@suse.cz> writes:

> To allow filtering of huge pages, makedumpfile must be able to identify
> them in the dump. This can be done by checking for the appropriate
> page flag, so communicate its value to makedumpfile through the VMCOREINFO 
> interface.

I don't have any siginificant problems with exporting this information.
However that #ifddef looks nasty and confusing.

Does that #ifdef exist in the huge page code as well?

Can we always export both?  Can we only export one?

What is the purpose of the #ifdef?

As it stands that looks like code that will figure out how to bitrot
if we just leave it sitting there.

> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
>
> ---
>  kernel/kexec.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1511,6 +1511,11 @@ static int __init crash_save_vmcoreinfo_
>  	VMCOREINFO_NUMBER(NR_FREE_PAGES);
>  	VMCOREINFO_NUMBER(PG_lru);
>  	VMCOREINFO_NUMBER(PG_private);
> +#ifdef CONFIG_PAGEFLAGS_EXTENDED
> +	VMCOREINFO_NUMBER(PG_head);
> +#else
> +	VMCOREINFO_NUMBER(PG_compound);
> +#endif
>  	VMCOREINFO_NUMBER(PG_swapcache);
>  
>  	arch_crash_save_vmcoreinfo();

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
