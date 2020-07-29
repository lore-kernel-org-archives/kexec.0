Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f68.google.com ([209.85.166.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0alu-0007my-Q1
 for kexec@lists.infradead.org; Wed, 29 Jul 2020 01:20:43 +0000
Received: by mail-io1-f68.google.com with SMTP id l1so22820696ioh.5
 for <kexec@lists.infradead.org>; Tue, 28 Jul 2020 18:20:42 -0700 (PDT)
Date: Wed, 29 Jul 2020 01:20:39 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <20200729012039.GN4332@42.do-not-panic.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
 <202005180820.46CEF3C2@keescook>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202005180820.46CEF3C2@keescook>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kees Cook <keescook@chromium.org>
Cc: rafael@kernel.org, Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, geert@linux-m68k.org, dan.carpenter@oracle.com, scott.branden@broadcom.com, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, gregkh@linuxfoundation.org, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

On Mon, May 18, 2020 at 08:21:08AM -0700, Kees Cook wrote:
> On Mon, May 18, 2020 at 08:37:42AM -0400, Mimi Zohar wrote:
> > Hi Christoph,
> > =

> > On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
> > > On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
> > > > On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> > > > > Can you also move kernel_read_* out of fs.h?  That header gets pu=
lled
> > > > > in just about everywhere and doesn't really need function not rel=
ated
> > > > > to the general fs interface.
> > > > =

> > > > Sure, where should I dump these?
> > > =

> > > Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
> > > of the file comment explaining the point of the interface, which I
> > > still don't get :)
> > =

> > Instead of rolling your own method of having the kernel read a file,
> > which requires call specific security hooks, this interface provides a
> > single generic set of pre and post security hooks.=A0=A0The
> > kernel_read_file_id enumeration permits the security hook to
> > differentiate between callers.
> > =

> > To comply with secure and trusted boot concepts, a file cannot be
> > accessible to the caller until after it has been measured and/or the
> > integrity (hash/signature) appraised.
> > =

> > In some cases, the file was previously read twice, first to measure
> > and/or appraise the file and then read again into a buffer for
> > use.=A0=A0This interface reads the file into a buffer once, calls the
> > generic post security hook, before providing the buffer to the caller.
> > =A0(Note using firmware pre-allocated memory might be an issue.)
> > =

> > Partial reading firmware will result in needing to pre-read the entire
> > file, most likely on the security pre hook.
> =

> Well described! :)

Since you're moving all this stuff, it woudl be good if you can add this
as part of new kdoc as well.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
