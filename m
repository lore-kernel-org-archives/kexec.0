Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgqLw-0007U7-Ac
	for kexec@lists.infradead.org; Tue, 01 Apr 2008 23:57:21 +0000
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	m31NvA3f002706 for <kexec@lists.infradead.org> (envelope-from
	takebe_akio@jp.fujitsu.com); Wed, 2 Apr 2008 08:57:10 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 1305253C124
	for <kexec@lists.infradead.org>; Wed,  2 Apr 2008 08:57:10 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id DED2B240097
	for <kexec@lists.infradead.org>; Wed,  2 Apr 2008 08:57:09 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4 [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C61E6161C006
	for <kexec@lists.infradead.org>; Wed,  2 Apr 2008 08:57:09 +0900 (JST)
Received: from fjm501.ms.jp.fujitsu.com (fjm501.ms.jp.fujitsu.com
	[10.56.99.71])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 35989161C00F
	for <kexec@lists.infradead.org>; Wed,  2 Apr 2008 08:57:09 +0900 (JST)
Received: from fjmscan502.ms.jp.fujitsu.com (fjmscan502.ms.jp.fujitsu.com
	[10.56.99.142])by fjm501.ms.jp.fujitsu.com with ESMTP id
	m31Nuvvk023580
	for <kexec@lists.infradead.org>; Wed, 2 Apr 2008 08:56:57 +0900
From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: Re: [Patch] fix error case of xen
Date: Wed, 02 Apr 2008 08:54:49 +0900
MIME-Version: 1.0
In-Reply-To: <47F1EA87.4030201@mxs.nes.nec.co.jp>
References: <A7C89354154DF3takebe_akio@jp.fujitsu.com>
	<47F1D054.9080307@mxs.nes.nec.co.jp>
	<47F1EA87.4030201@mxs.nes.nec.co.jp>
Message-Id: <ABC89453C582FBtakebe_akio@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Akio Takebe <takebe_akio@jp.fujitsu.com>, kexec-ml <kexec@lists.infradead.org>

Hi, Ohmichi-san

Thank you for your review.

>> Akio Takebe wrote:
>>> Curret kdump-xen with makdumpfile always return 0.
>>> So if we fail to kdump, we will get $?=0.
>>> This patch improve it.
>>>
>>> Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>
>>>
>>> --- makedumpfile/makedumpfile.c	2008-03-28 11:32:51.000000000 +0900
>>> +++ makedumpfile.mod/makedumpfile.c	2008-04-01 02:14:12.000000000 +0900
>>> @@ -993,6 +993,8 @@ get_symbol_addr(char *symname)
>>>  		if (!strcmp(sym_name, symname)) {
>>>  			symbol = sym.st_value;
>>>  			break;
>>> +		} else if (i >= (shdr.sh_size/shdr.sh_entsize)-1) {
>>> +			DEBUG_MSG("Can't get symbol of %s.\n", symname);
>> 
>> This patch is for fixing error code of xen, but the above code adds
>> the debugging message. So the above code doesn't match its purpose.
>> Is it necessary ?
>
>Sorry for incomprehensible comment.
>
>The existences of symbols depend on linux version, cpu architecture,
>and linux configuration (.config file). If the above code is merged,
>the debugging message will be big and unreadable.
>Do you want to know the lacks of necessary symbol for dump filtering 
>of Xen ?  -D option prints them.
>
Yes, that's right.
The concept of this hunk is to catch error at making vmcoreinfo file.
Current vmcoreinfo doesn't show error if some necessary symbols are not included.
Then we will find it at failing kdump.
So I wanted to add the debug message into the function finding symbol.
Since the hunk is not important, please drop it.

Best Regards,

Akio Takebe


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
