Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T8N9l-0003nJ-0G
 for kexec@lists.infradead.org; Mon, 03 Sep 2012 03:16:58 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 5FE4E3EE0BD
 for <kexec@lists.infradead.org>; Mon,  3 Sep 2012 12:16:54 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4B2E345DE3E
 for <kexec@lists.infradead.org>; Mon,  3 Sep 2012 12:16:54 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 30C8A45DE55
 for <kexec@lists.infradead.org>; Mon,  3 Sep 2012 12:16:54 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1524AE08003
 for <kexec@lists.infradead.org>; Mon,  3 Sep 2012 12:16:54 +0900 (JST)
Received: from m025.s.css.fujitsu.com (m025.s.css.fujitsu.com [10.0.81.65])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id C7FB11DB804E
 for <kexec@lists.infradead.org>; Mon,  3 Sep 2012 12:16:53 +0900 (JST)
Date: Mon, 03 Sep 2012 12:16:37 +0900 (JST)
Message-Id: <20120903.121637.204037088.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep
 memory usage constant.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120903.115057.275187572.d.hatayama@jp.fujitsu.com>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
 <20120830164521.0b07c16fe2993dd8afafc79b@mxc.nes.nec.co.jp>
 <20120903.115057.275187572.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep memory usage constant.
Date: Mon, 3 Sep 2012 11:50:57 +0900

> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Subject: [PATCH 01/16] [PATCH v3 1/12] Introduce cyclic mode to keep memory usage constant.
> Date: Thu, 30 Aug 2012 16:45:21 +0900
> 
> <cut>
> 
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index d024e95..21bb55a 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -2553,6 +2553,8 @@ initial(void)
>>  							info->name_memory);
>>  			return FALSE;
>>  		}
>> +		info->flag_cyclic = FALSE;
>> +
> 
> Please disable cyclic mode on sadump dumpfiles, too.
> 

Also, there's no information to users about disabling cyclic mode.
Now switching from cyclic to normal mode is implicitly done. This is
confusing. I think some message indicating that, is necessary.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
