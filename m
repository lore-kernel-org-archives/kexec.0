Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlJcl-0005T2-As
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 14:28:24 +0000
Date: Tue, 26 Nov 2013 09:27:59 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131126142759.GA5473@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131121190350.GC17070@kroah.com>
 <20131121190620.GA25951@srcf.ucam.org>
 <20131121191305.GK16208@redhat.com>
 <20131121191907.GA26366@srcf.ucam.org>
 <20131122185706.GK4046@redhat.com> <87vbzju6ql.fsf@xmission.com>
 <20131125163920.GC23094@redhat.com> <87fvqj2vxz.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87fvqj2vxz.fsf@xmission.com>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>, hpa@zytor.com

On Tue, Nov 26, 2013 at 04:23:36AM -0800, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Fri, Nov 22, 2013 at 07:39:14PM -0800, Eric W. Biederman wrote:
> >
> > [..]
> >> > Hmm..., I am running out of ideas here. This is what I understand.
> >> >
> >> > - If I sign the bzImage (using PKCS1.5 signature), and later it is signed
> >> >   with authenticode format signatures, then PKCS1.5 signatures will not be
> >> >   valid as PE/COFF signing will do some modification to PE/COFF header in
> >> >   bzImage. And another problem is that then I don't have a way to find
> >> >   PKCS1.5 signature.
> >> >
> >> > - If bzImage is first signed with authenticode format signature and then
> >> >   signed using PKCS1.5 signature, then  authenticode format signature
> >> >   will become invalid as it will also hash the data appened at the end
> >> >   of file.
> >> >
> >> > So looks like both signatures can't co-exist on same file. That means
> >> > one signature has to be detached.
> >> >
> >> > I am beginning to think that create a kernel option which allows to choose
> >> > between attached and detached signatures. Extend kexec syscall to allow
> >> > a parameter to pass in detached signatures. If detached signatures are
> >> > not passed, then look for signatures at the end of file. That way, those
> >> > who are signing kernels using platform specific format (authenticode) in 
> >> > this case, they can generate detached signature while others can just
> >> > use attached signatures.
> >> >
> >> > Any thoughts on how this should be handled?
> >> 
> >> Inside of a modern bzImage there is an embedded ELF image.  How about in
> >> userspace we just strip out the embedded ELF image and write that to a
> >> file.  Then we can use the same signature checking scheme as we do for
> >> kernel modules.  And you only have to support one file format.
> >
> > I think there is a problem with that. And that we lose the additional
> > metadata info present in bzImage which is important.
> >
> > For example, knowing how much memory kernel will consume before it
> > sets up its own GDT and page tables (init_size) is very important. That
> > gives image loader lot of flexibility in figuring out where to place rest
> > of the components safely (initrd, GDT, page tables, ELF header segment, 
> > backup region etc).
> 
> The init_size should be reflected in the .bss of the ELF segments.  If
> not it is a bug when generating the kernel ELF headers and should be
> fixed.
> 
> For use by kexec I don't see any issues with just signing the embedded
> ELF image.

Hmm..., I will check this.

I have another concern though. If we extract it and write it to a file,
this assumes that we have a good destination where file can be written.
This atleast does not seem to be useful to chrome OS people where root
is read only and if a kernel is coming from root, then they know it
can be trusted.

Being able to write kernel to a file and then load it feels little odd to
me. Though this should be allowed but this should not be mandatory.

I think if we allow passing detached signature in kexec system call, then
it makes it much more flexible. We should be able to do what you are
suggesting at the same time it will also keep the possibility open for what
chromeOS developers are looking for.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
