Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UiF3J-0005vs-RG
 for kexec@lists.infradead.org; Fri, 31 May 2013 02:26:50 +0000
Message-ID: <51A80A66.7080003@redhat.com>
Date: Fri, 31 May 2013 10:26:46 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Add a help message into man page of makedumpfile for
 -b option.
References: <20130530084418.15640.42675.stgit@k.asiapacific.hpqcorp.net>
In-Reply-To: <20130530084418.15640.42675.stgit@k.asiapacific.hpqcorp.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: oomichi@mxs.nes.nec.co.jp, bhe@redhat.com, jin.wang@hp.com, nan.chen2@hp.com, gang.xing@hp.com, kexec@lists.infradead.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, nigel.croxon@hp.com, vgoyal@redhat.com

Add Ken'ichi Ohmichi to cc list and remove redhat list from cc

On 05/30/2013 04:44 PM, Jingbai Ma wrote:
> This is a minor change that only adds a help message to -b option in makedumpfile man page.
> This message has been in Red Hat's makedumpfile source, they would like it in upstream also.
> 
> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
> ---
>  makedumpfile.8 |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index cfd1270..1e844db 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -534,6 +534,10 @@ order from left to right.  \fIVMCORE\fRs are assembled into a single
>  Print debugging message.
>  
>  .TP
> +\fB-b <order>\fR
> +cache 2^order pages in ram when generating vmcore info before writing to output
> +
> +.TP
>  \fB\-h\fR
>  Show help message and LZO/snappy support status (enabled/disabled).
>  
> 


-- 
Thanks
Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
