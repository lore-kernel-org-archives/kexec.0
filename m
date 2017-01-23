Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVelL-0006T3-JY
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 13:34:25 +0000
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <588606B9.3070604@redhat.com>
Date: Mon, 23 Jan 2017 21:35:53 +0800
MIME-Version: 1.0
In-Reply-To: <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>, Xunlei Pang <xlpang@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On 01/23/2017 at 08:51 PM, Borislav Petkov wrote:
> On Mon, Jan 23, 2017 at 04:01:51PM +0800, Xunlei Pang wrote:
>> We met an issue for kdump: after kdump kernel boots up,
>> and there comes a broadcasted mce in first kernel, the
> How does that even happen?
>
> Lemme try to understand this correctly: the first kernel gets an
> MCE, kdump starts and boots a *whole* kernel and *then* you get the
> broadcasted MCE? I have real hard time believing that.
>
> What happened to the approach of clearing CR4.MCE before loading the
> kdump kernel, in native_machine_shutdown() or wherever does the kdump
> gets loaded...
>

One possible timing sequence would be:
1st kernel running on multiple cpus panicked
then the crash dump code starts
the crash dump code stops the others cpus except the crashing one
2nd kernel boots up on the crash cpu with "nr_cpus=1"
some broadcasted mce comes on some cpu amongst the other cpus(not the crashing cpu)
the other cpus enter old mce handler of 1st kernel, while crash cpu enters new mce handler of 2nd kernel
the old mce handler of 1st kernel will timeout and panic due to mce syncrhonization under default setting

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
