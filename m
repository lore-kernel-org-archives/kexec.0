Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJcWI-0005M0-2V
 for kexec@lists.infradead.org; Wed, 01 Apr 2020 12:30:59 +0000
Date: Wed, 1 Apr 2020 14:30:47 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] crashdump-ppc64: crashkernel-base and crashkernel-size
 are big-endian
Message-ID: <20200401123047.GA29376@vergenet.net>
References: <20200304232711.30464-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200304232711.30464-1-cascardo@canonical.com>
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
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: kexec@lists.infradead.org, hbathini@linux.ibm.com

On Wed, Mar 04, 2020 at 08:27:11PM -0300, Thadeu Lima de Souza Cascardo wrote:
> When reading the device-tree exported crashkernel-base and
> crashkernel-size, their values should be converted from big-endian to the
> CPU byte order.
> 
> These is the output of running kexec --print-ckr-size on a little-endian
> ppc64 box.
> 
> $ kexec --print-ckr-size
> 137438953472
> $ kexec --print-ckr-size
> 536870912
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
