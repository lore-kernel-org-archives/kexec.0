Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1baCpA-0005Uk-Eq
 for kexec@lists.infradead.org; Thu, 18 Aug 2016 02:12:53 +0000
Subject: Re: [PATCH v7 2/2] Documentation: kdump: add description of enable
 multi-cpus support
References: <1471485011-19035-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1471485011-19035-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <57B5199C.3080105@redhat.com>
Date: Thu, 18 Aug 2016 10:12:44 +0800
MIME-Version: 1.0
In-Reply-To: <1471485011-19035-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org, kexec@lists.infradead.org, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

On 2016/08/18 at 09:50, Zhou Wenjian wrote:
> multi-cpu support is useful to improve the performance of kdump in
> some cases. So add the description of enable multi-cpu support in
> dump-capture kernel.
>
> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/kdump/kdump.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 96da2b7..c93a6e0 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -396,6 +396,13 @@ Notes on loading the dump-capture kernel:
>    Note, though maxcpus always works, you should replace it by nr_cpus to
>    save memory if supported by the current ARCH, such as x86.
>  
> +* You should enable multi-cpu support in dump-capture kernel if you intend
> +  to use multi-thread programs with it, such as parallel dump feature of
> +  makedumpfile. Otherwise, the multi-thread program may have a great
> +  performance degradation. To enable multi-cpu support, you should bring up
> +  a SMP dump-capture kernel and specify maxcpus\nr_cpus, disable_cpu_apicid=[X]

s/a SMP/an SMP/
For "maxcpus\nr_cpus", I think to use slash instead of backslash in Linux is better.

Otherwise, looks good to me.

Regards,
Xunlei

> +  options while loading it.
> +
>  * For s390x there are two kdump modes: If a ELF header is specified with
>    the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
>    is done on all other architectures. If no elfcorehdr= kernel parameter is


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
