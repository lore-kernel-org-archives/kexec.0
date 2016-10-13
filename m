Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bubln-0003rU-Pn
 for kexec@lists.infradead.org; Thu, 13 Oct 2016 08:53:45 +0000
Date: Thu, 13 Oct 2016 16:53:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Export memory sections virtual addresses to
 vmcoreinfo
Message-ID: <20161013085314.GF11185@x1>
References: <1475743561-23912-1-git-send-email-bhe@redhat.com>
 <877f9lckbq.fsf@x220.int.ebiederm.org> <20161011074111.GD11185@x1>
 <20161011081921.GA21765@dhcp-128-65.nay.redhat.com>
 <20161012002613.GB21477@x1>
 <256e8ba2-4f92-36cf-ec5c-2502113922c6@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <256e8ba2-4f92-36cf-ec5c-2502113922c6@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: keescook@chromium.org, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, thgarnie@google.com, takahiro.akashi@linaro.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, tonli@redhat.com

Hi Pratyush,

On 10/12/16 at 02:39pm, Pratyush Anand wrote:
> 
> 
> On Wednesday 12 October 2016 05:56 AM, Baoquan He wrote:
> > > PAGE_OFFSET can be get via vaddr - paddr from elf pt_loads so only
> > > > VMALLOC_BASE and VMEMMAP_BASE is necessary..
> > Well, yes, I was wrong. I wrongly thought of kernel text virtual address
> > when I wrote the reply
> 
> So, if you can get PAGE_OFFSET then, probably you do not need to know
> anything else.
> 
> I think, we can simplify makedumpfile code, where we do not need to depend
> on VMALLOC_START or VMEMMAP_START etc.
> 
> "If we know PAGE_OFFSET, we can read from swapper space. If we can read from
> swapper space, then we can know PA of any kernel VA, whether it is VMALLOC,
> or vmemmap or module or kernel text area."

Check makedumpfile code and re-think about this, it's really like you
said, we can convert VA to PA by swapper_pg_dir or init_level4_pgt. But the
reason why we have to involve VMALLOC_START and VMEMMAP_START is that in
x86_64 direct mapping and kernel text mapping are all linear mapping.
Linear mapping can let us do a very efficient translation from VA to
PA. Especially for page filtering, we need get PA of mm related data.
All of them need convert by swapper_pg_dir or init_level4_pgt, that's
inefficient, imagine the current system usually own many Tera bytes of
physical memory.

So here though we can pick up crash memory regions from elf program
header of vmcore and calculate the PAGE_OFFSET, we still need
VMALLOC_START and VMEMMAP_START.

Thanks
Baoquan
> 
> 
> In fact, I have cleanup patches for ARM64 [1], which take above approach and
> get rid of need of VMALLOC_START or VMEMMAP_START etc. I will be sending
> them upstream soon.
> 
> Probably, x86 can take the similar approach.
> 
> ~Pratyush
> 
> [1] https://github.com/pratyushanand/makedumpfile/blob/arm64_devel/arch/arm64.c#L228
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
