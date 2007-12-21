Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from home.nigel.suspend2.net ([203.171.70.205])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J5dM8-0001n6-3n
	for kexec@lists.infradead.org; Fri, 21 Dec 2007 08:35:50 +0000
Message-ID: <476B7ACF.8020602@nigel.suspend2.net>
Date: Fri, 21 Dec 2007 19:35:27 +1100
From: Nigel Cunningham <nigel@nigel.suspend2.net>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3 -mm] kexec jump -v8
References: <1198222399.1965.15.camel@caritas-dev.intel.com>
In-Reply-To: <1198222399.1965.15.camel@caritas-dev.intel.com>
Reply-To: nigel@nigel.suspend2.net
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

Hi.

Huang, Ying wrote:
> This patchset provides an enhancement to kexec/kdump. It implements
> the following features:
> 
> - Backup/restore memory used both by the original kernel and the
>   kexeced kernel.

Why the kexeced kernel as well?

[...]

> The features of this patchset can be used as follow:
> 
> - Kernel/system debug through making system snapshot. You can make
>   system snapshot, jump back, do some thing and make another system
>   snapshot.

Are you somehow recording all the filesystem changes after the first
snapshot? If not, this is pointless (you'll end up with filesystem
corruption).

[...]

> - Cooperative multi-kernel/system. With kexec jump, you can switch
>   between several kernels/systems quickly without boot process except
>   the first time. This appears like swap a whole kernel/system out/in.

How is this useful to the end user?

Regards,

Nigel



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
