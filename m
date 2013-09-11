Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJfvW-0007Ej-Fy
 for kexec@lists.infradead.org; Wed, 11 Sep 2013 08:37:31 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 0266A44DD82
 for <kexec@lists.infradead.org>; Wed, 11 Sep 2013 17:37:01 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id E155845DE54
 for <kexec@lists.infradead.org>; Wed, 11 Sep 2013 17:37:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id C392A45DD78
 for <kexec@lists.infradead.org>; Wed, 11 Sep 2013 17:37:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 88CF01DB8053
 for <kexec@lists.infradead.org>; Wed, 11 Sep 2013 17:37:00 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1E0C41DB803C
 for <kexec@lists.infradead.org>; Wed, 11 Sep 2013 17:36:56 +0900 (JST)
Message-ID: <52302B6D.8060103@jp.fujitsu.com>
Date: Wed, 11 Sep 2013 17:35:57 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 10/10] Warn cyclic buffer overrun and correct it if
 possible
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
 <20121116050223.8280.12865.stgit@localhost6.localdomain6>
 <52302103.5000304@mxc.nes.nec.co.jp>
In-Reply-To: <52302103.5000304@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

(2013/09/11 16:51), Atsushi Kumagai wrote:
> Hello HATAYAMA-san,
>
> (2012/11/16 14:02), HATAYAMA Daisuke wrote:
>> Clearling bits on cyclic buffer can overrun the cyclic buffer
>> according to some combination of MAX_ORDER and cyclic buffer size.
>>
>> The cyclic buffer size is corrected if possible.
>>
>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>
> I know it's so late, I found that updating pfn_cyclic is missing.
> It can cause memory corruption.
>

Hello Kumagai-san,

Reviewed-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

It might be even better to introduce some kind of helper function that
sets up these cyclic-mode-related parameters and then to use it in
initial() and check_cyclic_buffer_overrun().

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
