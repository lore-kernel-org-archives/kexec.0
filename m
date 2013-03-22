Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIpof-0003oH-Gg
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 00:26:43 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 9F8203EE0BD
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:26:33 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 83CB145DE54
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:26:33 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6863645DE55
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:26:33 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 565E41DB8052
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:26:33 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id F2B06E08002
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:26:32 +0900 (JST)
Date: Fri, 22 Mar 2013 09:25:47 +0900 (JST)
Message-Id: <20130322.092547.57832612.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly
 to get position of program header table
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130321141202.GF3934@redhat.com>
References: <87ppyvnjyn.fsf@xmission.com>
 <20130321.115041.225288996.d.hatayama@jp.fujitsu.com>
 <20130321141202.GF3934@redhat.com>
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
Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly to get position of program header table
Date: Thu, 21 Mar 2013 10:12:02 -0400

> On Thu, Mar 21, 2013 at 11:50:41AM +0900, HATAYAMA Daisuke wrote:
>> From: "Eric W. Biederman" <ebiederm@xmission.com>
>> Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly to get position of program header table
>> Date: Tue, 19 Mar 2013 14:44:16 -0700
>> 
>> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
>> > 
>> >> Currently, the code assumes that position of program header table is
>> >> next to ELF header. But future change can break the assumption on
>> >> kexec-tools and the 1st kernel. To avoid worst case, reference e_phoff
>> >> member explicitly to get position of program header table in
>> >> file-offset.
>> > 
>> > In principle this looks good.  However when I read this it looks like
>> > you are going a little too far.
>> > 
>> > You are changing not only the reading of the supplied headers, but
>> > you are changing the generation of the new new headers that describe
>> > the data provided by /proc/vmcore.
>> > 
>> > I get lost in following this after you mangle merge_note_headers.
>> > 
>> > In principle removing silly assumptions seems reasonable, but I think
>> > it is completely orthogonal to the task of maping vmcore mmapable.
>> > 
>> > I think it is fine to claim that the assumptions made here in vmcore are
>> > part of the kexec on panic ABI at this point, which would generally make
>> > this change unnecessary.
>> 
>> This was suggested by Vivek. He prefers generic one.
>> 
>> Vivek, do you agree to this? Or is it better to re-post this and other
>> clean-up patches as another one separately to this patch set?
> 
> Given the fact that current code has been working, I am fine to just
> re-post and take care of mmap() related issues. And we can take care
> of cleaning up of some assumptions about PT_NOTE headers later. Trying
> to club large cleanup with mmap() patches is making it hard to review.
> 

I see. I'll post the clean-up series separately.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
