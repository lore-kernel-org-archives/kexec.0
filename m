Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LOinr-0007zI-Jq
	for kexec@lists.infradead.org; Mon, 19 Jan 2009 01:19:50 +0000
Date: Mon, 19 Jan 2009 12:17:18 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [PPC64] Fix memory corruption when using
	realloc_memory_ranges()
Message-ID: <20090119011716.GB6249@verge.net.au>
References: <1232129494-20143-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1232129494-20143-1-git-send-email-bwalle@suse.de>
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
Cc: kexec@lists.infradead.org

On Fri, Jan 16, 2009 at 07:11:34PM +0100, Bernhard Walle wrote:
> Because realloc_memory_ranges() makes the old memory invalid, and we return
> a pointer to memory_range in get_memory_ranges(), we need to copy the contents
> in get_memory_ranges().
> 
> Some code that calls realloc_memory_ranges() may be triggered by
> get_base_ranges() which is called after get_memory_ranges().
> 
> Yes, the memory needs to be deleted somewhere, but I don't know currently
> where it's the best, and since it's not in a loop and memory is deleted
> anyway after program termination I don't want to introduce unneccessary
> complexity. The problem is that get_base_ranges() gets called from
> architecture independent code and that allocation is PPC64-specific here.

Thanks, this sounds like a bit of a mess, but I think that your
patch does improve the situation.

Applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
