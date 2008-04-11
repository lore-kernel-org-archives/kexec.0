Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 11 Apr 2008 12:55:34 -0700
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] add tunable_notifier function ,take2
Message-ID: <20080411195534.GA31401@kroah.com>
References: <47FF0EA5.8090804@ah.jp.nec.com> <47FF1910.1070001@ah.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47FF1910.1070001@ah.jp.nec.com>
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: nickpiggin@yahoo.com.au, k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Apr 11, 2008 at 04:53:52PM +0900, Takenori Nagano wrote:
> This patch adds new notifier function tunable_notifier_chain. Its base is
> atomic_notifier_chain.

You are adding sysfs files, not debugfs files, please change your
announcement text.

Also, as you are adding new sysfs files, we need some documentation to
be added to Documentation/ABI/ describing what these files are, what are
in them, and how to use them.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
