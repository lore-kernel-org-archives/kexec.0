Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1UAGIW-0000CR-5v
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 08:54:04 +0000
Date: Tue, 26 Feb 2013 00:53:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/2] kexec: Use min_t to simplify logic
Message-Id: <20130226005328.e2d31a97.akpm@linux-foundation.org>
In-Reply-To: <512C76FE.4070109@cn.fujitsu.com>
References: <512C44E4.70907@cn.fujitsu.com> <512C4881.90409@cn.fujitsu.com>
 <1361867881.2023.16.camel@joe-AO722>
 <512C76FE.4070109@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Joe Perches <joe@perches.com>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 26 Feb 2013 16:49:02 +0800 Zhang Yanfei <zhangyanfei@cn.fujitsu.com> wrote:

> >> diff --git a/kernel/kexec.c b/kernel/kexec.c
> > []
> >> @@ -822,13 +822,9 @@ static int kimage_load_normal_segment(struct kimage *image,
> > []
> >> +		mchunk = min_t(size_t, mbytes,
> >> +			       (size_t)(PAGE_SIZE - (maddr & ~PAGE_MASK)));
> > 
> > #define min_t(type, x, y) ({			\
> > 	type __min1 = (x);			\
> > 	type __min2 = (y);			\
> > 	__min1 < __min2 ? __min1: __min2; })
> > 
> > 
> > 
> 
> Hmm, from the definition, the cast is redundant.
> 
> Maybe I misunderstood what Andrew meant in the mail related to v2:
> 
> "The types of PAGE_SIZE and PAGE_MASK are vague - iirc they once had
> different types on different architectures, so some form of casting is
> unavoidable here."
> 
> Andrew, could you please explain the casting you meant above?

I mean that a cast (or min_t, which is a cast) will be needed. 
The code you have here casts the same thing two times, which isn't
necessary.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
