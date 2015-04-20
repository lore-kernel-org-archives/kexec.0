Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yk2H5-0002y6-Sw
 for kexec@lists.infradead.org; Mon, 20 Apr 2015 03:21:32 +0000
Date: Mon, 20 Apr 2015 11:21:06 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RFC 3/6] arm64: allocate memory for other segments after
 kernel
Message-ID: <20150420032106.GF15033@dhcp-16-116.nay.redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
 <1d852e11a3f121d5a3cfd86c05102e940e33944c.1429201849.git.panand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d852e11a3f121d5a3cfd86c05102e940e33944c.1429201849.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org

On 04/16/15 at 10:17pm, Pratyush Anand wrote:
> In case of KEXEC_ON_CRASH, load other segments after the addresses where
> kernel segments finish.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  kexec/arch/arm64/crashdump-arm64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
> index 41266f294589..75f4e4d269ca 100644
> --- a/kexec/arch/arm64/crashdump-arm64.c
> +++ b/kexec/arch/arm64/crashdump-arm64.c
> @@ -312,5 +312,6 @@ void set_crash_entry(struct mem_ehdr *ehdr, struct kexec_info *info)
>  off_t locate_dtb_in_crashmem(struct kexec_info *info, off_t dtb_size)
>  {
>  	return locate_hole(info, dtb_size, 128UL * 1024,
> -		crash_reserved_mem.start, crash_reserved_mem.end, 1);
> +		crash_reserved_mem.start + arm64_mem.text_offset +
> +		arm64_mem.image_size, crash_reserved_mem.end, 1);

So you have decided to hard code the sequence of segment. It
seems not good. Why don't do it by calling add_buffer_phys_virt() or
implement a similar function if you don't like add_buffer_phys_virt.

>  }
> -- 
> 2.1.0
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
