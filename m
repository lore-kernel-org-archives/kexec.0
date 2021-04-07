Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lUDqU-005q6f-Go
 for kexec@lists.infradead.org; Wed, 07 Apr 2021 19:28:19 +0000
Date: Wed, 7 Apr 2021 21:28:07 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] Fix early boot OOM issues for some platforms
Message-ID: <20210407192807.GB30418@vergenet.net>
References: <cover.1617716819.git.hongyxia@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1617716819.git.hongyxia@amazon.com>
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
To: Hongyan Xia <hx242@xen.org>
Cc: kexec@lists.infradead.org, raphning@amazon.com, jgrall@amazon.com

On Tue, Apr 06, 2021 at 03:11:51PM +0100, Hongyan Xia wrote:
> From: Hongyan Xia <hongyxia@amazon.com>
> 
> We have observed a couple of cases where after a successful kexec, the
> crash kernel loaded in the 2nd kernel will run out of memory and
> crash. We narrowed down to two issues:
> 
> 1. when preparing the memory map, kexec excludes the Interrupt Vector
>    Table. However, the end address of IVT is incorrect.
> 2. The wrong end address of IVT is not 1KiB aligned. When preparing the
>    crashkernel, the memory map will reject unaligned memory chunks. On
>    many x86 platforms this means the entire bottom 1MiB range is
>    excluded from the crashkernel memory map, resulting in OOM when the
>    crashkernel boots.
> 
> Patch 1 fixes 1 which is actually enough to eliminate the issue but we
> feel that such issue may happen again (e.g., with a weird BIOS that has
> unaligned e820 map), so we also have patch 2 to improve the handling of
> unaligned memory.
> 
> Hongyan Xia (2):
>   Fix where the real mode interrupt vector ends
>   Shrink segments to fit alignment instead of throwing them away

Thanks, series applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
