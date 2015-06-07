Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-x231.google.com ([2a00:1450:400c:c05::231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z1apu-0001c7-K8
 for kexec@lists.infradead.org; Sun, 07 Jun 2015 13:42:03 +0000
Received: by wibut5 with SMTP id ut5so60995951wib.1
 for <kexec@lists.infradead.org>; Sun, 07 Jun 2015 06:41:40 -0700 (PDT)
Date: Sun, 7 Jun 2015 15:41:36 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3 v3] Fix kdump failures with crashkernel=high
Message-ID: <20150607134136.GA27512@gmail.com>
References: <1433500202-25531-1-git-send-email-joro@8bytes.org>
 <20150605132736.GF3679@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150605132736.GF3679@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: jroedel@suse.de, Baoquan He <bhe@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>


* Borislav Petkov <bp@alien8.de> wrote:

> > Joerg Roedel (3):
> >   swiotlb: Warn on allocation failure in swiotlb_alloc_coherent
> >   x86, swiotlb: Try coherent allocations with __GFP_NOWARN
> >   x86, crash: Allocate enough low-mem when crashkernel=high
> > 
> >  arch/x86/kernel/pci-swiotlb.c |  7 +++++++
> >  arch/x86/kernel/setup.c       |  5 ++++-
> >  lib/swiotlb.c                 | 11 +++++++++--
> >  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> Looks simple enough, all applied, thanks.
> 
> hpa, Ingo, any concerns?

Modulo a couple of typos it all looks sane.

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
