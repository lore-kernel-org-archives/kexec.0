Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K63DH-0007Jd-C6
	for kexec@lists.infradead.org; Tue, 10 Jun 2008 12:44:35 +0000
Date: Tue, 10 Jun 2008 14:44:17 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/3] [x86] Fix crashkernel reservation on NUMA machines
Message-ID: <20080610124417.GA2432@elte.hu>
References: <20080608134628.757299158@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080608134628.757299158@halley.suse.de>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com


* Bernhard Walle <bwalle@suse.de> wrote:

> This patch series fixes the crashkernel reservation on NUMA machine. 
> The regression was discovered by Dave Anderson <anderson@redhat.com>.
> 
> The background is that on NUMA machines, reserve_bootmem_generic() is 
> required instead of reserve_bootmem(). To achieve that, it's necessary 
> to make a few API changes.
> 
> The patches are against latest linux-2.6 git. They should still go 
> into 2.6.26 since it's only bug fixing. For 2.6.27, we should unify 
> crashkernel reservation for i386 and x86-64.
> 
> Tested on both i386 and x86-64. Compilation was tested with both kexec 
> disabled and enabled. The change is x86 only, so no need to test on 
> other architectures.

applied to tip/x86/numa - thanks Bernhard.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
