Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1buFYF-0002mv-Pl
 for kexec@lists.infradead.org; Wed, 12 Oct 2016 09:10:16 +0000
Received: by mail-qt0-f176.google.com with SMTP id m5so10658799qtb.3
 for <kexec@lists.infradead.org>; Wed, 12 Oct 2016 02:09:55 -0700 (PDT)
Subject: Re: [PATCH] kexec: Export memory sections virtual addresses to
 vmcoreinfo
References: <1475743561-23912-1-git-send-email-bhe@redhat.com>
 <877f9lckbq.fsf@x220.int.ebiederm.org> <20161011074111.GD11185@x1>
 <20161011081921.GA21765@dhcp-128-65.nay.redhat.com>
 <20161012002613.GB21477@x1>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <256e8ba2-4f92-36cf-ec5c-2502113922c6@redhat.com>
Date: Wed, 12 Oct 2016 14:39:45 +0530
MIME-Version: 1.0
In-Reply-To: <20161012002613.GB21477@x1>
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
To: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, ats-kumagai@wm.jp.nec.com
Cc: keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, thgarnie@google.com, takahiro.akashi@linaro.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, tonli@redhat.com



On Wednesday 12 October 2016 05:56 AM, Baoquan He wrote:
>> PAGE_OFFSET can be get via vaddr - paddr from elf pt_loads so only
>> > VMALLOC_BASE and VMEMMAP_BASE is necessary..
> Well, yes, I was wrong. I wrongly thought of kernel text virtual address
> when I wrote the reply

So, if you can get PAGE_OFFSET then, probably you do not need to know 
anything else.

I think, we can simplify makedumpfile code, where we do not need to 
depend on VMALLOC_START or VMEMMAP_START etc.

"If we know PAGE_OFFSET, we can read from swapper space. If we can read 
from swapper space, then we can know PA of any kernel VA, whether it is 
VMALLOC, or vmemmap or module or kernel text area."


In fact, I have cleanup patches for ARM64 [1], which take above approach 
and get rid of need of VMALLOC_START or VMEMMAP_START etc. I will be 
sending them upstream soon.

Probably, x86 can take the similar approach.

~Pratyush

[1] 
https://github.com/pratyushanand/makedumpfile/blob/arm64_devel/arch/arm64.c#L228


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
