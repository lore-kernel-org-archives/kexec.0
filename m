Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOkfB-0000Cu-O5
 for kexec@lists.infradead.org; Wed, 25 Sep 2013 08:41:38 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 67FE73EE1D8
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 17:41:11 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 82F6745DE58
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 17:41:07 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4BD2645DE60
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 17:41:07 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2EEF31DB8046
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 17:41:07 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D33351DB8040
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 17:41:06 +0900 (JST)
Message-ID: <5242A13B.6000907@jp.fujitsu.com>
Date: Wed, 25 Sep 2013 17:39:23 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
References: <20130924124931.14715.24507.stgit@k.asiapacific.hpqcorp.net>
 <52422FCF.1030206@jp.fujitsu.com> <52429BF1.3050303@hp.com>
In-Reply-To: <52429BF1.3050303@hp.com>
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
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, lisa.mitchell@hp.com, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, anderson@redhat.com, chaowang@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, vgoyal@redhat.com, crash-utility@redhat.com

(2013/09/25 17:16), Jingbai Ma wrote:
<cut>
>>
>>> @@ -5153,10 +5160,11 @@ write_kdump_header(void)
>>> * Write common header
>>> */
>>> strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
>>> - dh->header_version = 5;
>>> + dh->header_version = 6;
>>> dh->block_size = info->page_size;
>>> dh->sub_hdr_size = sizeof(kh) + size_note;
>>> dh->sub_hdr_size = divideup(dh->sub_hdr_size, dh->block_size);
>>> + /* dh->max_mapnr may be truncated here, full 64bit in kh.max_mapnr */
>>> dh->max_mapnr = info->max_mapnr;
>>
>> dh->max_mapnr = MIN(info->max_mapnr, UINT_MAX) seems better for old
>> versions of crash utitlity.
>>
>
> Although change this value to UINT_MAX doesn't help the old crash utility very much. At least this special value will tell the user something happened.
> Will fix it.
>
>

This is the largest page frame number old crash utilities can represent, not special value.
By this, old crash utilities can read at least the pages less than UINT_MAX,
which is better than making dh->max_mapnr overflow; then dh->max_mapnr would typically become
a small number.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
