Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QimEk-0005ZX-HR
	for kexec@lists.infradead.org; Mon, 18 Jul 2011 11:43:47 +0000
Date: Mon, 18 Jul 2011 07:43:34 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC][PATCH] Replace a function call chain of
	kmsg_dump(KMSG_DUMP_KEXEC) with static function calls
Message-ID: <20110718114334.GA31986@redhat.com>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C17AAE59A@USINDEVS01.corp.hds.com>
	<m14o2mjj5l.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m14o2mjj5l.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Jarod Wilson <jwilson@redhat.com>, Americo Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Seiji Aguchi <seiji.aguchi@hds.com>, Matthew Garrett <mjg@redhat.com>

On Sat, Jul 16, 2011 at 09:16:06AM -0700, Eric W. Biederman wrote:

[..]
> Am I wrong in thinking that the core motivation behind this patch is
> that our EFI support sucks and thus kdump on EFI does not work on some
> platforms?

One of the arguments seems is that kdump might not work 100% of the
time and saving kernel messages atleast gets some information out
reliably.

I think being able to save dmesg to NVRAM, in general sounds good to
me (if done in a relatively clean manner). Especially if we can get
rid of code taking locks and code path executed after crash is not
tool long and relatively easy to audit.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
