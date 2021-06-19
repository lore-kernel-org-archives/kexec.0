Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lueKh-00HK4i-Pa
 for kexec@lists.infradead.org; Sat, 19 Jun 2021 17:00:37 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] lockdown,
 selinux: fix wrong subject in some SELinux lockdown checks
In-Reply-To: <20210616085118.1141101-1-omosnace@redhat.com>
References: <20210616085118.1141101-1-omosnace@redhat.com>
Date: Sat, 19 Jun 2021 19:00:30 +0200
Message-ID: <8735tdiyc1.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
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
To: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>

On Wed, Jun 16 2021 at 10:51, Ondrej Mosnacek wrote:
> diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
> index bda73cb7a044..c43a13241ae8 100644
> --- a/arch/x86/mm/testmmiotrace.c
> +++ b/arch/x86/mm/testmmiotrace.c
> @@ -116,7 +116,7 @@ static void do_test_bulk_ioremapping(void)
>  static int __init init(void)
>  {
>  	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
> -	int ret = security_locked_down(LOCKDOWN_MMIOTRACE);
> +	int ret = security_locked_down(current_cred(), LOCKDOWN_MMIOTRACE);

I have no real objection to those patches, but it strikes me odd that
out of the 62 changed places 58 have 'current_cred()' and 4 have NULL as
argument.

I can't see why this would ever end up with anything else than
current_cred() or NULL and NULL being the 'special' case. So why not
having security_locked_down_no_cred() and make current_cred() implicit
for security_locked_down() which avoids most of the churn and just makes
the special cases special. I might be missing something though.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
