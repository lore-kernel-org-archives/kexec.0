Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cd8Hy-0007h6-Cm
 for kexec@lists.infradead.org; Mon, 13 Feb 2017 04:31:00 +0000
Received: by mail-qt0-f174.google.com with SMTP id k15so74919358qtg.3
 for <kexec@lists.infradead.org>; Sun, 12 Feb 2017 20:30:37 -0800 (PST)
Subject: Re: [PATCH v3 0/10] kexec: Add option to get crash kernel region size
References: <1486764462-14176-1-git-send-email-eric.devolder@oracle.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <1bae55a4-db8d-cb11-d444-0a05bfb7fa3a@redhat.com>
Date: Mon, 13 Feb 2017 09:53:24 +0530
MIME-Version: 1.0
In-Reply-To: <1486764462-14176-1-git-send-email-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eric DeVolder <eric.devolder@oracle.com>, horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com



On Saturday 11 February 2017 03:37 AM, Eric DeVolder wrote:
> This is the third version of a patch series originally posted by
> Daniel Kiper on December 5.
>
> This version differs from the previous version based on feedback
> received from the mailing list, as such:
> - changes for coding convention and formatting
> - restructured to introduce get_crash_kernel_load_range() for each
>   architecture, and then a single function in kexec/kexec.c to call
>   the per-architecture get_crash_kernel_load_range() and print the
>   result.
>
> Eric
>
>  kexec/arch/arm/crashdump-arm.c     |  5 +++++
>  kexec/arch/arm64/crashdump-arm64.c |  6 ++++++
>  kexec/arch/cris/kexec-cris.c       |  6 ++++++
>  kexec/arch/ia64/crashdump-ia64.c   |  5 +++++
>  kexec/arch/m68k/kexec-m68k.c       |  6 ++++++
>  kexec/arch/mips/crashdump-mips.c   |  4 ++++
>  kexec/arch/ppc/crashdump-powerpc.c | 22 +++++++++++++++++++++-
>  kexec/arch/ppc/kexec-ppc.c         | 27 +++++++++++++++++++++++++++
>  kexec/arch/ppc/kexec-ppc.h         |  1 +
>  kexec/arch/ppc64/crashdump-ppc64.c | 21 +++++++++++++++++++++
>  kexec/arch/ppc64/kexec-ppc64.c     | 27 +++++++++++++++++++++++++++
>  kexec/arch/ppc64/kexec-ppc64.h     |  2 ++
>  kexec/arch/s390/kexec-s390.c       |  5 +++++
>  kexec/arch/sh/crashdump-sh.c       |  5 +++++
>  kexec/kexec.8                      |  3 +++
>  kexec/kexec.c                      | 20 ++++++++++++++++++++
>  kexec/kexec.h                      |  4 +++-
>  17 files changed, 167 insertions(+), 2 deletions(-)
>
> Daniel Kiper (10):
>       crashdump/arm: Add get_crash_kernel_load_range() function
>       crashdump/cris: Add get_crash_kernel_load_range() function
>       crashdump/ia64: Add get_crash_kernel_load_range() function
>       crashdump/m68k: Add get_crash_kernel_load_range() function
>       crashdump/mips: Add get_crash_kernel_load_range() function
>       crashdump/ppc: Add get_crash_kernel_load_range() function
>       crashdump/ppc64: Add get_crash_kernel_load_range() function
>       crashdump/s390: Add get_crash_kernel_load_range() function
>       crashdump/sh: Add get_crash_kernel_load_range() function
>       kexec: Add option to get crash kernel region size
>
> Eric DeVolder (1):
>       crashdump/arm64: Add get_crash_kernel_load_range() function
>

Reviewed-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
