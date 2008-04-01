Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgbLX-0006NI-Ql
	for kexec@lists.infradead.org; Tue, 01 Apr 2008 07:55:56 +0000
Message-Id: <47F1EA87.4030201@mxs.nes.nec.co.jp>
Date: Tue, 01 Apr 2008 16:55:51 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [Patch] fix error case of xen
References: <A7C89354154DF3takebe_akio@jp.fujitsu.com>
	<47F1D054.9080307@mxs.nes.nec.co.jp>
In-Reply-To: <47F1D054.9080307@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0116907031=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Akio Takebe <takebe_akio@jp.fujitsu.com>
Cc: kexec-ml <kexec@lists.infradead.org>

--===============0116907031==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Takebe-san,

Ken'ichi Ohmichi wrote:
> Hi Takebe-san,
> 
> Thank you for the patch.
> 
> Akio Takebe wrote:
>> Curret kdump-xen with makdumpfile always return 0.
>> So if we fail to kdump, we will get $?=0.
>> This patch improve it.
>>
>> Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>
>>
>> --- makedumpfile/makedumpfile.c	2008-03-28 11:32:51.000000000 +0900
>> +++ makedumpfile.mod/makedumpfile.c	2008-04-01 02:14:12.000000000 +0900
>> @@ -993,6 +993,8 @@ get_symbol_addr(char *symname)
>>  		if (!strcmp(sym_name, symname)) {
>>  			symbol = sym.st_value;
>>  			break;
>> +		} else if (i >= (shdr.sh_size/shdr.sh_entsize)-1) {
>> +			DEBUG_MSG("Can't get symbol of %s.\n", symname);
> 
> This patch is for fixing error code of xen, but the above code adds
> the debugging message. So the above code doesn't match its purpose.
> Is it necessary ?

Sorry for incomprehensible comment.

The existences of symbols depend on linux version, cpu architecture,
and linux configuration (.config file). If the above code is merged,
the debugging message will be big and unreadable.
Do you want to know the lacks of necessary symbol for dump filtering 
of Xen ?  -D option prints them.


Thanks
Ken'ichi Ohmichi


--===============0116907031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0116907031==--
