Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDmWz-0004j6-Lk
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 01:55:35 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 101B73EE0C5
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:55:26 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E517345DE65
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:55:25 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C196345DE5F
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:55:25 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B2639E0800E
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:55:25 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5CB12E08002
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:55:25 +0900 (JST)
Date: Fri, 08 Mar 2013 10:55:19 +0900 (JST)
Message-Id: <20130308.105519.82764856.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 15/20] kexec: fill note buffers by NT_VMCORE_PAD
 notes in page-size boundary
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <513867D2.7090501@cn.fujitsu.com>
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
 <20130302083714.31252.17863.stgit@localhost6.localdomain6>
 <513867D2.7090501@cn.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhangyanfei@cn.fujitsu.com
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Subject: Re: [PATCH v2 15/20] kexec: fill note buffers by NT_VMCORE_PAD notes in page-size boundary
Date: Thu, 7 Mar 2013 18:11:30 +0800

> 于 2013年03月02日 16:37, HATAYAMA Daisuke 写道:
>> Fill both crash_notes and vmcoreinfo_note buffers by NT_VMCORE_PAD
>> note type to make them satisfy mmap()'s page-size boundary
>> requirement.
>> 
>> So far, end of note segments has been marked by zero-filled elf
>> header. Instead, this patch writes NT_VMCORE_PAD note in the end of
>> note segments until the offset on page-size boundary.
> 
> 
> In the codes below, it seems that you assign name "VMCOREINFO" for
> note type NT_VMCORE_PAD, right? This is kind of wired, i think. This
> name has been used for NT_VMCORE_DEBUGINFO note already. Why not something
> like "VMCOREPAD" or "PAD"?
> 

It looks you are confusing or don't know name and type. The name is
namespace and in the namespace, there are multiple note types, each of
which has the corresponding data. In other words, data corresponding
to types differ if they belong to differnet name space even if
integers of the types are coincide with.

The "VMCOREINFO" name represents information exported from
/proc/vmcore that is used in kdump framework. In this sense,
NT_VMCORE_PAD that is specific for /proc/vmcore and kdump framework,
should belong to the "VMCOREINFO" name.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
