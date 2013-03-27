Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKqwx-0001yH-BL
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 14:03:36 +0000
Date: Wed, 27 Mar 2013 23:03:32 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Revert: "kexec: lengthen the kernel command line image"
Message-ID: <20130327140332.GB4324@verge.net.au>
References: <5152E934.6000602@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5152E934.6000602@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Cliff Wickman <cpw@sgi.com>

On Wed, Mar 27, 2013 at 08:42:28PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> This reverts commit 49320340f705694e387d794f7f19d407ad9baefa. The change
> of COMMAND_LINE_SIZE cannot solve Cliff's problem since the kernel side
> has the restriction, so it is useless. Let's recover the original value
> defined by kernel side.
> 
> Cc: Cliff Wickman <cpw@sgi.com>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
