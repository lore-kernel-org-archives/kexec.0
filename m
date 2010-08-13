Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ok3V4-0001Pa-P5
	for kexec@lists.infradead.org; Fri, 13 Aug 2010 23:17:23 +0000
Message-ID: <4C65D263.6050904@zytor.com>
Date: Fri, 13 Aug 2010 16:16:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH][EFI] Run EFI in physical mode
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>	<4C65C630.4070008@zytor.com>	<987664A83D2D224EAE907B061CE93D53015B2DAD87@orsmsx505.amr.corp.intel.com>
	<m1r5i2kt0n.fsf@fess.ebiederm.org>
In-Reply-To: <m1r5i2kt0n.fsf@fess.ebiederm.org>
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
Cc: "Luck, Tony" <tony.luck@intel.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/13/2010 04:11 PM, Eric W. Biederman wrote:
> 
> As to Peter's question I did not see any of that code that affected
> anything that ia64 used.
> 

I guess my real question was "is this something IA64 could benefit from
and/or could we make the IA64 code more similar to the x86 bits"?

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
