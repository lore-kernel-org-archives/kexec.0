Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cgPni-0003WU-6V
 for kexec@lists.infradead.org; Wed, 22 Feb 2017 05:49:18 +0000
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
References: <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
 <5886AD91.10803@redhat.com> <20170124122212.3dpdex5wjallypis@pd.tnic>
 <5889976A.9020802@redhat.com> <20170126064400.wfsn5pzxnpi6gcuk@pd.tnic>
 <58A53A65.3000405@redhat.com> <20170216101845.vkmnde4v6v72dgzx@pd.tnic>
 <58A59269.3050706@redhat.com> <20170216122215.uvrckt25g2msfxhe@pd.tnic>
 <58A65791.4090600@redhat.com> <20170217090735.ls5pmtsfwkf3q5h6@pd.tnic>
 <58A72316.20204@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F3A2BE9B1@ORSMSX114.amr.corp.intel.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58AD26B7.5070602@redhat.com>
Date: Wed, 22 Feb 2017 13:50:47 +0800
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F3A2BE9B1@ORSMSX114.amr.corp.intel.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Luck, Tony" <tony.luck@intel.com>, "xlpang@redhat.com" <xlpang@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On 02/22/2017 at 02:20 AM, Luck, Tony wrote:
>> It's from my understanding, I didn't get the explicit description from the intel SDM on this point.
>> If a broadcast SRAO comes on real hardware, will MSR_IA32_MCG_STATUS of each cpu have MCG_STATUS_RIPV bit set?
> MCG_STATUS is a per-thread MSR and will contain the status appropriate for that thread when #MC is delivered.
> So the RIPV bit will be set if, and only if, the thread saved a valid return address for this exception. The net result
> is that it is almost always set for "innocent bystander" CPUs that were dragged into the exception handler because
> of a broadcast #MC. We make the test because if it isn't set, then the do_machine_check() had better not return
> because we have no idea where it will return to - since there is not a valid return IP.
>

Got it, thanks for the details.

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
