Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VrV1k-0001XG-DE
 for kexec@lists.infradead.org; Fri, 13 Dec 2013 15:51:44 +0000
Received: by mail-qa0-f52.google.com with SMTP id cm18so886252qab.4
 for <kexec@lists.infradead.org>; Fri, 13 Dec 2013 07:51:21 -0800 (PST)
Date: Fri, 13 Dec 2013 16:51:33 +0100
From: Leif Lindholm <leif.lindholm@linaro.org>
Subject: Re: [PATCH v5 02/14] efi: use early_memremap and early_memunmap
Message-ID: <20131213155133.GR22356@rocoto.smurfnet.nu>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-3-git-send-email-dyoung@redhat.com>
 <20131211103903.GC19196@console-pimps.org>
 <20131211110227.GK22356@rocoto.smurfnet.nu>
 <20131211113207.GA29980@console-pimps.org>
 <1386775078.1979.98.camel@deneb.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386775078.1979.98.camel@deneb.redhat.com>
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
To: Mark Salter <msalter@redhat.com>
Cc: Matt Fleming <matt@console-pimps.org>, linux-efi@vger.kernel.org, toshi.kani@hp.com, mjg59@srcf.ucam.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@gmail.com>, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Wed, Dec 11, 2013 at 10:17:58AM -0500, Mark Salter wrote:
> Anyway, I posted a patch to create a generic early_ioremap
> implementation using generic bits of the x86 code:
> 
>   https://lkml.org/lkml/2013/11/27/621
> 
> So maybe Dave's patch 1/14 should be part of that series or
> get rebased on top of it.

Yes, having those two sets of changes to the same bits floating around
at the same time is painful.
If you could integrate those changes into your set, everyone wins.

/
    Leif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
