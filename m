Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPOHj-0002Cl-Vx
 for kexec@lists.infradead.org; Wed, 21 Nov 2018 08:55:01 +0000
Subject: Re: [PATCH v1 6/8] vmw_balloon: mark inflated pages PG_offline
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-7-david@redhat.com>
 <9F78496F-EBAE-4248-80F0-0CB55CEFA238@vmware.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b62e3d4b-f8ff-8e6c-c1b4-b36d5d32179d@redhat.com>
Date: Wed, 21 Nov 2018 09:54:29 +0100
MIME-Version: 1.0
In-Reply-To: <9F78496F-EBAE-4248-80F0-0CB55CEFA238@vmware.com>
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
To: Nadav Amit <namit@vmware.com>
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, pv-drivers <pv-drivers@vmware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kexec-ml <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Julien Freche <jfreche@vmware.com>, Xavier Deguillard <xdeguillard@vmware.com>, xen-devel <xen-devel@lists.xenproject.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Andrew Morton <akpm@linux-foundation.org>

On 21.11.18 04:22, Nadav Amit wrote:
> Thanks for this patch!
> 
>> On Nov 19, 2018, at 2:16 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> Mark inflated and never onlined pages PG_offline, to tell the world that
>> the content is stale and should not be dumped.
>>
>> Cc: Xavier Deguillard <xdeguillard@vmware.com>
>> Cc: Nadav Amit <namit@vmware.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Julien Freche <jfreche@vmware.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> drivers/misc/vmw_balloon.c | 32 ++++++++++++++++++++++++++++++++
>> 1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>> index e6126a4b95d3..8cc8bd9a4e32 100644
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@ -544,6 +544,36 @@ unsigned int vmballoon_page_order(enum vmballoon_page_size_type page_size)
>> 	return page_size == VMW_BALLOON_2M_PAGE ? VMW_BALLOON_2M_ORDER : 0;
>> }
>>
>> +/**
>> + * vmballoon_mark_page_offline() - mark a page as offline
>> + * @page: pointer for the page
> 
> If possible, please add a period at the end of the sentence (yes, I know I
> got it wrong in some places too).

Sure :)

> 
>> + * @page_size: the size of the page.
>> + */
>> +static void
>> +vmballoon_mark_page_offline(struct page *page,
>> +			    enum vmballoon_page_size_type page_size)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < 1ULL << vmballoon_page_order(page_size); i++)
> 
> Can you please do instead:
> 
> 	unsigned int;
> 
> 	for (i = 0; i < vmballoon_page_in_frames(page_size); i++)
> 

Will do, will have to move both functions a little bit down in the file
(exactly one function).


> We would like to test it in the next few days, but in the meanwhile, after
> you address these minor issues:
> 
> Acked-by: Nadav Amit <namit@vmware.com>

Thanks!

> 
> Thanks again,
> Nadav 
> 


-- 

Thanks,

David / dhildenb

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
