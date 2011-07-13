Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QgpOJ-0007cK-BA
	for kexec@lists.infradead.org; Wed, 13 Jul 2011 02:41:36 +0000
Date: Wed, 13 Jul 2011 11:41:14 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [v3] kexec-tools: ppc32: Fixup ThreadPointer for
	purgatory code
Message-ID: <20110713024113.GA6598@verge.net.au>
References: <20110712095029.18466.30735.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110712095029.18466.30735.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: "Ryan S. Arnold" <rsa@us.ibm.com>, kexec <kexec@lists.infradead.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Jul 12, 2011 at 03:20:40PM +0530, Suzuki K. Poulose wrote:
> PPC32 ELF ABI expects r2 to be loaded with Thread Pointer, which is 0x7000
> bytes past the end of TCB. Though the purgatory is single threaded, it uses
> TCB scratch space in vsnprintf(). This patch allocates a 1024byte TCB
> and populates the TP with the address accordingly.
> 
> Changes from V2: Avoid address overflow in TP allocation.
> Changes from V1: Fixed the addr calculation for uImage support.
> 
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Cc: Ryan S. Arnold <rsa@us.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
