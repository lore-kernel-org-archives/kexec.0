Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqyYh-0001sb-Mq
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 05:11:41 +0000
Date: Thu, 12 Dec 2013 14:11:02 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4] Minor fixes and improvements for kexec
Message-ID: <20131212051102.GC497@verge.net.au>
References: <cover.1386807069.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1386807069.git.geoff@infradead.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, linuxppc-dev@lists.ozlabs.org

On Thu, Dec 12, 2013 at 12:18:56AM +0000, Geoff Levand wrote:
> Hi Eric,
> 
> Here are a few minor fixes and improvements for kexec.  Please consider.

FWIW,

Reviewed-by: Simon Horman <horms@verge.net.au>

> 
> -Geoff
> 
> The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:
> 
>   Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/geoff.levand/linux-kexec.git for-kexec
> 
> for you to fetch changes up to 594a3d26aac66e9668edc81d7bfb4e801575514f:
> 
>   sh/kexec: Fix kexec build warning (2013-12-11 16:03:27 -0800)
> 
> ----------------------------------------------------------------
> Geoff Levand (4):
>       kexec: Simplify conditional
>       kexec: Add IND_FLAGS macro
>       powerpc/kexec: Use global IND_FLAGS macro
>       sh/kexec: Fix kexec build warning
> 
>  arch/powerpc/kernel/machine_kexec_64.c |  2 --
>  arch/sh/kernel/machine_kexec.c         |  2 +-
>  include/linux/kexec.h                  |  1 +
>  kernel/kexec.c                         | 17 ++++++++++-------
>  4 files changed, 12 insertions(+), 10 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
