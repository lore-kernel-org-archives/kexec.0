Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Fri, 16 Sep 2011 14:45:56 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ARM: kdump: copy kernel relocation code at the kexec
	prepare stage
Message-ID: <20110916054556.GA10298@verge.net.au>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Lei Wen <leiwen@marvell.com>
Cc: Yu Tang <ytang5@marvell.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Chao Xie <chao.xie@marvell.com>

On Thu, Sep 15, 2011 at 10:32:09PM -0700, Lei Wen wrote:
> This copy really don't need to do at the very second before the kernel
> would crash.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>

This seems reasonable to me.

Acked-by: Simon Horman <horms@verge.net.au>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
