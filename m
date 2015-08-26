Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZUSGx-00079O-P8
 for kexec@lists.infradead.org; Wed, 26 Aug 2015 04:25:16 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: remove the double free of sph
Date: Wed, 26 Aug 2015 04:23:23 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DE5B70@BPXM01GP.gisp.nec.co.jp>
References: <1440559354-8252-1-git-send-email-cfan@redhat.com>
 <55DD39AB.9030505@jp.fujitsu.com>
In-Reply-To: <55DD39AB.9030505@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chao Fan <cfan@redhat.com>, "HATAYAMA, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

>On 2015/08/26 12:22, Chao Fan wrote:
>> sph will be freed twice when it meet below conditions:
>>
>>              sph->signature1 != SADUMP_SIGNATURE1 ||
>>              sph->signature2 != SADUMP_SIGNATURE2
>>
>> Then it will be freed once and goto error: to free again. So remove the
>> 1st free.
>>
>> Signed-off-by: Chao Fan <cfan@redhat.com>
>> ---
>>   sadump_info.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/sadump_info.c b/sadump_info.c
>> index e8154f4..1474fb2 100644
>> --- a/sadump_info.c
>> +++ b/sadump_info.c
>> @@ -695,7 +695,6 @@ read_sadump_header_diskset(int diskid, struct sadump_diskset_info *sdi)
>>   	if (sph->signature1 != SADUMP_SIGNATURE1 ||
>>   	    sph->signature2 != SADUMP_SIGNATURE2) {
>>   		DEBUG_MSG("sadump: does not have partition header\n");
>> -		free(sph);
>>   		goto error;
>>   	}
>>
>>
>
>Thanks! It looks good to me.
>
>Acked-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>
>--
>Thanks.
>HATAYAMA, Daisuke

I'll merge this patch into v1.5.9, thanks.

Regards,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
