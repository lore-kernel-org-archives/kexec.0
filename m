Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3D37-0000DF-Uu
 for kexec@lists.infradead.org; Wed, 05 Aug 2020 06:37:19 +0000
Date: Wed, 5 Aug 2020 14:36:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/3] x86/kexec_file: Fix some corners bugs and improve
 the crash_exclude_mem_range()
Message-ID: <20200805063658.GA22086@dhcp-128-65.nay.redhat.com>
References: <20200804044933.1973-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200804044933.1973-1-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: k-hagio@ab.jp.nec.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>

Hi Lianbo,

Added Andrew in cc.
On 08/04/20 at 12:49pm, Lianbo Jiang wrote:
> This series includes the following patches, it fixes some corners bugs
> and improves the crash_exclude_mem_range().
> 
> [1] [PATCH 1/3] x86/crash: Correct the address boundary of function
>     parameters
> [2] [PATCH 2/3] kexec: Improve the crash_exclude_mem_range() to handle
>     the overlapping ranges
> [3] [PATCH 3/3] kexec_file: correctly output debugging information for
>     the PT_LOAD elf header
> 
> Lianbo Jiang (3):
>   x86/crash: Correct the address boundary of function parameters
>   kexec: Improve the crash_exclude_mem_range() to handle the overlapping
>     ranges
>   kexec_file: correctly output debugging information for the PT_LOAD elf
>     header
> 
>  arch/x86/kernel/crash.c |  2 +-
>  kernel/kexec_file.c     | 33 ++++++++++++++++++++++-----------
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> -- 
> 2.17.1

Looks good, thanks for the patches

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
