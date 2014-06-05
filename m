Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsUPc-0004MV-HA
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 09:56:45 +0000
Date: Thu, 5 Jun 2014 17:56:03 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH 06/13] kexec: New syscall kexec_file_load() declaration
Message-ID: <20140605095603.GD3876@dhcp-17-89.nay.redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-7-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401800822-27425-7-git-send-email-vgoyal@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com

On 06/03/14 at 09:06am, Vivek Goyal wrote:
> This is the new syscall kexec_file_load() declaration/interface. I have
> reserved the syscall number only for x86_64 so far. Other architectures
> (including i386) can reserve syscall number when they enable the support
> for this new syscall.

Hi, Vivek

I have a comment below about the kexec_file_load args.

[..]
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index c435c5f..a3044e6 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1098,6 +1098,13 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
>  }
>  #endif
>  
> +SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> +		const char __user *, cmdline_ptr, unsigned long,
> +		cmdline_len, unsigned long, flags)

initrd is optional for system boot.

How about using int *kernel_fd and int *initrd_fd as the argument? Then
if I don't need initrd, in userspace I can do this:

kexec_file_load(&kernel_fd, NULL, ...)

And even you can remove KEXEC_FILE_UNLOAD flag, because you could tell
that one wants to unload if the following is invoked:

kexec_file_load(NULL, NULL, ...)

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
