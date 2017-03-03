Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjf8P-0007ZH-E0
 for kexec@lists.infradead.org; Fri, 03 Mar 2017 04:48:07 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile Patch v3 7/7] mem-usage: allow to work only with
 -f for kernel version < 4.11
Date: Fri, 3 Mar 2017 04:35:48 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EAAE77@BPXM01GP.gisp.nec.co.jp>
References: <cover.1488443170.git.panand@redhat.com>
 <6689d9cf1e69f79b0e8c74ecab8e003e5507a79b.1488443170.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EAABEE@BPXM01GP.gisp.nec.co.jp>
 <3b32aab8-0cbe-fb9a-f884-3b0713717aca@redhat.com> <20170303030735.GB24001@x1>
In-Reply-To: <20170303030735.GB24001@x1>
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
To: Pratyush Anand <panand@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>> On Friday 03 March 2017 07:40 AM, Atsushi Kumagai wrote:
>> > > +		if (info->kernel_version < KERNEL_VERSION(4, 11, 0) &&
>> > > +				!info->flag_force) {
>> > > +			MSG("mem-usage not supported for this kernel.\n");
>> > > +			MSG("You can try with -f if your kernel's kcore has valid p_paddr\n");
>> > > +			goto out;
>> > > +		}
>> > You forgot to set COMPLETED to retcd before goto.
>> > The behavior will be different from the v2 patch.
>>
>>
>> I had thought about it. Should not an unsupported feature be a FAILED case?
>
>
>Judging from the result, it should be a failed case. People expect to
>get a dumped vmcore, it failed to collect at last because of unmatched
>kernel and tool.

When you change the design, please note it into changelog, 
it's a review point of view.

  Changes since v2:
    - Fixed a memory leak issue and updated man page and usage info

As for the return value, I guess both is OK if there is a clear intention.
If this is what you intended, I have no objection.
(it actually sounds more reasonable)

So I'll merge the v3 patch into v1.6.2, thanks for your work.


Regards,
Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
