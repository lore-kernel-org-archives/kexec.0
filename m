Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqvlL-0007bP-GQ
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 02:12:27 +0000
Date: Thu, 12 Dec 2013 10:11:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 09/14] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131212021145.GD3751@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-10-git-send-email-dyoung@redhat.com>
 <20131211121352.GB29980@console-pimps.org>
 <20131211140531.GJ21683@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131211140531.GJ21683@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Matt Fleming <matt@console-pimps.org>, linux-efi@vger.kernel.org, toshi.kani@hp.com, mjg59@srcf.ucam.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 12/11/13 at 03:05pm, Borislav Petkov wrote:
> On Wed, Dec 11, 2013 at 12:13:52PM +0000, Matt Fleming wrote:
> > > +	for (i = 0, md = data->map; i < nr_efi_runtime_map; i++, md++) {
> > > +		efi_map_region_fixed(md); /* FIXME: add error handling */
> > 
> > Oops. Please fix this ;-)
> 
> Yeah, this is on my TODO as it wraps around __map_region, the latter
> needing to propagate error codes.
> 
> I'll take care of it once you merge Dave's patchset.

Thanks Boris..

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
