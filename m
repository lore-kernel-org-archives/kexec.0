Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbjvE-0006Yk-N1
 for kexec@lists.infradead.org; Thu, 31 Oct 2013 04:31:54 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 24C293EE0BB
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:31:22 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 13E8E45DEBA
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:31:22 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id F049945DEB7
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:31:21 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E43F11DB8038
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:31:21 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 973DEE18001
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:31:21 +0900 (JST)
Message-ID: <5271DC51.6040200@jp.fujitsu.com>
Date: Thu, 31 Oct 2013 13:28:01 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] Write out a whole part of the 1st bitmap before
 entering cyclic process
References: <20131024065015.5291.51864.stgit@localhost6.localdomain6>
 <20131024065205.5291.37035.stgit@localhost6.localdomain6>
 <0910DD04CBD6DE4193FCF86B9C00BE971BA5FD@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971BA5FD@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

(2013/10/30 19:52), Atsushi Kumagai wrote:
> (2013/10/24 15:52), HATAYAMA Daisuke wrote:
>> Currently, 1st bitmap is created during cyclic process, but the
>> information represented by the 1st bitmap, originally present memory,
>> is still available from ELF program header table, so we don't need to
>> keep the 1st bitmap even in cyclic process.
>>
>> Supported is a conversion from ELF to kdump-compressed format only,
>> not from ELF to ELF.
>>
>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> ---
>>    makedumpfile.c |  224 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>>    1 file changed, 202 insertions(+), 22 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 4b6c0ed..7440c97 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -3055,7 +3055,8 @@ out:
>>    				 * bufsize_cyclic is used to allocate 1st and 2nd bitmap,
>>    				 * so it should be truncated to the half of free_memory.
>>    				 */
>> -				info->bufsize_cyclic = free_memory / 2;
>> +				if (info->flag_elf_dumpfile)
>> +					info->bufsize_cyclic = free_memory / 2;
>>    			}
>>    		}
> 
> I think here should be changed like below:
> 
> 		if (info->flag_elf_dumpfile)
> 			info->bufsize_cyclic = free_memory / 2;
> 		else
> 			info->bufsize_cyclic = free_memory;
> 

Thanks. I'll fix this.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
