Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-f194.google.com ([209.85.223.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f5SPc-0000mB-Mx
 for kexec@lists.infradead.org; Mon, 09 Apr 2018 08:44:30 +0000
Received: by mail-io0-f194.google.com with SMTP id e79so8692873ioi.7
 for <kexec@lists.infradead.org>; Mon, 09 Apr 2018 01:44:17 -0700 (PDT)
Subject: Re: [PATCH] Fix a segmentation fault when trying to run "kexec -p"
References: <20180405133926.14cc92ef@ezekiel.suse.cz>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <2f760cac-5005-626b-1f4f-ca9436427940@redhat.com>
Date: Mon, 9 Apr 2018 14:14:09 +0530
MIME-Version: 1.0
In-Reply-To: <20180405133926.14cc92ef@ezekiel.suse.cz>
Content-Language: en-US
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
To: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Michal Suchanek <msuchanek@suse.de>
Cc: horms@verge.net.au, Dave Young <dyoung@redhat.com>

On 04/05/2018 05:09 PM, Petr Tesarik wrote:
> Do not fall through to "--mem-min" when "-p" option is parsed. The
> break statement was apparently removed by mistake...
> 
> Fixes: cb434cbe6f401037e448276bb12056d1fdc3dbfc
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>   kexec/kexec.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 612c1c2..313d9fe 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1349,6 +1349,7 @@ int main(int argc, char *argv[])
>   			do_sync = 0;
>   			kexec_file_flags |= KEXEC_FILE_ON_CRASH;
>   			kexec_flags = KEXEC_ON_CRASH;
> +			break;
>   		case OPT_MEM_MIN:
>   			mem_min = strtoul(optarg, &endptr, 0);
>   			if (*endptr) {
> 

'kexec -p' is currently broken (segfaults) upstream. I tested this fix 
on my arm64 board, so:

Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
