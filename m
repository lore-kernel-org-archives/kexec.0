Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aw4i1-0007H8-Od
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 09:27:38 +0000
Date: Fri, 29 Apr 2016 17:32:21 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH 2/3] kexec: ensure user memory sizes do not wrap
Message-ID: <20160429093221.GA23421@dhcp-128-25.nay.redhat.com>
References: <20160414195938.GV19428@n2100.arm.linux.org.uk>
 <E1aqnQt-0001U2-Oa@rmk-PC.arm.linux.org.uk>
 <20160428110722.GA28541@dhcp-128-25.nay.redhat.com>
 <20160428122209.GZ19428@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160428122209.GZ19428@n2100.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org

On 04/28/16 at 01:22pm, Russell King - ARM Linux wrote:
> On Thu, Apr 28, 2016 at 07:07:22PM +0800, Minfei Huang wrote:
> > On 04/14/16 at 09:00pm, Russell King wrote:
> > > Ensure that user memory sizes do not wrap around when validating the
> > > user input, which can lead to the following input validation working
> > > incorrectly.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > ---
> > >  kernel/kexec_core.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index 8d34308ea449..d719a4d0ef55 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -169,6 +169,8 @@ int sanity_check_segment_list(struct kimage *image)
> > >  
> > >  		mstart = image->segment[i].mem;
> > >  		mend   = mstart + image->segment[i].memsz;
> > > +		if (mstart > mend)
> > > +			return result;
> > 
> > The type of image->segment[i].memsz is unsigned. So it is no need to
> > have a test here.
> 
> Absolutely wrong.  Consider the case:
> 
> 	segment[i].mem = 0xfff00000;
> 	segment[i].size = 0x00200000;
> 
> Here, mstart will be 0xfff00000, and mend will be 0x00100000.  Just
> because it's some random type does not make things magically work.

Hi, Russell.

Do you mean in PAE mode? If so, we will be in big trouble, because there
are a lot of functions which use unsigned long to store memory address,
and this type is 32 bit in PAE mode.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
