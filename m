Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ugl56-0003w7-PI
 for kexec@lists.infradead.org; Mon, 27 May 2013 00:14:34 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 372273EE0C8
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 09:14:03 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id F2D8D45DEBC
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 09:14:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D906745DEBA
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 09:14:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id CA3CD1DB8038
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 09:14:02 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 33CE31DB803F
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 09:14:02 +0900 (JST)
Message-ID: <51A2A524.4080303@jp.fujitsu.com>
Date: Mon, 27 May 2013 09:13:24 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 3/9] vmcore: treat memory chunks referenced by PT_LOAD
 program header entries in page-size boundary in vmcore_list
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052513.13864.85440.stgit@localhost6.localdomain6>
 <20130523144928.0328bb3ad7ccc1ff2da9558d@linux-foundation.org>
 <20130524131217.GA18218@redhat.com>
In-Reply-To: <20130524131217.GA18218@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: riel@redhat.com, hughd@google.com, jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, walken@google.com, cpw@sgi.com, Vivek Goyal <vgoyal@redhat.com>

(2013/05/24 22:12), Vivek Goyal wrote:
> On Thu, May 23, 2013 at 02:49:28PM -0700, Andrew Morton wrote:
>> On Thu, 23 May 2013 14:25:13 +0900 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>>
>>> Treat memory chunks referenced by PT_LOAD program header entries in
>>> page-size boundary in vmcore_list. Formally, for each range [start,
>>> end], we set up the corresponding vmcore object in vmcore_list to
>>> [rounddown(start, PAGE_SIZE), roundup(end, PAGE_SIZE)].
>>>
>>> This change affects layout of /proc/vmcore.
>>
>> Well, changing a userspace interface is generally unacceptable because
>> it can break existing userspace code.
>>
>> If you think the risk is acceptable then please do explain why.  In
>> great detail!
>
> I think it should not be a problem as /proc/vmcore is useful only when
> one parses the elf headers and then accesses the contents of file based
> on the header information. This patch just introduces additional areas
> in /proc/vmcore file and ELF headers still point to right contents. So
> any tool parsing ELF headers and then accessing file contents based on
> that info should still be fine.
>
> AFAIK, no user space tool should be broken there.
>
> Thanks
> Vivek
>

Yes, the changes are new introduction of holes between components of ELF
and tools doesn't reach the holes as long as by looking up program header
table and other tables. cp command touches the holes but trivially works
well.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
