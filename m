Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PalVF-00012Z-7W
	for kexec@lists.infradead.org; Thu, 06 Jan 2011 08:47:25 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1294302325-22593-1-git-send-email-amwang@redhat.com>
Date: Thu, 06 Jan 2011 00:47:00 -0800
In-Reply-To: <1294302325-22593-1-git-send-email-amwang@redhat.com> (Amerigo
	Wang's message of "Thu, 6 Jan 2011 16:25:25 +0800")
Message-ID: <m1bp3uifln.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [Patch] kexec_load: check CAP_SYS_MODULE
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Amerigo Wang <amwang@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Amerigo Wang <amwang@redhat.com> writes:

> Eric pointed out that kexec_load() actually allows you to
> run any code you want in ring0, this is more like CAP_SYS_MODULE.

Let me get this straight you want to make the permission checks
less stringent by allowing either CAP_SYS_MODULE or CAP_SYS_BOOT?

CAP_SYS_BOOT is the correct capability.  Sure you can run any
code but only after rebooting.  I don't see how this differs
from any other reboot scenario.

Eric


> Reported-by: Eric Paris <eparis@redhat.com>
> Signed-off-by: WANG Cong <amwang@redhat.com>
>
> ---
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index b55045b..c30d613 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -945,7 +945,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  	int result;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!capable(CAP_SYS_BOOT))
> +	if (!capable(CAP_SYS_BOOT) || !capable(CAP_SYS_MODULE))
>  		return -EPERM;
>  
>  	/*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
