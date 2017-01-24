Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVqtf-0003dE-Ha
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 02:31:49 +0000
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic> <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic> <20170123174008.GA4945@intel.com>
 <20170123175130.l7c7mnmu74ln5v6h@pd.tnic> <20170123180153.GA5646@intel.com>
 <20170123181437.xbjbsdjfcn7b67dh@pd.tnic>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <5886BCF6.9070006@redhat.com>
Date: Tue, 24 Jan 2017 10:33:26 +0800
MIME-Version: 1.0
In-Reply-To: <20170123181437.xbjbsdjfcn7b67dh@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, kexec@lists.infradead.org, x86@kernel.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On 01/24/2017 at 02:14 AM, Borislav Petkov wrote:
> On Mon, Jan 23, 2017 at 10:01:53AM -0800, Luck, Tony wrote:
>> will ignore the machine check on the other cpus ... assuming
>> that "cpu_is_offline(smp_processor_id())" does the right thing
>> in the kexec case where this is an "old" cpu that isn't online
>> in the new kernel.
> Nice. And kdump did do the dumping on one CPU, AFAIR. So we should be
> good there.
>

"nr_cpus=N" will consume more memory, using very large N is almost
impossible for kdump to boot with considering the limited crash memory
reserved.

For some large machine, nr_cpus=1 might not be enough, we have to use
nr_cpus=4 or more, it is also helpful for the vmcore parallel dumping :-)

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
