Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MQOz8-0004BX-HF
	for kexec@lists.infradead.org; Mon, 13 Jul 2009 17:06:51 +0000
References: <4A55A4AE.3000206@mxs.nes.nec.co.jp>
	<4A56E069.5040907@jp.fujitsu.com> <4A5AB903.6090204@mxs.nes.nec.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 13 Jul 2009 10:06:25 -0700
In-Reply-To: <4A5AB903.6090204@mxs.nes.nec.co.jp> (Ken'ichi Ohmichi's message
	of "Mon\, 13 Jul 2009 13\:33\:07 +0900")
Message-ID: <m14otga4xa.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH-v2] kdump: Enable kdump if 2nd-kernel is loaded.
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Simon Horman <horms@verge.net.au>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

"Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> writes:

> Hi,
>
> This patch is a new version by Seto-san's comment.
>
>
> Changelog since v1:
> * Remove the check code other than kexec_crash_image from kexec_should_crash()
>   because a kexec cannot crash if there is no image.
>
>
> This patch enables a kdump if 2nd-kernel is loaded.
> (The patch is based on linux-2.6.31-rc2.)
>
> Now, a kdump on oops is enabled if a kernel parameter "oops=panic"
> is specified and 2nd-kernel is loaded. I think that a kdump should
> be enabled regardless of "oops=panic" if 2nd-kernel is loaded,
> because a system administrator loads 2nd-kernel for enabling a kdump.

The Documentation for sysrq-c certainly needs to be updated.

If I am doing development on a system I like oops's.  All of the
information and nothing goes down.  I can get at /proc/kcore etc.

In a setting where I can't be Johnny on the spot and look at
things a core dump is probably the best I can get.  In that scenario
panic_on_oops sounds good.

As I read the current check it reads:
If we are going to panic and not oops || panic_on_oops
	kexec_should_crash = true;

Which seems a very reasonable implementation of policy.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
