Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1e4gjU-0007Hy-0n
 for kexec@lists.infradead.org; Wed, 18 Oct 2017 05:17:33 +0000
Date: Wed, 18 Oct 2017 07:16:53 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] kexec-tools: mips: Use proper page_offset for OCTEON
 CPUs.
Message-ID: <20171018051653.anvogntf3ijw7fta@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-4-david.daney@cavium.com>
 <20171016065636.wxm3nrzq7lkn4lw6@verge.net.au>
 <901800ab-a86a-6513-3bdd-2d2567105ac4@caviumnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <901800ab-a86a-6513-3bdd-2d2567105ac4@caviumnetworks.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org, kexec@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>

On Mon, Oct 16, 2017 at 09:05:22AM -0700, David Daney wrote:
> On 10/15/2017 11:56 PM, Simon Horman wrote:
> > On Thu, Oct 12, 2017 at 02:02:27PM -0700, David Daney wrote:
> > > The OCTEON family of MIPS64 CPUs uses a PAGE_OFFSET of
> > > 0x8000000000000000ULL, which is differs from other CPUs.
> > > 
> > > Scan /proc/cpuinfo to see if the current system is "Octeon", if so,
> > > patch the page_offset so that usable kdump core files are produced.
> > > 
> > > Signed-off-by: David Daney <david.daney@cavium.com>
> > 
> > Is it possible to read this offset from the system rather than
> > checking for an Octeon CPU? It seems that such an approach, if possible,
> > would be somewhat more general.
> > 
> 
> Before implementing this scanning of /proc/cpuinfo, I thought long and hard
> about this, and couldn't think of how the PAGE_OFFSET could be derived from
> information available in userspace.
> 
> Ralf (MIPS maintainer) may have an idea, but these address bits don't show
> up in /proc/kallsyms or any other file in /proc or /sys that I am aware of.

Thanks for the explanation. I've applied this patch pending any further
progress in this area.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
