Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDVby-0006SQ-Fr
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 16:27:51 +0000
Date: Wed, 2 Sep 2020 18:27:43 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Fix resource leaks in kexec.c
Message-ID: <20200902162742.GE21427@vergenet.net>
References: <1598345003-1634-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1598345003-1634-1-git-send-email-tangyouling@loongson.cn>
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: kexec@lists.infradead.org

On Tue, Aug 25, 2020 at 04:43:23PM +0800, Youling Tang wrote:
> Add free() call when handling some error returns.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Is there a value in cleaning up like this immediately before exiting?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
