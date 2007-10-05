Return-path: <kexec-bounces@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IdmoR-0007nN-K3
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 14:01:53 +0100
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 0/2] add new notifier function
References: <4704D09D.6080503@ah.jp.nec.com>
Date: Fri, 05 Oct 2007 07:01:17 -0600
In-Reply-To: <4704D09D.6080503@ah.jp.nec.com> (Takenori Nagano's message of
	"Thu, 04 Oct 2007 20:38:05 +0900")
Message-ID: <m1641llnqa.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces@lists.infradead.org
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Takenori Nagano <t-nagano@ah.jp.nec.com> writes:

> Hi,
>
> These patches add new notifier function and implement it to panic_notifier_list.
> We used the hardcoded notifier chain so far, but it was not flexible. New
> notifier is very flexible, because user can change a list of order by debugfs.

How is the lack of flexibility a problem?
Specifics please.

My impression is that the purpose of this patchset is to build
infrastructure to sort out a conflict between kdb and the kexec code,
which it does not do, and it can not do if it does not own up to
it's real purpose.

If I am correct in understanding the purpose of this patchset it does
not even address the problem it is aimed at solving.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
