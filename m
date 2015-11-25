Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1dw1-0006lN-Tj
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 17:32:50 +0000
Date: Wed, 25 Nov 2015 12:32:24 -0500
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 1/4] uImage: cleanup some warnings
Message-ID: <20151125173224.GA3581@hawk.localdomain>
References: <1448040714-19841-1-git-send-email-drjones@redhat.com>
 <1448040714-19841-2-git-send-email-drjones@redhat.com>
 <20151124070026.GC2632@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151124070026.GC2632@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On Tue, Nov 24, 2015 at 04:00:26PM +0900, Simon Horman wrote:
> I don't see any value in masking warnings with casts.

I assume you mean that you would prefer to either change the callers' type
or uImage's API in order to avoid the need for casts. Choosing to keep
warnings wouldn't make sense; they add noise making it difficult to spot
warnings that point out real problems, and you can't ever turn on -Werror.

In this case I think casts are the right solution. We shouldn't change the
uImage API, as unsigned char is the type generally used for an arbitrary
data stream. The callers could possibly be changed, but they're also free
to use whatever type they want, signed char may well be what they want.
Indeed, the fact that each caller (architecture) has its own wrapper
around the uImage API calls allows for this very thing. Furthermore, an
explicit cast acknowledges that the two types were both chosen by design.
If this patch is wrong, then the warning has done its job and we need to
change the callers.

Thanks,
drew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
