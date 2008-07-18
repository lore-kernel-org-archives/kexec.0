Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KJxcw-0007qt-MH
	for kexec@lists.infradead.org; Fri, 18 Jul 2008 21:36:35 +0000
Date: Fri, 18 Jul 2008 23:36:22 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: Move dma32_reserve_bootmem() after
	reserve_crashkernel()
Message-ID: <20080718213622.GA14603@elte.hu>
References: <86802c440807180922l3500082chf7dcf0a1bafc6629@mail.gmail.com>
	<1216400873-21862-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1216400873-21862-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, yhlu.kernel@gmail.com, vgoyal@redhat.com, linux-kernel@vger.kernel.org


* Bernhard Walle <bwalle@suse.de> wrote:

> On a x86-64 machine (nothing special I could encounter) I had the 
> problem that crashkernel reservation with the usual "64M@16M" failed. 
> While debugging that, I encountered that dma32_reserve_bootmem() 
> reserves a memory region which is in that area.
> 
> Because dma32_reserve_bootmem() does not rely on a specific offset but 
> crashkernel does, it makes sense to move the dma32_reserve_bootmem() 
> reservation down a bit. I tested that patch and it works without 
> problems. I don't see any negative effects of that move, but maybe I 
> oversaw something ...
> 
> While we strictly don't need that patch in 2.6.27 because we have the 
> automatic, dynamic offset detection, it makes sense to also include it 
> here because:
> 
>   - it's easier to get it in -stable then,
>   - many people are still used to the 'crashkernel=...@16M' syntax,
>   - not everybody may be using a reloatable kernel.

applied to tip/x86/crashdump, thanks Bernhard.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
