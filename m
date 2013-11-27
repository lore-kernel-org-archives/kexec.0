Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlgiL-0006Sm-E6
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 15:07:42 +0000
Date: Wed, 27 Nov 2013 16:07:10 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 11/12] x86: reserve setup_data ranges late after
 parsing memmap cmdline
Message-ID: <20131127150710.GH32267@pd.tnic>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-12-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385445477-9665-12-git-send-email-dyoung@redhat.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, Nov 26, 2013 at 01:57:56PM +0800, Dave Young wrote:
> Kdump kernel using memmap=exactmap, move e820_reserve_setup_data after
> parsing early params so they can be set reserved finally. Or kdump kernel
> will warn about ioremap a normal ram range.

I had to stare for a while at this commit message, rereading it a couple
of times and looking at the code in order to understand why you're
moving the call further down.

Please rewrite it into something more readable.

The usual structure which you could use is:

1. Currently we have A
2. We need B
3. In order to achieve it, we do C

or something to that effect.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
