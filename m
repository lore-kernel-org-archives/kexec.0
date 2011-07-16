Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Qi7Xd-0002fM-T8
	for kexec@lists.infradead.org; Sat, 16 Jul 2011 16:16:35 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <5C4C569E8A4B9B42A84A977CF070A35B2C17AAE59A@USINDEVS01.corp.hds.com>
Date: Sat, 16 Jul 2011 09:16:06 -0700
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2C17AAE59A@USINDEVS01.corp.hds.com>
	(Seiji Aguchi's message of "Mon, 11 Jul 2011 11:47:17 -0400")
Message-ID: <m14o2mjj5l.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Replace a function call chain of
	kmsg_dump(KMSG_DUMP_KEXEC) with static function calls
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Jarod Wilson <jwilson@redhat.com>, Americo Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Matthew Garrett <mjg@redhat.com>

Seiji Aguchi <seiji.aguchi@hds.com> writes:

> Hi,
>
> [Background]
>  - Requirement in enterprise area
>  From our support service experience, we always need to detect root causes of OS panic.
>  Because customers in enterprise area never forgive us if kdump fails and  we can't detect
>  root causes of panic due to lack of materials for investigation.
>
>  That is why I would like to add kmsg_dump() in kdump path.

You are whittling this down to something that has a chance of being
useful, but the code still has a ways to go.

It is good that you have managed to run tests that on one hardware
platform the firmware is reliable and that this does not reduce the odds
of kexec.  Your starting assertion however is that you can not do this
in the kernel started by kexec on panic because kexec on panic is
unreliable.  You don't have test cases that show your code working
when the kexec on panic kernel does not.

Calling out to EFI continues not to inspire my confidence that this
code will work on a wide variety of hardware platforms.

What is going on with EFI support?  We are still making efi calls in
virtual mode, and we don't have the one unified identity mapped physical
page table that hpa and I think others were working a while back.  Even
if because of bugs we need to transition EFI to virtual mode we can
still set physical to virtual so we don't have to deal with the nonsense.

Can we please make our EFI support ask the minimal from EFI before
adding lots more to it?

Am I wrong in thinking that the core motivation behind this patch is
that our EFI support sucks and thus kdump on EFI does not work on some
platforms?

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
