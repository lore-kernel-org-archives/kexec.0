Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eq7rE-0006Fh-QQ
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 01:45:39 +0000
Date: Mon, 26 Feb 2018 09:45:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: do KEXEC_FILE_LOAD and fallback to KEXEC_LOAD if
 not supported.
Message-ID: <20180226014515.GA2862@dhcp-128-65.nay.redhat.com>
References: <20180222222442.9422-1-msuchanek@suse.de>
 <20180222232043.GC693@localhost.localdomain>
 <20180223092900.76a5dd33@ezekiel.suse.cz>
 <20180224014342.GA11298@dhcp-128-65.nay.redhat.com>
 <20180224173431.12ab826c@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180224173431.12ab826c@ezekiel.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: horms@verge.net.au, Tony Jones <tonyj@suse.com>, Michal Suchanek <msuchanek@suse.de>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

On 02/24/18 at 05:34pm, Petr Tesarik wrote:
> On Sat, 24 Feb 2018 09:43:42 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > On 02/23/18 at 09:29am, Petr Tesarik wrote:
> > > Hi Baoquan,
> > > 
> > > On Fri, 23 Feb 2018 07:20:43 +0800
> > > Baoquan He <bhe@redhat.com> wrote:
> > >   
> > > > Hi Michal,
> > > > 
> > > > On 02/22/18 at 11:24pm, Michal Suchanek wrote:  
> > > > > The new KEXEC_FILE_LOAD is preferred in the case the platform supports
> > > > > it because it allows kexec in locked down secure boot mode.
> > > > > 
> > > > > However, some platforms do not support it so fall back to the old
> > > > > syscall there.    
> > > > 
> > > > I didn't read code change, just from patch log, I tend to not agree. There
> > > > are two options KEXEC_FILE_LOAD and KEXEC_LOAD, some platforms do not
> > > > support, why does some platforms not choose KEXEC_LOAD, the working one?
> > > > Why bother to make change in code? I believe there's returned message
> > > > telling if KEXEC_FILE_LOAD works or not.  
> > > 
> > > Well... let me give a bit of background. As you have probably noticed,
> > > this syscall was originally available only for x86_64, but more and
> > > more architectures are also adding it now.
> > > 
> > > Next, kexec is actually called by a script (which locates a suitable
> > > kernel and initrd, constructs the kernel command line, etc.). The
> > > script must either:
> > > 
> > >   A. know somehow if the currently running kernel implements
> > >      kexec_file_load(2), or
> > > 
> > >   B. try one method first, and if it fails, retry with the other.
> > > 
> > > I agree that kexec(1) should probably allow the user to force a
> > > specific method, but I don't see the benefit of implementing fallback
> > > in an external script and not in kexec-tools itself.
> > > 
> > > OTOH if you want to push the fallback logic out of kexec-tools, then I
> > > would like to get better diagnostic at least. Letting my script parse
> > > kexec output is, um, suboptimal.  
> > 
> > In Fedora/RHEL we use this in scripts by checking the arch first,
> > for distribution it is enough?
> 
> No.
> 
> First, you would also have to check the kernel version (and
> maintain an ugly mapping of which kernel version introduced
> kexec_file_load on which architecture).

The kernel version update is rare for these new syscall added, but
it is indeed needed to match with them

> 
> Second, it's not just the architecture. kexec_load(2) will fail if
> SecureBoot is active. OTOH kexec_file_load(2) will fail if the kernel
> is not signed. For kernel hackers who don't use SecureBoot, signing
> self-built kernels is just overkill. So, you should also check the
> state of SecureBoot, possibly also whether the kernel image is signed
> with a valid key, repeating a bit too much of the kernel logic, and
> quite likely introducing subtle differences...

Hmm, I did not say the exact details, yes, we checked the Secure Boot
state and only use kexec_file_load for that special case.

kexec_file and kexec_file_load is not exactly same so if one want to
use one instead of another for a specific functionality it seems not
good to automatically switch to another if one failed. For example which
one should be the first choice, it is hard to say.

