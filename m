Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from perches-mx.perches.com ([206.117.179.246] helo=labridge.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1UAG35-0007Kf-GG
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 08:38:08 +0000
Message-ID: <1361867881.2023.16.camel@joe-AO722>
Subject: Re: [PATCH v3 2/2] kexec: Use min_t to simplify logic
From: Joe Perches <joe@perches.com>
Date: Tue, 26 Feb 2013 00:38:01 -0800
In-Reply-To: <512C4881.90409@cn.fujitsu.com>
References: <512C44E4.70907@cn.fujitsu.com> <512C4881.90409@cn.fujitsu.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2013-02-26 at 13:30 +0800, Zhang Yanfei wrote:
> This is just a tweak: using min_t to simplify logic of variable
> assignments.
> 
> v3:
> - cast type of (PAGE_SIZE - (maddr & ~PAGE_MASK)) into size_t.

Why?  Isn't this just a redundant cast?

> diff --git a/kernel/kexec.c b/kernel/kexec.c
[]
> @@ -822,13 +822,9 @@ static int kimage_load_normal_segment(struct kimage *image,
[]
> +		mchunk = min_t(size_t, mbytes,
> +			       (size_t)(PAGE_SIZE - (maddr & ~PAGE_MASK)));

#define min_t(type, x, y) ({			\
	type __min1 = (x);			\
	type __min2 = (y);			\
	__min1 < __min2 ? __min1: __min2; })



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
