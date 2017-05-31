Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dFrrd-0004HV-Tc
 for kexec@lists.infradead.org; Wed, 31 May 2017 00:51:55 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH V3] elf_info: fix file_size if segment is
 excluded
Date: Wed, 31 May 2017 00:49:00 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EDC3E3@BPXM01GP.gisp.nec.co.jp>
References: <648cd9280e333c1b78584afb3f0843434640fe14.1494390678.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701ED845A@BPXM01GP.gisp.nec.co.jp>
 <8991bcd8-32ed-f7f1-64f4-86858ebb76f7@redhat.com>
In-Reply-To: <8991bcd8-32ed-f7f1-64f4-86858ebb76f7@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "xpang@redhat.com" <xpang@redhat.com>

>Hi Atsushi,
>
>On Wednesday 17 May 2017 01:15 PM, Atsushi Kumagai wrote:
>> Hello Pratyush,
>>
>> Sorry for late reply.
>> I have no further comment for now, but the current --mem-usage
>> seems have some problems. I can't decide that this patch is insufficient or
>> that's quite a different matter now, so please let me defer acknowledgment
>> for a while.
>>
>
>Any decision on this patch.

The problem I met is still unresolved, but it occurs even without this patch.
So I accept this patch for now.


Thanks,
Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
