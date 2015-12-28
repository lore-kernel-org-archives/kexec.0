Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aDN4a-0007vP-C7
 for kexec@lists.infradead.org; Mon, 28 Dec 2015 01:58:09 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (Postfix) with ESMTPS id 4479E57
 for <kexec@lists.infradead.org>; Mon, 28 Dec 2015 01:57:47 +0000 (UTC)
Received: from dhcp-128-28.nay.redhat.com ([10.66.129.152])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 tBS1vjfo005854
 for <kexec@lists.infradead.org>; Sun, 27 Dec 2015 20:57:46 -0500
Subject: Re: [PATCH 2/2] kexec: Provide
 arch_kexec_protect(unprotect)_crashkres()
References: <1450869146-6186-1-git-send-email-xlpang@redhat.com>
 <1450869146-6186-2-git-send-email-xlpang@redhat.com>
 <20151226152100.GA26946@dhcp-128-25.nay.redhat.com>
From: Xunlei Pang <xlpang@redhat.com>
Message-ID: <56809718.1050700@redhat.com>
Date: Mon, 28 Dec 2015 09:57:44 +0800
MIME-Version: 1.0
In-Reply-To: <20151226152100.GA26946@dhcp-128-25.nay.redhat.com>
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
To: kexec@lists.infradead.org

On 12/26/2015 at 11:21 PM, Minfei Huang wrote:
> On 12/23/15 at 07:12pm, Xunlei Pang wrote:
>> Implement the protection method for the crash kernel memory
>> reservation for the 64-bit x86 kdump.
>>
>> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
>> ---
>> Only provided x86_64 implementation, as I've only tested on x86_64 so far.
>>
>>  arch/x86/kernel/machine_kexec_64.c | 43 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 819ab3f..a3d289c 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -536,3 +536,46 @@ overflow:
>>  	return -ENOEXEC;
>>  }
>>  #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#ifdef CONFIG_KEXEC_CORE
>> +static int
>> +kexec_mark_range(unsigned long start, unsigned long end, bool protect)
>> +{
>> +	struct page *page;
>> +	unsigned int nr_pages;
>> +
>> +	if (!start || !end || start >= end)
>> +		return 0;
>> +
>> +	page = pfn_to_page(start >> PAGE_SHIFT);
>> +	nr_pages = (end + 1 - start) >> PAGE_SHIFT;
> The start and end may across two pages, although the range is small than
> PAGE_SIZE. You can use following to calculate count of page.
>
> nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;

For subpage ranges, you're right. I'll adjust this, thanks!

Regards,
Xunlei

>
> Thanks
> Minfei
>
>> +	if (protect)
>> +		return set_pages_ro(page, nr_pages);
>> +	else
>> +		return set_pages_rw(page, nr_pages);
>> +}
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
