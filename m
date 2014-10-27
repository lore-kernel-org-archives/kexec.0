Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xif8E-0004bF-1t
 for kexec@lists.infradead.org; Mon, 27 Oct 2014 07:54:28 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 0/5] makedumpfile: --split: assign fair I/O workloads
 in appropriate time
Date: Mon, 27 Oct 2014 07:51:56 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D58CD3@BPXM01GP.gisp.nec.co.jp>
References: <1413192866-28140-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D565C0@BPXM01GP.gisp.nec.co.jp>
 <54470DDD.6040700@cn.fujitsu.com>
In-Reply-To: <54470DDD.6040700@cn.fujitsu.com>
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

Hello Zhou,

>On 10/17/2014 11:50 AM, Atsushi Kumagai wrote:
>> Hello,
>>
>> The code looks good to me, thanks Zhou.
>> Now, I have a question on performance.
>>
>>> The issue is discussed at http://lists.infradead.org/pipermail/kexec/2014-March/011289.html
>>>
>>> This patch implements the idea of 2-pass algorhythm with smaller memory to manage splitblock table.
>>> Exactly the algorhythm is still 3-pass,but the time of second pass is much shorter.
>>> The tables below show the performence with different size of cyclic-buffer and splitblock.
>>> The test is executed on the machine having 128G memory.
>>>
>>> the value is total time (including first pass and second pass).
>>> the value in brackets is the time of second pass.
>>
>> Do you have any idea why the time of second pass is much larger when
>> the splitblock-size is 2G ? I worry about the scalability.
>>
>Hello,
>
>	Since the previous machine can't be used for some reasons,I test several times using latest code
>in others, but that never happened. It seems that all things are right. Tests are executed in two machines(server,pc).
>Tests are based on:

Well...OK, I'll take that as an issue specific to that machine
(or your mistakes as you said).
Now I have another question.

calculate_end_pfn_by_splitblock():
	...
        /* deal with incomplete splitblock */
        if (pfn_needed_by_per_dumpfile < 0) {
                --*current_splitblock;
                splitblock_inner -= splitblock->entry_size;
                end_pfn = CURRENT_SPLITBLOCK_PFN_NUM;
                *current_splitblock_pfns = (-1) * pfn_needed_by_per_dumpfile;
                pfn_needed_by_per_dumpfile += read_value_from_splitblock_table(splitblock_inner);
                end_pfn = calculate_end_pfn_in_cycle(CURRENT_SPLITBLOCK_PFN_NUM,
                                                     CURRENT_SPLITBLOCK_PFN_NUM + splitblock->page_per_splitblock,
                                                     end_pfn,pfn_needed_by_per_dumpfile);
        }

This block causes the re-scanning for the cycle corresponding to the
current_splitblock, so the larger cyc-buf, the longer the time takes.
If cyc-buf is 4096 (this means the number of cycle is 1), the whole page
scanning will be done in the second pass. Actually, the performance when
cyc-buf=4096 was so bad.

Is this process necessary ? I think splitting splitblocks is overkill
because I understood that splblk-size is the granularity of the
fairness I/O, tuning splblk-size is a trade off between fairness and
memory usage.
However, there is no advantage to reducing splblk-size in the current
implementation, it just consumes large amounts of memory.
If we remove the process, we can avoid the whole page scanning in
the second pass and reducing splblk-size will be meaningful as I
expected.


Thanks
Atsushi Kumagai


