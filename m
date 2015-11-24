Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a17Zl-0007C7-G2
 for kexec@lists.infradead.org; Tue, 24 Nov 2015 06:59:42 +0000
Date: Tue, 24 Nov 2015 15:59:18 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexex: arm: create ATAGS_MEM tag from devicetree
 memory node
Message-ID: <20151124065918.GB2632@verge.net.au>
References: <1448012867-10421-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1448012867-10421-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
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
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>, kexec@lists.infradead.org

On Fri, Nov 20, 2015 at 10:47:47AM +0100, Andreas Fenkart wrote:
> booting a non-devicetree kernel from a devicetree kernel failed,
> since the memory layout wasn't passed.
> 
> Signed-off-by: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>
> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
