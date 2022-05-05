From: Rob Herring <robh@kernel.org>
Date: Thu, 5 May 2022 15:03:03 -0500
Subject: [PATCH v23 5/6] of: Support more than one crash kernel regions
 for kexec -s
In-Reply-To: <20220505091845.167-6-thunder.leizhen@huawei.com>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
 <20220505091845.167-6-thunder.leizhen@huawei.com>
Message-ID: <YnQtd5+iSXj+R5X/@robh.at.kernel.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, 05 May 2022 17:18:44 +0800, Zhen Lei wrote:
> When "crashkernel=X,high" is used, there may be two crash regions:
> high=crashk_res and low=crashk_low_res. But now the syscall
> kexec_file_load() only add crashk_res into "linux,usable-memory-range",
> this may cause the second kernel to have no available dma memory.
> 
> Fix it like kexec tool do for option -c, add both 'high' and 'low' regions
> into the dtb.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/of/kexec.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

