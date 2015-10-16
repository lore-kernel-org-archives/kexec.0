Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zmu45-0007dY-20
 for kexec@lists.infradead.org; Fri, 16 Oct 2015 01:44:13 +0000
Date: Fri, 16 Oct 2015 10:43:46 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] configure: Set SUBARCH=BE for powerpc
Message-ID: <20151016014346.GD20667@verge.net.au>
References: <1444346477.29301.80.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1444346477.29301.80.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

On Thu, Oct 08, 2015 at 04:21:17PM -0700, Geoff Levand wrote:
> When building a 32 bit version of kexec-tools for powerpc64
> set the default powerpc64 SUBARCH as BE.
> 
> Fixes build errors like these:
> 
>  powerpc-linux-gnu/bin/ld: unrecognised emulation mode: elf64lppc
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Thanks Geoff,

applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
