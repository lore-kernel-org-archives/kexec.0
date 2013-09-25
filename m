Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOdR6-0007dI-PK
 for kexec@lists.infradead.org; Wed, 25 Sep 2013 00:58:37 +0000
Date: Wed, 25 Sep 2013 09:58:12 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc: Add nodes for initrd in dtb
Message-ID: <20130925005811.GL26081@verge.net.au>
References: <20130924052240.4517.85639.stgit@localhost.localdomain>
 <524167F4.6030709@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <524167F4.6030709@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: kexec@lists.infradead.org, Athira Rajeev <atrajeev@in.ibm.com>

On Tue, Sep 24, 2013 at 03:52:44PM +0530, Suzuki K. Poulose wrote:
> On 09/24/2013 10:52 AM, Athira Rajeev wrote:
> > From: Suzuki K. Poulose <suzuki@in.ibm.com>
> > 
> > If the primary kernel doesn't use an initrd,
> > we may not have linux,initrd-* entries in the
> > device-tree, and hence the initial flat tree
> > may not contain them.
> > 
> > Make sure we add the entries in the dtb if the
> > second kernel needs an initrd.
> Simon,
> 
> Without this patch, one cannot use an initrd with kexec on a machine
> which is booted without an initrd. (e.g, network booted boards.)
> 
> Please pull this one.

For some reason I don't seem to have the original post of the patch
in my inbox. Could either you or Athira send it to me with
kexec@lists.infradead.org CCed (again?).

> 
> Thanks
> Suzuki
> 
> > 
> > Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> > Signed-off-by: Athira Rajeev<atrajeev@in.ibm.com>
> > ---
> > 
> >  kexec/arch/ppc/fs2dt.c |   18 ++++++++++++++----
> >  1 files changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
> > index a49f85e..4121c7d 100644
> > --- a/kexec/arch/ppc/fs2dt.c
> > +++ b/kexec/arch/ppc/fs2dt.c
> > @@ -342,8 +342,17 @@ static void putnode(void)
> > 
> >  	putprops(dn, namelist, numlist);
> > 
> > -	/* Add initrd entries to the second kernel */
> > -	if (initrd_base && !strcmp(basename, "chosen/")) {
> > +	/* 
> > +	 * Add initrd entries to the second kernel
> > +	 * if
> > +	 * 	a) a ramdisk is specified in cmdline
> > +	 * 	 OR
> > +	 * 	b) reuseinitrd is specified and a initrd is
> > +	 * 	   used by the kernel.
> > +	 *
> > +	 */
> > +	if ((ramdisk || (initrd_base && reuse_initrd))
> > +		&& !strcmp(basename, "chosen/")) {
> >  		int len = 8;
> >  		unsigned long long initrd_end;
> >  		*dt++ = 3;
> > @@ -362,8 +371,9 @@ static void putnode(void)
> > 
> >  		memcpy(dt, &initrd_end, len);
> >  		dt += (len + 3)/4;
> > -
> > -		reserve(initrd_base, initrd_size);
> > +		/* reserve the existing initrd image in case of reuse_initrd */
> > +		if (initrd_base && initrd_size && reuse_initrd)
> > +			reserve(initrd_base, initrd_size);
> >  	}
> > 
> >  	for (i = 0; i < numlist; i++) {
> > 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
