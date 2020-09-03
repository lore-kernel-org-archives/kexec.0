Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com> <20200902171341.GC16673@gaia>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <84bb1cbb-c19e-9006-07b5-044eac5ecd4f@huawei.com>
Date: Thu, 3 Sep 2020 19:56:09 +0800
MIME-Version: 1.0
In-Reply-To: <20200902171341.GC16673@gaia>
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de



On 2020/9/3 1:13, Catalin Marinas wrote:
> On Sat, Aug 01, 2020 at 09:08:56PM +0800, Chen Zhou wrote:
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 2da65fef2a1c..4b58f97351d5 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -299,7 +299,15 @@ Boot into System Kernel
>>     "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
>>     starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
>>  
>> -   On x86 and x86_64, use "crashkernel=64M@16M".
>> +   On x86 use "crashkernel=64M@16M".
>> +
>> +   On x86_64, use "crashkernel=X" to select a region under 4G first, and
>> +   fall back to reserve region above 4G.
>> +   We can also use "crashkernel=X,high" to select a region above 4G, which
>> +   also tries to allocate at least 256M below 4G automatically and
>> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
>> +   Use "crashkernel=Y@X" if you really have to reserve memory from specified
>> +   start address X.
>>  
>>     On ppc64, use "crashkernel=128M@32M".
>>  
>> @@ -316,8 +324,15 @@ Boot into System Kernel
>>     kernel will automatically locate the crash kernel image within the
>>     first 512MB of RAM if X is not given.
>>  
>> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
>> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
>> +   On arm64, use "crashkernel=X" to try low allocation in ZONE_DMA, and
>> +   fall back to high allocation if it fails. And go for high allocation
>> +   directly if the required size is too large. If crash_base is outside
> I wouldn't mention crash_base in the admin guide. That's an
> implementation detail really and admins are not supposed to read the
> source code to make sense of the documentation. ZONE_DMA is also a
> kernel internal, so you'd need to define what it is for arm64. At least
> the DMA and DMA32 zones are printed during kernel boot.
Ok, i will fix this in next version.
>
>> +   ZONE_DMA, try to allocate at least 256M in ZONE_DMA automatically.
>> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
>> +   For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.
>> +   Use "crashkernel=Y@X" if you really have to reserve memory from
>> +   specified start address X. Note that the start address of the kernel,
>> +   X if explicitly specified, must be aligned to 2MiB (0x200000).



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
