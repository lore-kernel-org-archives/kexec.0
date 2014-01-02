Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vyp3N-0004Gh-L9
 for kexec@lists.infradead.org; Thu, 02 Jan 2014 20:39:43 +0000
Date: Thu, 2 Jan 2014 15:39:12 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20140102203912.GB22822@redhat.com>
References: <20131121191907.GA26366@srcf.ucam.org>
 <20131122185706.GK4046@redhat.com> <87vbzju6ql.fsf@xmission.com>
 <20131125163920.GC23094@redhat.com> <87fvqj2vxz.fsf@xmission.com>
 <20131126142759.GA5473@redhat.com> <20131219125439.GA6379@lst.de>
 <20131220141917.GB27063@redhat.com> <87a9fvqfs4.fsf@xmission.com>
 <CAGXu5jKJ88J-++nvkPVvghkXbN+_mB=T1siSDF7yoXQ-d-ONxg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGXu5jKJ88J-++nvkPVvghkXbN+_mB=T1siSDF7yoXQ-d-ONxg@mail.gmail.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg KH <greg@kroah.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Peter Jones <pjones@redhat.com>, Torsten Duwe <duwe@lst.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, Dec 20, 2013 at 03:20:16PM -0800, Kees Cook wrote:
> On Fri, Dec 20, 2013 at 3:11 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
> > Vivek Goyal <vgoyal@redhat.com> writes:
> >
> >> On Thu, Dec 19, 2013 at 01:54:39PM +0100, Torsten Duwe wrote:
> >>> On Tue, Nov 26, 2013 at 09:27:59AM -0500, Vivek Goyal wrote:
> >
> >>> IMO it's up to user land to search lists of certificates, and present
> >>> only the final chain of trust to the kernel for checking.
> >>>
> >>> ELF is the preferred format for most sane OSes and firmware, and a detached
> >>> signature would probably be simplest to check. If we have the choice,
> >>> without restrictions from braindead boot loaders, ELF should be first.
> >>> And if the pesigning isn't usable and another sig is needed anyway,
> >>> why not apply that to vmlinux(.gz) ?
> >>
> >> I have yet to look deeper into it that if we can sign elf images and
> >> just use elf loader. And can use space extract the elf image out of
> >> a bzImage and pass it to kernel.
> >>
> >> Even if it is doable, one disadvantage seemed to be that extracted
> >> elf images will have to be written to a file so thta it's file descriptor
> >> can be passed to kernel. And that assumed writable root and we chrome
> >> folks seems to have setups where root is not writable.
> >
> > In that case the chrome folks would simply have to use an ELF format
> > kernel and not a bzImage.
> 
> If we're doing fd origin verification (not signatures), can't we
> continue to use a regular bzImage?

If secureboot is enabled, it enforces module signature verification. I 
think similar will happen for kexec too. How would kernel know that on
a secureboot platform fd original verification will happen and it is
sufficient.

I personally want to support bzImage as well (apart from ELF) because
distributions has been shipping bzImage for a long time and I don't
want to enforce a change there because of secureboot. It is not necessary.
Right now I am thinking more about storing detached bzImage signatures
and passing those signatures to kexec system call.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
