Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1eqwqZ-0001KW-Oj
 for kexec@lists.infradead.org; Wed, 28 Feb 2018 08:12:21 +0000
Subject: Re: [RESEND makedumpfile PATCH 0/2] Add 5-level paging support
References: <20180228071308.17854-1-douly.fnst@cn.fujitsu.com>
 <20180228080012.GB30207@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <1dd96fc3-0ad0-e028-e5f5-900ce2824034@cn.fujitsu.com>
Date: Wed, 28 Feb 2018 16:12:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180228080012.GB30207@localhost.localdomain>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: mas-tachibana@vf.jp.nec.com, indou.takao@jp.fujitsu.com, kexec@lists.infradead.org, mas-hayashi@tg.jp.nec.com

Hi Baoquan,

At 02/28/2018 04:00 PM, Baoquan He wrote:
> Hi dou,
> 
> On 02/28/18 at 03:13pm, Dou Liyang wrote:
>> this patchset adds 5-level paging support in makedumpfile
>>
>>   -the 1th patch does some cleanup for the preparation of 5-level page tables support
>>   -the 2th patch add the 5-level page tables support
>>
>> Dou Liyang (2):
>>    arch/x86_64: Cleanup the address translation of the 4-level page
>>      tables
>>    arch/x86_64: Add 5-level paging support
> 
> It doesn't work on my qemu+la57, kernel 4.16-rc1+. Not sure what kernel
> you are testing, it truly works on kernel 4.16-rc1+ when cpu la57 is not

I tested in Linux v4.15+ and v4.16-rc2+.

The following commits in linux kernel changed mem_section array and
it causes this problem in makedumpfile.

commit 83e3c48729d9ebb7af5a31a504f3fd6aff0348c4
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Fri Sep 29 17:08:16 2017 +0300

commit 629a359bdb0e0652a8227b4ff3125431995fec6e
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Tue Nov 7 11:33:37 2017 +0300

So when I tested makedumpfile, I reverted these commits from kernel
temporarily.

Thanks
	dou

> supported?
> 
> Thanks
> Baoquan
> 
>>
>>   arch/x86_64.c  | 131 +++++++++++++++++++++++++++++++++++++++++----------------
>>   makedumpfile.h |  38 +++++++++++------
>>   2 files changed, 120 insertions(+), 49 deletions(-)
>>
>> -- 
>> 2.14.3
>>
>>
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
