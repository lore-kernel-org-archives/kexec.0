Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dGcwg-0006P3-DV
 for kexec@lists.infradead.org; Fri, 02 Jun 2017 03:08:16 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: makedumpfile PATCH] Fix the use of Xen physical and machine
 addresses
Date: Fri, 2 Jun 2017 03:04:30 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EDD48C@BPXM01GP.gisp.nec.co.jp>
References: <20170523093452.GQ30364@olila.local.net-space.pl>
 <b1e80585-7a71-b1d1-7d09-f52da8a82b7e@oracle.com>
 <20170530232815.5233981e@hananiah.suse.cz>
 <20170531090750.GA19333@olila.local.net-space.pl>
 <5f866d24-4aaa-ef80-4327-779780132b12@oracle.com>
 <54051391-6363-ec1b-0cc9-3f156c32908c@oracle.com>
In-Reply-To: <54051391-6363-ec1b-0cc9-3f156c32908c@oracle.com>
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
To: Petr Tesarik <ptesarik@suse.cz>, Eric DeVolder <eric.devolder@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>

Thanks everyone, I'll merge this patch into v1.6.2

Regards,
Atsushi Kumagai

>On 06/01/2017 09:18 AM, Eric DeVolder wrote:
>>
>>
>> On 05/31/2017 04:07 AM, Daniel Kiper wrote:
>>> On Tue, May 30, 2017 at 11:28:15PM +0200, Petr Tesarik wrote:
>>>> On Tue, 30 May 2017 14:30:43 -0500
>>>> Eric DeVolder <eric.devolder@oracle.com> wrote:
>>>>
>>>>> Hi,
>>>>> Testing is underway. Generally working but I do have a couple of fails
>>>>> I'm looking into:
>>>>>
>>>>>   > FAIL xen-4.1.2-rc3-pre_domU-pv_xl_linux-2.6.39-x86_64.tar.bz2
>>>>                              ^^^^^^^
>>>>
>>>> Is this a PV DomU xc_core style dump? If so, then it has never been
>>>> supported by makedumpfile, because the file format is very different,
>>>> with no program headers, but a special section called ".xen_pages". In
>>>> fact, the file format itself does not cover this type of dump.
>>>
>>> Ahhh... IIRC, you are right. Thanks for pointing this out. Eric, please
>>> double check it and if PV __GUESTS__ are not supported by makedumpfile
>>> skip tests for them. Just test dom0 and Xen hypervisor stuff.
>>
>> I concur, this dump format is not supported by makedumpfile.
>>
>> I'm still working on validating 32-bit dump files.
>
>I have validated the 32-bit dump files with this patch. All is good.
>eric
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
