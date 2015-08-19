Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZRw2z-0000ii-Bb
 for kexec@lists.infradead.org; Wed, 19 Aug 2015 05:36:25 +0000
Subject: Re: kexec, x86: Need a new e820 type support for kexec
References: <1437697592.3214.373.camel@hp.com>
 <20150806081231.GA16699@dhcp-128-28.nay.redhat.com>
 <1438910038.3109.116.camel@hp.com>
 <20150818085330.GB15480@dhcp-128-28.nay.redhat.com>
 <1439910078.24434.106.camel@hp.com>
 <20150819025316.GD19950@dhcp-128-28.nay.redhat.com>
From: Toshi Kani <toshi.kani@hp.com>
Message-ID: <55D415C1.2010406@hp.com>
Date: Tue, 18 Aug 2015 23:36:01 -0600
MIME-Version: 1.0
In-Reply-To: <20150819025316.GD19950@dhcp-128-28.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-nvdimm@ml01.01.org, kexec@lists.infradead.org, hch@lst.de, linux-kernel@vger.kernel.org

On 8/18/2015 8:53 PM, Baoquan He wrote:
> On 08/18/15 at 09:01am, Toshi Kani wrote:
>> On Tue, 2015-08-18 at 16:53 +0800, Baoquan He wrote:
>>> Rethink it again, maybe it's better to pass PMEM as PRAM to kdump
>>> kernel if user really want to use memmap way by specifying
>>> --pass-memmap-cmdline. Then I need add the PMEM and PRAM checking here
>>> you pointed out. Will repost with them.
>> No, you should not report PMEM as PRAM.  They are different things.  The
>> kdump kernel does not need to support memmap cmdline for PMEM, as the
>> regular kernel does not -- memmap cmdline cannot emulate PMEM.
> OK. Then it will be wrong if people intend to specify
> --pass-memmap-cmdline. There might be 3 ways to fix this:
>
> 1) add PMEM support in kernel. memmap cmdline is not only used for
> emulating, but for kexec/kdump using.
>
> 2) Delete --pass-memmap-cmdline option in kexec-tools since people
> rarely use it.
>
> 3) Add a note in kexec-tools that option --pass-memmap-cmdline can't
> work together with PMEM, people should not use it.

3) is fine, and I do not think we need a note either.  It does not make 
sense to add an memmap cmdline for PMEM since PMEM ranges require ACPI 
NFIT table.

Thanks,
-Toshi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
