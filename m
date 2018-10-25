Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFioW-0005bN-CV
 for kexec@lists.infradead.org; Thu, 25 Oct 2018 16:48:54 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Update help text to indicate --mem-usage
 is supported on archs other than x86_64
Date: Thu, 25 Oct 2018 16:46:42 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0355E667@BPXM09GP.gisp.nec.co.jp>
References: <1540448307-15300-1-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1540448307-15300-1-git-send-email-bhsharma@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>


On 10/25/2018 2:18 AM, Bhupesh Sharma wrote:
> Commit 8449bda73ab14516d4bf81d29503c1ea203bb865 ["Documentation:
> Update documentation regarding --mem-usage' option"]), updated the
> makedumpfile man page to indicate that this option is now
> supported on x86_64, arm64, ppc64 and s390x.
> 
> However, the help text for makedumpfile (which one can see
> by running 'makedumpfile --help'), still reflects the old
> support status, i.e. this option is only supported on x86_64.

Thanks Bhupesh, I couldn't be aware of it.
applied to the devel branch.

Kazu

> 
> This patch changes the help text to be in sync with the man
> page text.
> 
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  print_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/print_info.c b/print_info.c
> index 732d5b806c24..0be12ea8803c 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -300,7 +300,7 @@ print_usage(void)
>  	MSG("      necessary to specify [-x VMLINUX] or [-i VMCOREINFO].\n");
>  	MSG("\n");
>  	MSG("  [--mem-usage]:\n");
> -	MSG("      This option is only for x86_64.\n");
> +	MSG("      This option is currently supported on x86_64, arm64, ppc64 and s390x.\n");
>  	MSG("      This option is used to show the page numbers of current system in different\n");
>  	MSG("      use. It should be executed in 1st kernel. By the help of this, user can know\n");
>  	MSG("      how many pages is dumpable when different dump_level is specified. It analyzes\n");
> --
> 2.7.4
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
