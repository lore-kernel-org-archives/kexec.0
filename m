Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1erktO-0002Wt-Bh
 for kexec@lists.infradead.org; Fri, 02 Mar 2018 13:38:40 +0000
Date: Fri, 2 Mar 2018 14:38:22 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH 2/5] kexec: do not special-case the -s option
Message-ID: <20180302143822.7b0fc155@kitsune.suse.cz>
In-Reply-To: <20180302123616.4avyougf2aeagvqy@verge.net.au>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
 <28358b37c1174572ff6051ec430d750969efa9eb.1519646210.git.msuchanek@suse.de>
 <20180302123616.4avyougf2aeagvqy@verge.net.au>
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
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>

On Fri, 2 Mar 2018 13:36:16 +0100
Simon Horman <horms@verge.net.au> wrote:

> On Mon, Feb 26, 2018 at 01:00:35PM +0100, Michal Suchanek wrote:
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
> > @@ -1354,11 +1340,8 @@ int main(int argc, char *argv[])
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
> This appears to change the logic of options parsing.
> 

Care to share how exactly is the logic changed? I do not see it. To me
it looks like we have separate flags for KEXEC_LOAD and KEXEC_FILE_LOAD
so setting up both does not change anything. Whatever syscall is used
it has the flags set up.

In the existing logic we decide which syscall to do beforehand and set
up only flags for that syscall but that does not save much CPU cycles
and makes the code more complex and fragile. 

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
