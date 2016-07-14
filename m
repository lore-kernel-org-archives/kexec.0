Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNdTT-0000YE-Fu
 for kexec@lists.infradead.org; Thu, 14 Jul 2016 10:02:32 +0000
Date: Thu, 14 Jul 2016 18:02:06 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Add option to fallback to old kexec syscall when
 kexec file based syscall failed
Message-ID: <20160714100206.GA2946@x1.redhat.com>
References: <1468485911-21427-1-git-send-email-jlee@suse.com>
 <20160714095124.GA9366@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160714095124.GA9366@x1.redhat.com>
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
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Lee, Chun-Yi" <jlee@suse.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, Petr Tesarik <ptesarik@suse.com>

On 07/14/16 at 05:51pm, Baoquan He wrote:
> On 07/14/16 at 04:45pm, Lee, Chun-Yi wrote:
> > This patch adds a new "--fallback-kexec" option to give a chance to
> > fallback to old kexec syscall when file based kexec syscall operation
> > failed.
> > 
> > This option works with --kexec-file-syscall to provide more flexible
> > way to adapt to different kernels that those kernels built with
> > different kexec syscall config or have different verification policy.
> 
> Usually distribuition system uses script to build a framework to
	   ~ I mean distro here.
> connect the kexec/kdump, makedumpfile utility chain. This can make user
> execute a very simple script command to implement kexec load or kexec
> jumping job. In this case script can do what you are trying to do.
> 
> Besides, have you actually met that kexec-file failed but old kexec
> syscall works? I mean how did you test it? I am wondering when it will
> happen.
> 
> Thanks
> Baoquan
> 
> > 
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Petr Tesarik <ptesarik@suse.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> > ---
> >  kexec/kexec.c | 13 +++++++++++++
> >  kexec/kexec.h |  4 +++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > index 500e5a9..e05b43f 100644
> > --- a/kexec/kexec.c
> > +++ b/kexec/kexec.c
> > @@ -969,6 +969,7 @@ void usage(void)
> >  	       "                      preserve context)\n"
> >  	       "                      to original kernel.\n"
> >  	       " -s, --kexec-file-syscall Use file based syscall for kexec operation\n"
> > +	       "     --fallback-kexec     Fallback to old kexec when file based syscall failed\n"
> >  	       " -d, --debug           Enable debugging to help spot a failure.\n"
> >  	       "\n"
> >  	       "Supported kernel file types and options: \n");
> > @@ -1204,6 +1205,7 @@ int main(int argc, char *argv[])
> >  	int do_unload = 0;
> >  	int do_reuse_initrd = 0;
> >  	int do_kexec_file_syscall = 0;
> > +	int do_fallback_kexec_syscall = 0;
> >  	void *entry = 0;
> >  	char *type = 0;
> >  	char *endptr;
> > @@ -1226,9 +1228,13 @@ int main(int argc, char *argv[])
> >  		case OPT_KEXEC_FILE_SYSCALL:
> >  			do_kexec_file_syscall = 1;
> >  			break;
> > +		case OPT_FALLBACK_KEXEC:
> > +			do_fallback_kexec_syscall = 1;
> > +			break;
> >  		}
> >  	}
> >  
> > +fallback:
> >  	/* Reset getopt for the next pass. */
> >  	opterr = 1;
> >  	optind = 1;
> > @@ -1407,6 +1413,13 @@ int main(int argc, char *argv[])
> >  			result = my_load(type, fileind, argc, argv,
> >  						kexec_flags, entry);
> >  	}
> > +	/* fallback to old kexec syscall */
> > +	if (do_kexec_file_syscall && result != 0 && do_fallback_kexec_syscall) {
> > +		fprintf(stderr, "Fallback to kexec syscall\n");
> > +		do_kexec_file_syscall = 0;
> > +		do_fallback_kexec_syscall = 0;
> > +		goto fallback;
> > +	}
> >  	/* Don't shutdown unless there is something to reboot to! */
> >  	if ((result == 0) && (do_shutdown || do_exec) && !kexec_loaded()) {
> >  		die("Nothing has been loaded!\n");
> > diff --git a/kexec/kexec.h b/kexec/kexec.h
> > index 9194f1c..65dbd56 100644
> > --- a/kexec/kexec.h
> > +++ b/kexec/kexec.h
> > @@ -225,7 +225,8 @@ extern int file_types;
> >  #define OPT_LOAD_PRESERVE_CONTEXT 259
> >  #define OPT_LOAD_JUMP_BACK_HELPER 260
> >  #define OPT_ENTRY		261
> > -#define OPT_MAX			262
> > +#define OPT_FALLBACK_KEXEC	262
> > +#define OPT_MAX			263
> >  #define KEXEC_OPTIONS \
> >  	{ "help",		0, 0, OPT_HELP }, \
> >  	{ "version",		0, 0, OPT_VERSION }, \
> > @@ -244,6 +245,7 @@ extern int file_types;
> >  	{ "mem-max",		1, 0, OPT_MEM_MAX }, \
> >  	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
> >  	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
> > +	{ "fallback-kexec",     0, 0, OPT_FALLBACK_KEXEC }, \
> >  	{ "debug",		0, 0, OPT_DEBUG }, \
> >  
> >  #define KEXEC_OPT_STR "h?vdfxyluet:ps"
> > -- 
> > 2.6.6
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
