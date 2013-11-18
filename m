Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViLI4-00065x-Qu
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 09:38:46 +0000
Date: Mon, 18 Nov 2013 17:37:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 1/7 v2] Add function efi_remap_region for remapping to
 saved virt address
Message-ID: <20131118093749.GA16381@dhcp-16-126.nay.redhat.com>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082715.502723229@dhcp-16-126.nay.redhat.com>
 <1384556525.1791.4.camel@misato.fc.hp.com>
 <20131118020939.GB4025@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131118020939.GB4025@dhcp-16-126.nay.redhat.com>
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
To: Toshi Kani <toshi.kani@hp.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/18/13 at 10:09am, Dave Young wrote:
> On 11/15/13 at 04:02pm, Toshi Kani wrote:
> > On Tue, 2013-11-05 at 16:20 +0800, dyoung@redhat.com wrote:
> > > Kexec kernel will use saved runtime virtual mapping, so add a
> > > new function efi_remap_region to remapping it directly without
> > > calculate the virt addr from efi_va.
> > > 
> > > The md is passed in from 1st kernel, the virtual addr is
> > > saved in md->virt_addr.
> > 
> >  :
> > 
> > > +/*
> > > + * kexec kernel will use efi_map_region_fixed to map efi
> > > + * runtime memory ranges. md->virt_addr is the original virtual
> > > + * address which had been mapped in kexec 1st kernel.
> > > + */
> > > +void __init efi_map_region_fixed(efi_memory_desc_t *md)
> > 
> > Can you simply use __map_region() instead of creating this function?
> > Both functions seem to do the same thing.  (In __map_region(), size and
> > end are not used.)
> 
> Matt also suggest to reuse __map_region in another apply, will do.

Will remove the unused variables in another patch.

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