>		test1:
>			machine:	server
>			crashkernel:	512M
>			vmcore:		/proc/vmcore (128G)
>
>
>		test2:
>			machine:	pc
>			crashkernel:	256M
>			vmcore:		vmcore dumped from the server
>
>		test3:
>			machine:	pc
>			crashkernel:	128M
>			vmcore:		vmcore dumped from the server
>
>
>
>test1:
>													      sec
>		cyc-buf	2		4		8		16		32		64
>	splblk-size
>	2M		1.53(0.00)	1.24(0.00)	1.08(0.01)	0.99(0.01)	0.95(0.01)	0.95(0.04)
>	4M		1.52(0.00)	1.24(0.00)	1.08(0.01)	0.99(0.01)	0.95(0.01)	0.96(0.04)
>	8M		1.53(0.00)	1.23(0.00)	1.08(0.01)	0.99(0.01)	0.95(0.01)	0.95(0.04)
>	16M		1.53(0.00)	1.24(0.00)	1.08(0.01)	1.00(0.01)	0.94(0.01)	0.96(0.04)
>	32M		1.52(0.00)	1.25(0.00)	1.08(0.01)	0.99(0.01)	0.94(0.01)	0.96(0.05)
>	64M		1.52(0.00)	1.23(0.00)	1.07(0.01)	0.99(0.01)	0.97(0.01)	0.96(0.05)
>	128M		1.54(0.01)	1.25(0.01)	1.08(0.01)	0.99(0.01)	0.96(0.02)	0.96(0.05)
>	256M		1.53(0.01)	1.25(0.01)	1.08(0.01)	0.99(0.01)	0.95(0.02)	0.96(0.05)
>	512M		1.53(0.01)	1.25(0.01)	1.07(0.01)	1.01(0.02)	0.95(0.02)	0.96(0.05)
>	1G		1.54(0.02)	1.25(0.02)	1.08(0.02)	1.00(0.02)	0.96(0.03)	0.97(0.06)
>	2G		1.59(0.07)	1.30(0.06)	1.11(0.05)	1.04(0.06)	1.00(0.07)	0.98(0.07)
>	4G		1.60(0.08)	1.31(0.07)	1.14(0.07)	1.05(0.07)	1.02(0.08)	1.00(0.08)
>	8G		1.60(0.08)	1.31(0.07)	1.14(0.07)	1.05(0.07)	1.02(0.08)	0.99(0.08)
>	16G		1.60(0.08)	1.30(0.07)	1.14(0.07)	1.05(0.07)	1.02(0.08)	0.99(0.08)
>
>		cyc-buf	128		256		512		1024		2048		4096
>	splblk-size
>	2M		0.95(0.04)	0.94(0.04)	0.94(0.04)	0.95(0.05)	0.94(0.05)	1.68(0.78)
>	4M		0.95(0.04)	0.94(0.04)	0.94(0.04)	0.95(0.05)	0.94(0.05)	1.67(0.78)
>	8M		0.94(0.04)	0.94(0.04)	0.94(0.04)	0.95(0.05)	0.95(0.05)	1.68(0.78)
>	16M		0.96(0.05)	0.94(0.04)	0.95(0.05)	0.94(0.04)	0.94(0.05)	1.68(0.78)
>	32M		0.95(0.05)	0.94(0.05)	0.94(0.05)	0.94(0.05)	0.94(0.05)	1.68(0.78)
>	64M		0.96(0.05)	0.95(0.05)	0.94(0.05)	0.94(0.05)	0.95(0.05)	1.67(0.78)
>	128M		0.96(0.05)	0.95(0.05)	0.95(0.05)	0.95(0.05)	0.94(0.05)	1.67(0.78)
>	256M		0.95(0.05)	0.95(0.05)	0.95(0.05)	0.94(0.05)	0.94(0.05)	1.67(0.78)
>	512M		0.96(0.05)	0.95(0.05)	0.94(0.05)	0.94(0.05)	0.95(0.05)	1.68(0.79)
>	1G		0.96(0.06)	0.96(0.06)	0.97(0.06)	0.96(0.06)	0.96(0.07)	1.69(0.80)
>	2G		0.97(0.07)	0.97(0.07)	0.97(0.07)	0.96(0.07)	0.96(0.07)	1.70(0.80)
>	4G		1.02(0.10)	1.00(0.10)	0.99(0.10)	1.00(0.10)	0.99(0.10)	1.74(0.84)
>	8G		1.00(0.10)	1.06(0.16)	1.05(0.16)	1.05(0.16)	1.06(0.16)	1.78(0.89)
>	16G		1.00(0.10)	1.06(0.16)	1.16(0.26)	1.16(0.26)	1.15(0.26)	1.90(1.00)
>
>
>
>
>test2:
>														sec
>		cyc-buf	2		4		8		16		32		64
>	splblk-size
>	2M		23.42(0.03)	23.38(0.05)	23.46(0.11)	23.56(0.17)	23.56(0.23)	23.84(0.48)
>	4M		23.35(0.03)	23.35(0.05)	23.56(0.11)	23.51(0.17)	23.60(0.22)	23.81(0.48)
>	8M		23.34(0.03)	23.38(0.05)	23.46(0.11)	23.55(0.16)	23.58(0.22)	23.84(0.48)
>	16M		23.39(0.03)	23.36(0.06)	23.42(0.11)	23.50(0.16)	23.59(0.23)	23.86(0.48)
>	32M		23.43(0.03)	23.38(0.06)	23.47(0.12)	23.54(0.19)	23.58(0.23)	23.89(0.48)
>	64M		23.42(0.04)	23.43(0.07)	23.47(0.12)	23.53(0.18)	23.59(0.23)	23.87(0.48)
>	128M		23.45(0.07)	23.41(0.09)	23.52(0.14)	23.56(0.19)	23.59(0.23)	23.81(0.48)
>	256M		23.47(0.12)	23.48(0.14)	23.50(0.14)	23.55(0.20)	23.62(0.23)	23.84(0.48)
>	512M		23.48(0.18)	23.56(0.19)	23.55(0.19)	23.60(0.24)	23.71(0.32)	23.88(0.49)
>	1G		23.74(0.30)	23.53(0.23)	23.64(0.31)	23.54(0.24)	23.65(0.27)	23.98(0.52)
>	2G		23.78(0.48)	23.82(0.48)	23.84(0.48)	23.83(0.49)	23.89(0.52)	23.84(0.52)
>	4G		23.91(0.52)	23.81(0.50)	23.92(0.50)	23.87(0.51)	23.88(0.54)	23.92(0.54)
>	8G		23.80(0.50)	23.90(0.52)	23.82(0.49)	23.84(0.51)	23.90(0.54)	23.90(0.54)
>	16G		23.85(0.51)	23.86(0.50)	23.85(0.51)	23.87(0.51)	23.95(0.54)	23.88(0.54)
>
>		cyc-buf	128		256		512		1024		2048		4096
>	splblk-size
>	2M		23.90(0.47)	23.84(0.48)	23.84(0.48)	24.06(0.47)	23.93(0.47)	49.00(25.46)
>	4M		23.87(0.48)	23.84(0.48)	23.91(0.48)	23.93(0.47)	23.98(0.47)	49.00(25.46)
>	8M		23.80(0.48)	23.81(0.48)	23.95(0.48)	23.95(0.47)	24.03(0.52)	49.05(25.45)
>	16M		23.86(0.47)	23.84(0.48)	23.90(0.48)	23.93(0.47)	24.00(0.47)	48.95(25.41)
>	32M		23.86(0.48)	23.82(0.48)	23.98(0.54)	23.99(0.47)	23.97(0.47)	49.03(25.47)
>	64M		23.83(0.48)	23.79(0.48)	23.89(0.48)	24.02(0.47)	23.93(0.47)	48.96(25.49)
>	128M		23.92(0.55)	23.91(0.48)	23.85(0.48)	23.98(0.47)	23.90(0.47)	48.98(25.50)
>	256M		23.86(0.48)	23.88(0.48)	24.00(0.48)	24.17(0.47)	23.94(0.47)	49.01(25.50)
>	512M		23.85(0.49)	23.89(0.55)	23.93(0.49)	23.91(0.48)	24.01(0.48)	49.12(25.54)
>	1G		23.85(0.52)	23.84(0.52)	23.98(0.52)	23.98(0.51)	24.02(0.51)	49.28(25.73)
>	2G		23.92(0.52)	23.87(0.52)	23.93(0.52)	24.11(0.52)	24.04(0.52)	49.27(25.77)
>	4G		24.24(0.91)	24.31(0.91)	24.29(0.91)	24.37(0.90)	24.37(0.90)	50.01(26.49)
>	8G		24.27(0.91)	24.94(1.61)	25.07(1.62)	25.11(1.60)	25.02(1.60)	51.24(27.77)
>	16G		24.29(0.91)	24.98(1.63)	29.32(5.85)	29.34(5.83)	29.33(5.83)	53.91(30.43)
>
>
>test3:
>														sec
>		cyc-buf	2		4		8		16		32		64
>	splblk-size
>	2M		23.34(0.03)	23.38(0.05)	23.46(0.11)	23.47(0.16)	23.55(0.22)	23.97(0.65)
>	4M		23.38(0.03)	23.41(0.05)	23.46(0.11)	23.47(0.16)	23.56(0.22)	23.99(0.65)
>	8M		23.33(0.03)	23.41(0.06)	23.50(0.11)	23.52(0.16)	23.54(0.23)	24.05(0.66)
>	16M		23.38(0.03)	23.51(0.14)	23.46(0.12)	23.54(0.16)	23.57(0.23)	23.98(0.65)
>	32M		23.34(0.03)	23.37(0.06)	23.47(0.12)	23.53(0.18)	23.56(0.23)	24.06(0.66)
>	64M		23.36(0.06)	23.43(0.08)	23.52(0.13)	23.53(0.18)	23.63(0.23)	23.99(0.66)
>	128M		23.47(0.07)	23.40(0.09)	23.54(0.15)	23.50(0.19)	23.57(0.23)	24.15(0.74)
>	256M		23.48(0.13)	23.52(0.14)	23.50(0.15)	23.54(0.19)	23.56(0.23)	23.98(0.66)
>	512M		23.49(0.18)	23.49(0.19)	23.60(0.20)	23.66(0.32)	23.64(0.23)	24.15(0.75)
>	1G		23.58(0.23)	23.54(0.23)	23.62(0.24)	23.57(0.24)	23.64(0.27)	24.17(0.81)
>	2G		24.00(0.65)	23.99(0.66)	24.01(0.67)	24.01(0.70)	24.13(0.80)	24.43(0.82)
>	4G		24.04(0.66)	23.97(0.67)	24.05(0.71)	24.04(0.73)	24.15(0.82)	24.18(0.83)
>	8G		23.97(0.66)	24.06(0.67)	23.98(0.68)	24.07(0.73)	24.13(0.81)	24.16(0.83)
>	16G		24.05(0.66)	24.03(0.68)	24.02(0.68)	24.08(0.72)	24.18(0.82)	24.16(0.83)
>
>		cyc-buf	128		256		512		1024		2048		4096
>	splblk-size
>	2M		24.05(0.65)	24.04(0.65)	24.58(0.65)	24.15(0.64)	24.14(0.64)	49.05(25.46)
>	4M		23.98(0.65)	24.01(0.65)	24.29(0.65)	24.20(0.64)	24.18(0.66)	49.04(25.46)
>	8M		24.02(0.65)	24.03(0.65)	24.25(0.65)	24.26(0.70)	24.15(0.64)	48.98(25.44)
>	16M		24.01(0.65)	24.01(0.65)	24.30(0.65)	24.19(0.64)	24.12(0.65)	48.99(25.45)
>	32M		23.97(0.65)	24.06(0.73)	24.23(0.65)	24.17(0.64)	24.19(0.64)	48.97(25.50)
>	64M		24.06(0.66)	24.07(0.66)	24.27(0.66)	24.16(0.65)	24.17(0.65)	48.98(25.49)
>	128M		24.03(0.67)	24.00(0.67)	24.27(0.66)	24.22(0.66)	24.19(0.66)	48.98(25.48)
>	256M		24.12(0.67)	23.99(0.67)	24.27(0.67)	24.17(0.66)	24.12(0.66)	49.04(25.49)
>	512M		24.06(0.70)	24.08(0.70)	24.26(0.70)	24.14(0.71)	24.19(0.70)	49.13(25.64)
>	1G		24.20(0.82)	24.13(0.81)	24.36(0.81)	24.31(0.80)	24.33(0.81)	49.28(25.75)
>	2G		24.19(0.81)	24.22(0.81)	24.37(0.81)	24.29(0.80)	24.28(0.82)	49.30(25.78)
>	4G		25.29(1.90)	25.26(1.91)	25.49(1.91)	25.41(1.89)	25.50(1.90)	49.99(26.45)
>	8G		25.33(1.90)	26.60(3.23)	26.87(3.21)	26.71(3.23)	26.64(3.22)	51.27(27.73)
>	16G		25.28(1.90)	26.52(3.21)	29.47(5.86)	29.34(5.84)	29.38(5.86)	53.99(30.40)
>
>
>
>Thanks
>Zhou Wenjian
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
