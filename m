Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jhYxw-0006Fv-Ts
 for kexec@lists.infradead.org; Sat, 06 Jun 2020 13:34:30 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 11061E49C2EAA545ABB5
 for <kexec@lists.infradead.org>; Sat,  6 Jun 2020 21:34:01 +0800 (CST)
Subject: Re: [PATCH v3] arm64: kdump: add another DT property to crash dump
 kernel's dtb
References: <20200521083257.53415-1-chenzhou10@huawei.com>
 <20200606131933.GA24391@vergenet.net>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <d6d2bd25-19f8-7ccf-19e6-e29dd700f64d@huawei.com>
Date: Sat, 6 Jun 2020 21:33:59 +0800
MIME-Version: 1.0
In-Reply-To: <20200606131933.GA24391@vergenet.net>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org



On 2020/6/6 21:19, Simon Horman wrote:
> On Thu, May 21, 2020 at 04:32:57PM +0800, Chen Zhou wrote:
>> Currently, there is only one crash kernel region on arm64, we add
>> another region "crash kernel low" used for crash dump kernel devices.
>>
>> To do this, we add DT property "linux,low-memory-range" to crash
>> dump kernel's dtb to pass the low region.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>> For "support reserving crashkernel above 4G on arm64 kdump", we need
>> to modify the kexec-tools.
>>
>> Changes since [v2]:
>> - Rebase to latest kexec-tools code.
>>
>> Changes since [v1]:
>> - Add another DT property "linux,low-memory-range" to crash dump kernel's
>> dtb to pass the low region instead of reusing "linux,usable-memory-range".
>>
>> [1]: http://lists.infradead.org/pipermail/kexec/2019-April/022792.html
>> [2]: http://lists.infradead.org/pipermail/kexec/2019-August/023569.html
> Thanks.
>
> I think it would be appropriate for me to apply this change to
> kexec-tools once the corresponding changes have been accepted to
> the kernel.
>
> Please repost when that is the case.
ok.

Thanks,
Chen Zhou
>
> .
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
