Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1anbNL-0001tR-BJ
 for kexec@lists.infradead.org; Wed, 06 Apr 2016 00:31:16 +0000
Date: Wed, 6 Apr 2016 09:30:51 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] arm: properly handle a missing /chosen node in the DT
Message-ID: <20160406003050.GB27262@verge.net.au>
References: <1459438260-8205-1-git-send-email-alban.bedel@avionic-design.de>
 <20160405063306.GA19694@verge.net.au>
 <20160405093433.GA14598@avionic-0071.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160405093433.GA14598@avionic-0071.adnet.avionic-design.de>
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
To: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
Cc: Alban Bedel <alban.bedel@avionic-design.de>, kexec@lists.infradead.org

On Tue, Apr 05, 2016 at 11:34:33AM +0200, Nikolaus Schulz wrote:
> On Tue, Apr 05, 2016 at 03:33:06PM +0900, Simon Horman wrote:
> > On Thu, Mar 31, 2016 at 05:30:58PM +0200, Alban Bedel wrote:
> > > From: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
> > > 
> > > When adding a new node to the DT in the setup_dtb_prop function, the
> > > parent offset need be passed to fdt_add_subnode.  Currently a bogus
> > > error code is used.  Fix that by adding the parent offset as an extra
> > > function argument to setup_dtb_prop, and change the handling of the
> > > /chosen node to operate on a relative path plus (zero) offset instead of
> > > an absolute path.
> > > 
> > > Signed-off-by: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
> > 
> > Hi,
> > 
> > I am struggling to see the problem that this patch tries to solve.
> > 
> > * Where and when is a bogus error code used?
> 
> Hi Simon!
> 
> The bogus error code is passed to fdt_add_subnode, see comment inline in
> the patch below.

Thanks, I see that clearly now.

For some reason I inverted the "if (off == -FDT_ERR_NOTFOUND)" in my
mind when I was reviewing your patch yesterday.

> > * Why is a new parameter added to fdt_add_subnode and always passed as zero?
> 
> Yeah, this might look irritating... the point is, setup_dtb_prop looks
> like a generic function that could be used for finding/adding any nodes,
> which need not be top-level in the DT.  In practice though, the function
> is only used for the top-level /chosen node, and currently it can't add
> nodes that aren't top-level.
> 
> So, one could either a) make the function non-generic, handling
> top-level nodes only, or b) pass it the offset of the parent node, or c)
> let it operate on aribtrary DT paths with possibly multiple components.
> a) and b) are trivial to do.  libfdt typically does b) for similar
> functions, so I added that extra parameter to fdt_add_subnode.

Thanks, I understand now.
With the above explanation in mind I prefer b).

Could you re-work the changelog to explain things as you have done so above
and then resubmit the entire series?

> > * If it is inappropriate to pass off to fdt_add_subnode() can
> >   that be resolved by simply passing 0 instead?
> 
> If we know that we're adding a top-level node, then yes.  Basically,
> one can do that either in fdt_add_subnode, or when calling it in
> zImage_arm_load.  My patch does the latter.

Understood.

> Best regards,
> Nikolaus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
