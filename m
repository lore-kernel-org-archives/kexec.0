Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fx4D2-0006aG-Na
 for kexec@lists.infradead.org; Tue, 04 Sep 2018 05:49:05 +0000
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
Date: Mon, 3 Sep 2018 22:46:33 -0700
MIME-Version: 1.0
In-Reply-To: <20180904052036.GJ1740@192.168.1.3>
Content-Language: en-US
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
To: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com

On 09/03/18 22:20, Baoquan He wrote:
> On 09/03/18 at 09:13pm, H. Peter Anvin wrote:
>> On 09/03/18 20:44, Baoquan He wrote:
>>>
>>> 1) in arch/x86/kernel/relocate_kernel_64.S, we set X86_CR4_LA57 into cr4
>>> if the 1st kernel is in 5-level mode. Then in
>>> arch/x86/boot/compressed/head_64.S, paging_prepare() is called to decide
>>> if 5-level mode will be enabled, and prepare the trampoline. If
>>> kexec/kdump kernel is expected to be in 4-level, e.g with 'nolv5'
>>> specified, it still can handle well. But for the old kernel w/o these
>>>  5-level codes, it will ignore the fact that X86_CR4_LA57 has been set
>>> in CR4 and proceed anyway, then #GP is triggered. That's why XLF_5LEVEL
>>> is used to mark. 
>>>
>>
>> That's what I'm saying, don't do that.  Always jump into the second kernel in
>> 4-level mode, i.e. X86_CR4_LA57 unset.  That's the only sane thing.
> 
> Well, this might not be suggested. Kexec has been a formal feature in
> our distro, our customers usually use it to reboot high end servers
> because those machines may take one hour to boot up from firmware. And
> 5-level may be also supported very soon, if people want to do a fast
> reboot from the current kernel in 5-level, and expect to see it's in
> 5-level too in the 2nd kernel, this always kexec jumping to the 2nd
> kernel in 4-level mode might be unaccepted.
> 

That makes no sense.  I'm talking about *entering* the kernel; the second
kernel should switch to 5-level mode as necessary.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
