Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XLxzH-0002EB-JE
 for kexec@lists.infradead.org; Mon, 25 Aug 2014 17:23:23 +0000
Date: Mon, 25 Aug 2014 13:22:34 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/5] kexec: Fix make headers_check
Message-ID: <20140825172234.GD14379@redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <115373b6ac68ee7a305975896e1c4971e8e51d4c.1408731991.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <115373b6ac68ee7a305975896e1c4971e8e51d4c.1408731991.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Paul Bolle <pebolle@tiscali.nl>, maximilian attems <max@stro.at>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Fri, Aug 22, 2014 at 06:39:47PM +0000, Geoff Levand wrote:
> Remove the unneded declaration for a kexec_load() routine.
> 
> Fixes errors like these when running 'make headers_check':
> 
> include/uapi/linux/kexec.h: userspace cannot reference function or variable defined in the kernel
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

I think Paul Bolle tried to remove this in the past and maximilian
had objections.

http://lists.infradead.org/pipermail/kexec/2014-January/010902.html

I can't see that how exporting kernel prototype helps here. kexec-tools
seems to be using syscall(__NR_kexec_load) directly for non-xen case. So
I would be fine with removing this definition. Just trying to make sure
that it does not break any other library or users of this declaration.

Thanks
Vivek


> ---
>  include/uapi/linux/kexec.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 6925f5b..99048e5 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -55,12 +55,6 @@ struct kexec_segment {
>  	size_t memsz;
>  };
>  
> -/* Load a new kernel image as described by the kexec_segment array
> - * consisting of passed number of segments at the entry-point address.
> - * The flags allow different useage types.
> - */
> -extern int kexec_load(void *, size_t, struct kexec_segment *,
> -		unsigned long int);
>  #endif /* __KERNEL__ */
>  
>  #endif /* _UAPILINUX_KEXEC_H */
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
