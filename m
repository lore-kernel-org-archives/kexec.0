Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a4mJa-0004mg-4i
 for kexec@lists.infradead.org; Fri, 04 Dec 2015 09:06:06 +0000
Date: Fri, 4 Dec 2015 04:05:39 -0500 (EST)
From: Chao Fan <cfan@redhat.com>
Message-ID: <885095395.27300639.1449219939731.JavaMail.zimbra@redhat.com>
In-Reply-To: <1449111011-21749-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1449111011-21749-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
Subject: Re: [PATCH] Add more description for --num-threads
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
To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org

Ack.

Since in the condition of "-d 31", it will cost more time with
"--num-threads" than without "--num-threads". So I suggest not
using "--num-threads" when "-d 31" will be better.

Acked-by: Chao Fan <cfan@redhat.com>

----- Original Message -----
> From: "Zhou Wenjian" <zhouwj-fnst@cn.fujitsu.com>
> To: kexec@lists.infradead.org
> Sent: Thursday, December 3, 2015 10:50:11 AM
> Subject: [PATCH] Add more description for --num-threads
> 
> From the test result, we can see when "-d 31" is specified, using
> "--num-threads" always spends more time than not. And it occurs at
> most of the time in theory. So it should be mentioned in the
> description of "--num-threads".
> 
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  makedumpfile.8 | 6 ++++--
>  print_info.c   | 4 ++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index 6eff4f1..ec179a5 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -378,11 +378,13 @@ Using multiple threads to read and compress data of
> each page in parallel.
>  And it will reduces time for saving \fIDUMPFILE\fR.
>  This feature only supports creating \fIDUMPFILE\fR in kdump\-comressed
>  format from \fIVMCORE\fR in kdump\-compressed format or elf format.
> +Note that if too many pages are filtered, \'\-\-num\-threads\' may not
> improve
> +the performance, or even has bad effects. It means if \'\-d 31\' is
> specified,
> +you should think about whether to use \'\-\-num\-threads\'.
>  .br
>  .B Example:
>  .br
> -# makedumpfile \-d 31 \-\-num\-threads 4 /proc/vmcore dumpfile
> -
> +# makedumpfile \-\-num\-threads 4 /proc/vmcore dumpfile
>  .TP
>  \fB\-\-reassemble\fR
>  Reassemble multiple \fIDUMPFILE\fRs, which are created by \-\-split option,
> diff --git a/print_info.c b/print_info.c
> index d662c0c..d0302a8 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -194,6 +194,10 @@ print_usage(void)
>  	MSG("      And it will reduces time for saving DUMPFILE.\n");
>  	MSG("      This feature only supports creating DUMPFILE in kdump-comressed
>  	format from\n");
>  	MSG("      VMCORE in kdump-compressed format or elf format.\n");
> +	MSG("      Note that if too many pages are filtered, '--num-threads' may
> not improve\n");
> +	MSG("      the performance, or even has bad effects.\n");
> +	MSG("      It means if '-d 31' is specified, you should think about whether
> to use\n");
> +	MSG("      '--num-threads'.\n");
>  	MSG("\n");
>  	MSG("  [--reassemble]:\n");
>  	MSG("      Reassemble multiple DUMPFILEs, which are created by --split
>  	option,\n");
> --
> 1.8.3.1
> 
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
