Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqmPd-0000lV-6o
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 16:13:25 +0000
Message-ID: <1386775078.1979.98.camel@deneb.redhat.com>
Subject: Re: [PATCH v5 02/14] efi: use early_memremap and early_memunmap
From: Mark Salter <msalter@redhat.com>
Date: Wed, 11 Dec 2013 10:17:58 -0500
In-Reply-To: <20131211113207.GA29980@console-pimps.org>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-3-git-send-email-dyoung@redhat.com>
 <20131211103903.GC19196@console-pimps.org>
 <20131211110227.GK22356@rocoto.smurfnet.nu>
 <20131211113207.GA29980@console-pimps.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Tony Luck <tony.luck@gmail.com>, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Wed, 2013-12-11 at 11:32 +0000, Matt Fleming wrote:
> On Wed, 11 Dec, at 12:02:27PM, Leif Lindholm wrote:
> > On Wed, Dec 11, 2013 at 10:39:03AM +0000, Matt Fleming wrote:
> > > Leif, Mark, does this patch look OK for ARM? We'd need to introduce a
> > > new early_memunmap() function so that things still build, but that
> > > should be straight forward. You'd even be able to get rid of the
> > > asymmetry in uefi_init() where you map efi.systab with early_memremap()
> > > but unmap it with early_iounmap().
> > 
> > This patch looks splendid for ARM. As long as Mark can get the new
> > function into an update to the early_*remap() set, I can include this
> > in my next version - which is coming this week.
> 
> Great!
> 
> Oh and ia64 would also need early_memunmap(). Tony, the original patch
> is here,
> 

Couldn't ia64 just do:

  #define early_memremap(phys_addr, size) __va(phys_addr)
  #define early_memunmap(addr, size)

Anyway, I posted a patch to create a generic early_ioremap
implementation using generic bits of the x86 code:

  https://lkml.org/lkml/2013/11/27/621

So maybe Dave's patch 1/14 should be part of that series or
get rebased on top of it.

--Mark



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