> 
> Petr T
> 
> >  There are also some other arch dependent
> > options in kexec-tools, there is no way to just use same for every
> > different platform without checking in scripts. 
> > 
> > If your scripts is not for a distribution, I agree that it is indeed a
> > problem.
> > > 
> > > Petr T
> > >   
> > > > Thanks
> > > > Baoquan  
> > > > > 
> > > > > Also provide an option to call the old syscall in case the new syscall
> > > > > fails with other reason than ENOSYS.
> > > > > 
> > > > > Also document the options.
> > > > > 
> > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > ---
> > > > >  kexec/kexec.8 |  9 +++++++++
> > > > >  kexec/kexec.c | 41 +++++++++++++++--------------------------
> > > > >  kexec/kexec.h |  2 ++
> > > > >  3 files changed, 26 insertions(+), 26 deletions(-)
> > > > > 
> > > > > diff --git a/kexec/kexec.8 b/kexec/kexec.8
> > > > > index e0131b4ea827..7e4df723251d 100644
> > > > > --- a/kexec/kexec.8
> > > > > +++ b/kexec/kexec.8
> > > > > @@ -144,6 +144,15 @@ Load the new kernel for use on panic.
> > > > >  Specify that the new kernel is of this
> > > > >  .I type.
> > > > >  .TP
> > > > > +.BI \-s\ (\-\-kexec-file-syscall)
> > > > > +Specify that the new KEXEC_FILE_LOAD syscall should be used exclusively.
> > > > > +Otherwise KEXEC_FILE_LOAD is tried and when not supported KEXEC_LOAD is used.
> > > > > +.I type.
> > > > > +.TP
> > > > > +.BI \-c\ (\-\-kexec-syscall)
> > > > > +Specify that the old KEXEC_LOAD syscall should be used exclusively.
> > > > > +.I type.
> > > > > +.TP
> > > > >  .B \-u\ (\-\-unload)
> > > > >  Unload the current
> > > > >  .B kexec
> > > > > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > > > > index cfd837c1b6bb..25328c02b508 100644
> > > > > --- a/kexec/kexec.c
> > > > > +++ b/kexec/kexec.c
> > > > > @@ -1166,7 +1166,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
> > > > >  
> > > > >  	if (!is_kexec_file_load_implemented()) {
> > > > >  		fprintf(stderr, "syscall kexec_file_load not available.\n");
> > > > > -		return -1;
> > > > > +		return -ENOSYS;
> > > > >  	}
> > > > >  
> > > > >  	if (argc - fileind <= 0) {
> > > > > @@ -1243,6 +1243,7 @@ int main(int argc, char *argv[])
> > > > >  	int do_unload = 0;
> > > > >  	int do_reuse_initrd = 0;
> > > > >  	int do_kexec_file_syscall = 0;
> > > > > +	int do_kexec_syscall = 0;
> > > > >  	int do_status = 0;
> > > > >  	void *entry = 0;
> > > > >  	char *type = 0;
> > > > > @@ -1256,19 +1257,6 @@ int main(int argc, char *argv[])
> > > > >  	};
> > > > >  	static const char short_options[] = KEXEC_ALL_OPT_STR;
> > > > >  
> > > > > -	/*
> > > > > -	 * First check if --use-kexec-file-syscall is set. That changes lot of
> > > > > -	 * things
> > > > > -	 */
> > > > > -	while ((opt = getopt_long(argc, argv, short_options,
> > > > > -				  options, 0)) != -1) {
> > > > > -		switch(opt) {
> > > > > -		case OPT_KEXEC_FILE_SYSCALL:
> > > > > -			do_kexec_file_syscall = 1;
> > > > > -			break;
> > > > > -		}
> > > > > -	}
> > > > > -
> > > > >  	/* Reset getopt for the next pass. */
> > > > >  	opterr = 1;
> > > > >  	optind = 1;
> > > > > @@ -1310,8 +1298,7 @@ int main(int argc, char *argv[])
> > > > >  			do_shutdown = 0;
> > > > >  			do_sync = 0;
> > > > >  			do_unload = 1;
> > > > > -			if (do_kexec_file_syscall)
> > > > > -				kexec_file_flags |= KEXEC_FILE_UNLOAD;
> > > > > +			kexec_file_flags |= KEXEC_FILE_UNLOAD;
> > > > >  			break;
> > > > >  		case OPT_EXEC:
> > > > >  			do_load = 0;
> > > > > @@ -1354,11 +1341,8 @@ int main(int argc, char *argv[])
> > > > >  			do_exec = 0;
> > > > >  			do_shutdown = 0;
> > > > >  			do_sync = 0;
> > > > > -			if (do_kexec_file_syscall)
> > > > > -				kexec_file_flags |= KEXEC_FILE_ON_CRASH;
> > > > > -			else
> > > > > -				kexec_flags = KEXEC_ON_CRASH;
> > > > > -			break;
> > > > > +			kexec_file_flags |= KEXEC_FILE_ON_CRASH;
> > > > > +			kexec_flags = KEXEC_ON_CRASH;
> > > > >  		case OPT_MEM_MIN:
> > > > >  			mem_min = strtoul(optarg, &endptr, 0);
> > > > >  			if (*endptr) {
> > > > > @@ -1383,7 +1367,12 @@ int main(int argc, char *argv[])
> > > > >  			do_reuse_initrd = 1;
> > > > >  			break;
> > > > >  		case OPT_KEXEC_FILE_SYSCALL:
> > > > > -			/* We already parsed it. Nothing to do. */
> > > > > +			do_kexec_file_syscall = 1;
> > > > > +			do_kexec_syscall = 0;
> > > > > +			break;
> > > > > +		case OPT_KEXEC_SYSCALL:
> > > > > +			do_kexec_file_syscall = 0;
> > > > > +			do_kexec_syscall = 1;
> > > > >  			break;
> > > > >  		case OPT_STATUS:
> > > > >  			do_status = 1;
> > > > > @@ -1456,16 +1445,16 @@ int main(int argc, char *argv[])
> > > > >  		result = k_status(kexec_flags);
> > > > >  	}
> > > > >  	if (do_unload) {
> > > > > -		if (do_kexec_file_syscall)
> > > > > +		if (!do_kexec_syscall)
> > > > >  			result = kexec_file_unload(kexec_file_flags);
> > > > > -		else
> > > > > +		if ((result == -ENOSYS) || !do_kexec_file_syscall)
> > > > >  			result = k_unload(kexec_flags);
> > > > >  	}
> > > > >  	if (do_load && (result == 0)) {
> > > > > -		if (do_kexec_file_syscall)
> > > > > +		if (!do_kexec_syscall)
> > > > >  			result = do_kexec_file_load(fileind, argc, argv,
> > > > >  						 kexec_file_flags);
> > > > > -		else
> > > > > +		if ((result == -ENOSYS) || !do_kexec_file_syscall)
> > > > >  			result = my_load(type, fileind, argc, argv,
> > > > >  						kexec_flags, entry);
> > > > >  	}
> > > > > diff --git a/kexec/kexec.h b/kexec/kexec.h
> > > > > index 26225d2c002a..7abcec796cae 100644
> > > > > --- a/kexec/kexec.h
> > > > > +++ b/kexec/kexec.h
> > > > > @@ -219,6 +219,7 @@ extern int file_types;
> > > > >  #define OPT_TYPE		't'
> > > > >  #define OPT_PANIC		'p'
> > > > >  #define OPT_KEXEC_FILE_SYSCALL	's'
> > > > > +#define OPT_KEXEC_SYSCALL	'c'
> > > > >  #define OPT_STATUS		'S'
> > > > >  #define OPT_MEM_MIN             256
> > > > >  #define OPT_MEM_MAX             257
> > > > > @@ -246,6 +247,7 @@ extern int file_types;
> > > > >  	{ "mem-max",		1, 0, OPT_MEM_MAX }, \
> > > > >  	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
> > > > >  	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
> > > > > +	{ "kexec-syscall",	0, 0, OPT_KEXEC_SYSCALL }, \
> > > > >  	{ "debug",		0, 0, OPT_DEBUG }, \
> > > > >  	{ "status",		0, 0, OPT_STATUS }, \
> > > > >  	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
> > > > > -- 
> > > > > 2.13.6
> > > > > 
> > > > > 
> > > > > _______________________________________________
> > > > > kexec mailing list
> > > > > kexec@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/kexec    
> > > > 
> > > > _______________________________________________
> > > > kexec mailing list
> > > > kexec@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/kexec  
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec  
> > 
> > Thanks
> > Dave
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
