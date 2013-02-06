Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2zNG-0003bD-VS
 for kexec@lists.infradead.org; Wed, 06 Feb 2013 07:24:58 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A8C1A3EE0BD
 for <kexec@lists.infradead.org>; Wed,  6 Feb 2013 16:24:48 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F2F745DE53
 for <kexec@lists.infradead.org>; Wed,  6 Feb 2013 16:24:48 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 776D245DE5A
 for <kexec@lists.infradead.org>; Wed,  6 Feb 2013 16:24:48 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6998B1DB8045
 for <kexec@lists.infradead.org>; Wed,  6 Feb 2013 16:24:48 +0900 (JST)
Received: from g01jpexchyt12.g01.fujitsu.local
 (g01jpexchyt12.g01.fujitsu.local [10.128.194.51])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 132E8E08002
 for <kexec@lists.infradead.org>; Wed,  6 Feb 2013 16:24:48 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH] kdump, oldmem: support mmap on /dev/oldmem
Date: Wed, 6 Feb 2013 07:24:46 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AC61B3C@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E20AC36B01@G01JPEXMBYT03>
 <20130205151256.GB12853@redhat.com>
In-Reply-To: <20130205151256.GB12853@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "cpw@sgi.com" <cpw@sgi.com>

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump, oldmem: support mmap on /dev/oldmem
Date: Tue, 5 Feb 2013 10:12:56 -0500

> On Mon, Feb 04, 2013 at 04:59:35AM +0000, Hatayama, Daisuke wrote:

> [..]
>> For design decision, I didn't support mmap() on /proc/vmcore because
>> it abstracts old memory as ELF format, so there's range consequtive on
>> /proc/vmcore but not consequtive on the actual old memory. For
>> example, consider ELF headers on the 2nd kernel and the note objects,
>> memory chunks corresponding to PT_LOAD entries on the first kernel.
>> They are not consequtive on the old memory. So reampping them so
>> /proc/vmcore appears consequtive using existing remap_pfn_range() needs
>> some complicated work.
> 
> Can't we call remap_pfn_range() multiple times. Once for each sequential
> range of memory. /proc/vmcore already has list of contiguous memory areas.
> So we can parse user passed file offset and size and map into respective
> physical chunks and call rempa_pfn_range() on all these chunks.
> 
> I think supporting mmap() both on /dev/oldmem as well as /proc/vmcore will
> be nice.
> 
> Agreed that supporting mmap() on /proc/vmcore is more work as compared to
> /dev/oldmem but should be doable.
> 

The complication to support mmap() on /proc/vmcore lies in kdump
side. Objects exported from /proc/vmcore needs to be page-size aligned
on /proc/vmcore. This comes from the restriction of mmap() that
requires user-space address and physical address to be page-size
aligned.

As I said in the description, objects implicitly referened by
/proc/vmcore are

  - ELF headers,
  - NOTE objects (NT_PRSTATUS entries x cpus, VMCOREINFO), and
  - memory chunks x (the number of PT_LOAD entries).

Note objects are scattered on old memory. They are exported as a
single NOTE entry from program headers, so they need to be gathered at
the same location in the 2nd kernel starting from the page-size
aligned address.

VMCOREINFO is about 1.5KB on 2.6.32 kernel. One NT_PRSTATUS is 355
bytes. Recent limit of NR_CPUS is 5120 on x86_64. So less than about 2
MB is enough even on the worst case.

Note that the format of /proc/vmcore need to change since offset of
each object need to be page-size aligned.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
