Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hDjBJ-0004qK-L3
 for kexec@lists.infradead.org; Tue, 09 Apr 2019 05:20:28 +0000
Received: by mail-pl1-f194.google.com with SMTP id n8so4105363plp.10
 for <kexec@lists.infradead.org>; Mon, 08 Apr 2019 22:20:25 -0700 (PDT)
Subject: Re: [PATCH 0/3] support reserving crashkernel above 4G on arm64 kdump
References: <20190403030546.23718-1-chenzhou10@huawei.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <49012d55-2020-e2ac-1102-59a5f3911a29@redhat.com>
Date: Tue, 9 Apr 2019 13:20:16 +0800
MIME-Version: 1.0
In-Reply-To: <20190403030546.23718-1-chenzhou10@huawei.com>
Content-Language: en-US
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
To: Chen Zhou <chenzhou10@huawei.com>, catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org, rppt@linux.ibm.com, ard.biesheuvel@linaro.org, takahiro.akashi@linaro.org
Cc: linux-mm@kvack.org, wangkefeng.wang@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Chen,

Thanks for the patchset.

Before I review the patches in detail, I have a couple of generic 
queries. Please see them in-line:

On 04/03/2019 11:05 AM, Chen Zhou wrote:
> When crashkernel is reserved above 4G in memory, kernel should reserve
> some amount of low memory for swiotlb and some DMA buffers. So there may
> be two crash kernel regions, one is below 4G, the other is above 4G.
> 
> Crash dump kernel reads more than one crash kernel regions via a dtb
> property under node /chosen,
> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.
> 
> Besides, we need to modify kexec-tools:
>    arm64: support more than one crash kernel regions
> 
> Chen Zhou (3):
>    arm64: kdump: support reserving crashkernel above 4G
>    arm64: kdump: support more than one crash kernel regions
>    kdump: update Documentation about crashkernel on arm64
> 
>   Documentation/admin-guide/kernel-parameters.txt |   4 +-
>   arch/arm64/kernel/setup.c                       |   3 +
>   arch/arm64/mm/init.c                            | 108 ++++++++++++++++++++----
>   include/linux/memblock.h                        |   1 +
>   mm/memblock.c                                   |  40 +++++++++
>   5 files changed, 139 insertions(+), 17 deletions(-)

I am wondering about the use-case for the same. I remember normally 
fedora-based arm64 systems can do well with a maximum crashkernel size 
of <=512MB reserved below the 4G boundary.

So, do you mean that for your use-case (may be a huawei board based 
setup?), you need:

- more than 512MB of crashkernel size, or
- you want to split the crashkernel reservation across the 4GB boundary 
irrespective of the crashkernel size value.

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
