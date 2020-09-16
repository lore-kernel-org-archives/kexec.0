Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIcPe-0001zE-MD
 for kexec@lists.infradead.org; Wed, 16 Sep 2020 18:44:15 +0000
Received: by mail-ed1-x544.google.com with SMTP id e22so7505123edq.6
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 11:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <1599874721-6903-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1599874721-6903-1-git-send-email-tangyouling@loongson.cn>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Thu, 17 Sep 2020 00:14:02 +0530
Message-ID: <CAFTCetTxiOLF+2p06=KG-eTM4udgvSqa5FWg5Hbm+MDusXYNoA@mail.gmail.com>
Subject: Re: [PATCH] kexec-tools: Fix a prompt message when crashkernel is not
 reserved
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid@gonehiking.org>

Hi Youling,

On Sat, Sep 12, 2020 at 7:10 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Where Y specifies how much memory to reserve for the dump-capture kernel
> and X specifies the beginning of this reserved memory. So Y should be
> placed before X.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  kexec/kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index bb88caa..fd7c8d2 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1530,7 +1530,7 @@ int main(int argc, char *argv[])
>             !is_crashkernel_mem_reserved()) {
>                 die("Memory for crashkernel is not reserved\n"
>                     "Please reserve memory by passing"
> -                   "\"crashkernel=X@Y\" parameter to kernel\n"
> +                   "\"crashkernel=Y@X\" parameter to kernel\n"
>                     "Then try to loading kdump kernel\n");
>         }
>
> --
> 2.1.0

Thanks for the patch. LGTM, so:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

- Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
