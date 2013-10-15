Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVzw1-0000VW-8s
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 08:24:59 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7EFDB3EE0AE
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 17:24:30 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7275E45DEB5
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 17:24:30 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5840245DEB7
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 17:24:30 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4BD351DB803C
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 17:24:30 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 032EA1DB803F
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 17:24:30 +0900 (JST)
Message-ID: <525CFB45.8020502@jp.fujitsu.com>
Date: Tue, 15 Oct 2013 17:22:29 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
References: <20131014121648.1409.58312.stgit@k.asiapacific.hpqcorp.net>
 <525CD97B.3070209@jp.fujitsu.com> <525CF507.7000705@hp.com>
In-Reply-To: <525CF507.7000705@hp.com>
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
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, lisa.mitchell@hp.com, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, anderson@redhat.com, vgoyal@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, chaowang@redhat.com, crash-utility@redhat.com

(2013/10/15 16:55), Jingbai Ma wrote:
> On 10/15/2013 01:58 PM, HATAYAMA Daisuke wrote:
>> (2013/10/14 21:16), Jingbai Ma wrote:
>> <cut>
>>> @@ -125,7 +126,7 @@ get_max_mapnr(void)
>>> unsigned long long max_paddr;
>>>
>>> if (info->flag_refiltering) {
>>> - info->max_mapnr = info->dh_memory->max_mapnr;
>>> + info->max_mapnr = info->kh_memory->max_mapnr_64;
>>> return TRUE;
>>> }
>>>
>>
>> Please:
>>
>> if (dh.header_version < 6)
>> info->max_mapnr = info->dh_memmory->max_mapnr;
>> else
>> info->max_mapnr = info->kh_memory->max_mapnr_64;
>
> If we deal the max_mapnr_64 as below I did, we do not have to check header_version everywhere when we need to the value max_mapnr. I just set it to max_mapnr_64 regardless it's old version or new in the first place we get it. It can simplify the code logic in all code. Or we have to add this version check, it's also error prone.
>

No, it complicates code logic in the sense that header on the memory and
header on the disk are not identical.

It seems to me that the case where checking header version is definitely
necessary is only when assigning either of max_mapnr values to info->max_mapnr,
after which, it's enough to refer to info->max_mapnr.

>>
>>> @@ -783,6 +784,10 @@ get_kdump_compressed_header_info(char *filename)
>>> ERRMSG("header does not have dump_level member\n");
>>> return FALSE;
>>> }
>>> +
>>> + if (dh.header_version < 6)
>>> + kh.max_mapnr_64 = dh.max_mapnr;
>>> +
>>
>> Again, please don't do this. It's confusing if in-memory header data
>> is not identical to in-disk one.
>>
>
> I have explained the reason why I set the kh.max_mapnr_64 for old version here.
> If you still think we shouldn't change this value, and should check header_version everywhere when need max_mapnr, I will send a new version to change it.
>
>


-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
