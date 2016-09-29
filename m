Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpVyV-0002Kl-Nl
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 07:41:48 +0000
Date: Thu, 29 Sep 2016 09:41:22 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
Message-ID: <20160929074122.GC14497@verge.net.au>
References: <1474615059-9510-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160923095046.GB22928@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160923095046.GB22928@localhost.localdomain>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, kexec@lists.infradead.org

On Fri, Sep 23, 2016 at 03:20:46PM +0530, Pratyush Anand wrote:
> On 23/09/2016:12:47:39 PM, Madhavan Srinivasan wrote:
> > In dt_copy_old_root_param(), FILE * returned
> > from fopen is not checked for NULL pointer
> > before passinig to fclose(). This could trigger
> > a segfault. Patch adds a check.
> > 
> > Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> > ---
> >  kexec/fs2dt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> > index 6ed2399759cf..2c1ebdf525f4 100644
> > --- a/kexec/fs2dt.c
> > +++ b/kexec/fs2dt.c
> > @@ -540,7 +540,8 @@ static void dt_copy_old_root_param(void)
> >  	if (last_cmdline)
> >  		free(last_cmdline);
> >  
> > -	fclose(fp);
> > +	if (fp)
> > +		fclose(fp);
> 
> Looks fine, however a better practise could be to return just after fopen() if
> fp was null.

That sounds like it would be somewhat cleaner.
Madhavan, could you see about making it so?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
