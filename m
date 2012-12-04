Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tfo19-0008KD-PQ
 for kexec@lists.infradead.org; Tue, 04 Dec 2012 08:38:17 +0000
Date: Tue, 4 Dec 2012 17:36:25 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-Id: <20121204173625.b79ad10832e0adaa6e4db451@mxc.nes.nec.co.jp>
In-Reply-To: <20121203184001.GA27470@redhat.com>
References: <50A60CF2.6010309@linux.vnet.ibm.com>
 <20121116143649.GA4515@redhat.com>
 <20121120184755.01bc3c780dc226fe32f06e66@mxc.nes.nec.co.jp>
 <50AC809E.9060907@linux.vnet.ibm.com>
 <20121121135721.GB13114@redhat.com>
 <50AE5D89.2090101@linux.vnet.ibm.com>
 <20121126140448.GA28057@redhat.com>
 <50BC4073.7060402@linux.vnet.ibm.com>
 <20121203132059.GC24836@redhat.com>
 <50BCB8CA.3030909@linux.vnet.ibm.com>
 <20121203184001.GA27470@redhat.com>
Mime-Version: 1.0
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
To: aravinda@linux.vnet.ibm.com
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, anderson@redhat.com, vgoyal@redhat.com, buendgen@de.ibm.com

Hello Aravinda,

On Mon, 3 Dec 2012 13:40:01 -0500
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Dec 03, 2012 at 08:05:54PM +0530, Aravinda Prasad wrote:
> 
> [..]
> > >> Another approach is to dynamically load libeppic library - similar way
> > >> how crash does it. No major changes will be done to makedumpfile code,
> > >> except the addition of --eppic flag. Upon specifying --eppic flag
> > >> makedumpfile will dlopen libeppic.so, which will have functionality to
> > >> scrub the specified data. This will prevent makedumpfile bloat and will
> > >> not affect the size of initramfs as --eppic is only specified during
> > >> post processing. The distribution should build and ship libeppic.so and
> > >> the procedure for building .so will be similar to what we have in crash.
> > > 
> > > It will still show up in dynamic library dependencing using ldd. We will
> > > have to put some hack to exclude the leppic despite the fact that
> > > makedumpfile is dependent on it. 
> > > 
> > > In F18, now we use dracut to build kdump initramfs. On command line we
> > > specify any extra binaries to be included and makedumpfile is one of
> > > those. Dracut will determine all the dependencies and automatically pull
> > > these in. So even if we don't use --eppic flag, dracult will pull in
> > > eppic shared library anyway.
> > 
> > 
> > I think ldd or dracut will not be able to make out that we are dependent
> > on libeppic.so as we will be using the dlopen("libeppic.so, ...) call to
> > dynamically load. No extra flags will be added to Makefile to specify
> > -leppic while building makedumpfile. Hence, from my understanding, while
> > building kdump initramfs, dracut cannot determine that we are dependent
> > on eppic
> 
> Ok, if dracut does not pull in libeppic and does not bloat size of
> initramfs, I am fine.

I agree with this idea too.

However, the release date is closing in, so would you re-send the patch set
based on v1.5.1 ? I will accept it as official feature in v1.5.2.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
