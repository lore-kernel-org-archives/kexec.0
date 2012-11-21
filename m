Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbAnz-00087s-TM
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 13:57:33 +0000
Date: Wed, 21 Nov 2012 08:57:21 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-ID: <20121121135721.GB13114@redhat.com>
References: <50A4E524.8020702@linux.vnet.ibm.com>
 <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
 <20121115155557.GF2529@redhat.com>
 <50A60CF2.6010309@linux.vnet.ibm.com>
 <20121116143649.GA4515@redhat.com>
 <20121120184755.01bc3c780dc226fe32f06e66@mxc.nes.nec.co.jp>
 <50AC809E.9060907@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50AC809E.9060907@linux.vnet.ibm.com>
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
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, anderson@redhat.com, buendgen@de.ibm.com

On Wed, Nov 21, 2012 at 12:49:58PM +0530, Aravinda Prasad wrote:
> 
> 
> On 2012-11-20 15:17, Atsushi Kumagai wrote:
> 
> ...
> 
> 
> >>>
> >>>
> >>> As I mentioned, we don't need vmlinux in initramfs as filtering is done
> >>> during post processing only.
> >>
> >> You are missing the point. The point is that despite the fact that
> >> scrubbing will never be done from initramfs, all the users will pay
> >> penalty for increased makedumpfile size.
> >>
> >> So why not write a separate tool (scrub-vmcore) so that makedumpfile
> >> users don't pay the bloated size penatly.
> > 
> > As Vivek said, I think it's difficult to persuade almost all distributor
> > to specify EPPIC=on.
> > 
> > So, it seems that separate tool is better way for both user and distributor.
> > If you will make it, I will drop eppic support from v1.5.1 and export core
> > functions from makedumpfile as library for such tools in the future.
> > 
> > Does this meet your purpose, Aravinda ?
> 
> 
> Vivek, Atsushi,
> 
> How about distributions building two targets one with default
> makedumpfile and other with EPPIC=on, which can be done by a simple
> modification to Makefile.

That's not a good idea. Generally distributions don't ship multiple
binaries with minor differences like that. I think going with a
separate tool for doing this kind of filtering is better.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
