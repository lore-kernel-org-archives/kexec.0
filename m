Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMZYg-0007bZ-Um
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 08:25:56 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/2] cache: fix cache logic not go into invalid state
Date: Thu, 19 Sep 2013 08:18:59 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971B22B9@BPXM01GP.gisp.nec.co.jp>
References: <20130917062606.4671.40617.stgit@localhost6.localdomain6>
 <523A4B11.6010409@jp.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "ptesarik@suse.cz" <ptesarik@suse.cz>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello HATAYAMA-san,

(2013/09/19 9:54), HATAYAMA Daisuke wrote:
> Hello Kumagai-san,
>
> Could you review these patches?

Good catch, thanks for your fixing.
I'll merge this patch set into v1.5.5.

BTW, I'm going to be on vacation from Sep 21 until Sep 30,
I can't reply for a while.


Thanks
Atsushi Kumagai

>
> (2013/09/17 15:29), HATAYAMA Daisuke wrote:
>> I faced failure of sadump phys_base calculation and found a bug in
>> cache.c causes it. Due to the bug, cache_alloc() returns NULL forever
>> throughout execution. The fix is the 2nd patch. During the
>> investigation I also found a lack of malloc() allocation failure
>> check. The fix is the 1st patch. Primary is the 2nd one.
>>
>> I built this patch set on top of devel branch.
>>
>> ---
>>
>> HATAYAMA Daisuke (2):
>>        cache: allocate buffers at initialization to detect malloc() failure
>>        cache: reuse entry in pending list
>>
>>
>>   cache.c        |   50 +++++++++++++++++++++++++++++++++-----------------
>>   cache.h        |    1 +
>>   makedumpfile.c |    3 +++
>>   3 files changed, 37 insertions(+), 17 deletions(-)
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
