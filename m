Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaeGX-0002MT-4X
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 04:17:21 +0000
Date: Mon, 28 Oct 2013 13:16:56 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 4/4] Passing efi related data via setup_data
Message-ID: <20131028041653.GA19517@verge.net.au>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.350640917@dhcp-16-126.nay.redhat.com>
 <20131028003726.GF849@verge.net.au>
 <20131028011253.GB4397@dhcp-16-126.nay.redhat.com>
 <20131028030259.GC11692@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028030259.GC11692@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, vgoyal@redhat.com

On Mon, Oct 28, 2013 at 11:02:59AM +0800, Dave Young wrote:
> On 10/28/13 at 09:12am, Dave Young wrote:
> > > > +	size = nr_maps * sizeof(struct efi_mem_descriptor) + sizeof(struct efi_setup_data);
> > > > +	sd = malloc(sizeof(struct setup_data) + size);
> > > > +	if (!sd) {
> > > > +		free(esd);
> > > > +		return;
> > > > +	}
> > > 
> > > This function appears to leak sd.
> > 
> > Will fix
> 
> sd will be passed to add_buffer, it should be freed after kexec_load,
> is it really necessary, or I misunderstand something?

Thanks and sorry for missing that.
I now think the current handling of sd in this patch seems fine.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
