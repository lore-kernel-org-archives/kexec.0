Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XmEdB-0001u3-Cu
 for kexec@lists.infradead.org; Thu, 06 Nov 2014 04:25:11 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH V3 2/5] Add tools for reading and writing from
 splitblock table
Date: Thu, 6 Nov 2014 04:20:01 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D64D51@BPXM01GP.gisp.nec.co.jp>
References: <1414662309-15241-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1414662309-15241-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D647BB@BPXM01GP.gisp.nec.co.jp>
 <5459FC90.6070406@cn.fujitsu.com>
In-Reply-To: <5459FC90.6070406@cn.fujitsu.com>
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
To: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On 11/05/2014 12:18 PM, Atsushi Kumagai wrote:
>>> +unsigned long long
>>> >+read_from_splitblock_table(char *entry)
>>> >+{
>>> >+	unsigned long long value = 0;
>>> >+	int i;
>>> >+
>>> >+	for (i = splitblock->entry_size; i>  0; i--) {
>>> >+		value = value<<  BITPERBYTE;
>>> >+		value += *(entry + i - 1)&  0xff;
>>> >+	}
>> Did you forget to reflect the HATAYAMA-san's comment ?
>>
>
>I think it is needed.
>For example:
>	if *(entry + i - 1) == 0xfa
>	without & 0xff:
>		it will turn to: value += 0xfffffffffffffffa
>	with & 0xff:
>		it will be: value += 0xfffffffffffffffa & 0xff

Ah, I see, you meant "sign extension".
OK, I understand.


Thanks,
Atsushi Kumagai

>
>Thanks
>Zhou Wenjian
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
