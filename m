Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcX2b-0001w3-QA
 for kexec@lists.infradead.org; Wed, 15 May 2013 08:26:30 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 6E04D3EE0C7
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 17:26:02 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5F66245DE5B
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 17:26:02 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4580645DE59
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 17:26:02 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2C327E08003
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 17:26:02 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D4FF11DB8043
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 17:26:01 +0900 (JST)
Message-ID: <51934685.9080909@jp.fujitsu.com>
Date: Wed, 15 May 2013 17:25:41 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 7/8] vmcore: calculate vmcore file size from buffer
 size and total size of vmcore objects
References: <20130514015622.18697.77191.stgit@localhost6.localdomain6>
 <20130514015746.18697.1089.stgit@localhost6.localdomain6>
 <20130514164739.GJ13674@redhat.com>
In-Reply-To: <20130514164739.GJ13674@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, jingbai.ma@hp.com

(2013/05/15 1:47), Vivek Goyal wrote:
> On Tue, May 14, 2013 at 10:57:46AM +0900, HATAYAMA Daisuke wrote:
>> The previous patches newly added holes before each chunk of memory and
>> the holes need to be count in vmcore file size. There are two ways to
>> count file size in such a way:
>>
>> 1) supporse p as a poitner to the last program header entry with
>> PT_LOAD type, then roundup(p->p_offset + p->p_memsz, PAGE_SIZE), or

This part was wrong. This should have been:

1) support m as a pointer to the last vmcore object in vmcore_list, then 
file size is (m->offset + m->size), or

I'll correct this way in next patch.

Note that no functional change, only description is wrong here.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
