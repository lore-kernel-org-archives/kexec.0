Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.outflux.net ([2001:19d0:2:6:c0de:0:736d:7470])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjf9m-0002di-BY
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 01:03:39 +0000
Date: Thu, 21 Nov 2013 17:03:11 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131122010311.GZ5274@outflux.net>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131121190350.GC17070@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121190350.GC17070@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, Vivek Goyal <vgoyal@redhat.com>

Hi,

On Thu, Nov 21, 2013 at 11:03:50AM -0800, Greg KH wrote:
> On Wed, Nov 20, 2013 at 12:50:49PM -0500, Vivek Goyal wrote:
> > This patch implements the in kernel kexec functionality. It implements a
> > new system call kexec_file_load. I think parameter list of this system
> > call will change as I have not done the kernel image signature handling
> > yet. I have been told that I might have to pass the detached signature
> > and size as part of system call.
> 
> This could be done as we do with modules, and just tack the signature
> onto the end of the 'blob' of the image.  That way we could use the same
> tool to sign the binary as we do for modules, and save the need for
> extra parameters in the syscall.

As long as the system call passing in an fd, I'm all good. For those
of us that run from verified filesystems, we don't need the additional
signing overhead, but we do need the file descriptor to validate the
origin of the kernel.

-Kees

-- 
Kees Cook
Chrome OS Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
