Return-path: <kexec-bounces@lists.infradead.org>
Received: from smtp.ocgnet.org ([64.20.243.3])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Iku8L-0004QE-Rg
	for kexec@lists.infradead.org; Thu, 25 Oct 2007 05:15:53 +0100
Date: Thu, 25 Oct 2007 13:14:54 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch 2/2] Use BOOTMEM_EXCLUSIVE for kdump
Message-ID: <20071025041454.GB25376@linux-sh.org>
References: <20071024163733.366829630@strauss.suse.de>
	<20071024163734.204144819@strauss.suse.de>
	<20071024210533.b919dba3.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071024210533.b919dba3.akpm@linux-foundation.org>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net

On Wed, Oct 24, 2007 at 09:05:33PM -0700, Andrew Morton wrote:
> On Wed, 24 Oct 2007 18:37:35 +0200 Bernhard Walle <bwalle@suse.de> wrote:
> > This patch uses the BOOTMEM_EXCLUSIVE, introduced in the previous patch,
> > to avoid conflicts while reserving the memory for the kdump carpture kernel
> > (crashkernel=).
> > 
> > Signed-off-by: Bernhard Walle <bwalle@suse.de>
> > 
> > ---
> >  arch/sh/kernel/setup.c     |   29 ++++++++++++++++++-----------
> >  arch/x86/kernel/setup_32.c |   28 ++++++++++++++++++----------
> >  arch/x86/kernel/setup_64.c |   35 +++++++++++++++++++++--------------
> 
> ia64 and powerpc support crash dump too?
> 
Not via a reserved bootmem area at least, which is what these patches
touch.

Acked-by: Paul Mundt <lethal@linux-sh.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
