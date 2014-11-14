Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xp5rn-0000Fb-OV
 for kexec@lists.infradead.org; Fri, 14 Nov 2014 01:40:04 +0000
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7E48C3EE0C2
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 10:39:42 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 85B86AC0947
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 10:39:41 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 18CA31DB8040
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 10:39:41 +0900 (JST)
Date: Fri, 14 Nov 2014 10:42:35 +0900 (JST)
Message-Id: <20141114.104235.926535445994740268.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20141113154810.2ee36e72@hananiah.suse.cz>
References: <54646C1D.1050102@jp.fujitsu.com>
 <20141113142548.GA1978@redhat.com>
 <20141113154810.2ee36e72@hananiah.suse.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ptesarik@suse.cz
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, anderson@redhat.com, ebiederm@xmission.com, kumagai-atsushi@mxc.nes.nec.co.jp, vgoyal@redhat.com

From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
Date: Thu, 13 Nov 2014 15:48:10 +0100

> On Thu, 13 Nov 2014 09:25:48 -0500
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
>> On Thu, Nov 13, 2014 at 05:30:21PM +0900, HATAYAMA, Daisuke wrote:
>> > 
>> > (2014/11/13 17:06), Petr Tesarik wrote:
>> > >On Thu, 13 Nov 2014 09:17:09 +0900 (JST)
>> > >HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> > >
>> > >>From: Vivek Goyal <vgoyal@redhat.com>
>> > >>Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
>> > >>Date: Wed, 12 Nov 2014 17:12:05 -0500
>> > >>
>> > >>>On Wed, Nov 12, 2014 at 03:40:42PM +0900, HATAYAMA Daisuke wrote:
>> > >>>>Currently, VMCOREINFO note information reports the virtual address of
>> > >>>>phys_base that is assigned to symbol phys_base. But this doesn't make
>> > >>>>sense because to refer to value of the phys_base, it's necessary to
>> > >>>>get the value of phys_base itself we are now about to refer to.
>> > >>>>
>> > >>>
>> > >>>Hi Hatayama,
>> > >>>
>> > >>>/proc/vmcore ELF headers have virtual address information and using
>> > >>>that you should be able to read actual value of phys_base. gdb deals
>> > >>>with virtual addresses all the time and can read value of any symbol
>> > >>>using those headers.
>> > >>>
>> > >>>So I am not sure what's the need for exporting actual value of
>> > >>>phys_base.
>> > >>>
>> > >>
>> > >>Sorry, my logic in the patch description was wrong. For /proc/vmcore,
>> > >>there's enough information for makedumpdile to get phys_base. It's
>> > >>correct. The problem here is that other crash dump mechanisms that run
>> > >>outside Linux kernel independently don't have information to get
>> > >>phys_base.
>> > >
>> > >Yes, but these mechanisms won't be able to read VMCOREINFO either, will
>> > >they?
>> > >
>> > 
>> > I don't intend such sophisticated function only by VMCOREINFO.
>> > Search vmcore for VMCOREINFO using strings + grep before opening it by crash.
>> > I intend that only here.
>> 
>> I think this is very crude and not proper way to get to vmcoreinfo.
> 
> Same here. If VMCOREINFO must be locatable without communicating any
> information to the hypervisor, then I would rather go for something
> similar to what s390(x) folks do - a well-known location in physical
> memory that contains a pointer to a checksummed OS info structure,
> which in turn contains the VMCOREINFO pointers.
> 
> I'm a bit surprised such mechanism is not needed by Fujitsu SADUMP.
> Or is that part of the current plan, Daisuke?
> 

It's useful if there is. I don't plan now. For now, the idea of this
patch is enough for me.

BTW, for the above idea, I suspect that if the location in the
physical memory is unique, it cannot deal with the kdump 2nd kernel
case. I think it better for the idea to be able to represent multiple
kernel information.

--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
