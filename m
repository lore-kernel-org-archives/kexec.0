Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cWjB4-0002dq-D0
 for kexec@lists.infradead.org; Thu, 26 Jan 2017 12:29:27 +0000
Date: Thu, 26 Jan 2017 13:28:51 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v4] kexec: implemented XEN KEXEC STATUS to determine if
 an image is loaded
Message-ID: <20170126122851.GP16671@olila.local.net-space.pl>
References: <1485358275-11304-1-git-send-email-eric.devolder@oracle.com>
 <20170125230248.GM16671@olila.local.net-space.pl>
 <20170126102219.GA25761@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170126102219.GA25761@verge.net.au>
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
Cc: andrew.cooper3@citrix.com, Eric DeVolder <eric.devolder@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xenproject.org, konrad.wilk@oracle.com

On Thu, Jan 26, 2017 at 11:22:19AM +0100, Simon Horman wrote:
> On Thu, Jan 26, 2017 at 12:02:48AM +0100, Daniel Kiper wrote:
> > On Wed, Jan 25, 2017 at 09:31:15AM -0600, Eric DeVolder wrote:
> >
> > [...]
> >
> > > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > > index 500e5a9..ec16247 100644
> > > --- a/kexec/kexec.c
> > > +++ b/kexec/kexec.c
> > > @@ -51,6 +51,9 @@
> > >  #include "kexec-lzma.h"
> > >  #include <arch/options.h>
> > >
> > > +#define KEXEC_LOADED_PATH "/sys/kernel/kexec_loaded"
> > > +#define KEXEC_CRASH_LOADED_PATH "/sys/kernel/kexec_crash_loaded"
> > > +
> > >  unsigned long long mem_min = 0;
> > >  unsigned long long mem_max = ULONG_MAX;
> > >  static unsigned long kexec_flags = 0;
> > > @@ -890,8 +893,6 @@ static int my_exec(void)
> > >  	return -1;
> > >  }
> > >
> > > -static int kexec_loaded(void);
> > > -
> > >  static int load_jump_back_helper_image(unsigned long kexec_flags, void *entry)
> > >  {
> > >  	int result;
> > > @@ -902,6 +903,40 @@ static int load_jump_back_helper_image(unsigned long kexec_flags, void *entry)
> > >  	return result;
> > >  }
> > >
> > > +static int kexec_loaded(const char *file)
> > > +{
> > > +	long ret = -1;
> > > +	FILE *fp;
> > > +	char *p;
> > > +	char line[3];
> > > +
> > > +	/* No way to tell if an image is loaded under Xen, assume it is. */
> > > +	if (xen_present())
> > > +		return 1;
> > > +
> > > +	fp = fopen(file, "r");
> > > +	if (fp == NULL)
> > > +		return -1;
> > > +
> > > +	p = fgets(line, sizeof(line), fp);
> > > +	fclose(fp);
> > > +
> > > +	if (p == NULL)
> > > +		return -1;
> > > +
> > > +	ret = strtol(line, &p, 10);
> > > +
> > > +	/* Too long */
> > > +	if (ret > INT_MAX)
> > > +		return -1;
> > > +
> > > +	/* No digits were found */
> > > +	if (p == line)
> > > +		return -1;
> > > +
> > > +	return (int)ret;
> > > +}
> > > +
> > >  /*
> > >   *	Jump back to the original kernel
> > >   */
> > > @@ -909,7 +944,7 @@ static int my_load_jump_back_helper(unsigned long kexec_flags, void *entry)
> > >  {
> > >  	int result;
> > >
> > > -	if (kexec_loaded()) {
> > > +	if (kexec_loaded(KEXEC_LOADED_PATH)) {
> > >  		fprintf(stderr, "There is kexec kernel loaded, make sure "
> > >  			"you are in kexeced kernel.\n");
> > >  		return -1;
> > > @@ -970,6 +1005,7 @@ void usage(void)
> > >  	       "                      to original kernel.\n"
> > >  	       " -s, --kexec-file-syscall Use file based syscall for kexec operation\n"
> > >  	       " -d, --debug           Enable debugging to help spot a failure.\n"
> > > +	       " -S, --status         Return 0 if the type (by default crash) is loaded.\n"
> > >  	       "\n"
> > >  	       "Supported kernel file types and options: \n");
> > >  	for (i = 0; i < file_types; i++) {
> > > @@ -981,40 +1017,30 @@ void usage(void)
> > >  	printf("\n");
> > >  }
> > >
> > > -static int kexec_loaded(void)
> > > +static int k_status(unsigned long kexec_flags)
> > >  {
> > > -	long ret = -1;
> > > -	FILE *fp;
> > > -	char *p;
> > > -	char line[3];
> > > +	int result;
> > > +	long native_arch;
> > > +
> > > +	/* set the arch */
> > > +	native_arch = physical_arch();
> > > +	if (native_arch < 0) {
> > > +		return -1;
> > > +	}
> > > +	kexec_flags |= native_arch;
> > >
> > > -	/* No way to tell if an image is loaded under Xen, assume it is. */
> > >  	if (xen_present())
> > > -		return 1;
> > > -
> > > -	fp = fopen("/sys/kernel/kexec_loaded", "r");
> > > -	if (fp == NULL)
> > > -		return -1;
> > > -
> > > -	p = fgets(line, sizeof(line), fp);
> > > -	fclose(fp);
> > > -
> > > -	if (p == NULL)
> > > -		return -1;
> > > -
> > > -	ret = strtol(line, &p, 10);
> > > -
> > > -	/* Too long */
> > > -	if (ret > INT_MAX)
> > > -		return -1;
> > > -
> > > -	/* No digits were found */
> > > -	if (p == line)
> > > -		return -1;
> > > -
> > > -	return (int)ret;
> > > +		result = xen_kexec_status(kexec_flags);
> > > +	else {
> > > +		if (kexec_flags & KEXEC_ON_CRASH)
> > > +			result = kexec_loaded(KEXEC_CRASH_LOADED_PATH);
> > > +		else
> > > +			result = kexec_loaded(KEXEC_LOADED_PATH);
> > > +	}
> > > +	return result;
> > >  }
> >
> > Ohhh... This is awful. Have you tried --patience option for "git format-patch"?
> > Does it help? If yes please repost. If it does not let's wait for maintainers
> > opinion about that. Maybe we should leave forward declaration in first patch
> > as is and then move kexec_loaded() in second (as a cleanup).
> >
> > Though otherwise LGTM.
>
> It did not seem to help when I tried.
>
> I'm happy with things the way they are and I will apply this patch.

Great! Thanks.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
