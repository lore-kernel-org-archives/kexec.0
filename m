Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPfpE-00056R-N3
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 21:11:34 +0000
Date: Tue, 9 Apr 2013 23:11:19 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 6/8] xen: kexec crash image when dom0 crashes
Message-ID: <20130409211119.GC31533@debian70-amd64.local.net-space.pl>
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-7-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1365447593-11988-7-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, kexec@lists.infradead.org, Ian Campbell <Ian.Campbell@citrix.com>, xen-devel@lists.xen.org

On Mon, Apr 08, 2013 at 07:59:51PM +0100, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> ---
>  xen/common/shutdown.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/xen/common/shutdown.c b/xen/common/shutdown.c
> index 73a7d7b..b676a03 100644
> --- a/xen/common/shutdown.c
> +++ b/xen/common/shutdown.c
> @@ -47,6 +47,9 @@ void dom0_shutdown(u8 reason)
>      {
>          debugger_trap_immediate();
>          printk("Domain 0 crashed: ");

Maybe printk("Domain 0 crashed...\n") because kexec_crash()
does not print any message and current version looks a bit
strange i.e. it suggest that something should be printed but
something has failed... If yes then messages which could
be printed immediately after "Domain 0 crashed...\n" should
start from "..." e.g. "...rebooting...".

> +#ifdef CONFIG_KEXEC
> +        kexec_crash();
> +#endif
>          maybe_reboot();
>          break; /* not reached */
>      }

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
