Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDzvY-0003HA-OS
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 16:13:54 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CD6006EB.36EC%kingboard.ma@hp.com>
Date: Fri, 08 Mar 2013 08:13:31 -0800
In-Reply-To: <CD6006EB.36EC%kingboard.ma@hp.com> (Jingbai Ma's message of
 "Fri, 8 Mar 2013 13:31:51 +0000")
Message-ID: <87r4jpoono.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel to
 speedup kernel dump process
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
To: "Ma, Jingbai (Kingboard)" <kingboard.ma@hp.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mitchell,
 Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>, "mingo@redhat.com" <mingo@redhat.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>, "H. Peter Anvin" <hpa@zytor.com>, "yinghai@kernel.org" <yinghai@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

"Ma, Jingbai (Kingboard)" <kingboard.ma@hp.com> writes:

> On 3/8/13 6:33 PM, "H. Peter Anvin" <hpa@zytor.com> wrote:
>
>
>>On 03/08/2013 02:06 AM, Jingbai Ma wrote:
>>> 
>>> Kernel do have some abilities that user space haven't. It's possible to
>>> map whole memory space of the first kernel into user space on the second
>>> kernel. But the user space code has to re-implement some parts of the
>>> kernel memory management system again. And worse, it's architecture
>>> dependent, more architectures supported, more codes have to be
>>> implemented. All implementation in user space must be sync to kernel
>>> implementation. It's may called "flexibility", but it's painful to
>>> maintain the codes.
>>> 
>>
>>What?  You are basically talking about /dev/mem... there is nothing
>>particularly magic about it at all.
>
> What we are talking about is filtering memory pages (AKA memory pages
> classification)
> The makedumpfile (or any other dumper in user space) has to know the
> exactly
> memory layout of the memory management data structures, it not only
> architecture dependent, but also may varies in different kernel release.
> At this point, /dev/mem doesn't give any help.
> So IMHO, I would like to do it in kernel, rather than So keep tracking
> changes in user space code.

But the fact is there is no requirment that the crash dump capture
kernel is the same version as the kernel that crashed.  In fact it has
been common at some points in time to use slightly different build
options, or slightly different kernels.  Say a 32bit PAE kernel to
capture a 64bit x86_64 kernel.

So in fact performing this work in the kernel and is actively harmful to
reliability and maintenance because it adds an incorrect assumption.

If you do want the benefit of shared maintenance with the kernel one
solution that has been suggested several times is to put code into
tools/makedumpfile (probably a library) that encapsulates the kernel
specific knowledge that can be loaded into the ramdisk when the
crahsdump kernel is being loaded.

That would allow shared maintenance along without breaking the
possibility of supporting kernel versions.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
