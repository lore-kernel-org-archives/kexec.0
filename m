Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cixjH-0002xd-Vh
 for kexec@lists.infradead.org; Wed, 01 Mar 2017 06:27:18 +0000
Received: by mail-pg0-f47.google.com with SMTP id 25so17094984pgy.0
 for <kexec@lists.infradead.org>; Tue, 28 Feb 2017 22:26:53 -0800 (PST)
Subject: Re: [PATCH] ifdown: if socket can not be opened, then no need to
 close it
References: <1488269401-25926-1-git-send-email-piliu@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <af95a3c6-448e-d16c-c5ce-3c232f327b00@redhat.com>
Date: Wed, 1 Mar 2017 11:56:48 +0530
MIME-Version: 1.0
In-Reply-To: <1488269401-25926-1-git-send-email-piliu@redhat.com>
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
To: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>



On Tuesday 28 February 2017 01:40 PM, Pingfan Liu wrote:
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> ---
>  kexec/ifdown.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kexec/ifdown.c b/kexec/ifdown.c
> index 9679ad7..a5067ae 100644
> --- a/kexec/ifdown.c
> +++ b/kexec/ifdown.c
> @@ -34,7 +34,7 @@ int ifdown(void)
>  	if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
>  		fprintf(stderr, "ifdown: ");
>  		perror("socket");
> -		goto error;
> +		goto exit;

may be 'return -1 ' from here itself..

anyway..both are fine.

>  	}
>
>  	if ((ifa = if_nameindex()) == NULL) {
> @@ -74,5 +74,6 @@ int ifdown(void)
>
>  error:
>  	close(fd);
> +exit:
>  	return -1;
>  }
>

Reviewed-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
