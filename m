Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wz3wc-0004eG-Jv
 for kexec@lists.infradead.org; Mon, 23 Jun 2014 13:06:03 +0000
Date: Mon, 23 Jun 2014 21:05:33 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Makedumpfile: vmcore size estimate
Message-ID: <20140623130533.GA1616@dhcp-17-102.nay.redhat.com>
References: <1402490345-18656-1-git-send-email-bhe@redhat.com>
 <20140623123654.GA29112@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140623123654.GA29112@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, tak@redhat.com, gbarros@redhat.com
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On 06/23/14 at 08:36am, Vivek Goyal wrote:
> On Wed, Jun 11, 2014 at 08:39:05PM +0800, Baoquan He wrote:
> > sudo makedumpfile -E -d 31 --vmcore-estimate /proc/kcore /var/crash/kcore-dump
> > 
> > Questions:
> > 1. Or we can get the dumpable page numbers only, then calculate the estimated
> > vmcore size by a predifined factor if it's kdump compressed dumping. E.g if
> > lzo dump, we assume the compression ratio is 45%, then the estimate size is
> > equal to: (dumpable page numbers) * 4096* 45%.
> 
> I think that we can probably not guess the saving from compression.
> Compression ratio varies based on content of page. So if we keep it simple
> and just calculate the number of pages which will be dumped and multiply
> it by page size, that number will be much more accurate (for current
> system).

Yeah, this is another plan. Then the output will be the size of elf
dump. If user configured the kdump compression, such as lzo/snappy, they
can just estimate it by themselves. It's OK if user can accept this
since this is much more accurate.

Hi Anders,

Do you have any comments on this? I found you are concerned with this
issue too.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
