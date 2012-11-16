Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZN2T-0001mu-Is
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 14:37:03 +0000
Date: Fri, 16 Nov 2012 09:36:49 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-ID: <20121116143649.GA4515@redhat.com>
References: <50A4E524.8020702@linux.vnet.ibm.com>
 <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
 <20121115155557.GF2529@redhat.com>
 <50A60CF2.6010309@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50A60CF2.6010309@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp, buendgen@de.ibm.com

On Fri, Nov 16, 2012 at 03:22:50PM +0530, Aravinda Prasad wrote:
> 
> 
> On 2012-11-15 21:25, Vivek Goyal wrote:
> 
> > On Thu, Nov 15, 2012 at 09:27:45AM -0500, Dave Anderson wrote:
> > 
> > [..]
> >>> Yes, makedumpfile needs to be linked against eppic library for filtering
> >>> data and this will increase makedumpfile size and initramfs size too.
> >>
> >> Just to clarify -- your example indicates that the vmlinux file is required
> >> for this facility to work, correct?
> >>  
> >>> makedumpfile -c -d 31 -x vmlinux --eppic key.c vmcore filtered_vmcore
> >>
> >> Clearly distros won't be putting the vmlinux file in the initramfs -- that's
> >> the whole reasoning behind vmcoreinfo.  So the 99% of users that aren't
> >> interested in scrubbing will have to pay the penalty of the larger makedumpfile
> >> binary.
> > 
> > That's a good point Dave. We will never put debug compiled vmlinux in 
> > initramfs. Following two alternatives come to my mind.
> 
> 
> As I mentioned, we don't need vmlinux in initramfs as filtering is done
> during post processing only.

You are missing the point. The point is that despite the fact that
scrubbing will never be done from initramfs, all the users will pay
penalty for increased makedumpfile size.

So why not write a separate tool (scrub-vmcore) so that makedumpfile
users don't pay the bloated size penatly.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
