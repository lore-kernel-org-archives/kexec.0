Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SgR4f-0007YP-Qy
 for kexec@lists.infradead.org; Mon, 18 Jun 2012 01:48:14 +0000
Date: Mon, 18 Jun 2012 10:48:09 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Support kernel_noload uImage type
Message-ID: <20120618014809.GI7545@verge.net.au>
References: <1339833135-23978-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1339833135-23978-1-git-send-email-acourbot@nvidia.com>
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
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: kexec@lists.infradead.org

On Sat, Jun 16, 2012 at 04:52:15PM +0900, Alexandre Courbot wrote:
> Do not trigger an error when loading a uImage with the
> IH_TYPE_KERNEL_NOLOAD type. These images do not need to be copied to
> their load address before being executed.
> 
> All archs (excepted PPC) do not use the uImage load and entry point
> parameters, so their current behavior needs not be changed further than
> just accepting the image type.
> 
> Tested and validated on ARM.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
