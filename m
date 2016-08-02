Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bUUPG-0002Sz-Pm
 for kexec@lists.infradead.org; Tue, 02 Aug 2016 07:46:31 +0000
Date: Tue, 2 Aug 2016 15:46:02 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] Documentation: kdump: add description of bringing up
 SMP dump-capture kernel
Message-ID: <20160802074602.GA3663@x1.redhat.com>
References: <1470010988-18050-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1470010988-18050-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

Hi Wenjian,

On 08/01/16 at 08:23am, Zhou Wenjian wrote:
> v1->v2: change nr_cpus to maxcpus
> 
> SMP dump-capture kernel is useful to improve the performance of kdump in
> some cases. So add the description of bringing up SMP dump-capture kernel.
> 
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>

Discussed with people, it could be better to adjust the
description about nr_cpus and maxcpus part. I think you can still
describe nr_cpus/maxcpus in patch 1/2, and keep parallel dumping part in
2/2.

Originally maxcpus=1 is used for all ARCHes. Later people found
nr_cpus=1 is better since nr_cpus decides the number of possible cpu
while maxcpus decides the max working cpu after system boot. So nr_cpus
can save memory because percpu will pre-allocate memory for each
possible cpu for hotplug. So on x86 nr_cpus is used because much memory
can be saved if possible cpu number is very large.

So you can mention that both maxcpus and nr_cpus can be used but nr_cpus
has advantage if it has been implemented in some ARCHes like x86_64. And
I guess you mush have tested parallel dumping feature with nr_cpus
specified, it makes sense to tell people with the real situation.

Thanks
Baoquan

> ---
>  Documentation/kdump/kdump.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 88ff63d..c5762b7 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -394,6 +394,12 @@ Notes on loading the dump-capture kernel:
>    dump. Hence generally it is useful either to build a UP dump-capture
>    kernel or specify maxcpus=1 option while loading dump-capture kernel.
>  
> +* We should bring up a SMP dump-capture kernel if we intend to use multi-threads
> +  programs with it, such as parallel dump feature of makedumpfile. Otherwise,
> +  the multi-threads program may have a great performance degradation.
> +  To bring up a SMP dump-capture kernel, we should specify maxcpus=[X] and
> +  disable_cpu_apic=[Y] options while loading it.
> +
>  * For s390x there are two kdump modes: If a ELF header is specified with
>    the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
>    is done on all other architectures. If no elfcorehdr= kernel parameter is
> -- 
> 1.8.3.1
> 
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
