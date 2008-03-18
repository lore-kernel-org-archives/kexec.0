Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JblbL-0006UM-Ej
	for kexec@lists.infradead.org; Tue, 18 Mar 2008 23:52:21 +0000
Date: Wed, 19 Mar 2008 00:52:38 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
Message-ID: <20080318235238.GA1779@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803131803.31120.rjw@sisk.pl>
	<m1ejaew7dm.fsf@ebiederm.dsl.xmission.com>
	<200803140231.39282.rjw@sisk.pl>
	<m1prtsug2e.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1prtsug2e.fsf@ebiederm.dsl.xmission.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

> Does using the S4 state have advantages that I currently do not
> see?

Yes. S5 confuses BIOSes on some machines (HP nx5000), and they report
stale values for AC/battery power (and worse, like thermal management
broken).

But this should not stop kexec/kjump.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
