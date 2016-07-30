Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bTIj5-0005bg-3I
 for kexec@lists.infradead.org; Sat, 30 Jul 2016 01:06:03 +0000
Date: Sat, 30 Jul 2016 09:05:38 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: Add more descriptions of multi-threads
 feature
Message-ID: <20160730010538.GA2583@x1.redhat.com>
References: <1469763242-2221-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1469763242-2221-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: dyoung@redhat.com, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com

On 07/29/16 at 11:34am, Zhou Wenjian wrote:
> It will have a bad performance if the threads number is larger than
> the usable cpu number. So we should remind user of it.
> 
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>

It makes sense to tell people who use option "-num-threads".
Ack it.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  makedumpfile.8 | 2 ++
>  print_info.c   | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index 3b6f7e2..f74abea 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -376,6 +376,8 @@ the kdump\-compressed format.
>  \fB\-\-num\-threads\fR \fITHREADNUM\fR
>  Using multiple threads to read and compress data of each page in parallel.
>  And it will reduces time for saving \fIDUMPFILE\fR.
> +Note that if the usable cpu number is less than the thread number, it may
> +lead to great performance degradation.
>  This feature only supports creating \fIDUMPFILE\fR in kdump\-comressed
>  format from \fIVMCORE\fR in kdump\-compressed format or elf format.
>  .br
> diff --git a/print_info.c b/print_info.c
> index 1a9f70c..2fbfb12 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -200,6 +200,8 @@ print_usage(void)
>  	MSG("  [--num-threads THREADNUM]:\n");
>  	MSG("      Using multiple threads to read and compress data of each page in parallel.\n");
>  	MSG("      And it will reduces time for saving DUMPFILE.\n");
> +	MSG("      Note that if the usable cpu number is less than the thread number, it may\n");
> +	MSG("      lead to great performance degradation.\n");
>  	MSG("      This feature only supports creating DUMPFILE in kdump-comressed format from\n");
>  	MSG("      VMCORE in kdump-compressed format or elf format.\n");
>  	MSG("\n");
> -- 
> 1.8.3.1
> 
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
