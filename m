Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFwGD-0005gl-W1
 for kexec@lists.infradead.org; Thu, 03 Oct 2019 08:14:55 +0000
Date: Thu, 3 Oct 2019 10:14:51 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH]kexec-tools: Fix possible out-of-bounds access in ifdown
Message-ID: <20191003081450.mfnicityrpfec2tn@verge.net.au>
References: <20191001150605.GA25636@ls3530.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191001150605.GA25636@ls3530.fritz.box>
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
To: Helge Deller <deller@gmx.de>
Cc: Sven Schnelle <svens@stackframe.org>, kexec@lists.infradead.org

On Tue, Oct 01, 2019 at 05:06:05PM +0200, Helge Deller wrote:
> Fix a possible out-of-bounds access in function ifdown():
> 
> ifdown.c: In function 'ifdown':
> ifdown.c:56:4: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
>    56 |    strncpy(ifr.ifr_name, ifp->if_name, IFNAMSIZ);
> 

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
