Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VuBRO-0004Ge-FI
 for kexec@lists.infradead.org; Sat, 21 Dec 2013 01:33:19 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20131121190350.GC17070@kroah.com>
 <20131121190620.GA25951@srcf.ucam.org>
 <20131121191305.GK16208@redhat.com>
 <20131121191907.GA26366@srcf.ucam.org>
 <20131122185706.GK4046@redhat.com> <87vbzju6ql.fsf@xmission.com>
 <20131125163920.GC23094@redhat.com> <87fvqj2vxz.fsf@xmission.com>
 <20131126142759.GA5473@redhat.com> <20131219125439.GA6379@lst.de>
 <20131220141917.GB27063@redhat.com> <87a9fvqfs4.fsf@xmission.com>
 <52B4D0C6.2000505@zytor.com>
Date: Fri, 20 Dec 2013 17:32:46 -0800
In-Reply-To: <52B4D0C6.2000505@zytor.com> (H. Peter Anvin's message of "Fri,
 20 Dec 2013 15:20:38 -0800")
Message-ID: <87ioujf0ox.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load,
 for in kernel kexec
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>, Torsten Duwe <duwe@lst.de>, Vivek Goyal <vgoyal@redhat.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 12/20/2013 03:11 PM, Eric W. Biederman wrote:
>> 
>> In that case the chrome folks would simply have to use an ELF format
>> kernel and not a bzImage.
>> 
>
> This is starting to feel like everything is going in the direction of a
> massive feature regression.  bzImage may be weird (it has definitely
> grown organically), but the features that have been added to it have
> generally been for a reason, e.g. kernel relocation and so on.

Stuff and nonsense.  bzImage is just an ugly wrapper around an ELF
image.

I am just arguing that we expose the clean portable underpinnings and
make that work.

It absolutely does not make sense to make a solution that only works for
x86.  ELF is what ever other architecture uses so we absolutely have to
make any feature we build work with ELF.

At a very basic level for this feature ELF is good enough.  bzImage
isn't.

Given that in the worst case distro's will have to package a second
binary of the same kernel in their kernel rpm.  I don't know that there
is any point in supporting anything else except ELF in the kernel.
Given that the package and distribution are going to have to change
anyway to include signing a change in file format hardly seems scary.

But my point above was really that ELF is sufficient for the use case of
doing file based verification base on fd's in addition to the use case
of using detached signatures.  Which is really a long winded way of
saying the argument "But but but my distro only ships a bzImage today"
is a horrible techinical argument.

I am not fundamentally opposed to supporting other file formats but
given that ELF wins on both practical and techincal grounds ELF should
be the primary file format for kexec_file_load.  We can worry about
other file formats once ELF is shown to work.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
