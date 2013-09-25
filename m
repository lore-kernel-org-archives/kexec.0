Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOkrz-000102-Of
 for kexec@lists.infradead.org; Wed, 25 Sep 2013 08:54:53 +0000
Message-ID: <5242A4BF.5090903@hp.com>
Date: Wed, 25 Sep 2013 16:54:23 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
References: <20130924124931.14715.24507.stgit@k.asiapacific.hpqcorp.net>
 <52422FCF.1030206@jp.fujitsu.com> <52429BF1.3050303@hp.com>
 <5242A13B.6000907@jp.fujitsu.com>
In-Reply-To: <5242A13B.6000907@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, chaowang@redhat.com, lisa.mitchell@hp.com, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, anderson@redhat.com, vgoyal@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, Jingbai Ma <jingbai.ma@hp.com>, crash-utility@redhat.com

On 09/25/2013 04:39 PM, HATAYAMA Daisuke wrote:
> (2013/09/25 17:16), Jingbai Ma wrote:
> <cut>
>>>
>>>> @@ -5153,10 +5160,11 @@ write_kdump_header(void)
>>>> * Write common header
>>>> */
>>>> strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
>>>> - dh->header_version = 5;
>>>> + dh->header_version = 6;
>>>> dh->block_size = info->page_size;
>>>> dh->sub_hdr_size = sizeof(kh) + size_note;
>>>> dh->sub_hdr_size = divideup(dh->sub_hdr_size, dh->block_size);
>>>> + /* dh->max_mapnr may be truncated here, full 64bit in kh.max_mapnr */
>>>> dh->max_mapnr = info->max_mapnr;
>>>
>>> dh->max_mapnr = MIN(info->max_mapnr, UINT_MAX) seems better for old
>>> versions of crash utitlity.
>>>
>>
>> Although change this value to UINT_MAX doesn't help the old crash
>> utility very much. At least this special value will tell the user
>> something happened.
>> Will fix it.
>>
>>
>
> This is the largest page frame number old crash utilities can represent,
> not special value.
> By this, old crash utilities can read at least the pages less than
> UINT_MAX,
> which is better than making dh->max_mapnr overflow; then dh->max_mapnr
> would typically become
> a small number.
>

I knew, but crash utility may still report reading page error before its 
command prompt.
Anyway, UINT_MAX has a better chance to make old utility happy, so I 
will fix it. :)

-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
