Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdnDG-0004aB-Pf
 for kexec@lists.infradead.org; Tue, 05 Nov 2013 20:27:00 +0000
Date: Tue, 5 Nov 2013 15:26:31 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/3] makedumpfile: hugepage filtering for vmcore dump
Message-ID: <20131105202631.GC4598@redhat.com>
References: <20131105134532.32112.78008.stgit@k.asiapacific.hpqcorp.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131105134532.32112.78008.stgit@k.asiapacific.hpqcorp.net>
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
Cc: bhe@redhat.com, tom.vaden@hp.com, kexec@lists.infradead.org, ptesarik@suse.cz, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, anderson@redhat.com

On Tue, Nov 05, 2013 at 09:45:32PM +0800, Jingbai Ma wrote:
> This patch set intend to exclude unnecessary hugepages from vmcore dump file.
> 
> This patch requires the kernel patch to export necessary data structures into
> vmcore: "kexec: export hugepage data structure into vmcoreinfo"
> http://lists.infradead.org/pipermail/kexec/2013-November/009997.html
> 
> This patch introduce two new dump levels 32 and 64 to exclude all unused and
> active hugepages. The level to exclude all unnecessary pages will be 127 now.

Interesting. Why hugepages should be treated any differentely than normal
pages?

If user asked to filter out free page, then it should be filtered and
it should not matter whether it is a huge page or not?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
