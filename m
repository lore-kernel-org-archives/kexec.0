Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KJmcj-00077Z-6c
	for kexec@lists.infradead.org; Fri, 18 Jul 2008 09:51:37 +0000
Date: Fri, 18 Jul 2008 11:52:13 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] x86: Move crashkernel reservation before
	dma32_reserve_bootmem()
Message-ID: <20080718115213.3c87f8f8@halley.suse.de>
In-Reply-To: <86802c440807171550t360a2a76mddb9ae45c7e9f4fb@mail.gmail.com>
References: <1216332945-17197-1-git-send-email-bwalle@suse.de>
	<86802c440807171550t360a2a76mddb9ae45c7e9f4fb@mail.gmail.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: akpm@linux-foundation.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

* Yinghai Lu [2008-07-17 15:50]:
>
> > +       /*
> > +        * dma32_reserve_bootmem() allocates bootmem which may conflict
> > +        * with the crashkernel command line, so do that before
> > +        */
> > +       reserve_crashkernel();
> > +
> >  #ifdef CONFIG_X86_64
> >        dma32_reserve_bootmem();
> >  #endif
> > @@ -808,7 +814,6 @@ void __init setup_arch(char **cmdline_p)
> >         */
> >        find_smp_config();
> >  #endif
> > -       reserve_crashkernel();
> >
> >        reserve_ibft_region();
> 
> Joe Jin already had another one to move dma32_reserve_bootmem later

Commit id? Current status?


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
