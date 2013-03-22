Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIpsh-0003uQ-GR
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 00:30:52 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id BE0083EE0BD
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:30:45 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A039C45DEBB
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:30:45 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 85EB845DEB2
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:30:45 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 783BB1DB803F
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:30:45 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2E2C81DB803B
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:30:45 +0900 (JST)
Date: Fri, 22 Mar 2013 09:30:42 +0900 (JST)
Message-Id: <20130322.093042.393566604.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 17/21] vmcore: check NT_VMCORE_PAD as a mark
 indicating the end of ELF note buffer
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130321143656.GG3934@redhat.com>
References: <20130321.115920.339923125.d.hatayama@jp.fujitsu.com>
 <87r4j98l1q.fsf@xmission.com> <20130321143656.GG3934@redhat.com>
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
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 17/21] vmcore: check NT_VMCORE_PAD as a mark indicating the end of ELF note buffer
Date: Thu, 21 Mar 2013 10:36:56 -0400

> On Wed, Mar 20, 2013 at 08:54:25PM -0700, Eric W. Biederman wrote:
> 
> [..]
>> > Also, it's possible to get size of a whole part of ELF note segments
>> > from p_memsz or p_filesz, and gdb and binutils are reading the note
>> > segments until reaching the size.
>> 
>> Agreed.  Except in our weird case where we generate the notes on the
>> fly, and generate the NOTE segment header much earlier.
> 
> And in our case we don't know the size of ELF note. Kernel is not
> exporting the size. So kexec-tools is putting an upper limit of 1024
> and putting that value in p_memsz and p_filesz fields.
> 
> Given the fact that we are reserving elf notes at boot. That means
> we know the size of ELF notes. It should make sense to export it
> to user space and let kexec-tools put right values.
> 
> In fact looks like /sys/kernel/vmcoreinfo is exporting two values. Address
> and size. (This is kind of violation of sysfs poilcy of one value per
> file). But for per cpu notes, we are exporting only address and not
> size.

IIRC, Greg Norman pointed out this violation of vmcoreinfo file when
he found some monthes ago.

> 
> /sys/devices/system/cpu/cpu<n>/crash_notes
> 
> May be we should export another file
> 
> /sys/devices/system/cpu/cpu<n>/crash_notes_size
> 
> and let kexec-tools parse it.

Anyway, I think of this issue as beyond the scope of what I'm working
here...

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
