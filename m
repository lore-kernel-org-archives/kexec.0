Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dFsBb-00054Z-5O
 for kexec@lists.infradead.org; Wed, 31 May 2017 01:12:33 +0000
Received: by mail-pg0-f48.google.com with SMTP id x64so81713pgd.3
 for <kexec@lists.infradead.org>; Tue, 30 May 2017 18:12:09 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH V3] elf_info: fix file_size if segment is
 excluded
References: <648cd9280e333c1b78584afb3f0843434640fe14.1494390678.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701ED845A@BPXM01GP.gisp.nec.co.jp>
 <8991bcd8-32ed-f7f1-64f4-86858ebb76f7@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EDC3E3@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <16711da5-0245-c6e4-033f-e9ee2bdf286c@redhat.com>
Date: Wed, 31 May 2017 06:42:04 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EDC3E3@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>, "xpang@redhat.com" <xpang@redhat.com>



On Wednesday 31 May 2017 06:19 AM, Atsushi Kumagai wrote:
>> Hi Atsushi,
>>
>> On Wednesday 17 May 2017 01:15 PM, Atsushi Kumagai wrote:
>>> Hello Pratyush,
>>>
>>> Sorry for late reply.
>>> I have no further comment for now, but the current --mem-usage
>>> seems have some problems. I can't decide that this patch is insufficient or
>>> that's quite a different matter now, so please let me defer acknowledgment
>>> for a while.
>>>
>>
>> Any decision on this patch.
>
> The problem I met is still unresolved, but it occurs even without this patch.
> So I accept this patch for now.

Thanks.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
