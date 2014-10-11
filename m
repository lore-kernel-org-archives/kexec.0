Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xcu0y-0004TQ-PJ
 for kexec@lists.infradead.org; Sat, 11 Oct 2014 10:35:09 +0000
Message-ID: <543907B5.7060001@zytor.com>
Date: Sat, 11 Oct 2014 03:34:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [resend Patch v3 1/2] kaslr: check if kernel location is changed
References: <1412060896-1902-1-git-send-email-bhe@redhat.com>
 <542B1EC1.8090502@zytor.com> <20141001135237.GA13689@redhat.com>
 <543553C7.9010906@zytor.com> <20141008192728.GA26517@redhat.com>
 <20141011031452.GB11560@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20141011031452.GB11560@dhcp-16-116.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>
Cc: whissi@whissi.de, ak@linux.intel.com, keescook@chromium.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, tglx@linutronix.de

On 10/10/2014 08:14 PM, Baoquan He wrote:
> On 10/08/14 at 03:27pm, Vivek Goyal wrote:
>> On Wed, Oct 08, 2014 at 08:09:59AM -0700, H. Peter Anvin wrote:
>
>>> Sorry... this makes no sense.
>>>
>>> For x86-64, there is no direct connection between the physical and
>>> virtual address spaces that the kernel runs in...
>>
>> I am sorry I did not understand this one. I thought that initial
>> relocatable kernel implementaion did not have any direct connection
>> between virtual and physical address. One could load kernel anywhere
>> and kernel virtual address will not change and we will just adjust
>> page tables to map virtual address to right physical address.
>>
>> Now handle_relocation() stuff seems to introduce a close coupling
>> between physical and virtual address. So if kernel shifts by 16MB
>> in physical address space, then it will shift by equal amount
>> in virtual address space. So there seems to be a direct connection
>> between virtual and physical address space in this case.
>
> Yeah, it's exactly as Vivek said.
>
> Before kaslr was introduced, x86_64 kernel can be put anywhere, and
> always _text is 0xffffffff81000000. Meanwhile phys_base contains the
> offset between the compiled addr (namely 0x1000000) and kernel loaded
> addr. After kaslr implementation was added, as long as kernel loaded
> addr is different 0x1000000, it will call handle_relocations(). The
> offset now is added onto each symbols including _text and phys_base
> becomes 0.
>
> It's clearly showing that by checking /proc/kallsyms and value of
> phys_base.
>

This really shouldn't have happened this way on x86-64.  It has to 
happen this way on i386, but I worry that this may be a serious 
misdesign in kaslr on x86-64.  I'm also wondering if there is any other 
fallout of this?

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
