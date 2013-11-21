Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjZSk-0003zV-AC
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 18:58:51 +0000
Date: Thu, 21 Nov 2013 10:58:28 -0800
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
Message-ID: <20131121185828.GA17070@kroah.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
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
Cc: mjg59@srcf.ucam.org, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On Wed, Nov 20, 2013 at 12:50:45PM -0500, Vivek Goyal wrote:
> Current proposed secureboot implementation disables kexec/kdump because
> it can allow unsigned kernel to run on a secureboot platform. Intial
> idea was to sign /sbin/kexec binary and let that binary do the kernel
> signature verification. I had posted RFC patches for this apparoach
> here.
> 
> https://lkml.org/lkml/2013/9/10/560
> 
> Later we had discussion at Plumbers and most of the people thought
> that signing and trusting /sbin/kexec is becoming complex. So a 
> better idea might be let kernel do the signature verification of
> new kernel being loaded. This calls for implementing a new system call
> and moving lot of user space code in kernel.
> 
> kexec_load() system call allows loading a kexec/kdump kernel and jump
> to that kernel at right time. Though a lot of processing is done in
> user space which prepares a list of segments/buffers to be loaded and
> kexec_load() works on that list of segments. It does not know what's
> contained in those segments.
> 
> Now a new system call kexec_file_load() is implemented which takes
> kernel fd and initrd fd as parameters. Now kernel should be able
> to verify signature of newly loaded kernel. 
> 
> This is an early RFC patchset. I have not done signature handling
> part yet. This is more of a minimal patch to show how new system
> call and functionality will look like. Right now it can only handle
> bzImage with 64bit entry point on x86_64. No EFI, no x86_32  or any
> other architecture. Rest of the things can be added slowly as need
> arises. In first iteration, I have tried to address most common use case
> for us.

Very good stuff, thanks for working on this.  How have you been testing
this on the userspace side?  Are there patches to kexec, or are you just
using a small test program with the new syscall?

I'll comment on the patches separately.

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
