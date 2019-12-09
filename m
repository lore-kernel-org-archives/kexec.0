Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieCBG-0000kR-KV
 for kexec@lists.infradead.org; Mon, 09 Dec 2019 06:06:04 +0000
Subject: Re: [PATCH] makedumpfile: assign bitmap2 fd for sub process during
 refiltering
References: <1575358627-17152-1-git-send-email-piliu@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035977E6@BPXM09GP.gisp.nec.co.jp>
From: piliu <piliu@redhat.com>
Message-ID: <0d793e2d-6698-6543-13de-a3de8732df75@redhat.com>
Date: Mon, 9 Dec 2019 14:05:54 +0800
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035977E6@BPXM09GP.gisp.nec.co.jp>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On 12/07/2019 06:11 AM, Kazuhito Hagio wrote:
> Hi Pingfan,
> 
>> -----Original Message-----
>> In refiltering mode, each sub process inherits bitmap2->fd from parent.
>> Then they lseek()/read() on the same fd, which means that they interference
>> with each other.
>>
>> This breaks the purpose of SPLITTING_FD_BITMAP(i) for each sub process.
>> Fix it by assigning a sub process dedicated fd to bitmap2->fd.
>>
>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> 
> Thanks for the patch.
> I'm still reading the code, but it might be better to apply this to bitmap1->fd
> as well?  see you next week..
Yes. Although during my test, bitmap1 is not touched, but it is a
reasonable step to against any future bug.

Thanks,
Pingfan
> 
> Thanks,
> Kazu
> 
>> ---
>>  makedumpfile.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index d76a435..1dc8640 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -8857,7 +8857,8 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>>  	if (info->flag_cyclic) {
>>  		if (!prepare_bitmap2_buffer())
>>  			return FALSE;
>> -	}
>> +	} else if (info->flag_refiltering)
>> +		info->bitmap2->fd = info->fd_bitmap;
>>
>>  	/*
>>  	 * Write pages and bitmap cyclically.
>> --
>> 2.7.5
>>
> 
> 
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
