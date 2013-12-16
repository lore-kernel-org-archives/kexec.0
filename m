Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VsNLO-0005nf-Ue
 for kexec@lists.infradead.org; Mon, 16 Dec 2013 01:51:40 +0000
Date: Mon, 16 Dec 2013 09:50:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 02/14] efi: use early_memremap and early_memunmap
Message-ID: <20131216015049.GB3754@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-3-git-send-email-dyoung@redhat.com>
 <20131211103903.GC19196@console-pimps.org>
 <20131211110227.GK22356@rocoto.smurfnet.nu>
 <20131211113207.GA29980@console-pimps.org>
 <1386775078.1979.98.camel@deneb.redhat.com>
 <20131213155133.GR22356@rocoto.smurfnet.nu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131213155133.GR22356@rocoto.smurfnet.nu>
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
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Matt Fleming <matt@console-pimps.org>, linux-efi@vger.kernel.org, hpa@zytor.com, mjg59@srcf.ucam.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@gmail.com>, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, Mark Salter <msalter@redhat.com>, toshi.kani@hp.com, vgoyal@redhat.com

On 12/13/13 at 04:51pm, Leif Lindholm wrote:
> On Wed, Dec 11, 2013 at 10:17:58AM -0500, Mark Salter wrote:
> > Anyway, I posted a patch to create a generic early_ioremap
> > implementation using generic bits of the x86 code:
> > 
> >   https://lkml.org/lkml/2013/11/27/621
> > 
> > So maybe Dave's patch 1/14 should be part of that series or
> > get rebased on top of it.
> 
> Yes, having those two sets of changes to the same bits floating around
> at the same time is painful.
> If you could integrate those changes into your set, everyone wins.

I have no idea how to handle these dependency problems between different
patchset, but for this one I feel it's better to add it to Mark's series,
what's the status of the series, has it been reviewed and ready for merge?

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
