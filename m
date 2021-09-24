Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTnCt-00EyOy-C5
 for kexec@lists.infradead.org; Fri, 24 Sep 2021 15:33:48 +0000
Date: Fri, 24 Sep 2021 17:33:44 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec:Fix  memory leak problem in zImage_ppc64_load()
Message-ID: <20210924153344.GB25765@vergenet.net>
References: <20210924010804.10406-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210924010804.10406-1-songkai01@inspur.com>
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
To: Kai Song <songkai01@inspur.com>
Cc: kexec@lists.infradead.org

On Fri, Sep 24, 2021 at 09:08:04AM +0800, Kai Song wrote:
> When the function exits abnormally,ph should be freed.
> 
> Signed-off-by: Kai Song <songkai01@inspur.com>
> ---
>  kexec/arch/ppc64/kexec-zImage-ppc64.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
