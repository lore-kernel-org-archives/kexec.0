Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z5ZuN-0000p5-0Y
 for kexec@lists.infradead.org; Thu, 18 Jun 2015 13:31:07 +0000
Date: Thu, 18 Jun 2015 09:30:44 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150618133044.GA1040@redhat.com>
References: <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
 <20150615131728.GK15793@thunk.org>
 <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
 <20150615200115.GG5003@thunk.org>
 <87zj3zigug.fsf@x220.int.ebiederm.org>
 <20150616202757.GB14943@redhat.com>
 <87y4jjglvu.fsf@x220.int.ebiederm.org>
 <20150617014737.GB30214@redhat.com>
 <20150618011629.GA8718@dhcp-128-32.nay.redhat.com>
 <20150618020209.GA8390@dhcp-128-32.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150618020209.GA8390@dhcp-128-32.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Theodore Ts'o <tytso@mit.edu>, kexec <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Jun 18, 2015 at 10:02:09AM +0800, Dave Young wrote:

[..]
> > Or simply add a new config option KEXEC_VERIFY_SIG_FORCE, so we can return
> > error in kexec_load and print some error message.
> 
> Just like below, does this work for you, Ted?
> 
> ---
>  arch/x86/Kconfig |    7 +++++++
>  kernel/kexec.c   |    9 ++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> --- linux.orig/arch/x86/Kconfig
> +++ linux/arch/x86/Kconfig
> @@ -1755,6 +1755,13 @@ config KEXEC_VERIFY_SIG
>  	  verification for the corresponding kernel image type being
>  	  loaded in order for this to work.
>  
> +config KEXEC_VERIFY_SIG_FORCE
> +	bool "Enforce kexec signature verifying"
> +	depends on KEXEC_VERIFY_SIG
> +	---help---
> +	  This option disable kexec_load() syscall, only kexec_file_load
> + 	  can be used.
> +


Hi Dave,

I think we might not need a new config option. A new config option makes
it little confusing. KEXEC_VERIFY_SIG already implies KEXEC_VERIFY_SIG_FORCE
(for new syscall). Now extending it to also mean that it should disable old
syscall is confusing.

We already have a sysctl knob to disable kexec kernel loading. But that
knob disables it on both the syscalls.

May be we can just introduce another command line option say
"kexec_verify_sig_force" and this will work across both the syscalls and
will deny loading a unsigned kernel in following two cases.

- Using old syscall
- Using new syscall if kernel was compiled with KEXEC_VERIFY_SIG=n.

This should be simple and get us going in short term.

If we want to disable unsigned kernel loading at compile time, then we
really need to work on decoupling CONFIG_KEXEC and CONFIG_FILE_KEXEC.
Introducing another config option is not the way forward, IMHO.

Thanks
Vivek


>  config KEXEC_BZIMAGE_VERIFY_SIG
>  	bool "Enable bzImage signature verification support"
>  	depends on KEXEC_VERIFY_SIG
> --- linux.orig/kernel/kexec.c
> +++ linux/kernel/kexec.c
> @@ -45,6 +45,12 @@
>  #include <crypto/hash.h>
>  #include <crypto/sha.h>
>  
> +#ifdef CONFIG_KEXEC_VERIFY_SIG_FORCE
> +static bool kexec_verify_sig_force = true;
> +#else
> +static bool kexec_verify_sig_force;
> +#endif
> +
>  /* Per cpu memory for storing cpu states in case of system crash. */
>  note_buf_t __percpu *crash_notes;
>  
> @@ -1243,7 +1249,8 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
>  	int result;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> +	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled
> +	    || kexec_verify_sig_force)
>  		return -EPERM;
>  
>  	/*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
