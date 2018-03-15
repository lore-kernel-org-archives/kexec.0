Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ewQp8-00054w-M3
 for kexec@lists.infradead.org; Thu, 15 Mar 2018 11:13:32 +0000
Date: Thu, 15 Mar 2018 12:13:18 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH v4 2/5] kexec: do not special-case the -s option
Message-ID: <20180315121318.3d5ffc46@kitsune.suse.cz>
In-Reply-To: <20180315103830.txngzqrwj63qq53p@verge.net.au>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <28358b37c1174572ff6051ec430d750969efa9eb.1520342150.git.msuchanek@suse.de>
 <20180315103830.txngzqrwj63qq53p@verge.net.au>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Petr Tesarik <ptesarik@suse.cz>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>

On Thu, 15 Mar 2018 11:38:30 +0100
Simon Horman <horms@verge.net.au> wrote:

> On Tue, Mar 06, 2018 at 02:15:53PM +0100, Michal Suchanek wrote:
> > It is parsed separately to save a few CPU cycles when setting up
> > other options but it just complicates the code. So fold it back and
> > set up all flags both for KEXEC_LOAD and KEXEC_FILE_LOAD
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  kexec/kexec.c | 25 ++++---------------------
> >  1 file changed, 4 insertions(+), 21 deletions(-)
> > 
> > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > index ab8cff7fe083..9ea102e1565a 100644
> > --- a/kexec/kexec.c
> > +++ b/kexec/kexec.c
> > @@ -1256,19 +1256,6 @@ int main(int argc, char *argv[])
> >  	};
> >  	static const char short_options[] = KEXEC_ALL_OPT_STR;
> >  
> > -	/*
> > -	 * First check if --use-kexec-file-syscall is set. That
> > changes lot of
> > -	 * things
> > -	 */
> > -	while ((opt = getopt_long(argc, argv, short_options,
> > -				  options, 0)) != -1) {
> > -		switch(opt) {
> > -		case OPT_KEXEC_FILE_SYSCALL:
> > -			do_kexec_file_syscall = 1;
> > -			break;
> > -		}
> > -	}
> > -
> >  	/* Reset getopt for the next pass. */
> >  	opterr = 1;
> >  	optind = 1;
> > @@ -1310,8 +1297,7 @@ int main(int argc, char *argv[])
> >  			do_shutdown = 0;
> >  			do_sync = 0;
> >  			do_unload = 1;
> > -			if (do_kexec_file_syscall)
> > -				kexec_file_flags |=
> > KEXEC_FILE_UNLOAD;
> > +			kexec_file_flags |= KEXEC_FILE_UNLOAD;
> >  			break;
> >  		case OPT_EXEC:
> >  			do_load = 0;  
>  @@ -1354,11 +1340,8 @@ int main(int argc, char *argv[])
> 
>  The existing code has the following above the context shown in the
> patch:
> 
> 			do_load = 1;
> 
> 
> >  			do_exec = 0;
> >  			do_shutdown = 0;
> >  			do_sync = 0;
> > -			if (do_kexec_file_syscall)
> > -				kexec_file_flags |=
> > KEXEC_FILE_ON_CRASH;
> > -			else
> > -				kexec_flags = KEXEC_ON_CRASH;
> > -			break;
> > +			kexec_file_flags |= KEXEC_FILE_ON_CRASH;
> > +			kexec_flags = KEXEC_ON_CRASH;  
> 
> kexec_flags is now set regardless of the value of
> do_kexec_file_syscall, which was not the case prior to this patch.
> That seems to affect the following which appears later in the
> function. Is that ok?
> 
> 
>         if (do_load && (kexec_flags & KEXEC_ON_CRASH) &&
>             !is_crashkernel_mem_reserved()) {
>                 die("Memory for crashkernel is not reserved\n"
>                     "Please reserve memory by passing"
>                     "\"crashkernel=X@Y\" parameter to kernel\n"
>                     "Then try to loading kdump kernel\n");
>         }

Do you not need memory for kexec -s? This looks broken to start with.
> 
> 	...
> 
>         if ((result == 0) && do_load_jump_back_helper) {

And yes, this should not be allowed with -s

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
