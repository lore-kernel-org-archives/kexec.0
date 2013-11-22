Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjwiY-0000if-GE
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 19:48:43 +0000
Date: Fri, 22 Nov 2013 11:48:14 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
Message-ID: <20131122194814.GC25105@kroah.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <8761rl73s7.fsf@xmission.com> <20131122015518.GA31921@redhat.com>
 <87txf4y304.fsf@xmission.com> <20131122141945.GE4046@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131122141945.GE4046@redhat.com>
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
Cc: mjg59@srcf.ucam.org, hpa@zytor.com, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Fri, Nov 22, 2013 at 09:19:46AM -0500, Vivek Goyal wrote:
> On Fri, Nov 22, 2013 at 05:34:03AM -0800, Eric W. Biederman wrote:
> 
> [..]
> > > Why ELF case is so interesting. I have not use kexec to boot ELF
> > > images in years and have not seen others using it too. In fact bzImage
> > > seems to be the most common kernel image format for x86, most of the distros
> > > ship and use.
> > 
> > ELF is interesting because it is the minimal file format that does
> > everything you need.   So especially for a proof of concept ELF needs to
> > come first.  There is an extra virtual address field in the ELF segment
> > header but otherwise ELF does not have any unnecessary fields.
> > 
> > ELF is interesting because it is the native kernel file format on all
> > architectures linux supports including x86.
> > 
> > ELF is interesting because producing an ELF image in practice requires
> > a trivial amount of tooling so it is a good general purpose format to
> > support.
> 
> Ok. I will have a look at ELF loader too. I was hoping to keep only one
> loader in initial patch. But looks like that's not acceptable.

I totally disagree.  I think what you have done now is fine.  If it
works for bzImage, it's a good sense that this is usable as-is.

And, if someone else cares about signed elf images, hey, let them
implement the loader for it :)

Either way, the syscall interface wouldn't change, which is the
important thing to get right, so you should be fine for now.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
