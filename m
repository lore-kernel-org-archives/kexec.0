Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdsED-0002HY-7T
 for kexec@lists.infradead.org; Wed, 06 Nov 2013 01:48:17 +0000
Message-ID: <52799FC5.5040408@hp.com>
Date: Wed, 06 Nov 2013 09:47:49 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] makedumpfile: hugepage filtering for vmcore dump
References: <20131105134532.32112.78008.stgit@k.asiapacific.hpqcorp.net>
 <20131105202631.GC4598@redhat.com>
In-Reply-To: <20131105202631.GC4598@redhat.com>
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
Cc: bhe@redhat.com, tom.vaden@hp.com, kexec@lists.infradead.org, ptesarik@suse.cz, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, anderson@redhat.com, Jingbai Ma <jingbai.ma@hp.com>

On 11/06/2013 04:26 AM, Vivek Goyal wrote:
> On Tue, Nov 05, 2013 at 09:45:32PM +0800, Jingbai Ma wrote:
>> This patch set intend to exclude unnecessary hugepages from vmcore dump file.
>>
>> This patch requires the kernel patch to export necessary data structures into
>> vmcore: "kexec: export hugepage data structure into vmcoreinfo"
>> http://lists.infradead.org/pipermail/kexec/2013-November/009997.html
>>
>> This patch introduce two new dump levels 32 and 64 to exclude all unused and
>> active hugepages. The level to exclude all unnecessary pages will be 127 now.
>
> Interesting. Why hugepages should be treated any differentely than normal
> pages?
>
> If user asked to filter out free page, then it should be filtered and
> it should not matter whether it is a huge page or not?

Yes, free hugepages should be filtered out with other free pages. It 
sounds reasonable.

But for active hugepages, I would offer user more choices/flexibility. 
(maybe bad).
I'm OK to filter active hugepages with other user data page.

Any other comments?


>
> Thanks
> Vivek


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
