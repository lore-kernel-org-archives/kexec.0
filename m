Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1e9o6q-0002oq-0m
 for kexec@lists.infradead.org; Wed, 01 Nov 2017 08:10:49 +0000
Date: Wed, 1 Nov 2017 09:10:25 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] ARM: cleanup initrd and dtb handing
Message-ID: <20171101081024.4n7ikghrpgrzogmc@verge.net.au>
References: <20171023100547.GA5431@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171023100547.GA5431@n2100.armlinux.org.uk>
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
To: Russell King <rmk@armlinux.org.uk>
Cc: kexec@lists.infradead.org

On Mon, Oct 23, 2017 at 11:05:48AM +0100, Russell King wrote:
> There is no difference in the way the initrd is handled between an
> ATAG-based kernel and a DTB-based kernel.  Therefore, this should be
> handled identically in both cases.
> 
> Rearrange the code to achieve this.
> 
> Signed-off-by: Russell King <rmk@armlinux.org.uk>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
