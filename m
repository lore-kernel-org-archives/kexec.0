Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVzAE-0007nK-RM
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 07:35:36 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 0CADD3EE1D9
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 16:35:09 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F207245DD78
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 16:35:08 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D5E1845DE50
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 16:35:08 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C9B9A1DB8041
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 16:35:08 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 76A111DB803C
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 16:35:08 +0900 (JST)
Message-ID: <525CEFAB.1000303@jp.fujitsu.com>
Date: Tue, 15 Oct 2013 16:32:59 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
References: <20131014121648.1409.58312.stgit@k.asiapacific.hpqcorp.net>
 <525CD97B.3070209@jp.fujitsu.com>
In-Reply-To: <525CD97B.3070209@jp.fujitsu.com>
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

(2013/10/15 14:58), HATAYAMA Daisuke wrote:
> (2013/10/14 21:16), Jingbai Ma wrote:
> <cut>

>> @@ -2793,7 +2806,7 @@ initialize_bitmap_memory(void)
>>       bmp->offset = bitmap_offset + bitmap_len / 2;
>>       info->bitmap_memory = bmp;
>>
>> -    max_sect_len = divideup(dh->max_mapnr, BITMAP_SECT_LEN);
>> +    max_sect_len = divideup(kh->max_mapnr_64, BITMAP_SECT_LEN);
>>       info->valid_pages = calloc(sizeof(ulong), max_sect_len);
>
> Ah, please here needs to be fixed, too. Here should have been
> used sizeof(int) but now sizeof(off_t) should be used.
>

This is wrong. Please ignore.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
