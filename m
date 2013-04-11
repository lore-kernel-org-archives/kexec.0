Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQJ5d-0003iC-P0
 for kexec@lists.infradead.org; Thu, 11 Apr 2013 15:07:06 +0000
Message-ID: <5166D18A.7090800@zytor.com>
Date: Thu, 11 Apr 2013 08:06:50 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
 <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
In-Reply-To: <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Cliff Wickman <cpw@sgi.com>, Vivek Goyal <vgoyal@redhat.com>

On 04/11/2013 07:55 AM, Yinghai Lu wrote:
> On Thu, Apr 11, 2013 at 5:26 AM, Thomas Renninger <trenn@suse.de> wrote:
>> Currently ranges are passed via kernel boot parameters:
>> memmap=exactmap memmap=X#Y memmap=
>>
>> Pass them via e820 table directly instead.
> 
> how to address "saved_max_pfn" referring in kernel?
> 
> kernel need to use saved_max_pfn from old e820 in
> drivers/char/mem.c::read_oldmem()
> 
> mips and powerpc they are passing that from command line "savemaxmem="
> 
> x86 should use that too?
> 

Oh bloody hell, yet another f-ing "max_pfn" variable.

The *only* one that makes any kind of sense is max_low_pfn (marking the
cutoff to highmem)... the pretty much the rest of them are just plain wrong.

And I don't mean "mildly annoying", I mean "catastrophically wrong
semantics".  In this case, it introduces a completely arbitrary
distinction between a nonmemory range below a high water mark and a
nonmemory range above that high water mark.  In fact, from reading the
code it seems pretty clear that the device will blindly assume that
anything below saved_max_pfn is memory and will try to map it
cachable... which will #MC on quite a few machines.

This kind of crap HAS TO STOP.  Memory is discontiguous, deal with it
and deal with it properly.

I also have to admit that I don't see the difference between /dev/mem
and /dev/oldmem, as the former allows access to memory ranges outside
the ones used by the current kernel, which is what the oldmem device
seems to be intended to od.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
