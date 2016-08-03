Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bUmR0-0004Kn-N4
 for kexec@lists.infradead.org; Wed, 03 Aug 2016 03:01:31 +0000
Date: Wed, 3 Aug 2016 11:01:02 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4 1/2] Documentation: kdump: remind user of nr_cpus
Message-ID: <20160803030102.GC2465@x1.redhat.com>
References: <1470191495-32020-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1470191495-32020-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com, dyoung@redhat.com, linux-kernel@vger.kernel.org

Hi Wenjian,

On 08/03/16 at 10:31am, Zhou Wenjian wrote:
> v3->v4: update the description of bring up SMP dump-capture kernel
> v2->v3: add description of nr_cpus.
> v1->v2: change nr_cpus to maxcpus
> 
> nr_cpus can help to save memory. So we should remind user of it.
> 
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>

The change log can be put in cover-letter if you are posting a patchset,
or put it below the three dashes where it will be discarded
automatically when maintainer apply your patch to his/her branch.

Next time please CC akpm too, he helps to pick up these kexec related
patches.

Except for this, I am fine with this patchset. Ack it again.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> ---
>  Documentation/kdump/kdump.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 88ff63d..b474060 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -393,6 +393,8 @@ Notes on loading the dump-capture kernel:
>  * We generally don' have to bring up a SMP kernel just to capture the
>    dump. Hence generally it is useful either to build a UP dump-capture
>    kernel or specify maxcpus=1 option while loading dump-capture kernel.
> +  Note, though maxcpus always works, we should replace it by nr_cpus to
> +  save memory if supported by the current ARCH, such as x86.
>  
>  * For s390x there are two kdump modes: If a ELF header is specified with
>    the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
