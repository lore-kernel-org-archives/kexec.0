Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViEHY-0000sG-7O
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 02:09:45 +0000
Date: Mon, 18 Nov 2013 10:08:51 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 3/7 v2] Cleanup efi_enter_virtual_mode function
Message-ID: <20131118020850.GA4025@dhcp-16-126.nay.redhat.com>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082716.825753041@dhcp-16-126.nay.redhat.com>
 <1384557682.1791.9.camel@misato.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384557682.1791.9.camel@misato.fc.hp.com>
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

On 11/15/13 at 04:21pm, Toshi Kani wrote:
> On Tue, 2013-11-05 at 16:20 +0800, dyoung@redhat.com wrote:
> > Add two small functions:
> > efi_merge_regions and efi_map_regions, efi_enter_virtual_mode
> > calls them instead of embedding two long for loop.
> 
>  :
> 
> > +void __init efi_enter_virtual_mode(void)
> > +{
> > +	efi_status_t status;
> > +	void *p, *new_memmap = NULL;
> 
> *p is unused.

The *p was removed in later patch, will remove it in this patch.

Thanks for review.
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
