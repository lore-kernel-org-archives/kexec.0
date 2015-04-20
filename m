Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yk2EU-0001V0-TT
 for kexec@lists.infradead.org; Mon, 20 Apr 2015 03:18:51 +0000
Message-ID: <55347000.8030201@redhat.com>
Date: Mon, 20 Apr 2015 08:48:24 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 2/6] purgatory: No need to sha256 update if ptr->len
 is zero
References: <cover.1429201849.git.panand@redhat.com>
 <a66d1e193a9bd27e940edfbb56ca521556e95b39.1429201849.git.panand@redhat.com>
 <20150420030108.GE15033@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20150420030108.GE15033@dhcp-16-116.nay.redhat.com>
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
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org



On Monday 20 April 2015 08:31 AM, Baoquan He wrote:
> On 04/16/15 at 10:17pm, Pratyush Anand wrote:
>> If ptr->len is zero we do not need to update sha256.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>>   purgatory/purgatory.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
>> index 3bbcc0935ad5..f8ed69b8fbfb 100644
>> --- a/purgatory/purgatory.c
>> +++ b/purgatory/purgatory.c
>> @@ -18,6 +18,8 @@ int verify_sha256_digest(void)
>>   	sha256_starts(&ctx);
>>   	end = &sha256_regions[sizeof(sha256_regions)/sizeof(sha256_regions[0])];
>>   	for(ptr = sha256_regions; ptr < end; ptr++) {
>> +		if (ptr->len == 0)
>> +			continue;
>
> Hi Pratyush,
>
> I don't think this is necessary, but don't object to it strongly.
> Since sha256_update will check the length and return immediately if it's
> 0.
>


I think you are right, we can skip this.

~Pratyush

> void sha256_update( sha256_context *ctx, const uint8_t *input, size_t
> length )
> {
>          size_t left, fill;
>
>          if( ! length ) return;
>
> ...
> }
>
> Thanks
> Baoquan
>
>>   		sha256_update(&ctx, (uint8_t *)((uintptr_t)ptr->start),
>>   			      ptr->len);
>>   	}
>> --
>> 2.1.0
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
