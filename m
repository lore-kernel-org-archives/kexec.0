Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PalBp-0000M2-14
	for kexec@lists.infradead.org; Thu, 06 Jan 2011 08:27:21 +0000
Message-ID: <4D257CE5.1030001@redhat.com>
Date: Thu, 06 Jan 2011 16:27:17 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
Subject: Re: [Patch] kexec_load: check CAP_SYS_MODULE
References: <1294302325-22593-1-git-send-email-amwang@redhat.com>
In-Reply-To: <1294302325-22593-1-git-send-email-amwang@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Amerigo Wang <amwang@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>, Eric Biederman <ebiederm@xmission.com>

(Forgot Cc'ing Eric Paris, adding.)

> Eric pointed out that kexec_load() actually allows you to
> run any code you want in ring0, this is more like CAP_SYS_MODULE.
>
> Reported-by: Eric Paris<eparis@redhat.com>
> Signed-off-by: WANG Cong<amwang@redhat.com>
>
> ---
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index b55045b..c30d613 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -945,7 +945,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>   	int result;
>
>   	/* We only trust the superuser with rebooting the system. */
> -	if (!capable(CAP_SYS_BOOT))
> +	if (!capable(CAP_SYS_BOOT) || !capable(CAP_SYS_MODULE))
>   		return -EPERM;
>
>   	/*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
