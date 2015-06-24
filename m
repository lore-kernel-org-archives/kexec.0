Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z7bQv-0007QX-Me
 for kexec@lists.infradead.org; Wed, 24 Jun 2015 03:33:06 +0000
Date: Wed, 24 Jun 2015 09:02:41 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] makedumpfile: Support ARM64
Message-ID: <20150624033241.GA22348@localhost.localdomain>
References: <d76572d93d25b0196cb2b32c88fd15dc4eb78682.1431714565.git.panand@redhat.com>
 <CAOZdJXWjZmL_K=FmvBU=U3VSDY9R4AucFU16v8CAgQCEe8HYDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOZdJXWjZmL_K=FmvBU=U3VSDY9R4AucFU16v8CAgQCEe8HYDg@mail.gmail.com>
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
To: Timur Tabi <timur@codeaurora.org>
Cc: virajm@codeaurora.org, ats-kumagai@wm.jp.nec.com, asamson@codeaurora.org, kexec@lists.infradead.org

Hi Timur,

On 23/06/2015:06:19:01 PM, Timur Tabi wrote:
> On Fri, May 15, 2015 at 1:30 PM, Pratyush Anand <panand@redhat.com> wrote:
> > Patch adds support for ARM64 in makedumpfile. It takes care of vmalloc,
> > vmemmap, module and directly map kernel memory region's translation.
> >
> > Currently we only support 2 leverl 64K pages and VA_BITS as 42. Support
> > to find these machine specific parameters dynamically and then to act
> > accordingly can be added latter.
> 
> So ARM64 kernels are typically compiled with 3-level 4KB pages:
> 
> CONFIG_ARM64_4K_PAGES=y
> # CONFIG_ARM64_64K_PAGES is not set
> CONFIG_ARM64_VA_BITS_39=y
> # CONFIG_ARM64_VA_BITS_48 is not set
> CONFIG_ARM64_VA_BITS=39
> 
> Does this mean that your patch won't work on such a kernel?  If so, do

Yes, it will not work with above kernel.

> you have any plans to add support for 4K 3-level pages?

I can try to find out some time in weekend to refactor arm64 code
and then add 3 level, 4K support. May be I will need a Tested-by.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
