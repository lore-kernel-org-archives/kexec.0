From: Simon Horman <horms@verge.net.au>
Date: Fri, 1 Apr 2022 16:01:08 +0200
Subject: [PATCH 0/3] arm64: add support for new reloc type in kexec-arm64.c
In-Reply-To: <20220331033807.9802-1-piliu@redhat.com>
References: <20220331033807.9802-1-piliu@redhat.com>
Message-ID: <YkcFpCWxsCVaJATH@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Mar 31, 2022 at 11:38:04AM +0800, Pingfan Liu wrote:
> With GCC 12 or Clang 13, kexec-tools can not load kernel successfully on
> aarch64. This is caused by some unsupported reloc type in
> arm64/kexec-arm64.c.
> 
> This series add support for those reloc type.
> 
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> To: kexec at lists.infradead.org
> 
> Pingfan Liu (3):
>   arm64/kexec-arm64: add support for R_AARCH64_LDST128_ABS_LO12_NC rela
>   arm64/kexec-arm64: use enum to organize the reloc type
>   arm64/kexec-arm64: add support for R_AARCH64_MOVW_UABS_G* rela
> 
>  kexec/arch/arm64/kexec-arm64.c | 104 +++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 37 deletions(-)

Thanks, applied.

