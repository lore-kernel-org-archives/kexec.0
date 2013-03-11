Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UEyUW-0001iF-LJ
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 08:53:57 +0000
Message-ID: <513D9B9F.4000204@hp.com>
Date: Mon, 11 Mar 2013 16:53:51 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel
 to speedup kernel dump process
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com> <5139B827.3050500@hp.com>
 <20130308161912.GD8219@redhat.com>
In-Reply-To: <20130308161912.GD8219@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Mitchell,
 Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, hpa@zytor.com, yinghai@kernel.org, Jingbai Ma <jingbai.ma@hp.com>

On 03/09/2013 12:19 AM, Vivek Goyal wrote:
> On Fri, Mar 08, 2013 at 06:06:31PM +0800, Jingbai Ma wrote:
>
> [..]
>>> - First of all it is doing more stuff in first kernel. And that runs
>>>    contrary to kdump design where we want to do stuff in second kernel.
>>>    After a kernel crash, you can't trust running kernel's data structures.
>>>    So to improve reliability just do minial stuff in crashed kernel and
>>>    get out quickly.
>>
>> I agreed with you, the first kernel should do as less as possible.
>> Intuitively, filter memory pages in the first kernel will harm the
>> reliability of kernel dump, but let's think it thoroughly:
>>
>> 1. It only relies on the memory management data structure that
>> makedumpfile also relies on, so no any reliability degradation at
>> this point.
>
> Its not same. If there is something wrong with memory management
> data structures, you can panic() again and self lock yourself and
> never even transition to the second kernel.
>
> With makedumpfile, if something is wrong, either we will save wrong
> bits or get segmentation fault. But one can still try to be careful
> or save whole dump and try to get specific pieces out.
>
> So it it is not apples to apples comparison.
>

Understood, the double panic() does harm the reliabilities. But consider 
the chance to panic in to memory filtering code, it shouldn't increase 
the risks very much.
If the filtering code panicked, I doubt even without it, the second 
kernel could be booted up normally.

> [..]
>>> Looks like now hpa and yinghai have done the work to be able to load
>>> kdump kernel above 4GB. I am assuming this also removes the restriction
>>> that we can only reserve 512MB or 896MB in second kernel. If that's
>>> the case, then I don't see why people can't get away with reserving
>>> 64MB per TB.
>>
>> That's true. With kernel 3.9-rc1 with kexec-tools 2.0.4, capture
>> kernel will have enough memory to run. And makedumpfile could be
>> always run at non-cyclic mode, but we still concern about the kernel
>> dump performance on systems with huge memory (above 4TB).
>
> I would think that lets first try to make mmap() on /proc/vmcore work and
> optimize makefumpfile to make use of it and then see if performance is
> acceptable or not on large machines. And then take it from there.

Sure, you are right, I'm going to test the mmap() solution first, if it 
doesn't meet the performance requirement on large machine, We still need 
a solution here.

Thanks!

>
> Thanks
> Vivek


-- 
Jingbai Ma (jingbai.ma@hp.com)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
