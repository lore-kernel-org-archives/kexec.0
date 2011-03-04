Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PvIbv-0004It-Sr
	for kexec@lists.infradead.org; Fri, 04 Mar 2011 00:11:13 +0000
Date: Fri, 4 Mar 2011 09:11:04 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] Avoid signed/unsigned comparsions
Message-ID: <20110304001104.GB15019@verge.net.au>
References: <1299105976-11360-1-git-send-email-horms@verge.net.au>
	<1299105976-11360-2-git-send-email-horms@verge.net.au>
	<m162rzswf6.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m162rzswf6.fsf@fess.ebiederm.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

On Thu, Mar 03, 2011 at 01:53:33PM -0800, Eric W. Biederman wrote:
> Simon Horman <horms@verge.net.au> writes:
> 
> At least the change of ret from ssize_t to size_t is bogus.
> pread returns a ssize_t and I am comparing it against sizeof(X).  We
> might as we type convert in the comparison.   That test is a necessary 
> and real comparison and I don't think hiding that fact with an implicit
> conversion does anything but obfuscate things.

Thanks, I'll restore ret to a ssize_t.

> 
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  vmcore-dmesg/vmcore-dmesg.c |   12 ++++--------
> >  1 files changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> > index 365e293..f7eef16 100644
> > --- a/vmcore-dmesg/vmcore-dmesg.c
> > +++ b/vmcore-dmesg/vmcore-dmesg.c
> > @@ -79,8 +79,7 @@ static void read_elf32(int fd)
> >  {
> >  	Elf32_Ehdr ehdr32;
> >  	Elf32_Phdr *phdr32;
> > -	size_t phdrs32_size, phdrs_size;
> > -	ssize_t ret, i;
> > +	ssize_t phdrs32_size, phdrs_size, ret, i;
> >  
> >  	ret = pread(fd, &ehdr32, sizeof(ehdr32), 0);
> >  	if (ret != sizeof(ehdr32)) {
> > @@ -151,8 +150,7 @@ static void read_elf64(int fd)
> >  {
> >  	Elf64_Ehdr ehdr64;
> >  	Elf64_Phdr *phdr64;
> > -	size_t phdrs_size;
> > -	ssize_t ret, i;
> > +	size_t phdrs_size, ret, i;
> >  
> >  	ret = pread(fd, &ehdr64, sizeof(ehdr64), 0);
> >  	if (ret != sizeof(ehdr)) {
> > @@ -240,8 +238,7 @@ static void scan_vmcoreinfo(char *start, size_t size)
> >  	};
> >  
> >  	for (pos = start; pos <= last; pos = eol + 1) {
> > -		size_t len;
> > -		int i;
> > +		size_t len, i;
> >  		/* Find the end of the current line */
> >  		for (eol = pos; (eol <= last) && (*eol != '\n') ; eol++)
> >  			;
> > @@ -274,8 +271,7 @@ static void scan_vmcoreinfo(char *start, size_t size)
> >  static void scan_notes(int fd, loff_t start, loff_t lsize)
> >  {
> >  	char *buf, *last, *note, *next;
> > -	size_t size;
> > -	ssize_t ret;
> > +	ssize_t size, ret;
> >  
> >  	if (lsize > LONG_MAX) {
> >  		fprintf(stderr, "Unable to handle note section of %llu bytes\n",
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
