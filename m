Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XLxcm-00087E-0I
 for kexec@lists.infradead.org; Mon, 25 Aug 2014 17:00:08 +0000
Date: Mon, 25 Aug 2014 12:59:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/5] kexec: minor fixups and enhancements
Message-ID: <20140825165916.GC14379@redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1408731991.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Fri, Aug 22, 2014 at 06:39:47PM +0000, Geoff Levand wrote:
> Hi,
> 
> Here are a few minor fixups and enhancements for kexec support. 
> 
> Patch 3 and 4 that add preprocessor macros for the kimage list flags are
> ones that I use in the arm64 kexec support I am working on, so it would
> be nice for those to go in.
> 
> Please consider.

Hi Geoff,

Does arm64 has secureboot? If yes, then it might make sense to
enable the new syscall kexec_file_load() on arm64 instead of trying
to make old syscall work first.

Thanks
Vivek

> 
> -Geoff
>     
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/geoff.levand/linux-kexec.git for-kexec
> 
> for you to fetch changes up to dc3c63e69815e00dce5454bd50e2991e9ea33f64:
> 
>   powerpc/kexec: Use global IND_FLAGS macro (2014-08-22 11:15:18 -0700)
> 
> ----------------------------------------------------------------
> Geoff Levand (5):
>       kexec: Fix make headers_check
>       kexec: Simplify conditional
>       kexec: Add bit definitions for kimage entry flags
>       kexec: Add IND_FLAGS macro
>       powerpc/kexec: Use global IND_FLAGS macro
> 
>  arch/powerpc/kernel/machine_kexec_64.c |  2 --
>  include/linux/kexec.h                  | 20 ++++++++++++++++----
>  include/uapi/linux/kexec.h             |  6 ------
>  kernel/kexec.c                         | 17 ++++++++++-------
>  4 files changed, 26 insertions(+), 19 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
