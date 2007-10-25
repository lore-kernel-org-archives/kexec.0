Return-path: <kexec-bounces@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IktyY-0004Dr-Fh
	for kexec@lists.infradead.org; Thu, 25 Oct 2007 05:05:46 +0100
Date: Wed, 24 Oct 2007 21:05:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/2] Use BOOTMEM_EXCLUSIVE for kdump
Message-Id: <20071024210533.b919dba3.akpm@linux-foundation.org>
In-Reply-To: <20071024163734.204144819@strauss.suse.de>
References: <20071024163733.366829630@strauss.suse.de>
	<20071024163734.204144819@strauss.suse.de>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net

On Wed, 24 Oct 2007 18:37:35 +0200 Bernhard Walle <bwalle@suse.de> wrote:

> This patch uses the BOOTMEM_EXCLUSIVE, introduced in the previous patch,
> to avoid conflicts while reserving the memory for the kdump carpture kernel
> (crashkernel=).
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> ---
>  arch/sh/kernel/setup.c     |   29 ++++++++++++++++++-----------
>  arch/x86/kernel/setup_32.c |   28 ++++++++++++++++++----------
>  arch/x86/kernel/setup_64.c |   35 +++++++++++++++++++++--------------

ia64 and powerpc support crash dump too?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
