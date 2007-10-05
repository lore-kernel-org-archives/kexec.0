Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Idg88-0002Ec-Pa
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 06:53:48 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l955ph9Y009072
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 14:51:43 +0900 (JST)
Message-ID: <4705D070.7080403@ah.jp.nec.com>
Date: Fri, 05 Oct 2007 14:49:36 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] add tunable_notifier function
References: <4704D0BA.4090507@ah.jp.nec.com> <20071005054205.GB4893@in.ibm.com>
In-Reply-To: <20071005054205.GB4893@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Vivek Goyal wrote:
> On Thu, Oct 04, 2007 at 08:38:34PM +0900, Takenori Nagano wrote:
>> This patch adds new notifier function tunable_notifier_chain. Its base is
>> atomic_notifier_chain.
>>
>> Thanks,
>>
>> ---
>>
>> Signed-off-by: Takenori Nagano <t-nagano@ah.jp.nec.com>
>>
>> ---
>> diff -uprN linux-2.6.23-rc9.orig/include/linux/notifier.h
>> linux-2.6.23-rc9/include/linux/notifier.h
>> --- linux-2.6.23-rc9.orig/include/linux/notifier.h	2007-10-02 12:24:52.000000000
>> +0900
>> +++ linux-2.6.23-rc9/include/linux/notifier.h	2007-10-03 14:48:04.288000000 +0900
>> @@ -13,6 +13,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/rwsem.h>
>>  #include <linux/srcu.h>
>> +#include <linux/kobject.h>
>>
>>  /*
>>   * Notifier chains are of four types:
>> @@ -53,6 +54,14 @@ struct notifier_block {
>>  	int priority;
>>  };
>>
>> +struct tunable_notifier_block {
>> +	struct notifier_block *nb;
>> +	struct tunable_notifier_head *head;
>> +	struct dentry *dir;
>> +	struct dentry *pri_dentry;
>> +	struct dentry *desc_dentry;
>> +};
>> +
> 
> Should this be tunable_atomic_notifier_block? I think there are two kind
> of lists. One where handlers have to be atomic and other one where handlers
> can be blocking one. I think you are making atomic one tunable. If that's
> the case it should be reflected in the naming everywhere.

Hi Vivek,

Yes, it based on atomic_notifier_list. I think your opinion is reasonable.
I'll change the name tunable_notifier to tunable_atomic_notifier.

Thanks,

Takenori Nagano <t-nagano@ah.jp.nec.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
