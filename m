Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UEyd5-0002v0-9n
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 09:02:48 +0000
Message-ID: <513D9DB1.7040100@hp.com>
Date: Mon, 11 Mar 2013 17:02:41 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel
 to speedup kernel dump process
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com> <5139B827.3050500@hp.com>
 <20130309.133118.214580151.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130309.133118.214580151.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, jingbai.ma@hp.com, hpa@zytor.com, yinghai@kernel.org, vgoyal@redhat.com, ebiederm@xmission.com

On 03/09/2013 12:31 PM, HATAYAMA Daisuke wrote:
> From: Jingbai Ma<jingbai.ma@hp.com>
> Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel to speedup kernel dump process
> Date: Fri, 8 Mar 2013 18:06:31 +0800
>
>> On 03/07/2013 11:21 PM, Vivek Goyal wrote:
>>> On Thu, Mar 07, 2013 at 10:58:18PM +0800, Jingbai Ma wrote:
> ...
>>> First of all 64MB per TB should not be a huge deal. And makedumpfile
>>> also has this cyclic mode where you process a map, discard it and then
>>> move on to next section. So memory usage remains constant at the
>>> expense
>>> of processing time.
>>
>> Yes, that's true. But in cyclic mode, makedumpfile will have to
>> write/read bitmap from storage, it will also impact the performance.
>> I have measured the penalty for cyclic mode is about 70%
>> slowdown. Maybe could be faster after mmap implemented.
>
> I guess the slowdown came from the issue that enough VMCOREINFO was
> not provided from the kernel, and unnecessary filtering processing for
> free pages is done multiple times.

Thanks for your comments! It would be very helpful.
I will test it on the machine again.

-- 
Jingbai Ma (jingbai.ma@hp.com)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
