Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1as4ij-0000Xu-QG
 for kexec@lists.infradead.org; Mon, 18 Apr 2016 08:39:50 +0000
Date: Mon, 18 Apr 2016 09:37:16 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3] kexec: ensure user memory sizes do not wrap
Message-ID: <20160418083715.GZ19428@n2100.arm.linux.org.uk>
References: <20160414195938.GV19428@n2100.arm.linux.org.uk>
 <E1aqnQt-0001U2-Oa@rmk-PC.arm.linux.org.uk>
 <20160418053534.GB3602@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160418053534.GB3602@x1.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org

On Mon, Apr 18, 2016 at 01:35:34PM +0800, Baoquan He wrote:
> On 04/14/16 at 09:00pm, Russell King wrote:
> > Ensure that user memory sizes do not wrap around when validating the
> > user input, which can lead to the following input validation working
> > incorrectly.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  kernel/kexec_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 8d34308ea449..d719a4d0ef55 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -169,6 +169,8 @@ int sanity_check_segment_list(struct kimage *image)
> >  
> >  		mstart = image->segment[i].mem;
> >  		mend   = mstart + image->segment[i].memsz;
> > +		if (mstart > mend)
> > +			return result;
> 
> These segments are built in kexec utility, their availability should be
> guaranteed there. If without some alignment handling, wrapping around
> might not happen here. But I don't have strong objection to it.

In which case, what's the point of all the other validation which is done,
like the check below:

> >  		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
> >  			return result;
> >  		if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)

Your reply is contradictory to the whole suite of tests which kexec does
to validate its input from userspace.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
