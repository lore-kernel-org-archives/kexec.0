Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZURsj-0008HY-Qj
 for kexec@lists.infradead.org; Wed, 26 Aug 2015 04:00:14 +0000
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
 [10.134.21.209])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0467FAC0502
 for <kexec@lists.infradead.org>; Wed, 26 Aug 2015 12:59:47 +0900 (JST)
Message-ID: <55DD39AB.9030505@jp.fujitsu.com>
Date: Wed, 26 Aug 2015 12:59:39 +0900
From: "HATAYAMA, Daisuke" <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: remove the double free of sph
References: <1440559354-8252-1-git-send-email-cfan@redhat.com>
In-Reply-To: <1440559354-8252-1-git-send-email-cfan@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chao Fan <cfan@redhat.com>, kexec@lists.infradead.org



On 2015/08/26 12:22, Chao Fan wrote:
> sph will be freed twice when it meet below conditions:
>
>              sph->signature1 != SADUMP_SIGNATURE1 ||
>              sph->signature2 != SADUMP_SIGNATURE2
>
> Then it will be freed once and goto error: to free again. So remove the
> 1st free.
>
> Signed-off-by: Chao Fan <cfan@redhat.com>
> ---
>   sadump_info.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/sadump_info.c b/sadump_info.c
> index e8154f4..1474fb2 100644
> --- a/sadump_info.c
> +++ b/sadump_info.c
> @@ -695,7 +695,6 @@ read_sadump_header_diskset(int diskid, struct sadump_diskset_info *sdi)
>   	if (sph->signature1 != SADUMP_SIGNATURE1 ||
>   	    sph->signature2 != SADUMP_SIGNATURE2) {
>   		DEBUG_MSG("sadump: does not have partition header\n");
> -		free(sph);
>   		goto error;
>   	}
>
>

Thanks! It looks good to me.

Acked-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
