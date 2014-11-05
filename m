Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xlxvo-00053B-8T
 for kexec@lists.infradead.org; Wed, 05 Nov 2014 10:35:17 +0000
Message-ID: <5459FC90.6070406@cn.fujitsu.com>
Date: Wed, 5 Nov 2014 18:31:44 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH V3 2/5] Add tools for reading and writing from splitblock
 table
References: <1414662309-15241-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1414662309-15241-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D647BB@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D647BB@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 11/05/2014 12:18 PM, Atsushi Kumagai wrote:
>> +unsigned long long
>> >+read_from_splitblock_table(char *entry)
>> >+{
>> >+	unsigned long long value = 0;
>> >+	int i;
>> >+
>> >+	for (i = splitblock->entry_size; i>  0; i--) {
>> >+		value = value<<  BITPERBYTE;
>> >+		value += *(entry + i - 1)&  0xff;
>> >+	}
> Did you forget to reflect the HATAYAMA-san's comment ?
>

I think it is needed.
For example:
	if *(entry + i - 1) == 0xfa
	without & 0xff:
		it will turn to: value += 0xfffffffffffffffa
	with & 0xff:
		it will be: value += 0xfffffffffffffffa & 0xff

Thanks
Zhou Wenjian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
