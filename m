From: Philipp Rudo <prudo@redhat.com>
Date: Thu, 20 Jan 2022 19:09:32 +0100
Subject: [PATCHv4 1/4] arm64: make phys_offset signed
In-Reply-To: <20220118074812.27702-2-piliu@redhat.com>
References: <20220118074812.27702-1-piliu@redhat.com>
 <20220118074812.27702-2-piliu@redhat.com>
Message-ID: <20220120190932.269510dc@rhtmp>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Pingfan,

On Tue, 18 Jan 2022 15:48:09 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> After kernel commit 7bc1a0f9e176 ("arm64: mm: use single quantity to
> represent the PA to VA translation"), phys_offset can be negative if
> running 52-bits kernel on 48-bits hardware.
> 
> So changing phys_offset from unsigned to signed.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Philipp Rudo <prudo@redhat.com>
> To: kexec at lists.infradead.org
> ---
>  kexec/arch/arm64/kexec-arm64.c | 12 ++++++------
>  kexec/arch/arm64/kexec-arm64.h |  2 +-
>  util_lib/elf_info.c            |  2 +-
>  util_lib/include/elf_info.h    |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 

[...]

> diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
> index ed447ac..1844b67 100644
> --- a/kexec/arch/arm64/kexec-arm64.h
> +++ b/kexec/arch/arm64/kexec-arm64.h
> @@ -58,7 +58,7 @@ extern off_t initrd_size;
>   */
>  
>  struct arm64_mem {
> -	uint64_t phys_offset;
> +	long phys_offset;

I think this one should be int64_t as well.

Other than that
Reviewed-by: Philipp Rudo <prudo@redhat.com>

>  	uint64_t text_offset;
>  	uint64_t image_size;
>  	uint64_t vp_offset;


