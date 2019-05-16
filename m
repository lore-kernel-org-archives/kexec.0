Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 4/4] kdump: update Documentation about crashkernel on arm64
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <20190507035058.63992-5-chenzhou10@huawei.com>
 <de5b827f-5db2-2280-b848-c5c887b9bb58@redhat.com>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <168b5c80-9a8b-ee94-9cfb-56e4955958c1@huawei.com>
Date: Thu, 16 May 2019 11:23:58 +0800
MIME-Version: 1.0
In-Reply-To: <de5b827f-5db2-2280-b848-c5c887b9bb58@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>, catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org, ard.biesheuvel@linaro.org, rppt@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com
Cc: wangkefeng.wang@huawei.com, takahiro.akashi@linaro.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, horms@verge.net.au, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linux-arm-kernel@lists.infradead.org

On 2019/5/15 13:16, Bhupesh Sharma wrote:
> On 05/07/2019 09:20 AM, Chen Zhou wrote:
>> Now we support crashkernel=X,[high,low] on arm64, update the
>> Documentation.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 268b10a..03a08aa 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -705,7 +705,7 @@
>>               memory region [offset, offset + size] for that kernel
>>               image. If '@offset' is omitted, then a suitable offset
>>               is selected automatically.
>> -            [KNL, x86_64] select a region under 4G first, and
>> +            [KNL, x86_64, arm64] select a region under 4G first, and
>>               fall back to reserve region above 4G when '@offset'
>>               hasn't been specified.
>>               See Documentation/kdump/kdump.txt for further details.
>> @@ -718,14 +718,14 @@
>>               Documentation/kdump/kdump.txt for an example.
>>         crashkernel=size[KMG],high
>> -            [KNL, x86_64] range could be above 4G. Allow kernel
>> +            [KNL, x86_64, arm64] range could be above 4G. Allow kernel
>>               to allocate physical memory region from top, so could
>>               be above 4G if system have more than 4G ram installed.
>>               Otherwise memory region will be allocated below 4G, if
>>               available.
>>               It will be ignored if crashkernel=X is specified.
>>       crashkernel=size[KMG],low
>> -            [KNL, x86_64] range under 4G. When crashkernel=X,high
>> +            [KNL, x86_64, arm64] range under 4G. When crashkernel=X,high
>>               is passed, kernel could allocate physical memory region
>>               above 4G, that cause second kernel crash on system
>>               that require some amount of low memory, e.g. swiotlb
>>
> 
> IMO, it is a good time to update 'Documentation/kdump/kdump.txt' with this patchset itself for both x86_64 and arm64, where we still specify only the old format for 'crashkernel' boot-argument:
> 
> Section: Boot into System Kernel
>          =======================
> 
> On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> ...
> 
> We can update this to add the new crashkernel=size[KMG],low or crashkernel=size[KMG],high format as well.
> 
> Thanks,
> Bhupesh
> 
> .

Sure, we can also update here.

Thanks,
Chen Zhou




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
