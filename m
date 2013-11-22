Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjrab-0007bs-Uy
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 14:20:10 +0000
Date: Fri, 22 Nov 2013 09:19:46 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
Message-ID: <20131122141945.GE4046@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <8761rl73s7.fsf@xmission.com> <20131122015518.GA31921@redhat.com>
 <87txf4y304.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87txf4y304.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, greg@kroah.com, hpa@zytor.com

On Fri, Nov 22, 2013 at 05:34:03AM -0800, Eric W. Biederman wrote:

[..]
> > Why ELF case is so interesting. I have not use kexec to boot ELF
> > images in years and have not seen others using it too. In fact bzImage
> > seems to be the most common kernel image format for x86, most of the distros
> > ship and use.
> 
> ELF is interesting because it is the minimal file format that does
> everything you need.   So especially for a proof of concept ELF needs to
> come first.  There is an extra virtual address field in the ELF segment
> header but otherwise ELF does not have any unnecessary fields.
> 
> ELF is interesting because it is the native kernel file format on all
> architectures linux supports including x86.
> 
> ELF is interesting because producing an ELF image in practice requires
> a trivial amount of tooling so it is a good general purpose format to
> support.

Ok. I will have a look at ELF loader too. I was hoping to keep only one
loader in initial patch. But looks like that's not acceptable.

[..]
> >> There is also a huge missing piece of this in that your purgatory is not
> >> checking a hash of the loaded image before jumping too it.  Without that
> >> this is a huge regression at least for the kexec on panic case.  We
> >> absolutely need to check that the kernel sitting around in memory has
> >> not been corrupted before we let it run very far.
> >
> > Agreed. This should not be hard. It is just a matter of calcualting
> > digest of segments. I will store it in kimge and verify digest again
> > before passing control to control page. Will fix it in next version.
> 
> Nak.  The verification needs to happen in purgatory. 
> 
> The verification needs to happen in code whose runtime environment is
> does not depend on random parts of the kernel.  Anything else is a
> regression in maintainability and reliability.
> 
> It is the wrong direction to add any code to what needs to run in the
> known broken environment of the kernel when a panic happens.
> 
> Which means that you almost certainly need to go to the trouble of
> supporting the complexity needed to support purgatory code written in C.
> 
> (For those just tuning in purgatory is our term for the code that runs
> between the kernels to do those things that can not happen a priori).

In general, I agree with not using kernel parts after crash.

But what protects against that purgatory itself has been scribbled over.
IOW, how different purgatory memory is as compared to kernel memory where
digest routines are stored. They have got equal probably of being scribbled
over and if that's the case one is not better than other?

And if they both got equal probability to getting corrupted, then there does
not seem to be an advantage in moving digest verification inside purgatory.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
