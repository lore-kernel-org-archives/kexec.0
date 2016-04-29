Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aw5qx-0007Wv-RA
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 10:40:56 +0000
Date: Fri, 29 Apr 2016 18:45:39 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH 2/3] kexec: ensure user memory sizes do not wrap
Message-ID: <20160429104539.GB23421@dhcp-128-25.nay.redhat.com>
References: <20160414195938.GV19428@n2100.arm.linux.org.uk>
 <E1aqnQt-0001U2-Oa@rmk-PC.arm.linux.org.uk>
 <20160428110722.GA28541@dhcp-128-25.nay.redhat.com>
 <20160428122209.GZ19428@n2100.arm.linux.org.uk>
 <20160429093221.GA23421@dhcp-128-25.nay.redhat.com>
 <20160429093046.GR19428@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160429093046.GR19428@n2100.arm.linux.org.uk>
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

On 04/29/16 at 10:30am, Russell King - ARM Linux wrote:
> > > > > @@ -169,6 +169,8 @@ int sanity_check_segment_list(struct kimage *image)
> > > > >  
> > > > >  		mstart = image->segment[i].mem;
> > > > >  		mend   = mstart + image->segment[i].memsz;
> > > > > +		if (mstart > mend)
> > > > > +			return result;
> > > > 
> > > > The type of image->segment[i].memsz is unsigned. So it is no need to
> > > > have a test here.
> > > 
> > > Absolutely wrong.  Consider the case:
> > > 
> > > 	segment[i].mem = 0xfff00000;
> > > 	segment[i].size = 0x00200000;
> > > 
> > > Here, mstart will be 0xfff00000, and mend will be 0x00100000.  Just
> > > because it's some random type does not make things magically work.
> > 
> > Hi, Russell.
> > 
> > Do you mean in PAE mode? If so, we will be in big trouble, because there
> > are a lot of functions which use unsigned long to store memory address,
> > and this type is 32 bit in PAE mode.
> 
> This is basic input validation stuff, it's got nothing to do with whether
> we're in PAE mode.  If we get passed such a segment as I illustrate above,
> we should detect and fail it, just as we detect and fail other similar
> errors.
> 
> I'm not sure what the big deal here is.  This is basic validation checks
> for stuff coming from userspace which the kernel should be doing as a
> matter of course to protect itself.

Hi, Russell.

Thanks for your reply. I'm fine with this basic test now.

Please feel free to add
Reviewed-by: Minfei Huang <mhuang@redhat.com>.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
