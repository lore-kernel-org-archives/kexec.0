Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjqsV-0006Yz-48
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 13:34:36 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <8761rl73s7.fsf@xmission.com> <20131122015518.GA31921@redhat.com>
Date: Fri, 22 Nov 2013 05:34:03 -0800
In-Reply-To: <20131122015518.GA31921@redhat.com> (Vivek Goyal's message of
 "Thu, 21 Nov 2013 20:55:18 -0500")
Message-ID: <87txf4y304.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, greg@kroah.com, hpa@zytor.com

Vivek Goyal <vgoyal@redhat.com> writes:

> On Thu, Nov 21, 2013 at 03:07:04PM -0800, Eric W. Biederman wrote:
>
> [..]
>> 
>> Before you are done we need an ELF loader.  bzImage really is very
>> uninteresting.  To the point I am not at all convinced that an in kernel
>> loader should support it.
>
> Hi Eric,
>
> Why ELF case is so interesting. I have not use kexec to boot ELF
> images in years and have not seen others using it too. In fact bzImage
> seems to be the most common kernel image format for x86, most of the distros
> ship and use.

ELF is interesting because it is the minimal file format that does
everything you need.   So especially for a proof of concept ELF needs to
come first.  There is an extra virtual address field in the ELF segment
header but otherwise ELF does not have any unnecessary fields.

ELF is interesting because it is the native kernel file format on all
architectures linux supports including x86.

ELF is interesting because producing an ELF image in practice requires
a trivial amount of tooling so it is a good general purpose format to
support.

> So first I did the loader for the common use case. There is no reason 
> that one can't write another loader for ELF images. It just bloats
> the code. Hence I thought that other image loaders can follow slowly. I am
> not sure why do you say that bzImage is uninteresting. 

If you boot anything that isn't a linux kernel bzImage on x86 bzImage is
not the solution you are using.  Furthermore because bzImage is a bunch
of hacks thrown together bzImage keeps evolving in weird and strange
ways.  The complexity of supporting bzImage only grows through the
years.

At the end of the day we will probably need to support bzImage in some
form (possibly just going so far as in userspace extracting the embedded
ELF image) as there are support benefits of only having one blob you
sling around.

But let's first start with the sane general case before worring about x86
legacy weirdness.

For a long term stable ABI to support booting things other than the
linux kernel bzImage is not my first choice.

>> There is also a huge missing piece of this in that your purgatory is not
>> checking a hash of the loaded image before jumping too it.  Without that
>> this is a huge regression at least for the kexec on panic case.  We
>> absolutely need to check that the kernel sitting around in memory has
>> not been corrupted before we let it run very far.
>
> Agreed. This should not be hard. It is just a matter of calcualting
> digest of segments. I will store it in kimge and verify digest again
> before passing control to control page. Will fix it in next version.

Nak.  The verification needs to happen in purgatory. 

The verification needs to happen in code whose runtime environment is
does not depend on random parts of the kernel.  Anything else is a
regression in maintainability and reliability.

It is the wrong direction to add any code to what needs to run in the
known broken environment of the kernel when a panic happens.

Which means that you almost certainly need to go to the trouble of
supporting the complexity needed to support purgatory code written in C.

(For those just tuning in purgatory is our term for the code that runs
between the kernels to do those things that can not happen a priori).

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
