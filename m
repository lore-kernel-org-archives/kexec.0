Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a17eY-00015h-Fh
 for kexec@lists.infradead.org; Tue, 24 Nov 2015 07:04:38 +0000
Date: Tue, 24 Nov 2015 16:04:17 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm: use /sys/firmware/fdt in case without --atags and
 --dtb
Message-ID: <20151124070417.GG2632@verge.net.au>
References: <20151123070423.GA3972@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151123070423.GA3972@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Mon, Nov 23, 2015 at 03:04:23PM +0800, Dave Young wrote:
> Latest linux kernel will create /sys/firmware/fdt file. It will be convenient
> to use it in case one does not specify --atags and --dtb options.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
