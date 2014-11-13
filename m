Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xoi5d-0001hH-TT
 for kexec@lists.infradead.org; Thu, 13 Nov 2014 00:16:46 +0000
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [10.0.237.133])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6CC873EE1CF
 for <kexec@lists.infradead.org>; Thu, 13 Nov 2014 09:16:21 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 62802AC0467
 for <kexec@lists.infradead.org>; Thu, 13 Nov 2014 09:16:20 +0900 (JST)
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
 [10.134.21.209])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id F02D71DB8042
 for <kexec@lists.infradead.org>; Thu, 13 Nov 2014 09:16:19 +0900 (JST)
Date: Thu, 13 Nov 2014 09:17:09 +0900 (JST)
Message-Id: <20141113.091709.520211949477822929.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20141112221205.GB5265@redhat.com>
References: <20141112.154042.59640143160036130.d.hatayama@jp.fujitsu.com>
 <20141112221205.GB5265@redhat.com>
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
To: vgoyal@redhat.com
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, anderson@redhat.com, kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
Date: Wed, 12 Nov 2014 17:12:05 -0500

> On Wed, Nov 12, 2014 at 03:40:42PM +0900, HATAYAMA Daisuke wrote:
>> Currently, VMCOREINFO note information reports the virtual address of
>> phys_base that is assigned to symbol phys_base. But this doesn't make
>> sense because to refer to value of the phys_base, it's necessary to
>> get the value of phys_base itself we are now about to refer to.
>> 
> 
> Hi Hatayama,
> 
> /proc/vmcore ELF headers have virtual address information and using
> that you should be able to read actual value of phys_base. gdb deals
> with virtual addresses all the time and can read value of any symbol
> using those headers.
> 
> So I am not sure what's the need for exporting actual value of
> phys_base.
> 

Sorry, my logic in the patch description was wrong. For /proc/vmcore,
there's enough information for makedumpdile to get phys_base. It's
correct. The problem here is that other crash dump mechanisms that run
outside Linux kernel independently don't have information to get
phys_base.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
