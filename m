Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S7BSy-0001LB-0X
 for kexec@lists.infradead.org; Mon, 12 Mar 2012 20:03:38 +0000
Message-ID: <4F5E566D.9060209@zytor.com>
Date: Mon, 12 Mar 2012 13:02:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] boot: ignore early NMIs
References: <m1ipip6xe8.fsf@fess.ebiederm.org>
 <4F573E1C.2060909@oss.ntt.co.jp> <4F573E74.5040504@oss.ntt.co.jp>
 <m1eht31z8e.fsf@fess.ebiederm.org> <4F58495B.5080308@oss.ntt.co.jp>
 <m1r4x3yrsv.fsf@fess.ebiederm.org> <4F5A6D87.4050809@zytor.com>
 <4F5D8D0E.8060702@oss.ntt.co.jp> <4F5D8E63.60606@zytor.com>
 <4F5D943C.5020403@oss.ntt.co.jp> <20120312133619.GB17288@redhat.com>
 <m1ipi9prrl.fsf@fess.ebiederm.org>
In-Reply-To: <m1ipi9prrl.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Don Zickus <dzickus@redhat.com>, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXU=?= =?UTF-8?B?ZXogQ2Fv?= <fernando@oss.ntt.co.jp>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

On 03/12/2012 12:02 PM, Eric W. Biederman wrote:
> 
> Disabling NMI generation in the LAPIC is fine, and for the short term
> I don't even have a problem with disabling the entire LAPIC as all of
> our platforms seem to have code for completely reprogramming it.
> 
> At the same time there have been cases like the i8259 routed through
> the ExtInt pin of the lapci that we haven't been given programming
> information about and that if we want to work we should avoid touching.
> 

I'm pretty sure that information is in the SDM (I'm looking at it now.)

You can also block NMI though this route, since external NMI really is
LINT1 and hence is routed through the LAPIC; you can mask it by clearing
bit 16 in LVT LINT1 as described in the SDM.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
