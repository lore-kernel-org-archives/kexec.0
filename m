Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjdLU-0000ta-HQ
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 23:07:37 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
Date: Thu, 21 Nov 2013 15:07:04 -0800
In-Reply-To: <1384969851-7251-1-git-send-email-vgoyal@redhat.com> (Vivek
 Goyal's message of "Wed, 20 Nov 2013 12:50:45 -0500")
Message-ID: <8761rl73s7.fsf@xmission.com>
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
>
> Any feedback is welcome.

Before you are done we need an ELF loader.  bzImage really is very
uninteresting.  To the point I am not at all convinced that an in kernel
loader should support it.

There is also a huge missing piece of this in that your purgatory is not
checking a hash of the loaded image before jumping too it.  Without that
this is a huge regression at least for the kexec on panic case.  We
absolutely need to check that the kernel sitting around in memory has
not been corrupted before we let it run very far.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
