Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OP3vW-0008M3-VN
	for kexec@lists.infradead.org; Thu, 17 Jun 2010 01:29:55 +0000
Date: Thu, 17 Jun 2010 10:29:47 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: extend for large cpu count and memory
Message-ID: <20100617012947.GK21129@verge.net.au>
References: <E1OOsmn-0001CG-Pk@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1OOsmn-0001CG-Pk@eag09.americas.sgi.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

On Wed, Jun 16, 2010 at 08:36:09AM -0500, Cliff Wickman wrote:
> 
> Simon,
>   per your reply to my first version
>   > Could you provide a diff against the current git tree?
>   done
>   > In particular, I think that the temp_region fiddling has already been done.
>   dropped from this patch
> 
> The MAX_MEMORY_RANGES of 64 is too small for a very large NUMA machine.
> (A 512 processor SGI UV, for example.)
> 
> And fix a temporary workaround (hack) in load_crashdump_segments() that
> assumes that 16k is sufficient for the size of the crashdump elf header.
> This is too small for a machine with a large cpu count. A PT_NOTE is created
> in the elf header for each cpu.
> 
> Diffed against git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git

Thanks Cliff, applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
