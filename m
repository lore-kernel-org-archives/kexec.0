Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzQXe-0000lb-ET
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 10:32:35 +0000
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Mon, 20 Feb 2012 16:01:12 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1KAV4lA2941026
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 16:01:04 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1KAV4ja018975
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 16:01:04 +0530
Message-ID: <4F4220E7.2060505@in.ibm.com>
Date: Mon, 20 Feb 2012 16:01:03 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
References: <20120216033411.7972.77705.stgit@suzukikp>
 <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F3DEBCF.8000201@in.ibm.com> <1329467969.2892.58.camel@pasglop>
 <20120220185601.d08b8864.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120220185601.d08b8864.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: benh@kernel.crashing.org, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

On 02/20/2012 03:26 PM, Atsushi Kumagai wrote:
> Hi, Benjamin
> Hi, Suzuki
>
> On Fri, 17 Feb 2012 19:39:29 +1100
> Benjamin Herrenschmidt<benh@kernel.crashing.org>  wrote:
>
>> On Fri, 2012-02-17 at 11:25 +0530, Suzuki K. Poulose wrote:
>>>> Could you tell me what kind of data is stored in vmalloc region in
>>> PPC ?
>>>> I want to estimate importance of your patches for makedumpfile.
>>> I know at least the modules are loaded in the vmalloc'd region. I have
>>> Cc'ed linux-ppc dev. We should be able to get enough info from the
>>> experts here.
>>>
>>> Josh / Kumar / Others,
>>>
>>> Could you please let us know your thoughts ?
>>
>> Modules, driver IO mappings, etc... I can see that being useful for
>> crashdumps.
>
> Thank you for your information.
>
> The above data may be required for one function of makedumpfile (filter
> out kernel data) but not so crucial for makedumpfile as page descriptors
> and related data(e.g. pglist_data).
>
> Moreover, I'm preparing the release of v1.4.3 now, so I'll merge vmalloc
> support for PPC32 into v1.4.4. Is it all right for you, Suzuki ?

Yep,  fine with me.

Thanks
Suzuki


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
