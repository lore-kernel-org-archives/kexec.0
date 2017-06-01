Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dGQwa-0002YR-Vp
 for kexec@lists.infradead.org; Thu, 01 Jun 2017 14:19:22 +0000
Subject: Re: makedumpfile PATCH] Fix the use of Xen physical and machine
 addresses
References: <20170523093452.GQ30364@olila.local.net-space.pl>
 <b1e80585-7a71-b1d1-7d09-f52da8a82b7e@oracle.com>
 <20170530232815.5233981e@hananiah.suse.cz>
 <20170531090750.GA19333@olila.local.net-space.pl>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <5f866d24-4aaa-ef80-4327-779780132b12@oracle.com>
Date: Thu, 1 Jun 2017 09:18:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170531090750.GA19333@olila.local.net-space.pl>
Content-Language: en-US
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
To: Daniel Kiper <daniel.kiper@oracle.com>, Petr Tesarik <ptesarik@suse.cz>
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, konrad.wilk@oracle.com



On 05/31/2017 04:07 AM, Daniel Kiper wrote:
> On Tue, May 30, 2017 at 11:28:15PM +0200, Petr Tesarik wrote:
>> On Tue, 30 May 2017 14:30:43 -0500
>> Eric DeVolder <eric.devolder@oracle.com> wrote:
>>
>>> Hi,
>>> Testing is underway. Generally working but I do have a couple of fails
>>> I'm looking into:
>>>
>>>   > FAIL xen-4.1.2-rc3-pre_domU-pv_xl_linux-2.6.39-x86_64.tar.bz2
>>                              ^^^^^^^
>>
>> Is this a PV DomU xc_core style dump? If so, then it has never been
>> supported by makedumpfile, because the file format is very different,
>> with no program headers, but a special section called ".xen_pages". In
>> fact, the file format itself does not cover this type of dump.
> 
> Ahhh... IIRC, you are right. Thanks for pointing this out. Eric, please
> double check it and if PV __GUESTS__ are not supported by makedumpfile
> skip tests for them. Just test dom0 and Xen hypervisor stuff.

I concur, this dump format is not supported by makedumpfile.

I'm still working on validating 32-bit dump files.

eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
