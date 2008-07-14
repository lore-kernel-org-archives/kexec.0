Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KITJK-0004XX-TQ
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 19:02:11 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<86802c440807140011v728cc35fy2540b537ddca9844@mail.gmail.com>
	<20080714112404.36783df5@halley.suse.de>
	<m1od50ztoa.fsf@frodo.ebiederm.org>
	<86802c440807141006o98afac8t66b0933d8acd2746@mail.gmail.com>
	<m17iboz83v.fsf@frodo.ebiederm.org>
	<86802c440807141117q218fdd61w1216dc6ded72252a@mail.gmail.com>
	<m1r69wxq8v.fsf@frodo.ebiederm.org>
	<20080714204748.07b06e30@halley.suse.de>
Date: Mon, 14 Jul 2008 11:55:34 -0700
In-Reply-To: <20080714204748.07b06e30@halley.suse.de> (Bernhard Walle's
	message of "Mon, 14 Jul 2008 20:47:48 +0200")
Message-ID: <m1iqv8xpll.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, Yinghai Lu <yhlu.kernel@gmail.com>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org

Bernhard Walle <bwalle@suse.de> writes:

> But such checks belong into kexec itself, not into the kernel.

Exactly.

All we should do in the kernel is bias the search for a low address.
As that is more usable.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
