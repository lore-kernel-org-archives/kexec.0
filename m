Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x229.google.com ([2607:f8b0:400e:c03::229])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b1553-0001ym-4y
 for kexec@lists.infradead.org; Fri, 13 May 2016 04:52:06 +0000
Received: by mail-pa0-x229.google.com with SMTP id r5so37850043pag.1
 for <kexec@lists.infradead.org>; Thu, 12 May 2016 21:51:44 -0700 (PDT)
Date: Fri, 13 May 2016 13:55:15 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v16 00/20] arm64 kexec kernel patches v16
Message-ID: <20160513045501.GC8417@linaro.org>
References: <cover.1460668521.git.geoff@infradead.org>
 <5734CA48.7040706@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5734CA48.7040706@arm.com>
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
To: Julien Grall <julien.grall@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steve Capper <Steve.Capper@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, ard.biesheuvel@linaro.org, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

[+Ard]

Hi Julien,

Thank you for reporting this issue.

On Thu, May 12, 2016 at 07:24:08PM +0100, Julien Grall wrote:
> Hello Geoff,
> 
> On 14/04/16 22:21, Geoff Levand wrote:
> >This series adds the core support for kexec re-boot and kdump on ARM64.  This
> >version of the series combines Takahiro's kdump patches with my kexec patches.
> >Please consider all patches for inclusion.
> >
> >To load a second stage kernel and execute a kexec re-boot or to work with kdump
> >on ARM64 systems a series of patches to kexec-tools [2], which have not yet been
> >merged upstream, are needed.  Please update to the latest if you have been using
> >an older version.
> >
> >To examine vmcore (/proc/vmcore), you should use
> >   - gdb v7.7 or later
> >   - crash v7.1.1 or later
> 
> I have been trying to use crash dump with your branch without much
> success on juno-r2:
> 
> WARNING: could not find MAGIC_START!
> crash: cannot determine base kernel version
> crash: /root/vmlinux and /root/coredump.kernel do not match!
> 
> Looking at the debug log (-p 5), the translation va -> pa computed
> by crash is wrong.
> 
> The physical address expected is 0x80a76b28, but crash return 0x88a76b28.

Yeah, this is due to Ard's KASLR patches (especially, f9040773b7bb: "arm64:
move kernel image to base of vmalloc area").
Now that the kernel image (and so all the kernel symbols) is located
in the vmalloc area, which is below PAGE_OFFSET, we can't use liner mapping
conversion for va -> pa in order to access kernel data in the core image.

I'm sure that the image (/proc/vmcore) is still sane, and we will have
to fix a user-space tool, i.e. crash.
The good news is that I've already confirmed that we could read the core
image successfully by adding a bit nasty hack to the tool.

I'll let you know once a refined patch gets ready.

Thanks for your patience,
-Takahiro AKASHI

> I am using crash built from [1] and the panic has been created using
> /proc/sysrq-trigger.
> 
> Also, crash dump seems to always report that Xen is running even
> when KVM was in used (see logs [2]) below.
> 
> Lastly, crash fails with an error after a couple of minutes (see logs [2]).
>
> How you seen such errors during your testing?
> 
> Regards,
> 
> [1] https://github.com/crash-utility/crash
> [2] http://pastebin.com/wC8w44SN
> 
> -- 
> Julien Grall

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
