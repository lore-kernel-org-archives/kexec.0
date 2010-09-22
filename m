Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OyD3b-0004u6-GF
	for kexec@lists.infradead.org; Wed, 22 Sep 2010 00:19:32 +0000
Date: Wed, 22 Sep 2010 09:19:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/arch/ppc/fixup_dtb.c: Calcuate new FDT size
	correctly
Message-ID: <20100922001926.GG3243@verge.net.au>
References: <1285109931-21184-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1285109931-21184-1-git-send-email-msm@freescale.com>
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
To: Matthew McClintock <msm@freescale.com>
Cc: kexec@lists.infradead.org

On Tue, Sep 21, 2010 at 05:58:51PM -0500, Matthew McClintock wrote:
> It was possible to not add enough space when we allocate
> more space for more memory reserve regions, this was because
> we were incorrectly accounting for the size of a reserve
> region. This corrects the assumed size for a resize region
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>


Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
