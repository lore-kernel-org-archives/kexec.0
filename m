Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TTCx2-0008UM-C5
 for kexec@lists.infradead.org; Tue, 30 Oct 2012 14:37:57 +0000
Date: Tue, 30 Oct 2012 10:37:50 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 0/2] Exclude hwpoison page from vmcore dump
Message-ID: <20121030143750.GF2290@redhat.com>
References: <508FDEF3.8030601@hitachi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <508FDEF3.8030601@hitachi.com>
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
To: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Oct 30, 2012 at 11:06:43PM +0900, Mitsuhiro Tanino wrote:

[..]
> These patches introduce a new "-p" option into "makedumpfile" to
> exclude hwpoison page from vmcore.

Why to introduce this option "-p"? Until and unless there are serious
side effects, this should be default functionality. Isn't it? Who would
like to touch/save poisoned pages and run into MCE?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
