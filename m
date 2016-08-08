Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWa66-00087h-Dg
 for kexec@lists.infradead.org; Mon, 08 Aug 2016 02:15:23 +0000
Date: Mon, 8 Aug 2016 10:14:51 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 1/2] Documentation: kdump: remind user of nr_cpus
Message-ID: <20160808021451.GA5375@dhcp-128-65.nay.redhat.com>
References: <1470185952-23477-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1470185952-23477-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bhe@redhat.com

On 08/03/16 at 08:59am, Zhou Wenjian wrote:
> v2->v3: add description of nr_cpus.
> v1->v2: change nr_cpus to maxcpus
> 
> nr_cpus can help to save memory. So we should remind user of it.
> 
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> ---
>  Documentation/kdump/kdump.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 88ff63d..4aa194e 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -393,6 +393,8 @@ Notes on loading the dump-capture kernel:
>  * We generally don' have to bring up a SMP kernel just to capture the
>    dump. Hence generally it is useful either to build a UP dump-capture
>    kernel or specify maxcpus=1 option while loading dump-capture kernel.
> +  Note, though maxcpus always works, we should replace it by nr_cpus to
> +  save memory if supported by the current ARCH, such as x86. 

Can you replace "we" with "you" in both these patches?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
