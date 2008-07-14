Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rn-out-0910.google.com ([64.233.170.191])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KITPT-0007qK-Sq
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 19:08:32 +0000
Received: by rn-out-0910.google.com with SMTP id m7so1525771rnd.3
	for <kexec@lists.infradead.org>; Mon, 14 Jul 2008 12:08:30 -0700 (PDT)
Message-ID: <86802c440807141208u5108f7d9q23ec8cbf41ec59df@mail.gmail.com>
Date: Mon, 14 Jul 2008 12:08:30 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
In-Reply-To: <m1iqv8xpll.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<86802c440807140011v728cc35fy2540b537ddca9844@mail.gmail.com>
	<20080714112404.36783df5@halley.suse.de>
	<m1od50ztoa.fsf@frodo.ebiederm.org>
	<86802c440807141006o98afac8t66b0933d8acd2746@mail.gmail.com>
	<m17iboz83v.fsf@frodo.ebiederm.org>
	<86802c440807141117q218fdd61w1216dc6ded72252a@mail.gmail.com>
	<m1r69wxq8v.fsf@frodo.ebiederm.org>
	<20080714204748.07b06e30@halley.suse.de>
	<m1iqv8xpll.fsf@frodo.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On Mon, Jul 14, 2008 at 11:55 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Bernhard Walle <bwalle@suse.de> writes:
>
>> But such checks belong into kexec itself, not into the kernel.
>
> Exactly.
>
> All we should do in the kernel is bias the search for a low address.
> As that is more usable.

let kexec to uncompress the bzImage (need to check if header version
is 2.0.8(?) above?) , if the kdump_base is above 4g.

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
