Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cfzDh-0001ZR-6T
 for kexec@lists.infradead.org; Tue, 21 Feb 2017 01:26:22 +0000
Subject: Re: [PATCH v2] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
References: <1487571037-10821-1-git-send-email-xlpang@redhat.com>
 <20170220110941.vwcm3je3e4kkei6o@pd.tnic> <58AAEF34.9000303@redhat.com>
 <20170220202654.kakjxgmxrlhak6q3@pd.tnic>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58AB97B4.8040303@redhat.com>
Date: Tue, 21 Feb 2017 09:28:20 +0800
MIME-Version: 1.0
In-Reply-To: <20170220202654.kakjxgmxrlhak6q3@pd.tnic>
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

On 02/21/2017 at 04:26 AM, Borislav Petkov wrote:
> On Mon, Feb 20, 2017 at 09:29:24PM +0800, Xunlei Pang wrote:
>> There is a small window between crash and kdump kernel boot, so
>> if a SRAO comes within this window it will also cause the mce
>> synchronization problem on the crashing cpu if we don't bail out the
>> crashing cpu.
> You mean, in the window between, kdump kernel starts writing out memory
> and the second, kexec-ed kernel?

Not kdump kernel starts dumping, just during nmi_shootdown_cpus(), if some
MCE comes after crashing_cpu was set and we don't skip crashing_cpu, then
the crashing cpu will enter mce handler and trigger the synchronization issue.

>
> If so, please add that information to the place in do_machine_check()
> where we check crashing_cpu so that we know why we're doing this
> temporary ignore of #MC.

Ok, will add, thanks for the feedback.

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
