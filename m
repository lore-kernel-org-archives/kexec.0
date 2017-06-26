Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dPQ6r-0008Eu-3N
 for kexec@lists.infradead.org; Mon, 26 Jun 2017 09:15:07 +0000
Date: Mon, 26 Jun 2017 10:14:12 +0100
From: Russell King <rmk@armlinux.org.uk>
Subject: Re: [PATCH] kexec:arm: support zImage with appended device tree
Message-ID: <20170626091412.GE837@flint.armlinux.org.uk>
References: <1498208138-19283-1-git-send-email-hoeun.ryu@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1498208138-19283-1-git-send-email-hoeun.ryu@gmail.com>
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
To: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Matthew Leach <matthew.leach@arm.com>, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Wang Nan <wangnan0@huawei.com>

On Fri, Jun 23, 2017 at 05:55:38PM +0900, Hoeun Ryu wrote:
> Arm linux supports zImage with appended dtb (CONFIG_ARM_APPENDED_DTB) and
> the concatenated image is generated like `cat zImage dtb > zImage_w_dtb`.

We support that only for the purpose of allowing old boot loaders that
are not DT aware to load kernels that require DT.  If it weren't for
that, we wouldn't have it.

I don't see why we should propagate this hack to other systems such as
kexec, especially when they have native DT support.

-- 
Russell King

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
