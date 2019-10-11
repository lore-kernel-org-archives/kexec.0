Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v6 03/17] arm64: hibernate: check pgd table allocation
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-4-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <b5f965b5-bbd6-9e53-c085-d1a0c0dceca7@arm.com>
Date: Fri, 11 Oct 2019 19:17:55 +0100
MIME-Version: 1.0
In-Reply-To: <20191004185234.31471-4-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 04/10/2019 19:52, Pavel Tatashin wrote:
> There is a bug in create_safe_exec_page(), when page table is allocated
> it is not checked that table is allocated successfully:
> 
> But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).  Check that
> allocation was successful.


> Fixes: 82869ac57b5d ("arm64: kernel: Add support for hibernate/suspend-to-disk")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Nit: Please remove the stray newline so all the tags appear together.


> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index d52f69462c8f..ef46ce66d7e8 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -217,6 +217,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	__flush_icache_range(dst, dst + length);
>  
>  	trans_pgd = allocator(mask);
> +	if (!trans_pgd) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
>  	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
>  	if (pgd_none(READ_ONCE(*pgdp))) {
>  		pudp = allocator(mask);
> 

Thanks for splitting [0] into two ... but this fix depends on the previous patch - which
isn't an issue that anyone can hit, and doesn't match Greg's 'stable-kernel-rules'.

Please separate out this patch - and post it on its own as a stand-alone fix that can be
sent to the stable trees.


Mixing fixes with other patches leads to problems like this. It isn't possible to pick
this fix independently of the cleanup in the previous patch.


Thanks,

James

[0] https://lore.kernel.org/linux-arm-kernel/ddd81093-89fc-5146-0b33-ad3bd9a1c10c@arm.com/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
