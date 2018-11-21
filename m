Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPODq-0001SE-HP
 for kexec@lists.infradead.org; Wed, 21 Nov 2018 08:51:00 +0000
Subject: Re: [PATCH v1 3/8] kexec: export PG_offline to VMCOREINFO
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-4-david@redhat.com>
 <20181121060458.GC7386@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ddd5a6f4-59d0-474b-45d5-3589a21ebcd4@redhat.com>
Date: Wed, 21 Nov 2018 09:50:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181121060458.GC7386@MiWiFi-R3L-srv>
Content-Language: en-US
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
To: Baoquan He <bhe@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, pv-drivers@vmware.com, linux-doc@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Borislav Petkov <bp@alien8.de>, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Omar Sandoval <osandov@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lianbo Jiang <lijiang@redhat.com>

On 21.11.18 07:04, Baoquan He wrote:
> On 11/19/18 at 11:16am, David Hildenbrand wrote:
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 933cb3e45b98..093c9f917ed0 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -464,6 +464,8 @@ static int __init crash_save_vmcoreinfo_init(void)
>>  	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
>>  #ifdef CONFIG_HUGETLB_PAGE
>>  	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
>> +#define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
>> +	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
>>  #endif
> 
> This solution looks good to me. One small concern is why we don't
> export PG_offline to vmcoreinfo directly, then define
> PAGE_OFFLINE_MAPCOUNT_VALUE in makedumpfile. We have been exporting
> kernel data/MACRO directly, why this one is exceptional.
> 

1. We are much more similar to PG_buddy (in contrast to actual page
flags), and for PG_buddy it is historically handled like this (and I
think it makes sense to expose these as actual MAPCOUNT_VALUEs).

2. Right now only one page type per page is supported. Therefore only
exactly one value in mapcount indicates e.g. PageBuddy()/PageOffline().

Now, if we ever decide to change this (e.g. treat them like real flags),
it is much easier to switch to PG_offline/PG_buddy then. We can directly
see in makedumpfile that .*_MAPCOUNT_VALUE is no longer available but
instead e.g. PG_offline and PG_buddy. Instead we would no see a change
in makedumpfile and would have to rely on other properties.

If there are no strong opinions I will leave it like this.

Thanks!

> Thanks
> Baoquan
> 


-- 

Thanks,

David / dhildenb

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
