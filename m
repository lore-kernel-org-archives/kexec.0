Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xls57-0001sS-VB
 for kexec@lists.infradead.org; Wed, 05 Nov 2014 04:20:30 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH V3 2/5] Add tools for reading and writing from
 splitblock table
Date: Wed, 5 Nov 2014 04:18:11 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D647BB@BPXM01GP.gisp.nec.co.jp>
References: <1414662309-15241-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1414662309-15241-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1414662309-15241-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

>The function added in this patch, is used for writing and reading value
>from the char array in struct SplitBlock.
>
>Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
>Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>---
> makedumpfile.c |   29 +++++++++++++++++++++++++++++
> 1 files changed, 29 insertions(+), 0 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 7017943..f86dfd2 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -5716,6 +5716,35 @@ calculate_entry_size(void)
> 	return entry_size;
> }
>
>+void
>+write_into_splitblock_table(char *entry,
>+				unsigned long long value)
>+{
>+	char temp;
>+	int i = 0;
>+
>+	while (i++ < splitblock->entry_size) {
>+		temp = value & 0xff;
>+		value = value >> BITPERBYTE;
>+		*entry = temp;
>+		entry++;
>+	}
>+}
>+
>+unsigned long long
>+read_from_splitblock_table(char *entry)
>+{
>+	unsigned long long value = 0;
>+	int i;
>+
>+	for (i = splitblock->entry_size; i > 0; i--) {
>+		value = value << BITPERBYTE;
>+		value += *(entry + i - 1) & 0xff;
>+	}

Did you forget to reflect the HATAYAMA-san's comment ?

>> +	for (i = splitblock->entry_size; i > 0; i--) {
>> +		ret = ret << BITPERBYTE;
>> +		ret += *(splitblock_inner + i - 1) & 0xff;
>
> The & 0xff is necessary? because splitblock_inner is of type char *.


Thanks,
Atsushi Kumagai

>+
>+	return value;
>+}
>+
> mdf_pfn_t
> get_num_dumpable(void)
> {
>--
>1.7.1
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
