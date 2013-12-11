Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqkQK-0005C3-4x
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 14:06:00 +0000
Date: Wed, 11 Dec 2013 15:05:31 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 09/14] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131211140531.GJ21683@pd.tnic>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-10-git-send-email-dyoung@redhat.com>
 <20131211121352.GB29980@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131211121352.GB29980@console-pimps.org>
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
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Wed, Dec 11, 2013 at 12:13:52PM +0000, Matt Fleming wrote:
> > +	for (i = 0, md = data->map; i < nr_efi_runtime_map; i++, md++) {
> > +		efi_map_region_fixed(md); /* FIXME: add error handling */
> 
> Oops. Please fix this ;-)

Yeah, this is on my TODO as it wraps around __map_region, the latter
needing to propagate error codes.

I'll take care of it once you merge Dave's patchset.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
