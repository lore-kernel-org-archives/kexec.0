Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K1Fyo-0001yZ-VA
	for kexec@lists.infradead.org; Wed, 28 May 2008 07:21:51 +0000
Date: Wed, 28 May 2008 09:22:25 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Use 'long long' for printf() format string and ELF64
	numbers.
Message-ID: <20080528092225.7f424d67@halley.suse.de>
In-Reply-To: <e2ed954f0805271748s2254480at35f71c3395072def@mail.gmail.com>
References: <20080525221154.2fd2e432@kopernikus.site>
	<e2ed954f0805271748s2254480at35f71c3395072def@mail.gmail.com>
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
To: Jamey Sharp <jamey@minilop.net>
Cc: kexec@lists.infradead.org

* Jamey Sharp [2008-05-27 17:48]:
>
> On Sun, May 25, 2008 at 1:11 PM, Bernhard Walle <bwalle@suse.de> wrote:
> >  kexec/crashdump-elf.c:160: warning: format '%lx' expects type \
> >        'long unsigned int', but argument 4 has type 'Elf64_Off'
> 
> This is what inttypes.h is for, right?
> 
> > dbgprintf("%s: p_type = %u, p_offset = 0x%llx p_paddr = 0x%llx " ...
> 
> Perhaps (... "p_offset = 0x" PRIx64 " p_paddr = 0x" PRIx64 ...)?

Yes, I know this, but it's really ugly to read IMO. If it's not really
necessary I think it's better to avoid it.



	Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
