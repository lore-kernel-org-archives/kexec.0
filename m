Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XpDXw-00041R-A1
 for kexec@lists.infradead.org; Fri, 14 Nov 2014 09:52:05 +0000
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [10.0.237.133])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 3E8A13EE1E8
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 18:51:40 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 460DEAC0667
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 18:51:39 +0900 (JST)
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
 [10.134.21.209])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E0C991DB802C
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 18:51:38 +0900 (JST)
Date: Fri, 14 Nov 2014 18:54:23 +0900 (JST)
Message-Id: <20141114.185423.380949544673818300.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20141114093145.746c7efe@hananiah.suse.cz>
References: <20141113154810.2ee36e72@hananiah.suse.cz>
 <20141114.104235.926535445994740268.d.hatayama@jp.fujitsu.com>
 <20141114093145.746c7efe@hananiah.suse.cz>
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
Date: Fri, 14 Nov 2014 09:31:45 +0100

> On Fri, 14 Nov 2014 10:42:35 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> From: Petr Tesarik <ptesarik@suse.cz>
>> Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
>> Date: Thu, 13 Nov 2014 15:48:10 +0100
>> 
>> > On Thu, 13 Nov 2014 09:25:48 -0500
>> > Vivek Goyal <vgoyal@redhat.com> wrote:
>> > 
>> >> On Thu, Nov 13, 2014 at 05:30:21PM +0900, HATAYAMA, Daisuke wrote:
>> >> > 
>> >> > (2014/11/13 17:06), Petr Tesarik wrote:
>> >> > >On Thu, 13 Nov 2014 09:17:09 +0900 (JST)
>> >> > >HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> >> > >
>> >> > >>From: Vivek Goyal <vgoyal@redhat.com>
>> >> > >>Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
>> >> > >>Date: Wed, 12 Nov 2014 17:12:05 -0500
>> >> > >>
>> >> > >>>On Wed, Nov 12, 2014 at 03:40:42PM +0900, HATAYAMA Daisuke wrote:
>> >> > >>>>Currently, VMCOREINFO note information reports the virtual address of
>> >> > >>>>phys_base that is assigned to symbol phys_base. But this doesn't make
>> >> > >>>>sense because to refer to value of the phys_base, it's necessary to
>> >> > >>>>get the value of phys_base itself we are now about to refer to.
>> >> > >>>>
>> >> > >>>
>> >> > >>>Hi Hatayama,
>> >> > >>>
>> >> > >>>/proc/vmcore ELF headers have virtual address information and using
>> >> > >>>that you should be able to read actual value of phys_base. gdb deals
>> >> > >>>with virtual addresses all the time and can read value of any symbol
>> >> > >>>using those headers.
>> >> > >>>
>> >> > >>>So I am not sure what's the need for exporting actual value of
>> >> > >>>phys_base.
>> >> > >>>
>> >> > >>
>> >> > >>Sorry, my logic in the patch description was wrong. For /proc/vmcore,
>> >> > >>there's enough information for makedumpdile to get phys_base. It's
>> >> > >>correct. The problem here is that other crash dump mechanisms that run
>> >> > >>outside Linux kernel independently don't have information to get
>> >> > >>phys_base.
>> >> > >
>> >> > >Yes, but these mechanisms won't be able to read VMCOREINFO either, will
>> >> > >they?
>> >> > >
>> >> > 
>> >> > I don't intend such sophisticated function only by VMCOREINFO.
>> >> > Search vmcore for VMCOREINFO using strings + grep before opening it by crash.
>> >> > I intend that only here.
>> >> 
>> >> I think this is very crude and not proper way to get to vmcoreinfo.
>> > 
>> > Same here. If VMCOREINFO must be locatable without communicating any
>> > information to the hypervisor, then I would rather go for something
>> > similar to what s390(x) folks do - a well-known location in physical
>> > memory that contains a pointer to a checksummed OS info structure,
>> > which in turn contains the VMCOREINFO pointers.
>> > 
>> > I'm a bit surprised such mechanism is not needed by Fujitsu SADUMP.
>> > Or is that part of the current plan, Daisuke?
>> > 
>> 
>> It's useful if there is. I don't plan now. For now, the idea of this
>> patch is enough for me.
>> 
>> BTW, for the above idea, I suspect that if the location in the
>> physical memory is unique, it cannot deal with the kdump 2nd kernel
>> case.
> 
> No, not at all. The low 640K are copied away to a pre-allocated area by
> kexec purgatory code on x86_64, so it's safe to overwrite any location
> in there. The copy is needed, because BIOS already uses some hardcoded
> addresses in that range. I think the Linux kernel may safely use part of
> PFN 0 starting at physical address 0x0500. This area was originally
> used by MS-DOS, so chances are high that no broken BIOS out there
> corrupts this part of RAM...
> 

In fact, I didn't consider in such deep way... I had forgot back up
region at all. But it's hard to use the low 640K area. Then, it's hard
to get phys_base of the kdump 1st kernel that is assumed to be saved
in thw low 640K now. Because externally running mechanism can run
after kdump 2nd kernel has booted up, crash utility needs to convert a
read request to the low 640K area into the corresponding part of the
pre-allocated area. See kdump_backup_region_init() in crash utility,
which tries to find the pre-allocated area via ELF header, where
symbol kexec_crash_image is read to find ELF header. This means we
need phys_base to find the pre-allocated area.

> Anyway, I'm not going to implement it right now for lack of time. I'm
> adding it to my TODO list, but if anybody wants to post a patch, I
> won't be offended.
> 
> Petr T

--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
