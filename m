Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kf6MP-0008EB-Df
	for kexec@lists.infradead.org; Mon, 15 Sep 2008 05:10:59 +0000
Date: Mon, 15 Sep 2008 15:10:51 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH]IA64: assign a distinguishable label to uncached memory
	in /proc/iomem
Message-ID: <20080915051049.GA7369@verge.net.au>
References: <48C9A2F8.3060308@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48C9A2F8.3060308@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org, Bernhard Walle <bwalle@suse.de>, Jack Steiner <steiner@sgi.com>, linux-ia64@vger.kernel.org

On Thu, Sep 11, 2008 at 04:00:08PM -0700, Jay Lan wrote:
> Currently a memory segment in memory map with attribute of EFI_MEMORY_UC
> is denoted as "System RAM" in /proc/iomem, while memory of attribute
> (EFI_MEMORY_WB|EFI_MEMORY_UC) is also labeled the same.
> 
> The kexec utility then includes uncached memory as part of vmcore. The
> kdump kernel MCA'ed when it tries to save the vmcore to a disk. A normal
> "cached" access may cause MCAs.
> 
> This patch would label memory with attribute of EFI_MEMORY_UC only as
> "Uncached RAM" so that kexec would know not to include it in the vmcore.
> I will submit a separate kexec-tools patch to the kexec list.
> 
> Signed-off-by: Jay Lan <jlan@sgi.com>

Hi Jay,

I've taken a look on an RX2620, Tiger2 and Tiger4 and none of these
machines have EFI memory regions that are covered by this new check. That
is, any regions with the EFI_MEMORY_UC bit set in the attribute either also
have other attibute bits set, or are of a type not covered by this.

I strongly suspect that this is not a problem, but I wanted to bring it to
your attention anyway. I can provide more detailed EFI information from any
or all of these machines if you need it.

With regards to the kexec-tools portion of this patch, it looks fine to me
and I don't think there will be any problem in merging it if/when the
kernel portion is accepted.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
