From: Simon Horman <horms@verge.net.au>
Date: Fri, 1 Apr 2022 16:00:56 +0200
Subject: [PATCH 0/2] misc improvement of code
In-Reply-To: <20220331055934.13608-1-piliu@redhat.com>
References: <20220331055934.13608-1-piliu@redhat.com>
Message-ID: <YkcFmFXeX9qTBWE9@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Mar 31, 2022 at 01:59:32PM +0800, Pingfan Liu wrote:
> 
> Cc: Simon Horman <horms@verge.net.au>
> To: kexec at lists.infradead.org
> 
> Pingfan Liu (2):
>   arm64/crashdump-arm64: explicit type conversion to suppress compiler
>     warning
>   kexec/elf: assign one to align if sh_addralign equals zero
> 
>  kexec/arch/arm64/crashdump-arm64.c |  2 +-
>  kexec/kexec-elf-rel.c              | 10 +++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)

Thanks, applied.

