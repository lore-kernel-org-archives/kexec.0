Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fSVnb-0006MF-WE
 for kexec@lists.infradead.org; Mon, 11 Jun 2018 23:00:34 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1528738546-3328-1-git-send-email-jmf@amazon.com>
Date: Mon, 11 Jun 2018 17:59:38 -0500
In-Reply-To: <1528738546-3328-1-git-send-email-jmf@amazon.com> (Jarrett
 Farnitano's message of "Mon, 11 Jun 2018 10:35:46 -0700")
Message-ID: <87po0xszdx.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: yield to scheduler when loading kimage segments
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
To: Jarrett Farnitano <jmf@amazon.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Jarrett Farnitano <jmf@amazon.com> writes:

> Without yielding while loading kimage segments, a large initrd
> will block all other work on the CPU performing the load until
> it is completed. For example loading an initrd of 200MB on a
> low power single core system will lock up the system for a few
> seconds.
>
> To increase system responsiveness to other tasks at that time,
> call cond_resched() in both the crash kernel and normal kernel
> segment loading loops.

I remember years ago something like this was proposed and there was a
reason we did not include it.  I don't remember what that reason is
right now.  But I am reluctant to ack this until I remember.

Is there a practical problem with unresponsiveness?  You are talking
an embedded machine and rarely are there people in front of embedded
computers these days.

Eric

> Signed-off-by: Jarrett Farnitano <jmf@amazon.com>
> ---
>  kernel/kexec_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5616755..8ee07d6 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -783,6 +783,8 @@ static int kimage_load_normal_segment(struct kimage *image,
>  		else
>  			buf += mchunk;
>  		mbytes -= mchunk;
> +
> +		cond_resched();
>  	}
>  out:
>  	return result;
> @@ -847,6 +849,8 @@ static int kimage_load_crash_segment(struct kimage *image,
>  		else
>  			buf += mchunk;
>  		mbytes -= mchunk;
> +
> +		cond_resched();
>  	}
>  out:
>  	return result;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
