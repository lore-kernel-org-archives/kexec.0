Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpWip-0000bn-P9
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 08:29:40 +0000
Date: Thu, 29 Sep 2016 16:29:11 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
Message-ID: <20160929082911.GA13033@dhcp-128-65.nay.redhat.com>
References: <1475135953-21729-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160929082020.GH14497@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160929082020.GH14497@verge.net.au>
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
Cc: panand@redhat.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, kexec@lists.infradead.org

On 09/29/16 at 10:20am, Simon Horman wrote:
> [CC Dave Young]
> 
> On Thu, Sep 29, 2016 at 01:29:13PM +0530, Madhavan Srinivasan wrote:
> > In dt_copy_old_root_param(), FILE * returned
> > from fopen is not checked for NULL pointer
> > before passinig to fclose(). This could trigger
> > a segfault. Patch to fix the same.
> > 
> > Reviewed-by: Dave Young <dyoung@redhat.com>
> 
> Probably Dave's tag should be dropped as that was for a somewhat
> different (though equally trivial) approach.

Simion, I think I'm fine with any of them. 

> 
> > Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> > ---
> > Changelog v1:
> >  - Moved the check right after fopen
> > 
> >  kexec/fs2dt.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> > index 6ed2399759cf..5ba3ec0fa65c 100644
> > --- a/kexec/fs2dt.c
> > +++ b/kexec/fs2dt.c
> > @@ -524,6 +524,9 @@ static void dt_copy_old_root_param(void)
> >  	strcpy(filename, pathname);
> >  	strcat(filename, "bootargs");
> >  	fp = fopen(filename, "r");
> > +	if (!fp)
> > +		return;
> > +
> 
> With the (!fp) conditional above the (fp) conditional below can be removed.
> 
> >  	if (fp) {
> >  		if (getline(&last_cmdline, &len, fp) == -1)
> >  			die("unable to read %s\n", filename);
> > -- 
> > 2.7.4
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
