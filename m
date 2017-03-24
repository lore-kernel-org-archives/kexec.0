Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1crIxi-0007fD-6Q
 for kexec@lists.infradead.org; Fri, 24 Mar 2017 06:44:40 +0000
Date: Fri, 24 Mar 2017 07:44:12 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86: Support large number of memory ranges
Message-ID: <20170324064412.GF1319@verge.net.au>
References: <1490267819-13606-1-git-send-email-xlpang@redhat.com>
 <CS1PR84MB01983072D64758E237736825833F0@CS1PR84MB0198.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CS1PR84MB01983072D64758E237736825833F0@CS1PR84MB0198.NAMPRD84.PROD.OUTLOOK.COM>
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
To: "Ramsay, Frank" <frank.ramsay@hpe.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Dave Young <dyoung@redhat.com>, Xunlei Pang <xlpang@redhat.com>

On Thu, Mar 23, 2017 at 01:27:08PM +0000, Ramsay, Frank wrote:
> ________________________________________
> From: Xunlei Pang <xlpang@redhat.com>
> Sent: Thursday, March 23, 2017 7:16:59 AM
> To: kexec@lists.infradead.org
> Cc: Dave Young; Xunlei Pang; Ramsay, Frank
> Subject: [PATCH] x86: Support large number of memory ranges
> 
> We got a problem on one SGI 64TB machine, the current kexec-tools
> failed to work due to the insufficient ranges(MAX_MEMORY_RANGES)
> allowed which is defined as 1024(less than the ranges on the machine).
> The kcore header is insufficient due to the same reason as well.
> 
> To solve this, this patch simply doubles "MAX_MEMORY_RANGES" and
> "KCORE_ELF_HEADERS_SIZE".
> 
> Cc: Frank Ramsay <frank.ramsay@hpe.com>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> 
> acking I tested this
> Tested-by: Frank Ramsay <frank.ramsay@hpe.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
