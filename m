Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBrRN-0005zR-9v
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 13:23:10 +0000
Date: Thu, 26 Jun 2008 15:22:57 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: Limit E820 map when a user-defined memory map is
	specified
Message-ID: <20080626132257.GD18444@elte.hu>
References: <1214422756-10923-1-git-send-email-bwalle@suse.de>
	<86802c440806251259o6b1b1038v9f645992415f0372@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86802c440806251259o6b1b1038v9f645992415f0372@mail.gmail.com>
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
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com


* Yinghai Lu <yhlu.kernel@gmail.com> wrote:

> On Wed, Jun 25, 2008 at 12:39 PM, Bernhard Walle <bwalle@suse.de> wrote:
> > This patch brings back limiting of the E820 map when a user-defined
> > E820 map is specified. While the behaviour of i386 (32 bit) was to limit
> > the E820 map (and /proc/iomem), the behaviour of x86-64 (64 bit) was not to
> > limit.
> >
> > That patch limits the E820 map again for both x86 architectures.
> >
> > Code was tested for compilation and booting on a 32 bit and 64 bit system.
> >
> >
> > Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> Acked-by: Yinghai Lu <yhlu.kernel@gmail.com>

applied to tip/x86/unify-setup - thanks.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
