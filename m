Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGIE0-0004q7-I4
	for kexec@lists.infradead.org; Tue, 08 Jul 2008 18:47:41 +0000
Date: Tue, 8 Jul 2008 20:47:35 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Use progress bar also for bitmap creation
Message-ID: <20080708204735.6ccb32c2@kopernikus.site>
In-Reply-To: <4873B242.1010002@sgi.com>
References: <20080626143721.GA12486@suse.de>
	<4864B595.8040205@mxs.nes.nec.co.jp>
	<48718477.3020406@mxs.nes.nec.co.jp>
	<20080708174354.641d5a1a@halley.suse.de> <4873B242.1010002@sgi.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org

Hi,

* Jay Lan <jlan@sgi.com> [2008-07-08 11:30]:
> 
> By "memory holes", did you mean zero value memory or memory gap
> as you can see from /proc/iomem?  For example,
>   26003000000-26033dfffff : System RAM
>   26033e00000-260f7ffffff : System RAM  <-- big gap b/t this and next
>   26800000000-268f7ffffff : System RAM
> 
> If latter, the gap represents address gap between nodes and are
> non-existent memory.

Right.

> We do not need to spend time on non-existent memory.

See the loop below. The code processes very PFN and checks for it

	3488 static inline int
	3489 is_in_segs(unsigned long long paddr)
	3490 {
	3491         if (paddr_to_offset(paddr))
	3492                 return TRUE;
	3493         else
	3494                 return FALSE;
	3495 }

The whole process takes about 1 minute on a machine with 14 GiB memory.
So it's worth printing a progress bar. (Proabably that code could be optimised,
but that's an additional step.)



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
