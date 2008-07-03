Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KEPbQ-0001Yu-7o
	for kexec@lists.infradead.org; Thu, 03 Jul 2008 14:16:04 +0000
Date: Thu, 3 Jul 2008 16:15:43 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: x86: Add /sys/firmware/memmap
Message-ID: <20080703141543.GA26416@elte.hu>
References: <1214565175-21512-1-git-send-email-bwalle@suse.de>
	<20080627181833.GA7735@suse.de>
	<20080627203409.3bc891e3@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080627203409.3bc891e3@kopernikus.site>
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
Cc: x86@kernel.org, Greg KH <gregkh@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com, vgoyal@redhat.com


* Bernhard Walle <bwalle@suse.de> wrote:

> * Greg KH <gregkh@suse.de> [2008-06-27 11:18]:
> > 
> > Looks good, want me to take this through my tree (due to the firmware
> > core change)?  If so, can you get an ack on the x86 portion from the
> > respective people as well?
> 
> Well, the x86 part only applies on tip (because your tree doesn't have 
> the e820_{32,64} -> e820 merge). So, wouldn't it easier to ack that 
> patch from your side and merge via tip?

Bernhard, i've created a new -tip topic for your changes: 
tip/sysfs/firmware-mmap. It is available at:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git sysfs/firmware-mmap

This will become a 2-commit topic branch once the dependent x86 bits are 
upstream. At that point Greg will be able to pull it from -tip and push 
it out via the sysfs tree.

I've added it to the tip/master integration rules to give it testing and 
to make sure any subsequent x86 changes stay in sync with the e820 API 
changes your patches required.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
