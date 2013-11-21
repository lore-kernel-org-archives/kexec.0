Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjWb7-00078R-Qa
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 15:55:18 +0000
Date: Thu, 21 Nov 2013 16:54:48 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [patch 1/9 v3] efi: remove unused variables in __map_region
Message-ID: <20131121155448.GJ26009@pd.tnic>
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
 <20131121061752.715177297@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121061752.715177297@dhcp-16-126.nay.redhat.com>
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
To: dyoung@redhat.com
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Thu, Nov 21, 2013 at 02:17:05PM +0800, dyoung@redhat.com wrote:
> variables size and end is useless in this function, thus remove them.
> 
> Reported-by: Toshi Kani <toshi.kani@hp.com>
> Signed-off-by: Dave Young <dyoung@redhat.com>

Good catch.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
