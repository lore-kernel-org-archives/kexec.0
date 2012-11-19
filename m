Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TaUu5-0002XS-7A
 for kexec@lists.infradead.org; Mon, 19 Nov 2012 17:13:01 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <878v9zp55t.fsf@xmission.com>
 <1353294278-32230-1-git-send-email-yinghai@kernel.org>
 <1353294278-32230-3-git-send-email-yinghai@kernel.org>
Date: Mon, 19 Nov 2012 09:05:05 -0800
In-Reply-To: <1353294278-32230-3-git-send-email-yinghai@kernel.org> (Yinghai
 Lu's message of "Sun, 18 Nov 2012 19:04:34 -0800")
Message-ID: <87fw454j7i.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/6] kexec: don't die during buffer finding
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Yinghai Lu <yinghai@kernel.org> writes:

> could return 0, and let the caller retry with new ranges.

And in 3 lines of code you have broken. all callers of
add_buffer_phys_virt.

If you are going to remove the die here you need to push it into all of
the callers that don't have any other error handling.

Eric

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  kexec/kexec.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 8928be0..0f8aec8 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -366,10 +366,9 @@ unsigned long add_buffer_phys_virt(struct kexec_info *info,
>  	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
>  
>  	base = locate_hole(info, memsz, buf_align, buf_min, buf_max, buf_end);
> -	if (base == ULONG_MAX) {
> -		die("locate_hole failed\n");
> -	}
> -	
> +	if (base == ULONG_MAX)
> +		return 0;
> +
>  	add_segment_phys_virt(info, buf, bufsz, base, memsz, phys);
>  	return base;
>  }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
