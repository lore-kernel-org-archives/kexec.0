Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cWdXj-0005Vv-5L
 for kexec@lists.infradead.org; Thu, 26 Jan 2017 06:28:24 +0000
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic> <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic> <5886AD91.10803@redhat.com>
 <20170124122212.3dpdex5wjallypis@pd.tnic>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <5889976A.9020802@redhat.com>
Date: Thu, 26 Jan 2017 14:30:02 +0800
MIME-Version: 1.0
In-Reply-To: <20170124122212.3dpdex5wjallypis@pd.tnic>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, xlpang@redhat.com
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On 01/24/2017 at 08:22 PM, Borislav Petkov wrote:
> On Tue, Jan 24, 2017 at 09:27:45AM +0800, Xunlei Pang wrote:
>> It occurred on real hardware when testing crash dump.
>>
>> 1) SysRq-c was injected for the test in 1st kernel
>> [ 49.897279] SysRq : Trigger a crash 2) The 2nd kernel started for kdump
>>    [ 0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.10.0-229.el7.x86_64 root=UUID=976a15c8-8cbe-44ad-bb91-23f9b18e8789
> Yeah, no, I'm not debugging the RH Frankenstein kernel.
>
> Please retrigger this with latest tip/master first.
>

The hardware machine check is hard to reproduce, but the mce code of RHEL7 is quite
the same as that of tip/master, anyway we are able to inject software mce to reproduce it.

It is also clear from the theoretical analysis of the code.

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
