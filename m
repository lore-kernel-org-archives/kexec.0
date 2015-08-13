Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZPzLU-0006ge-US
 for kexec@lists.infradead.org; Thu, 13 Aug 2015 20:43:29 +0000
Date: Thu, 13 Aug 2015 13:43:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REPOST PATCH] kexec: Remove the unnecessary conditional
 judgement to simplify the code logic
Message-Id: <20150813134306.70faabec1634fa3cd777a212@linux-foundation.org>
In-Reply-To: <20150813005525.GB7852@verge.net.au>
References: <1438058802-6462-1-git-send-email-mnfhuang@gmail.com>
 <20150813005525.GB7852@verge.net.au>
Mime-Version: 1.0
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
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Minfei Huang <mnfhuang@gmail.com>, vgoyal@redhat.com, ebiederm@xmission.com

On Thu, 13 Aug 2015 09:55:25 +0900 Simon Horman <horms@verge.net.au> wrote:

> On Tue, Jul 28, 2015 at 12:46:42PM +0800, Minfei Huang wrote:
> > Transforming PFN(Page Frame Number) to struct page is never failure, so
> > we can simplify the code logic to do the image->control_page assignment
> > directly in the loop, and remove the unnecessary conditional judgement.
> > 
> > Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> > Acked-by: Dave Young <dyoung@redhat.com>
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> 
> Andrew, could you consider picking this up.
> It seems to have been sufficiently reviewed, acked, etc...

I grabbed this one of July 28. 
http://ozlabs.org/~akpm/mmotm/broken-out/kexec-remove-the-unnecessary-conditional-judgement-to-simplify-the-code-logic.patch

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
