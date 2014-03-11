Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNKyq-0001pM-Vw
 for kexec@lists.infradead.org; Tue, 11 Mar 2014 11:36:22 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 11:35:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C004517D8059
 for <kexec@lists.infradead.org>; Tue, 11 Mar 2014 11:36:28 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2BBZbLP45023456
 for <kexec@lists.infradead.org>; Tue, 11 Mar 2014 11:35:37 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2BBZm1k032511
 for <kexec@lists.infradead.org>; Tue, 11 Mar 2014 05:35:49 -0600
Date: Tue, 11 Mar 2014 12:35:45 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: makedumpfile: get_max_mapnr() from ELF header problem
Message-ID: <20140311123545.30bc23cf@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971F4AFE@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971EFABE@BPXM01GP.gisp.nec.co.jp>
 <20140303104408.7031a457@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F4AFE@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, 11 Mar 2014 06:22:41 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> >On Mon, 3 Mar 2014 03:11:23 +0000
> >Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> >The tools do a physical memory detection and that defines the range
> >of memory to be dumped and also defines the memory chunks for the
> >ELF header.
> 
> makedumpfile is designed for kdump, this means it relies on dependable ELF
> headers. If we support such an incorrect ELF header, makedumpfile has to get
> the actual memory map from vmcore (but I have no ideas how to do it now) and
> re-calculate all PT_LOAD regions with it. It sounds too much work for
> irregular case, I don't plan to take care of it now.

Ok, fair.
 
> >And I think we are not the only ones that have this problem. For example,
> >the KVM virsh dump probably also has that problem.
> 
> virsh dump seems to have the same issue as you said, but I suppose qemu
> developers don't worry about that because they are developing an original
> way to dump guest's memory in kdump-compressed format as "dump-guest-memory"
> command. It seems that they know such case is out of the scope of makedumpfile.

Even if they create a kdump-compressed format dump, they (probably) do not
filter while dumping. Therefore for large dumps post-processing with
makedumpfile could still make sense, e.g. for transfering the dumps. 

Because qemu is not aware of kernel parameters this will also fail when "mem="
has been used.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
