Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c5nAj-0005B3-OJ
 for kexec@lists.infradead.org; Sun, 13 Nov 2016 05:17:42 +0000
Date: Sun, 13 Nov 2016 13:17:17 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v6 7/9] iommu/amd: Update domain into to dte entry during
 device driver init
Message-ID: <20161113051717.GB19995@x1>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
 <1476963440-23039-8-git-send-email-bhe@redhat.com>
 <20161110114816.GE9996@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161110114816.GE9996@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Vincent.Wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com

Hi Joerg,

Thanks for your reviewing and great comments!

On 11/10/16 at 12:48pm, Joerg Roedel wrote:
> On Thu, Oct 20, 2016 at 07:37:18PM +0800, Baoquan He wrote:
> >  	prot = dir2prot(direction);
> > +	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
> > +		dev_data->domain_updated = true;
> > +		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
> > +		if (alias != dev_data->devid)
> > +			set_dte_entry(alias, domain, dev_data->ats.enabled);
> > +		device_flush_dte(dev_data);
> > +	}
> 
> Hmm, I really don't like to have these checks in the fast-path. But to
> get rid of it I think we need to re-work the way domains are assigned to
> devices.
> 
> One way to do this would be to add a 'defered-domain-attach' feature to
> the iommu-core code. What do you think about this?

Yes, I have to admit code in this patch is really urly. Could you say a
little more about the "defered-domain-attach"? I would love to do any
improvement as long as it's make things correct and better. I could read
code flow several times from init to the end of driver probe, then may
get what you say because of my limited knowledge. If you can give a little
details about it, I can try to change and post for reviewing.

What I get now is you want to see a function  is added so that we can invoke
when attach domain to device. And the calling can be decided by checking
if it's in kdump. This makes it like intel iommu does, defer the
attaching to probe stage. That's why you don't need to do what I am
doing in this patch when you fix intel iommu failure in kdump kernel. Am
I right?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
