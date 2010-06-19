Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OQ3y5-0000Iz-Ku
	for kexec@lists.infradead.org; Sat, 19 Jun 2010 19:44:42 +0000
Date: Sat, 19 Jun 2010 21:44:36 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] Export kexec.h
Message-ID: <20100619194435.GP18946@basil.fritz.box>
References: <20100619132235.GA24200@basil.fritz.box>
	<m1y6eau96z.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1y6eau96z.fsf@fess.ebiederm.org>
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
Cc: Sam Ravnborg <sam@ravnborg.org>, akpm@linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org

> Is there a corresponding patch for /sbin/kexec ?

No. This would be mostly for new users.

> What is the reason for wanting to export a currently kernel only header?

I wrote a manpage and realized the system call is unusable
without a header.

-Andi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
