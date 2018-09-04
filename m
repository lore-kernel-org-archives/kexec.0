Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fx6vC-0000uA-HQ
 for kexec@lists.infradead.org; Tue, 04 Sep 2018 08:42:51 +0000
Received: by mail-pf1-x444.google.com with SMTP id d4-v6so1362623pfn.0
 for <kexec@lists.infradead.org>; Tue, 04 Sep 2018 01:42:40 -0700 (PDT)
Date: Tue, 4 Sep 2018 11:42:31 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
Message-ID: <20180904084231.ubyjaqp4xhqcnper@kshutemo-mobl1>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com

On Mon, Sep 03, 2018 at 10:46:33PM -0700, H. Peter Anvin wrote:
> On 09/03/18 22:20, Baoquan He wrote:
> > On 09/03/18 at 09:13pm, H. Peter Anvin wrote:
> >> On 09/03/18 20:44, Baoquan He wrote:
> >>>
> >>> 1) in arch/x86/kernel/relocate_kernel_64.S, we set X86_CR4_LA57 into cr4
> >>> if the 1st kernel is in 5-level mode. Then in
> >>> arch/x86/boot/compressed/head_64.S, paging_prepare() is called to decide
> >>> if 5-level mode will be enabled, and prepare the trampoline. If
> >>> kexec/kdump kernel is expected to be in 4-level, e.g with 'nolv5'
> >>> specified, it still can handle well. But for the old kernel w/o these
> >>>  5-level codes, it will ignore the fact that X86_CR4_LA57 has been set
> >>> in CR4 and proceed anyway, then #GP is triggered. That's why XLF_5LEVEL
> >>> is used to mark. 
> >>>
> >>
> >> That's what I'm saying, don't do that.  Always jump into the second kernel in
> >> 4-level mode, i.e. X86_CR4_LA57 unset.  That's the only sane thing.
> > 
> > Well, this might not be suggested. Kexec has been a formal feature in
> > our distro, our customers usually use it to reboot high end servers
> > because those machines may take one hour to boot up from firmware. And
> > 5-level may be also supported very soon, if people want to do a fast
> > reboot from the current kernel in 5-level, and expect to see it's in
> > 5-level too in the 2nd kernel, this always kexec jumping to the 2nd
> > kernel in 4-level mode might be unaccepted.
> > 
> 
> That makes no sense.  I'm talking about *entering* the kernel; the second
> kernel should switch to 5-level mode as necessary.

Switching between 4- and 5-level paging modes (in either direction)
requires paing disabling. It means the code that does the switching has to
be under 4G otherwise we would lose control.

We handle the switching correctly in kernel decompression code, but not on
kexec caller side.

XLF_5LEVEL indicates that kernel decompression code can deal with
switching between paging modes and it's safe to jump there in 5-level
paging mode.

As an alternative we can change kexec to switch to 4-level paging mode
before starting the new kernel. Not sure how hard it will be.

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
