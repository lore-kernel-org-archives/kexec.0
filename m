Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjgFZ-00044q-JO
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 02:13:42 +0000
Date: Thu, 21 Nov 2013 21:13:12 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131122021312.GD31921@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131121190350.GC17070@kroah.com>
 <20131122010311.GZ5274@outflux.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131122010311.GZ5274@outflux.net>
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
Cc: mjg59@srcf.ucam.org, Greg KH <greg@kroah.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Thu, Nov 21, 2013 at 05:03:11PM -0800, Kees Cook wrote:
> Hi,
> 
> On Thu, Nov 21, 2013 at 11:03:50AM -0800, Greg KH wrote:
> > On Wed, Nov 20, 2013 at 12:50:49PM -0500, Vivek Goyal wrote:
> > > This patch implements the in kernel kexec functionality. It implements a
> > > new system call kexec_file_load. I think parameter list of this system
> > > call will change as I have not done the kernel image signature handling
> > > yet. I have been told that I might have to pass the detached signature
> > > and size as part of system call.
> > 
> > This could be done as we do with modules, and just tack the signature
> > onto the end of the 'blob' of the image.  That way we could use the same
> > tool to sign the binary as we do for modules, and save the need for
> > extra parameters in the syscall.
> 
> As long as the system call passing in an fd, I'm all good. For those
> of us that run from verified filesystems, we don't need the additional
> signing overhead, but we do need the file descriptor to validate the
> origin of the kernel.

Yep, Greg had mentioned that keep the interface file descriptor based so
that it can work well with LSM hooks and that's why I went with it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
