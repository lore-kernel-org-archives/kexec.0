Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bTJt3-0004PA-Gp
 for kexec@lists.infradead.org; Sat, 30 Jul 2016 02:20:26 +0000
Date: Sat, 30 Jul 2016 10:19:59 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/2] Documentation: kdump: update maxcpus to nr_cpus
Message-ID: <20160730021959.GC2583@x1.redhat.com>
References: <1469762595-1085-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1469762595-1085-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: dyoung@redhat.com, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 07/29/16 at 11:23am, Zhou Wenjian wrote:
> Parameter nr_cpus is used to bring up a SMP dump-capture kernel,
> instead of the old parameter maxcpus. This commit update it in
> Documentation/kdump/kdump.txt.
> 
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  Documentation/kdump/kdump.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 88ff63d..9a77247 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -392,7 +392,7 @@ Notes on loading the dump-capture kernel:
>  
>  * We generally don' have to bring up a SMP kernel just to capture the
>    dump. Hence generally it is useful either to build a UP dump-capture
> -  kernel or specify maxcpus=1 option while loading dump-capture kernel.
> +  kernel or specify nr_cpus=1 option while loading dump-capture kernel.


IIRC, ARCHes like ppc don't have nr_cpus yet, maxpcus is necessary. So
either you explicitly tell which can use nr_cpus and which can only use
maxcpus option, or drop this patch for now.

>  
>  * For s390x there are two kdump modes: If a ELF header is specified with
>    the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
> -- 
> 1.8.3.1
> 
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
