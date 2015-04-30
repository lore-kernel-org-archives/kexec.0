Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YngGj-00073Q-JB
 for kexec@lists.infradead.org; Thu, 30 Apr 2015 04:40:14 +0000
Date: Thu, 30 Apr 2015 13:39:51 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] purgatory: Disabling GCC's stack protection
Message-ID: <20150430043950.GD15511@verge.net.au>
References: <1430225419-23969-1-git-send-email-kexin.hao@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1430225419-23969-1-git-send-email-kexin.hao@windriver.com>
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
To: Kevin Hao <kexin.hao@windriver.com>
Cc: kexec@lists.infradead.org

Hi Kevin,

On Tue, Apr 28, 2015 at 08:50:19PM +0800, Kevin Hao wrote:
> If the GCC's stack protection is enabled by default, the purgatory will
> also be built with this option. But it makes no sense to enable this
> for the purgatory code, and would cause error when we are trying to
> relocate the purgatory codes because symbol like __stack_chk_fail is
> unresolved. Instead of disabling this for some archs specifically,
> disable it for all the archs.
> 
> Signed-off-by: Kevin Hao <kexin.hao@windriver.com>

This seems like a reasonable change to me, however, it does
not apply cleanly to the kexec tree on kernel.org which I maintain.

https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Could you rebase and repost?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
