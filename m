Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOjHY-00081Z-UA
 for kexec@lists.infradead.org; Mon, 19 Nov 2018 13:08:05 +0000
Subject: Re: [PATCH v1 4/8] xen/balloon: mark inflated pages PG_offline
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-5-david@redhat.com>
 <fc69e0cf-c005-472a-b3f6-09d0c963cf52@suse.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <554d4e68-8fa9-6849-8480-fc9446bea79d@redhat.com>
Date: Mon, 19 Nov 2018 14:07:18 +0100
MIME-Version: 1.0
In-Reply-To: <fc69e0cf-c005-472a-b3f6-09d0c963cf52@suse.com>
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
To: Juergen Gross <jgross@suse.com>, linux-mm@kvack.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, linux-pm@vger.kernel.org, pv-drivers@vmware.com, linux-doc@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

On 19.11.18 13:22, Juergen Gross wrote:
> On 19/11/2018 11:16, David Hildenbrand wrote:
>> Mark inflated and never onlined pages PG_offline, to tell the world that
>> the content is stale and should not be dumped.
>>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/xen/balloon.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>> index 12148289debd..14dd6b814db3 100644
>> --- a/drivers/xen/balloon.c
>> +++ b/drivers/xen/balloon.c
>> @@ -425,6 +425,7 @@ static int xen_bring_pgs_online(struct page *pg, unsigned int order)
>>  	for (i = 0; i < size; i++) {
>>  		p = pfn_to_page(start_pfn + i);
>>  		__online_page_set_limits(p);
>> +		__SetPageOffline(p);
>>  		__balloon_append(p);
>>  	}
> 
> This seems not to be based on current master. Could you please tell
> against which tree this should be reviewed?
> 
Hi Juergen,

this is based on linux-next/master.

Thanks!

> 
> Juergen
> 


-- 

Thanks,

David / dhildenb

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
