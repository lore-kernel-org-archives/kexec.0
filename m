Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jahZn-0001qH-4V
 for kexec@lists.infradead.org; Mon, 18 May 2020 15:21:12 +0000
Received: by mail-pf1-x443.google.com with SMTP id v63so5099919pfb.10
 for <kexec@lists.infradead.org>; Mon, 18 May 2020 08:21:11 -0700 (PDT)
Date: Mon, 18 May 2020 08:21:08 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <202005180820.46CEF3C2@keescook>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1589805462.5111.107.camel@linux.ibm.com>
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: rafael@kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, geert@linux-m68k.org, dan.carpenter@oracle.com, scott.branden@broadcom.com, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, gregkh@linuxfoundation.org, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, ebiederm@xmission.com, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

On Mon, May 18, 2020 at 08:37:42AM -0400, Mimi Zohar wrote:
> Hi Christoph,
> =

> On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
> > On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
> > > On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> > > > Can you also move kernel_read_* out of fs.h?  That header gets pull=
ed
> > > > in just about everywhere and doesn't really need function not relat=
ed
> > > > to the general fs interface.
> > > =

> > > Sure, where should I dump these?
> > =

> > Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
> > of the file comment explaining the point of the interface, which I
> > still don't get :)
> =

> Instead of rolling your own method of having the kernel read a file,
> which requires call specific security hooks, this interface provides a
> single generic set of pre and post security hooks.=A0=A0The
> kernel_read_file_id enumeration permits the security hook to
> differentiate between callers.
> =

> To comply with secure and trusted boot concepts, a file cannot be
> accessible to the caller until after it has been measured and/or the
> integrity (hash/signature) appraised.
> =

> In some cases, the file was previously read twice, first to measure
> and/or appraise the file and then read again into a buffer for
> use.=A0=A0This interface reads the file into a buffer once, calls the
> generic post security hook, before providing the buffer to the caller.
> =A0(Note using firmware pre-allocated memory might be an issue.)
> =

> Partial reading firmware will result in needing to pre-read the entire
> file, most likely on the security pre hook.

Well described! :)

-- =

Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
