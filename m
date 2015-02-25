Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YQTnX-000137-TM
 for kexec@lists.infradead.org; Wed, 25 Feb 2015 04:42:12 +0000
Date: Wed, 25 Feb 2015 13:41:49 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/1] kexec: iomem: fix callbacks params for sh and x86
 archs
Message-ID: <20150225044149.GC23320@verge.net.au>
References: <1424780328-31722-1-git-send-email-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1424780328-31722-1-git-send-email-r.peniaev@gmail.com>
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
To: Roman Pen <r.peniaev@gmail.com>
Cc: kexec@lists.infradead.org

On Tue, Feb 24, 2015 at 09:18:47PM +0900, Roman Pen wrote:
> Commit 4362bfac changes params for kexec_iomem_for_each_line from
> 'unsigned long' to 'unsigned long long'.
> 
> This patch fixes forgotten changes for sh and x86 archs.
> Bug causes incorrect parsing of memory ranges.
> 
> Signed-off-by: Roman Pen <r.peniaev@gmail.com>
> Cc: kexec@lists.infradead.org

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
