Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LjrNg-00006O-Ba
	for kexec@lists.infradead.org; Wed, 18 Mar 2009 08:44:26 +0000
Date: Wed, 18 Mar 2009 19:44:06 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec jump: use add_segment_phys_virt()
Message-ID: <20090318084404.GE21399@verge.net.au>
References: <20090318060701.664.13386.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090318060701.664.13386.sendpatchset@rx1.opensource.se>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org

On Wed, Mar 18, 2009 at 03:07:01PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Since /proc/iomem contains physical addresses, use
> add_segment_phys_virt(xxx, 0) instead of add_segment()
> in add_backup_segments().
> 
> This fix is needed for kexec jump on SuperH where
> add_segment() only takes virtual addresses.

Thanks, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
