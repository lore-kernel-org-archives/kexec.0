Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMTzY-0007nV-OW
 for kexec@lists.infradead.org; Fri, 22 Jan 2016 05:10:38 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [RFC PATCH 1/4] purgatory/ipmi: Support BMC watchdog timer
 start/stop in purgatory
Date: Fri, 22 Jan 2016 05:10:12 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454AA9364@GSjpTKYDCembx31.service.hitachi.net>
References: <20160120103734.4234.64015.stgit@softrs>
 <20160120103736.4234.69214.stgit@softrs> <56A0FC07.3020507@acm.org>
In-Reply-To: <56A0FC07.3020507@acm.org>
Content-Language: ja-JP
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "'minyard@acm.org'" <minyard@acm.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> A general note here.  It does not appear that you implement the
> error recovery states in your state machine.  If the system fails
> in the middle of doing an IPMI operation, it is likely to fail.

The reason why I din't implement the error handling is that
I think the error rate is low and it may take many seconds (but I
don't have any statistical data, that's my anticipation).

The most important thing is to start booting the 2nd kernel surely
and as soon as possible.  For example, if a user uses a feature
like fence_kdump and if the execution of fence_kdump gets delayed,
the crashed host will be shot down by other host waiting for the
notification from fence_kdump.

Also, to keep the code simple is important for the reliability.

Anyway, I'll rethink whether I can implement the error handling
in simple logic or not.

> If you do this you will need to detect and abort any running
> operation.  Implementing the full state machine is probably the
> best approach, it should handle this, though it is rather complex.
> 
> -corey

Regards,
--
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
