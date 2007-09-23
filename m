Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IZXvg-0006YA-8p
	for kexec@lists.infradead.org; Sun, 23 Sep 2007 16:19:49 -0400
Date: Sun, 23 Sep 2007 22:19:43 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 1/7] Extended crashkernel command line
Message-ID: <20070923201943.GA5272@suse.de>
References: <20070920171845.774383000@stravinsky.suse.de>
	<20070920171846.062209000@stravinsky.suse.de>
	<E1IZEAi-00051i-23@flower>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IZEAi-00051i-23@flower>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Oleg Verych <olecom@flower.upol.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Oleg Verych <olecom@flower.upol.cz> [2007-09-23 01:14]:
> * Thu, 20 Sep 2007 19:18:46 +0200
> 
> []
> >  extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
> >  extern unsigned int vmcoreinfo_size;
> >  extern unsigned int vmcoreinfo_max_size;
> > +int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
> > +		unsigned long long *crash_size, unsigned long long *crash_base);
> 
> (BTW, why `system_ram' is `unsigned long' in parse_crashkernel_mem() but
> `unsigned long long' in parse_crashkernel()?)

Because that's a bug, thanks for spotting that out. I will sent an
updated version of this patch until the issue below has been
clarified:

> What is the point of not using `ulong' and `u64'?
> 
> What about another names?
> 
>  +int __init get_crashkernel_params(u64 *memsize, u64 *addrbase, char *cmdline, u64 ram);

Andrew, what's your opinion on this? Whould I resend the patch with
shorter type names?


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
