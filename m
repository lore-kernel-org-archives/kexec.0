Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZRtVX-0007Ky-0T
 for kexec@lists.infradead.org; Wed, 19 Aug 2015 02:53:43 +0000
Date: Wed, 19 Aug 2015 10:53:16 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec, x86: Need a new e820 type support for kexec
Message-ID: <20150819025316.GD19950@dhcp-128-28.nay.redhat.com>
References: <1437697592.3214.373.camel@hp.com>
 <20150806081231.GA16699@dhcp-128-28.nay.redhat.com>
 <1438910038.3109.116.camel@hp.com>
 <20150818085330.GB15480@dhcp-128-28.nay.redhat.com>
 <1439910078.24434.106.camel@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439910078.24434.106.camel@hp.com>
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
Cc: linux-nvdimm@ml01.01.org, dan.j.williams@intel.com, kexec@lists.infradead.org, hch@lst.de, linux-kernel@vger.kernel.org

On 08/18/15 at 09:01am, Toshi Kani wrote:
> On Tue, 2015-08-18 at 16:53 +0800, Baoquan He wrote:
> > Rethink it again, maybe it's better to pass PMEM as PRAM to kdump
> > kernel if user really want to use memmap way by specifying
> > --pass-memmap-cmdline. Then I need add the PMEM and PRAM checking here
> > you pointed out. Will repost with them.
> 
> No, you should not report PMEM as PRAM.  They are different things.  The
> kdump kernel does not need to support memmap cmdline for PMEM, as the
> regular kernel does not -- memmap cmdline cannot emulate PMEM.

OK. Then it will be wrong if people intend to specify
--pass-memmap-cmdline. There might be 3 ways to fix this:

1) add PMEM support in kernel. memmap cmdline is not only used for
emulating, but for kexec/kdump using.

2) Delete --pass-memmap-cmdline option in kexec-tools since people
rarely use it.

3) Add a note in kexec-tools that option --pass-memmap-cmdline can't
work together with PMEM, people should not use it.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
