Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L5vMT-0005kF-1O
	for kexec@lists.infradead.org; Fri, 28 Nov 2008 04:53:49 +0000
Date: Fri, 28 Nov 2008 13:53:42 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Don't use /sys/firmware/memmap for Xen
Message-ID: <20081128045340.GE23112@verge.net.au>
References: <1227690039-16014-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1227690039-16014-1-git-send-email-bwalle@suse.de>
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

On Wed, Nov 26, 2008 at 10:00:39AM +0100, Bernhard Walle wrote:
> On Xen, we have to use /proc/iomem to retrieve the memory area for the kexec'd
> kernel, not /sys/firmware/memmap. Dom0 kernel gets a E820 map that contains
> only one region:
> 
>     0000000000000000-0000000018e5e000 (System RAM)
> 
> Compared to the /proc/iomem:
> 
>     00000000-0009cbff : System RAM
>     0009cc00-0009ffff : reserved
>     000ce000-000d3fff : reserved
>     000e0000-000fffff : reserved
>     00100000-1fd6ffff : System RAM
>       01000000-04ffffff : Crash kernel
>       1ec00000-1fbfffff : Hypervisor code and data
>         1f0b4680-1f0b4873 : Crash note
>         1f0b4900-1f0b4a93 : Crash note
>         1f0b4b80-1f0b4d13 : Crash note
>         1f0b4e00-1f0b4f93 : Crash note
>     ...
> 
> Without that patch, /proc/vmcore is empty in the kexec'd kernel and I'm unable
> to copy the crashdump.

Thanks Bernhard, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
