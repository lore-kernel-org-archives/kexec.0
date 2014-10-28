Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj8CW-0002WW-Jz
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 14:56:49 +0000
Message-ID: <544FAE98.6080901@akamai.com>
Date: Tue, 28 Oct 2014 10:56:24 -0400
From: Jason Baron <jbaron@akamai.com>
MIME-Version: 1.0
Subject: Re: [PATCH V5] kernel, add panic_on_warn
References: <1414499499-21952-1-git-send-email-prarit@redhat.com>
In-Reply-To: <1414499499-21952-1-git-send-email-prarit@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabian Frederick <fabf@skynet.be>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 10/28/2014 08:31 AM, Prarit Bhargava wrote:
> There have been several times where I have had to rebuild a kernel to
> cause a panic when hitting a WARN() in the code in order to get a crash
> dump from a system.  Sometimes this is easy to do, other times (such as
> in the case of a remote admin) it is not trivial to send new images to the
> user.
> 

....

> diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
> index 9a4f750..c62d421 100644
> --- a/kernel/sysctl_binary.c
> +++ b/kernel/sysctl_binary.c
> @@ -137,6 +137,7 @@ static const struct bin_table bin_kern_table[] = {
>         { CTL_INT,      KERN_COMPAT_LOG,                "compat-log" },
>         { CTL_INT,      KERN_MAX_LOCK_DEPTH,            "max_lock_depth" },
>         { CTL_INT,      KERN_PANIC_ON_NMI,              "panic_on_unrecovered_nmi" },
> +       { CTL_INT,      KERN_BUG_ON_WARN,               "panic_on_warn" },
>         {}
>  };
> 


I think you meant KERN_PANIC_ON_WARN here.

Thanks,

-Jason



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
