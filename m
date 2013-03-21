Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIVaf-0000DY-46
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 02:50:54 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B43D444DD81
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 11:50:47 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9D78645DE52
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 11:50:47 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 862E845DE4D
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 11:50:47 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 76D121DB803A
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 11:50:47 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2E2341DB802C
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 11:50:47 +0900 (JST)
Date: Thu, 21 Mar 2013 11:50:41 +0900 (JST)
Message-Id: <20130321.115041.225288996.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly
 to get position of program header table
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <87ppyvnjyn.fsf@xmission.com>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040053.15064.93652.stgit@localhost6.localdomain6>
 <87ppyvnjyn.fsf@xmission.com>
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
To: ebiederm@xmission.com, vgoyal@redhat.com
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly to get position of program header table
Date: Tue, 19 Mar 2013 14:44:16 -0700

> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
> 
>> Currently, the code assumes that position of program header table is
>> next to ELF header. But future change can break the assumption on
>> kexec-tools and the 1st kernel. To avoid worst case, reference e_phoff
>> member explicitly to get position of program header table in
>> file-offset.
> 
> In principle this looks good.  However when I read this it looks like
> you are going a little too far.
> 
> You are changing not only the reading of the supplied headers, but
> you are changing the generation of the new new headers that describe
> the data provided by /proc/vmcore.
> 
> I get lost in following this after you mangle merge_note_headers.
> 
> In principle removing silly assumptions seems reasonable, but I think
> it is completely orthogonal to the task of maping vmcore mmapable.
> 
> I think it is fine to claim that the assumptions made here in vmcore are
> part of the kexec on panic ABI at this point, which would generally make
> this change unnecessary.

This was suggested by Vivek. He prefers generic one.

Vivek, do you agree to this? Or is it better to re-post this and other
clean-up patches as another one separately to this patch set?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
