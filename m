Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wz3Ur-0002Ys-Oc
 for kexec@lists.infradead.org; Mon, 23 Jun 2014 12:37:18 +0000
Date: Mon, 23 Jun 2014 08:36:54 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Makedumpfile: vmcore size estimate
Message-ID: <20140623123654.GA29112@redhat.com>
References: <1402490345-18656-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402490345-18656-1-git-send-email-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On Wed, Jun 11, 2014 at 08:39:05PM +0800, Baoquan He wrote:
> User want to get a rough estimate of vmcore size, then they can decide
> how much storage space is reserved for vmcore dumping. This can help them
> to deploy their machines better, possibly hundreds of machines.
> 
> In this draft patch, a new configuration option is added,
>     "--vmcore-estimate"
> User can execute below command to get a dumped kcore. Since kcore is a
> elf file to map the whole memory of current kernel, it's  equal to the
> memory of crash kernel though it's not exact. Content of kcore is dynamic
> though /proc/vmcore is fixed once crash happened. But for vmcore size
> estimate, it is better enough.
> 
> sudo makedumpfile -E -d 31 --vmcore-estimate /proc/kcore /var/crash/kcore-dump
> 
> Questions:
> 1. Or we can get the dumpable page numbers only, then calculate the estimated
> vmcore size by a predifined factor if it's kdump compressed dumping. E.g if
> lzo dump, we assume the compression ratio is 45%, then the estimate size is
> equal to: (dumpable page numbers) * 4096* 45%.

I think that we can probably not guess the saving from compression.
Compression ratio varies based on content of page. So if we keep it simple
and just calculate the number of pages which will be dumped and multiply
it by page size, that number will be much more accurate (for current
system).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
